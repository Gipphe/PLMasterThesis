module BipedalMovement
    ( bipedalMovement
    , MovementSpeed(..)
    ) where

import Movement (Movement, distanceBetween)
import Util (roundTo)

data MovementSpeed
    = Walking
    | Running

movementSpeedToDouble :: MovementSpeed -> Double
movementSpeedToDouble m = case m of
    Walking -> 1
    Running -> 3

bipedalMovement :: MovementSpeed -> Movement
bipedalMovement ms from to = mconcat
    [ "walking from "
    , show from
    , " to "
    , show to
    , ",\na distance of "
    , round2 distance
    , ",\nat a speed of "
    , round2 speed
    , ",\nwhich will take "
    , round2 time
    , " seconds"
    ]
  where
    distance = distanceBetween from to
    speed    = movementSpeedToDouble ms
    time     = distance / speed
    round2   = show . roundTo 2
