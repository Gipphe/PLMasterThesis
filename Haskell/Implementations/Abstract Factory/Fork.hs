module Fork
    ( Fork
    , forkLength
    , forkProngs
    , stickFood
    , mkPrimitiveFork
    , mkSilverwareFork
    ) where

data Fork = Fork
    { forkLength :: Int
    , forkProngs :: Int
    , stickFood  :: String -> IO ()
    }

mkPrimitiveFork :: Fork
mkPrimitiveFork = Fork
    { forkLength = 25
    , forkProngs = 1
    , stickFood  = \food -> putStrLn
        (  "You force the stick into the "
        ++ food
        ++ ", mildly squishing the "
        ++ food
        ++ " in the process."
        )
    }

mkSilverwareFork :: Fork
mkSilverwareFork = Fork
    { forkLength = 30
    , forkProngs = 3
    , stickFood  = \food -> putStrLn
        ("You stick the fork gently and elegantly into the " ++ food ++ ".")
    }
