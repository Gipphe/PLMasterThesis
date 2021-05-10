module Structure
    ( Structure(..)
    ) where

import Display (Display(..))

data Structure = MkStructure
    { name :: String
    }

instance Display Structure where
    display (MkStructure name) = "Structure " <> name
