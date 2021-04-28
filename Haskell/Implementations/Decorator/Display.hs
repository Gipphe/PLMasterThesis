module Display
    ( Display(..)
    ) where

class Display a where
    display :: a -> String
