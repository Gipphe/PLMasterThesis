instance Foldable ((,) e) where
    foldr :: (a -> b -> b) -> b -> (e, a) -> b
    foldr f z (_, x) = f x z
