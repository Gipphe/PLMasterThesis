module User
    ( User
    , mkUser
    , newCommand
    , runCommandsAsUser
    ) where

import Command (Command, dispatchList)
import Email (emptyEmail)

data User = MkUser String [Command]

mkUser :: String -> User
mkUser n = MkUser n []

newCommand :: Command -> User -> User
newCommand c (MkUser name commands) = MkUser name (commands <> [c])

runCommandsAsUser :: User -> IO ()
runCommandsAsUser (MkUser name commands) = do
    putStrLn $ "Running commands as user " <> name
    _ <- dispatchList emptyEmail commands
    pure ()
