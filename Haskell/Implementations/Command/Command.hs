module Command
    ( Command(..)
    , dispatch
    , dispatchList
    ) where

import Email (Email, sendEmail, signEmail)

data Command
    = SendEmail String
    | SignEmail
    | EditEmail (Email -> Email)
    | Macro [Command]

dispatch :: Email -> Command -> IO Email
dispatch email c = case c of
    SendEmail recipient -> do
        sendEmail email recipient
        pure email
    SignEmail          -> pure (signEmail email)
    EditEmail updateFn -> pure (updateFn email)
    Macro     commands -> dispatchList email commands

dispatchList :: Email -> [Command] -> IO Email
dispatchList email = foldl
    (\io c -> do
        e <- io
        dispatch e c
    )
    (pure email)
