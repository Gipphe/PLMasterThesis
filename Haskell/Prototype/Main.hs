{-# LANGUAGE ExistentialQuantification #-}

import Control.Monad (forM_)

class Display a where
    display :: a -> String

data Thruster = MkThruster
    { thrust :: Int
    }

instance Display Thruster where
    display (MkThruster thrust) = "Thruster with " <> show thrust <> " thrust"

data Structure = MkStructure
    { name :: String
    }

instance Display Structure where
    display (MkStructure name) = "Structure " <> name

data Window = MkWindow
    { tint :: Int
    }

instance Display Window where
    display (MkWindow tint) =
        "Window with " <> show tint <> " black tint to it"

data Gun = MkGun
    { power :: Int
    }

instance Display Gun where
    display (MkGun power) = "Gun with " <> show power <> " power"

data Part = forall a . Display a => Part a

instance Display Part where
    display part = case part of
        Part p -> display p

data SpaceShip = MkSpaceShip
    { parts :: [Part]
    }

emptySpaceShip :: SpaceShip
emptySpaceShip = MkSpaceShip []

addPart :: Part -> SpaceShip -> SpaceShip
addPart p (MkSpaceShip parts) = MkSpaceShip (parts <> [p])

displaySpaceShip :: SpaceShip -> String
displaySpaceShip (MkSpaceShip parts) = "Space ship with the following parts:\n"
    <> mconcat ((\p -> "  " <> p <> "\n") . display <$> parts)

main :: IO ()
main = do
    let tp = Part (MkThruster 30)
        sp = Part (MkStructure "")
        wp = Part (MkWindow 50)
        gp = Part (MkGun 10)

        assembleSpaceShip =
            applyNTimes 10 (addPart sp)
                . addPart gp
                . addPart wp
                . addPart tp
                . addPart tp

        finalSpaceShip = assembleSpaceShip emptySpaceShip

    putStrLn (displaySpaceShip finalSpaceShip)

applyNTimes :: Int -> (a -> a) -> a -> a
applyNTimes n f x
    | n <= 0    = x
    | otherwise = applyNTimes (n - 1) f (f x)
