module Thruster
    ( Thruster(..)
    ) where

import Display (Display(..))

newtype Thruster = MkThruster
    { thrust :: Int
    }

instance Display Thruster where
    display (MkThruster t) = "Thruster with " <> show t <> " thrust"
