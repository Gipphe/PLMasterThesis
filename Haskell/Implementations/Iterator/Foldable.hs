{-# LANGUAGE NoImplicitPrelude #-}

module Foldable
    ( Foldable(..)
    ) where

import MyPrelude

class Foldable t where
    foldl :: (b -> a -> b) -> b -> t a -> b
