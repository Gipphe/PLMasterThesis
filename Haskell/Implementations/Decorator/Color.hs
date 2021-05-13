module Color
    ( Color(..)
    ) where

class Color c where
    colorCode :: c -> String
