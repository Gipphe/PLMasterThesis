instance Functor List where
    fmap :: (a -> b) -> List a -> List b
    fmap _ Nil         = Nil
    fmap f (Cons x xs) = Cons (f x) (fmap f xs)
