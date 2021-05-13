module Structure
    ( Structure(..)
    ) where

import Display (Display(..))

newtype Structure = MkStructure
    { hitpoints :: Int
    }

instance Display Structure where
    display (MkStructure hp) = "Structure: " <> show hp <> " hp"
