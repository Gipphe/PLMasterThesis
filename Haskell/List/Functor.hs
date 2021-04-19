instance Functor List where
    fmap :: (a -> b) -> List a -> List b
    fmap _ Nil          = Nil
    fmap f (Const x xs) = Const (f x) (fmap f xs)
