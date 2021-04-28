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
main =
    putStrLn
        $ displayComponent
        $ flip addComponent (addCDROM computer)
        $ addCPU
        $ addRAM mb
  where
    computer = mkChassis "Cheap chassis" 350 :: Component []
    mb       = mkMotherboard "Decent motherboard" 1100
    addRAM   = addComponent (mkRAM "Expensive RAM" 1400 4000000000000)
    addCPU   = addComponent (mkCPU "Good CPU" 2000 "3 GHz")
    addCDROM = addComponent (mkCDROM "Cheap CDROM" 150)
