module Gun
    ( Gun(..)
    ) where

import Display (Display(..))

newtype Gun = MkGun
    { power :: Int
    }

instance Display Gun where
    display (MkGun p) = "Gun: " <> show p <> " power"
