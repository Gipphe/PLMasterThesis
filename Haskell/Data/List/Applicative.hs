concat :: List a -> List a -> List a
concat Nil         ys = ys
concat (Cons x xs) ys = Cons x (concat xs ys)

flatten :: List (List a) -> List a
flatten Nil            = Nil
flatten (Const xs xss) = concat xs (flatten xss)

instance Applicative List where
    pure :: a -> List a
    pure x = Const x Nil

    (<*>) :: List (a -> b) -> List a -> List b
    Empty <*> _     = Empty
    _     <*> Empty = Empty
    fs    <*> xs    = flatten (fmap (\f -> fmap f xs) fs)
