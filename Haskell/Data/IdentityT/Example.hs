newtype IdentityT m a = IdentityT { runIdentityT :: m a }

instance Functor m => Functor (IdentityT m) where
    fmap f (IdentityT m) = IdentityT (fmap f m)

instance Applicative m => Applicative (IdentityT m) where
    pure x = IdentityT (pure x)
    IdentityT f <*> IdentityT x = IdentityT (f <*> x)

instance Monad m => Monad (IdentityT m) where
    IdentityT m >>= k = IdentityT $ do
        v <- m
        runIdentityT (k v)
