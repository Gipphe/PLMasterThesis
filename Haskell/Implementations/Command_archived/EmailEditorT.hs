{-# LANGUAGE FlexibleContexts #-}
{-# LANGUAGE MultiParamTypeClasses #-}

module EmailEditorT
    ( EmailEditorT(..)
    ) where

import Control.Monad.IO.Class (MonadIO(..))
import Email (Email)
import qualified Email as E
import MonadEmailEditor (MonadEmailEditor(..))
import MonadState (MonadState(..), modify)
import MonadTrans (MonadTrans(..))
import StateT (StateT)

-- | Monad transformer to make a `MonadEmailEditor` instance for
-- `MonadState Email m` monads. This lets us use a more discriptive langauge
-- when handling the email editing.
newtype EmailEditorT m a = EmailEditorT
    { runEmailEditorT :: StateT Email m a
    }

instance Functor m => Functor (EmailEditorT m) where
    fmap f (EmailEditorT m) = EmailEditorT (fmap f m)

instance Monad m => Applicative (EmailEditorT m) where
    pure x = EmailEditorT (pure x)
    EmailEditorT f <*> EmailEditorT m = EmailEditorT (f <*> m)

instance Monad m => Monad (EmailEditorT m) where
    m >>= k = EmailEditorT
        (do
            v <- runEmailEditorT m
            runEmailEditorT (k v)
        )

instance MonadIO m => MonadIO (EmailEditorT m) where
    liftIO io = EmailEditorT (liftIO io)

instance Monad m => MonadState Email (EmailEditorT m) where
    get = EmailEditorT get
    put x = EmailEditorT (put x)

instance Monad m => MonadEmailEditor (EmailEditorT m) where
    subject s = EmailEditorT (modify (\email -> email { E.subject = s }))
    body b = EmailEditorT (modify (\email -> email { E.body = b }))
    sign s = EmailEditorT (modify (\email -> email { E.signature = Just s }))
    mapEmail f = EmailEditorT (modify f)
    create = EmailEditorT get

instance MonadTrans EmailEditorT where
    lift m = EmailEditorT (lift m)
