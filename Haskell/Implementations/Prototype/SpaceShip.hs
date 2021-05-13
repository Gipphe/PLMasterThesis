{-# LANGUAGE ExistentialQuantification #-}

module SpaceShip
    ( SpaceShip(..)
    , Part(..)
    , mkSpaceShip
    , addPart
    ) where

import Display (Display(..))

data Part = forall p . Display p => Part p

instance Display Part where
    display (Part p) = display p

data SpaceShip = MkSpaceShip
    { parts :: [Part]
    , name  :: String
    }

instance Display SpaceShip where
    display (MkSpaceShip ps n) =
        "Space ship "
            <> n
            <> " with "
            <> show (length ps)
            <> " parts:\n"
            <> mconcat ((\p -> "  " <> p <> "\n") . display <$> ps)

mkSpaceShip :: String -> SpaceShip
mkSpaceShip = MkSpaceShip []

addPart :: Display part => part -> SpaceShip -> SpaceShip
addPart p ss = ss { parts = parts ss <> [Part p] }
