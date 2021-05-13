{-# LANGUAGE MultiParamTypeClasses #-}

module Add
    ( Add(..)
    ) where

class Add m a where
    add :: a -> m a -> m a
