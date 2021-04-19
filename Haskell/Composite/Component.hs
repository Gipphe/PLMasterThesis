module Collection
    ( Collection(..)
    ) where

data Collection a
    = One a
    | Many a (Collection a)

instance Functor Collection where
    fmap f (One x      ) = One (f x)
    fmap f (Many x rest) = Many (f x) (fmap f rest)

instance Applicative Collection where
    pure = One
    fs <*> xs = do
        f <- fs
        x <- xs
        pure (f x)

instance Monad Collection where
    One x       >>= f = f x
    Many x rest >>= f = f x <> (rest >>= f)

instance Semigroup (Collection a) where
    One x     <> ys = Many x ys
    Many x xs <> ys = Many x (xs <> ys)

instance Monoid a => Monoid (Collection a) where
    mempty = One mempty
