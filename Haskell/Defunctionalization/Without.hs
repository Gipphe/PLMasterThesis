data Ordering
    = Eq
    | Lt
    | Gt

sortList :: (a -> a -> Ordering) -> [a] -> [a]
sortList f xs = ...
