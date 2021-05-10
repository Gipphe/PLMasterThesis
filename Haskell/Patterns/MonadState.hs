{-# LANGUAGE MultiParamTypeClasses #-}

class Monad m => MonadState s m where
    get :: m s
    put :: s -> m ()
