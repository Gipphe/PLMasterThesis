module DrivingMovement
    ( drivingMovement
    ) where

import Movement (Movement, distanceBetween)
import Util (roundTo)

drivingMovement :: Double -> Double -> Movement
drivingMovement minSpeed maxSpeed from to = mconcat
    [ "driving from "
    , show from
    , " to "
    , show to
    , ",\na distance of "
    , round2 distance
    , ",\nat a speed between "
    , round2 minSpeed
    , " and "
    , round2 maxSpeed
    , ",\nwhich will take between "
    , round2 minTime
    , " and "
    , round2 maxTime
    , " seconds"
    , ",\nbut will on average take "
    , round2 avgTime
    , " seconds"
    ]
  where
    distance = distanceBetween from to
    avgSpeed = (maxSpeed + minSpeed) / 2
    maxTime  = distance / minSpeed
    minTime  = distance / maxSpeed
    avgTime  = distance / avgSpeed
    round2   = show . roundTo 2
