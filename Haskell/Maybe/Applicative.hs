instance Applicative Maybe where
    pure :: a -> Maybe a
    pure x = Just x

    (<*>) :: Maybe (a -> b) -> Maybe a -> Maybe b
    Nothing <*> _       = Nothing
    _       <*> Nothing = Nothing
    Just f  <*> Just x  = Just (f x)
