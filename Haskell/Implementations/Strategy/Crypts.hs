module Crypts
    ( intersperseCrypt
    , macroCrypt
    , rotCrypt
    ) where

import Data.Char (chr, isLower, isUpper, ord)
import Data.List (intercalate)

intersperseCrypt :: String -> String -> String
intersperseCrypt s = intercalate s . fmap pure

macroCrypt :: [String -> String] -> String -> String
macroCrypt crypts s = foldl (\s' c -> c s') s crypts

rotCrypt :: Int -> String -> String
rotCrypt nn = fmap (rot nn)
  where
    intToLetter x n = chr (ord x + n)
    intToLowerLetter = intToLetter 'a'
    intToUpperLetter = intToLetter 'A'
    letterToInt x c = ord c - ord x
    lowerLetterToInt = letterToInt 'a'
    upperLetterToInt = letterToInt 'A'
    rot n c
        | isLower c = intToLowerLetter ((lowerLetterToInt c + n) `mod` 26)
        | isUpper c = intToUpperLetter ((upperLetterToInt c + n) `mod` 26)
        | otherwise = c
