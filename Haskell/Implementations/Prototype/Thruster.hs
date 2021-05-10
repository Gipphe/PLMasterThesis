module Thruster
    ( Thruster(..)
    ) where

import Display (Display(..))

data Thruster = MkThruster
    { thrust :: Int
    }

instance Display Thruster where
    display (MkThruster thrust) = "Thruster with " <> show thrust <> " thrust"
