{-# LANGUAGE FlexibleContexts #-}

module Command
    ( Command(..)
    , dispatch
    ) where

import Control.Monad.IO.Class (MonadIO(..))
import Email (Email)
import MailServer (SendEmail(..), SignEmail(..))
import MonadEmailEditor (MonadEmailEditor)
import qualified MonadEmailEditor as Editor

data Command
    = SendEmail String
    | SignEmail
    | UpdateText (String -> Email -> Email) String
    | Macro [Command]

dispatch :: (SendEmail m, SignEmail m, MonadEmailEditor m, MonadIO m)
         => Command
         -> m ()
dispatch c = case c of
    SendEmail recipient -> do
        email <- Editor.create
        sendEmail email recipient
    SignEmail                -> signEmailAsServer
    UpdateText updateFn text -> Editor.mapEmail (updateFn text)
    Macro commands           -> do
        _ <- traverse dispatch commands
        pure ()
