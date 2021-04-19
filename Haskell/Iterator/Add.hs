{-# LANGUAGE MultiParamTypeClasses #-}
{-# LANGUAGE NoImplicitPrelude #-}

module Add
    ( Add(..)
    ) where

import MyPrelude

class Add m a where
    add :: a -> m a -> m a
