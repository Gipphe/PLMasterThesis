module App
    ( App(..)
    ) where

import Control.Monad.IO.Class (MonadIO(..))
import Data.Bifunctor (second)
import Data.List (intercalate)
import Email (Email)
import qualified Email as E
import MailServer (SendEmail(..), SignEmail(..))
import MonadEmailEditor (MonadEmailEditor(..))

newtype App a = App { runApp :: Email -> IO (Email, a) }

instance Functor App where
    fmap f m = App (fmap (second f) . runApp m)

instance Applicative App where
    pure x = App (\s -> pure (s, x))

    App sf <*> App sm = App $ \s -> do
        (s' , f) <- sf s
        (s'', x) <- sm s'
        pure (s'', f x)

instance Monad App where
    m >>= k = App $ \s -> do
        (s', x) <- runApp m s
        runApp (k x) s'

instance MonadIO App where
    liftIO io = App $ \s -> do
        x <- io
        pure (s, x)

instance SendEmail App where
    sendEmail email recipient = App $ \s -> do
        putStrLn $ intercalate
            "\n"
            (  [ "+ New email"
               , "| Recipient: " <> recipient
               , "| Subject: " <> E.subject email
               ]
            <> (case E.signature email of
                   Nothing  -> []
                   Just sig -> ["| Signature: " <> sig]
               )
            <> ["| Body: " <> E.body email]
            )
        pure (s, ())

instance SignEmail App where
    withSignature signFn = pure (signFn "Signed by ConsoleMailServer")

instance MonadEmailEditor App where
    subject s = modifyEmail (\email -> email { E.subject = s })
    body b = modifyEmail (\email -> email { E.body = b })
    sign s = modifyEmail (\email -> email { E.signature = Just s })
    mapEmail f = modifyEmail f
    create = getEmail

modifyEmail :: (Email -> Email) -> App ()
modifyEmail f = App $ \s -> pure (f s, ())

getEmail :: App Email
getEmail = App $ \s -> pure (s, s)
