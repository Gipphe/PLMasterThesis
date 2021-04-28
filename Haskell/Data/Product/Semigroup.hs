instance Semigroup Product where
    Product x <> Product y = Product (x * y)
