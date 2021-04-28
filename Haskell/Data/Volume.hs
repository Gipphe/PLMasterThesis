data Volume
    = UnMuted Int
    | Muted

instance Semigroup Volume where
    (<>) :: Volume -> Volume -> Volume
    Muted     <> x         = x
    x         <> Muted     = Muted
    UnMuted x <> UnMuted y = UnMuted (clamp (x + y))

instance Monoid Volume where
    mempty :: Volume
    mempty = Muted

clamp :: Int -> Int
clamp = max 0 . min 100
