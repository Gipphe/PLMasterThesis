newtype ExceptT e m a = ExceptT { runExceptT :: m (Either e a) }

instance Functor m => Functor (ExceptT e m) where
    fmap f (ExceptT m) = ExceptT (fmap (fmap f) m)

instance (Monad m) => Applicative (ExceptT e m) where
    pure x = ExceptT (pure (Right x))
    ExceptT f <*> ExceptT v = ExceptT $ do
        mf <- f
        case mf of
            Left  e -> pure (Left e)
            Right k -> do
                mv <- v
                case mv of
                    Left  e -> pure (Left e)
                    Right x -> pure (Right (k x))

instance (Monad m) => Monad (ExceptT e m) where
    ExceptT m >>= k = ExceptT $ do
        a <- m
        case a of
            Left  e -> pure (Left e)
            Right x -> runExceptT (k x)

throwE :: Applicative m => e -> ExceptT e m a
throwE e = ExceptT (pure (Left e))

catchE :: Applicative m
       => ExceptT e m a
       -> (e -> ExceptT e' m a)
       -> ExceptT e' m a
catchE m handler = ExceptT $ do
    ma <- runExceptT m
    case a of
        Left  e -> runExceptT (handler e)
        Right x -> pure (Right x)
