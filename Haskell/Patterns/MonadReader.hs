class Monad m => MonadReader r m where
    ask :: m r
