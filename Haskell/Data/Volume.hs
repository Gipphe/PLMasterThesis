{-# LANGUAGE InstanceSigs #-}

import Test.QuickCheck

data Volume
    = UnMuted Int
    | Muted
    deriving (Eq, Show)

instance Semigroup Volume where
    (<>) :: Volume -> Volume -> Volume
    Muted     <> x         = x
    x         <> Muted     = x
    UnMuted x <> UnMuted y = UnMuted (clamp (x + y))

instance Monoid Volume where
    mempty :: Volume
    mempty = Muted

clamp :: Int -> Int
clamp = max 0 . min 100

main = quickCheck prop_associativity

prop_associativity :: Maybe Int -> Maybe Int -> Maybe Int -> Bool
prop_associativity x y z =
    (eatMaybe x <> eatMaybe y)
        <> eatMaybe z
        == eatMaybe x
        <> (eatMaybe y <> eatMaybe z)
  where
    eatMaybe (Just a) = UnMuted (clamp a)
    eatMaybe Nothing  = Muted
