class Foo a where
    foo :: a -> a

instance Foo Int where
    foo x = x
