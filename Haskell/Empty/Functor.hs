instance Functor Empty where
    fmap :: (a -> b) -> Empty a -> Empty b
    fmap _ Empty = Empty
