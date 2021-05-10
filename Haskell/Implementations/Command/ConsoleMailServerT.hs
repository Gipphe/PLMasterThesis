module ConsoleMailServerT
    ( ConsoleMailServerT(..)
    ) where

import Control.Monad.IO.Class (MonadIO(..))
import Data.List (intercalate)
import Email (Email(..))
import MailServer (SendEmail(..), SignEmail(..))
import MonadEmailEditor (MonadEmailEditor)
import qualified MonadEmailEditor as Editor
import MonadState (MonadState, modify)
import MonadTrans (MonadTrans(..))

newtype ConsoleMailServerT m a = ConsoleMailServerT
    { runConsoleMailServerT :: m a
    }

instance Functor m => Functor (ConsoleMailServerT m) where
    fmap f (ConsoleMailServerT m) = ConsoleMailServerT (fmap f m)

instance Applicative m => Applicative (ConsoleMailServerT m) where
    pure x = ConsoleMailServerT (pure x)
    ConsoleMailServerT f <*> ConsoleMailServerT m =
        ConsoleMailServerT (f <*> m)

instance Monad m => Monad (ConsoleMailServerT m) where
    ConsoleMailServerT m >>= k = ConsoleMailServerT $ do
        v <- m
        runConsoleMailServerT (k v)

instance MonadIO m => MonadIO (ConsoleMailServerT m) where
    liftIO io = ConsoleMailServerT (liftIO io)

instance MonadIO m => SendEmail (ConsoleMailServerT m) where
    sendEmail email recipient =
        ConsoleMailServerT $ liftIO $ putStrLn $ intercalate
            "\n"
            (  [ "New email"
               , "Recipient: " <> recipient
               , "Subject: " <> subject email
               ]
            <> (case signature email of
                   Nothing  -> []
                   Just sig -> ["Signature: " <> sig]
               )
            <> ["Body: " <> body email]
            )

instance MonadEmailEditor m => SignEmail (ConsoleMailServerT m) where
    signEmailAsServer =
        ConsoleMailServerT (Editor.sign "Signed by ConsoleMailServer")

instance MonadTrans ConsoleMailServerT where
    lift = ConsoleMailServerT

instance MonadEmailEditor m => MonadEmailEditor (ConsoleMailServerT m) where
    body     = lift . Editor.body
    subject  = lift . Editor.subject
    sign     = lift . Editor.subject
    create   = lift Editor.create
    mapEmail = lift . Editor.mapEmail
