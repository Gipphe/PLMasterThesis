module MailServer
    ( SendEmail(..)
    , SignEmail(..)
    ) where

import Email (Email)

class Monad m => SendEmail m where
    sendEmail :: Email -> String -> m ()

class Monad m => SignEmail m where
    signEmailAsServer :: m ()
