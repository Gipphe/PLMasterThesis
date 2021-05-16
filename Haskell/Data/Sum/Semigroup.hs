instance Semigroup Sum where
    Sum x <> Sum y = Sum (x + y)
