import Control.Monad (forM_)
import Display (Display(..))
import Gun (Gun(..))
import SpaceShip (Part(..), SpaceShip, addPart, emptySpaceShip)
import Structure (Structure(..))
import Thruster (Thruster(..))
import Window (Window(..))

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

    putStrLn (display finalSpaceShip)

applyNTimes :: Int -> (a -> a) -> a -> a
applyNTimes n f x
    | n <= 0    = x
    | otherwise = applyNTimes (n - 1) f (f x)
