instance Semigroup [a] where
    (<>) :: [a] -> [a] -> [a]
    []       <> ys = ys
    (x : xs) <> ys = x : (xs <> ys)
