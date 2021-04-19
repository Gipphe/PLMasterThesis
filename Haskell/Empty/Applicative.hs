instance Applicative Empty where
    pure :: a -> Empty a
    pure _ = Empty

    (<*>) :: Empty (a -> b) -> Empty a -> Empty b
    _ <*> _ = Empty
