module Operator
    ( human1
    , human2
    ) where

import Command (Command(..), dispatch)
import Email (Email(..), emptyEmail)
import MailServer (MailServer(..))
import StateT (runStateT)

sendEditedEmail :: String -> Command
sendEditedEmail = SendEmail

signEmailWithServer :: Command
signEmailWithServer = SignEmail

writeSubject :: String -> Command
writeSubject = UpdateText (\s email -> email { subject = s })

writeBody :: String -> Command
writeBody = UpdateText (\s email -> email { body = s })

human1 :: MailServer ms => ms -> IO ()
human1 ms = do
    _ <- runStateT
        (do
            _ <- traverse (dispatch ms) commands
            pure ()
        )
        emptyEmail
    pure ()
  where
    writeInitialBody = writeBody "Foo bar baz quux quack"
    changeBody       = writeBody "Eleven point eight inches"
    writeTheSubject  = writeSubject "Foobar"
    signTheEmail     = signEmailWithServer
    sendTheEmail     = sendEditedEmail "foo.bar@quack.quux"
    commands =
        [ writeInitialBody
        , changeBody
        , writeTheSubject
        , signTheEmail
        , sendTheEmail
        ]

human2 :: MailServer ms => ms -> IO ()
human2 ms = do
    (prevEmail, ()) <- runStateT
        (do
            _ <- traverse (dispatch ms) firstEmail
            pure ()
        )
        emptyEmail
    putStrLn "-----"
    _ <- runStateT (dispatch ms sendEmailAgainByAccident) prevEmail
    putStrLn "-----"
    _ <- runStateT
        (do
            _ <- traverse (dispatch ms) secondEmail
            pure ()
        )
        emptyEmail
    pure ()
  where
    recipient                = "grace.hopper@us.navy"

    writeInitialBody         = writeBody "Hello"
    writeMoreBody            = writeBody "Hello there"
    writeEvenMoreBody        = writeBody "Hello th"
    writeFinalBody           = writeBody "Hello, dear reader"
    writeTheSubject          = writeSubject "To hello"
    correctTheSubject        = Macro [writeSubject "", writeSubject "To reader"]
    sendTheEmail             = sendEditedEmail recipient
    sendEmailAgainByAccident = sendEditedEmail recipient
    firstEmail =
        [ writeInitialBody
        , writeMoreBody
        , writeEvenMoreBody
        , writeFinalBody
        , writeTheSubject
        , correctTheSubject
        , sendTheEmail
        ]

    writeApologeticBody    = writeBody "Sorry for sending it twice"
    writeApologeticSubject = writeSubject "RE: To reader"
    sendApologeticEmail    = sendEditedEmail recipient
    secondEmail =
        [writeApologeticBody, writeApologeticSubject, sendApologeticEmail]
