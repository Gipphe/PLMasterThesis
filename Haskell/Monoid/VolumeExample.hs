data Volume
        = UnMuted Int
        | Muted

instance Semigroup Volume where
    (<>) :: Volume -> Volume -> Volume
    Muted     <> x         = x
    x         <> Muted     = x
    UnMuted x <> UnMuted y = UnMuted (x + y)

instance Monoid Volume where
    mempty :: Volume
    mempty = Muted
