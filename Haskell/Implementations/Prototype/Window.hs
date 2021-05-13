module Window
    ( Window(..)
    ) where

import Display (Display(..))

newtype Window = MkWindow
    { hitpoints :: Int
    }

instance Display Window where
    display (MkWindow hp) = "Window: " <> show hp <> " hp"
