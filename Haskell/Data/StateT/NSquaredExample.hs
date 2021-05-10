instance MonadReader r m => MonadReader r (StateT s m) where
    ask = lift ask
