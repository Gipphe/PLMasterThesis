module MonadEmailEditor
    ( MonadEmailEditor(..)
    ) where

import Email (Email)

class Monad m => MonadEmailEditor m where
    subject :: String -> m ()
    body :: String -> m ()
    sign :: String -> m ()
    mapEmail :: (Email -> Email) -> m ()
    create :: m Email
