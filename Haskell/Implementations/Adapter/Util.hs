module Util
    ( sentenceCase
    ) where

import Data.Char (toUpper)

sentenceCase :: String -> String
sentenceCase []       = []
sentenceCase (x : xs) = toUpper x : xs
