module Duck
    ( Duck(..)
    , mkDuck
    , moveDuck
    ) where

import Movement (Movement, Position(..))

data Duck = MkDuck
    { name     :: String
    , movement :: Movement
    , pos      :: Position
    }

mkDuck :: String -> Movement -> Duck
mkDuck n m = MkDuck n m (MkPosition 0 0)

moveDuck :: Position -> Duck -> IO Duck
moveDuck dest (MkDuck name moveFn currPos) = do
    putStrLn (name <> " " <> moveFn currPos dest <> ".")
    pure (MkDuck name moveFn dest)
