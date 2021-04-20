instance Foldable [a] where
    foldr :: (a -> b -> b) -> b -> [a] -> b
    foldr _ z []       = z
    foldr f z (x : xs) = f x (foldr f z xs)
