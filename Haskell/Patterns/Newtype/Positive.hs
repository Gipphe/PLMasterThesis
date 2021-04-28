module Positive
    ( Positive
    , getPositive
    , mkPositive
    ) where

newtype Positive n = MkPositive { getPositive :: n }
    deriving (Show)

mkPositive :: (Ord n, Num n) => n -> Maybe (Positive n)
mkPositive x
    | x >= 0    = Just (MkPositive x)
    | otherwise = Nothing
