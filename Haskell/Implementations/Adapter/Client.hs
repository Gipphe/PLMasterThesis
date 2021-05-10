{-# LANGUAGE ExistentialQuantification #-}

module Client
    ( Client(..)
    , eat
    ) where

import Fork (Fork(..))
import Knife (Knife(..))

data Client = forall f k . (Fork f, Knife k) => MkClient f k

eat :: Client -> String -> String
eat m food = case m of
    MkClient f k -> cutFood food k <> "\n" <> stabFood food f <> "\nNom"
