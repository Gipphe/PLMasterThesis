module Operator
    ( human1
    , human2
    ) where

import Command (Command(..), dispatch)
import ConsoleMailServerT (ConsoleMailServerT(..))
import Email (Email(..), emptyEmail)
import EmailEditorT (EmailEditorT(..))
import MailServer (SendEmail, SignEmail)
import StateT (StateT(..))
import User (User, mkUser, newCommand, runCommandsAsUser)

sendEditedEmail :: String -> Command
sendEditedEmail = SendEmail

signEmailWithServer :: Command
signEmailWithServer = SignEmail

writeSubject :: String -> Command
writeSubject = UpdateText (\s email -> email { subject = s })

writeBody :: String -> Command
writeBody = UpdateText (\s email -> email { body = s })

runCommands :: ConsoleMailServerT (EmailEditorT IO) a -> IO ()
runCommands p = do
    _ <-
        (\p' -> runStateT p' emptyEmail)
        $ runEmailEditorT
        $ runConsoleMailServerT p
    pure ()

human1 :: IO ()
human1 = do
    _ <- runCommands (runCommandsAsUser user)
    pure ()
  where
    user =
        newCommand sendTheEmail
            . newCommand signTheEmail
            . newCommand writeTheSubject
            . newCommand changeBody
            . newCommand writeInitialBody
            $ mkUser "Human 1"
    writeInitialBody = writeBody "Foo bar baz quux quack"
    changeBody       = writeBody "Eleven point eight inches"
    writeTheSubject  = writeSubject "Foobar"
    signTheEmail     = signEmailWithServer
    sendTheEmail     = sendEditedEmail "foo.bar@quack.quux"

human2 :: IO ()
human2 = do
    _ <- runCommands (runCommandsAsUser firstEmailUser)
    putStrLn "-----"
    _ <- runCommands (runCommandsAsUser secondEmailUser)
    pure ()
  where
    user                     = mkUser "Human 2"
    recipient                = "grace.hopper@us.navy"
    writeInitialBody         = writeBody "Hello"
    writeMoreBody            = writeBody "Hello there"
    writeEvenMoreBody        = writeBody "Hello th"
    writeFinalBody           = writeBody "Hello, dear reader"
    writeTheSubject          = writeSubject "To hello"
    correctTheSubject        = Macro [writeSubject "", writeSubject "To reader"]
    sendTheEmail             = sendEditedEmail recipient
    sendEmailAgainByAccident = sendEditedEmail recipient
    firstEmailUser =
        newCommand sendTheEmail
            . newCommand sendTheEmail
            . newCommand correctTheSubject
            . newCommand writeTheSubject
            . newCommand writeFinalBody
            . newCommand writeEvenMoreBody
            . newCommand writeMoreBody
            . newCommand writeInitialBody
            $ user

    writeApologeticBody    = writeBody "Sorry for sending it twice"
    writeApologeticSubject = writeSubject "RE: To reader"
    sendApologeticEmail    = sendEditedEmail recipient
    secondEmailUser =
        newCommand sendApologeticEmail
            . newCommand writeApologeticSubject
            . newCommand writeApologeticBody
            $ user
