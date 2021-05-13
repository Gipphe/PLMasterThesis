import BipedalMovement (MovementSpeed(..), bipedalMovement)
import Data.List (intersperse)
import DrivingMovement (drivingMovement)
import Duck (Duck, mkDuck, moveDuck)
import FlightMovement (flightMovement)
import Movement (Position(..))
import System.Random (mkStdGen, randomIO, setStdGen)

main :: IO ()
main = do
    setStdGen (mkStdGen 1234)
    putStrLn ("Round 1\n" <> sep)
    movedDucks <- moveAll ducks
    putStrLn (sep <> "\nRound 2\n" <> sep)
    _ <- moveAll movedDucks
    pure ()
  where
    moveAll :: [Duck] -> IO [Duck]
    moveAll []     = pure []
    moveAll [duck] = do
        newDuck <- doMove duck
        pure [newDuck]
    moveAll (duck : ducks) = do
        newDuck <- doMove duck
        putStrLn sep
        newDucks <- moveAll ducks
        pure (newDuck : newDucks)

    doMove :: Duck -> IO Duck
    doMove duck = do
        rx <- randomIO
        ry <- randomIO
        let
            newPos = MkPosition
                (posX maxPos * rx + posX minPos)
                (posY maxPos * ry + posY minPos)
        moveDuck newPos duck

    ducks =
        [ mkDuck "Grace"  (bipedalMovement Walking)
        , mkDuck "Tim"    (drivingMovement 5 12)
        , mkDuck "Alan"   (flightMovement 20)
        , mkDuck "Donald" (bipedalMovement Running)
        , mkDuck "John"   (drivingMovement 7 16)
        ]

    minPos = MkPosition 0 0
    maxPos = MkPosition 300 300
    rand   = mkStdGen 1234
    sep    = "-----"
