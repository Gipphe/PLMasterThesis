{-# LANGUAGE FlexibleContexts #-}

module User
    ( User
    , mkUser
    , newCommand
    , runCommandsAsUser
    ) where

import Command (Command, dispatch)
import Control.Monad.IO.Class (MonadIO(..))
import Email (Email)
import MailServer (SendEmail, SignEmail)
import MonadEmailEditor (MonadEmailEditor)

data User = MkUser
    { name     :: String
    , commands :: [Command]
    }

mkUser :: String -> User
mkUser n = MkUser n []

newCommand :: Command -> User -> User
newCommand c user = user { commands = commands user <> [c] }

runCommandsAsUser :: (SignEmail m, SendEmail m, MonadEmailEditor m, MonadIO m)
                  => User
                  -> m ()
runCommandsAsUser (MkUser name commands) = do
    liftIO (putStrLn ("Running commands as user " <> name))
    _ <- traverse dispatch commands
    pure ()
