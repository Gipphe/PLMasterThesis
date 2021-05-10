module Window
    ( Window(..)
    ) where

import Display (Display(..))

data Window = MkWindow
    { tint :: Int
    }

instance Display Window where
    display (MkWindow tint) =
        "Window with " <> show tint <> " black tint to it"
