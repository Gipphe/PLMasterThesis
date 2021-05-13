module Movement
    ( Movement
    , Position(..)
    , distanceBetween
    ) where

import Util (roundTo)

type Movement = Position -> Position -> String

data Position = MkPosition
    { posX :: Double
    , posY :: Double
    }

instance Show Position where
    show (MkPosition x y) = "(" <> round2 x <> ", " <> round2 y <> ")"
        where round2 = show . roundTo 2

distanceBetween :: Position -> Position -> Double
distanceBetween (MkPosition ax ay) (MkPosition bx by) =
    sqrt ((bx - ax) ^ 2 + (by - ay) ^ 2)
