import Component
    ( Component(..)
    , addComponent
    , displayComponent
    , mkCDROM
    , mkCPU
    , mkChassis
    , mkMotherboard
    , mkRAM
    )

main :: IO ()
main = putStrLn $ displayComponent $ addToChassis $ addCPU $ addRAM mb
  where
    computer = mkChassis "Cheap chassis" 350 :: Component []
    addToChassis x = addComponent x (addCDROM computer)
    mb       = mkMotherboard "Decent motherboard" 1100
    addRAM   = addComponent (mkRAM "Expensive RAM" 1400 4000000000000)
    addCPU   = addComponent (mkCPU "Good CPU" 2000 "3 GHz")
    addCDROM = addComponent (mkCDROM "Cheap CDROM" 150)
