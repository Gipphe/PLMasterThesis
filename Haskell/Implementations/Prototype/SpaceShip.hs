{-# LANGUAGE ExistentialQuantification #-}

module SpaceShip
    ( SpaceShip(..)
    , Part(..)
    , emptySpaceShip
    , addPart
    ) where

import Display (Display(..))

data SpaceShip = MkSpaceShip
    { parts :: [Part]
    }


data Part = forall a . Display a => Part a

instance Display Part where
    display part = case part of
        Part p -> display p

instance Display SpaceShip where
    display (MkSpaceShip parts) = "Space ship with the following parts:\n"
        <> mconcat ((\p -> "  " <> p <> "\n") . display <$> parts)


emptySpaceShip :: SpaceShip
emptySpaceShip = MkSpaceShip []

addPart :: Part -> SpaceShip -> SpaceShip
addPart p (MkSpaceShip parts) = MkSpaceShip (parts <> [p])
