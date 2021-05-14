module Email
    ( Email(..)
    , emptyEmail
    , signEmail
    , sendEmail
    ) where

import Data.List (intercalate)

data Email = MkEmail
    { subject   :: String
    , body      :: String
    , signature :: Maybe String
    }

emptyEmail :: Email
emptyEmail = MkEmail { subject = "", body = "", signature = Nothing }

sendEmail :: Email -> String -> IO ()
sendEmail email recipient = do
    putStrLn $ intercalate
        "\n"
        (  [ "+ New email"
           , "| Recipient: " <> recipient
           , "| Subject: " <> subject email
           ]
        <> (case signature email of
               Nothing  -> []
               Just sig -> ["| Signature: " <> sig]
           )
        <> ["| Body: " <> body email]
        )

signEmail :: Email -> Email
signEmail email = email { signature = Just "Signed by ConsoleMailServer" }
