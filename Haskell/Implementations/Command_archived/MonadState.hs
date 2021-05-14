{-# LANGUAGE MultiParamTypeClasses #-}

module MonadState
    ( MonadState(..)
    , modify
    ) where

class Monad m => MonadState s m where
    get :: m s
    put :: s -> m ()

modify :: MonadState s m => (s -> s) -> m ()
modify f = get >>= put . f
