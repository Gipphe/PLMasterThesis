module FlightMovement
    ( flightMovement
    ) where

import Movement (Movement, Position, distanceBetween)
import Util (roundTo)

flightMovement :: Double -> Movement
flightMovement speed from to = mconcat
    [ "flies from "
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
    time     = distance / speed
    round2   = show . roundTo 2
