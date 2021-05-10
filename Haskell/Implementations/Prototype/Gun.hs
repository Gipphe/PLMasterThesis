module Gun
    ( Gun(..)
    ) where

import Display (Display(..))

data Gun = MkGun
    { power :: Int
    }

instance Display Gun where
    display (MkGun power) = "Gun with " <> show power <> " power"
