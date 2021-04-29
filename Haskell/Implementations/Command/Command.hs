{-# LANGUAGE FlexibleContexts #-}

module Command
    ( Command(..)
    , dispatch
    ) where

import Control.Monad.IO.Class (MonadIO(..))
import Email (Email)
import MailServer (MailServer(..))
import StateT (MonadState(..))

data Command
    = SendEmail String
    | SignEmail
    | UpdateText (String -> Email -> Email) String
    | Macro [Command]

dispatch :: (MailServer ms, MonadState m Email, MonadIO m)
         => ms
         -> Command
         -> m ()
dispatch ms c = do
    email <- get
    case c of
        SendEmail recipient -> do
            liftIO (sendEmail email recipient ms)
        SignEmail -> do
            signedEmail <- liftIO (signEmailAsServer email ms)
            put signedEmail
        UpdateText updateFn text -> put (updateFn text email)
        Macro commands           -> do
            _ <- traverse (dispatch ms) commands
            pure ()
