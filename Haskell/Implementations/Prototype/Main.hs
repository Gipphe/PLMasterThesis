import Display (Display(..))
import Gun (Gun(..))
import SpaceShip (addPart, mkSpaceShip)
import Structure (Structure(..))
import Thruster (Thruster(..))
import Window (Window(..))

main :: IO ()
main = do
    putStrLn (display smallSpaceShip <> "\n")
    putStrLn (display largeSpaceShip)
  where
    weakThruster    = MkThruster 30
    strongThruster  = MkThruster 70
    normalStructure = MkStructure 100
    strongStructure = MkStructure 250
    window          = MkWindow 25
    weakGun         = MkGun 10
    strongGun       = MkGun 40

    smallSpaceShip =
        (\s -> foldr addPart s $ replicate 10 normalStructure)
            . addPart weakGun
            . addPart weakGun
            . addPart window
            . addPart weakThruster
            . addPart weakThruster
            $ mkSpaceShip "Foo"

    largeSpaceShip =
        (\s -> foldr addPart s $ replicate 20 normalStructure)
            . (\s -> foldr addPart s $ replicate 5 window)
            . (\s -> foldr addPart s $ replicate 5 strongStructure)
            . addPart weakGun
            . addPart strongGun
            . addPart strongGun
            . addPart weakThruster
            . addPart weakThruster
            . addPart strongThruster
            . addPart strongThruster
            $ mkSpaceShip "Bar"
