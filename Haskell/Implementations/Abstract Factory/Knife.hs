module Knife
    ( Knife
    , knifeWeight
    , knifeDoubleEdged
    , cutFood
    , mkPrimitiveKnife
    , mkSilverwareKnife
    ) where

data Knife = Knife
    { knifeWeight      :: Int
    , knifeDoubleEdged :: Bool
    , cutFood          :: String -> IO ()
    }

mkPrimitiveKnife :: Knife
mkPrimitiveKnife = Knife
    { knifeWeight      = 110
    , knifeDoubleEdged = True
    , cutFood          = \food -> putStrLn
        (  "You attempt to cut the "
        ++ food
        ++ ", but you instead end up clumsily crushing it."
        )
    }

mkSilverwareKnife :: Knife
mkSilverwareKnife = Knife
    { knifeWeight      = 240
    , knifeDoubleEdged = False
    , cutFood          = \food ->
        putStrLn ("The " ++ food ++ " slices easily, and with finesse.")
    }
