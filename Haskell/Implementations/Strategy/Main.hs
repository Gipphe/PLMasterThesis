import BipedalMovement (MovementSpeed(..), bipedalMovement)
import DrivingMovement (drivingMovement)
import Duck (mkDuck, moveDuck)
import FlightMovement (flightMovement)
import Movement (Position(..))
import System.Random (mkStdGen, randomIO, setStdGen)

main :: IO ()
main = do
    setStdGen (mkStdGen 1234)
    putStrLn "Round 1\n-----"
    newDucks <- traverse
        (\d -> do
            nd <- doMove d
            putStrLn "-----"
            pure nd
        )
        ducks
    putStrLn "Round 2"
    _ <- traverse
        (\d -> do
            putStrLn "-----"
            doMove d
        )
        newDucks
    pure ()
  where
    doMove duck = do
        i <- randomIO
        let
            newPos = MkPosition
                (posX maxPos * i + posX minPos)
                (posY maxPos * i + posY minPos)
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
