module Square
    ( Square(..)
    ) where

import Data.List (genericReplicate)
import Display (Display(..))

newtype Square = MkSquare Word

instance Display Square where
    display (MkSquare size) =
        "Square of size " <> show size <> "x" <> show size <> "\n" <> square
      where
        hor      = genericReplicate size '-'
        vert     = "|" <> genericReplicate (size - 2) ' ' <> "|"
        vertSegs = genericReplicate (size - 2) vert
        square   = unlines $ [hor] <> vertSegs <> [hor]
