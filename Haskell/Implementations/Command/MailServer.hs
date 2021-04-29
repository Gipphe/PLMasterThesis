module MailServer
    ( MailServer(..)
    , ConsoleMailServer(..)
    ) where

import Data.List (intercalate)
import Email (Email(..), addSignature)

class MailServer m where
    sendEmail :: Email -> String -> m -> IO ()
    signEmailAsServer :: Email -> m -> IO Email

data ConsoleMailServer = MkConsoleMailServer

instance MailServer ConsoleMailServer where
    sendEmail email recipient _ = putStrLn
        (intercalate
            "\n"
            (  [ "New email"
               , "Recipient: " <> recipient
               , "Subject: " <> subject email
               ]
            <> (case signature email of
                   Nothing  -> []
                   Just sig -> ["Signature: " <> sig]
               )
            <> ["\n" <> body email]
            )
        )

    signEmailAsServer email _ =
        pure (addSignature "Signed by ConsoleMailServer" email)
