newtype StateT s m a = StateT { runStateT :: s -> m (s, a) }

instance Functor m => Functor (StateT s m) where
    fmap f m = StateT (fmap (\(s', x) -> (s', f x)) . runStateT m)

instance Monad m => Applicative (StateT s m) where
    pure x = StateT (\s -> pure (s, x))

    StateT sf <*> StateT sm = StateT
        (\s -> do
            (s' , f) <- sf s
            (s'', x) <- sm s'
            pure (s'', f x)
        )

instance Monad m => Monad (StateT s m) where
    m >>= k = StateT
        (\s -> do
            (s', x) <- runStateT m s
            runStateT (k x) s'
        )

instance MonadTrans (StateT s) where
    lift m = StateT
        (\s -> do
            v <- m
            pure (s, v)
        )

get :: Applicative m => StateT s m s
get = StateT $ \s -> pure (s, s)

put :: Applicative m => s -> StateT s m ()
put x = StateT $ \_ -> pure (x, ())
