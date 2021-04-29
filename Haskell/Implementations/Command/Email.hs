module Email
    ( Email(..)
    , addSignature
    , emptyEmail
    ) where

data Email = MkEmail
    { subject   :: String
    , body      :: String
    , signature :: Maybe String
    }

emptyEmail :: Email
emptyEmail = MkEmail "" "" Nothing

addSignature :: String -> Email -> Email
addSignature s email = email { signature = Just s }
