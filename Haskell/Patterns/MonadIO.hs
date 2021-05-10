class Monad m => MonadIO m where
    liftIO :: IO a -> m a
