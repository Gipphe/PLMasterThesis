module Util
    ( roundTo
    ) where

roundTo :: Int -> Double -> Double
roundTo digits x = fromIntegral (round (x * 10 ^ digits)) / 10 ^ digits
