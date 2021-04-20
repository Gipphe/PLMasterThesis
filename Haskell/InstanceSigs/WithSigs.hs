class Foo a where
    foo :: a -> a

instance Foo Int where
    foo :: Int -> Int
    foo x = x
