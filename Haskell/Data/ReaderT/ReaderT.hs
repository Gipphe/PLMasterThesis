newtype ReaderT r m a = ReaderT { runReaderT :: r -> m a }

instance Functor m => Functor (ReaderT r m) where
    fmap f (ReaderT m) = ReaderT (fmap f m)

instance Applicative m => Applicative (ReaderT r m) where
    pure x = ReaderT (pure x)
    ReaderT fm <*> ReaderT xm = ReaderT $ \r -> fm r <*> xm r

instance Monad m => Monad (ReaderT r m) where
    ReaderT m >>= k = ReaderT $ \r -> do
        x <- m r
        runReaderT (k x) r

instance MonadIO m => MonadIO (ReaderT r m) where
    liftIO io = ReaderT (liftIO io)

instance MonadTrans (ReaderT r) where
    lift m = ReaderT (\_ -> m)

ask :: Applicative m => ReaderT r m r
ask = ReaderT pure
