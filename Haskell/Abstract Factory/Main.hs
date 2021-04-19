import System.Environment (getArgs)
import System.Exit (exitFailure, exitSuccess)

data CutleryFactory = CutleryFactory
    { makeFork  :: Fork
    , makeKnife :: Knife
    }

data Fork = Fork
    { forkLength :: Int
    , forkProngs :: Int
    , stickFood  :: String -> IO ()
    }

data Knife = Knife
    { knifeWeight      :: Int
    , knifeDoubleEdged :: Bool
    , cutFood          :: String -> IO ()
    }

primitiveCutleryFactory :: CutleryFactory
primitiveCutleryFactory =
    CutleryFactory { makeFork = mkPrimitiveFork, makeKnife = mkPrimitiveKnife }

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

silverwareCutleryFactory :: CutleryFactory
silverwareCutleryFactory = CutleryFactory
    { makeFork  = mkSilverwareFork
    , makeKnife = mkSilverwareKnife
    }

mkSilverwareFork :: Fork
mkSilverwareFork = Fork
    { forkLength = 30
    , forkProngs = 3
    , stickFood  = \food -> putStrLn
        ("You stick the fork gently and elegantly into the " ++ food ++ ".")
    }

mkSilverwareKnife :: Knife
mkSilverwareKnife = Knife
    { knifeWeight      = 240
    , knifeDoubleEdged = False
    , cutFood          = \food ->
        putStrLn ("The " ++ food ++ " slices easily, and with finesse.")
    }

data KnifeAndForkHolder = KnifeAndForkHolder Knife Fork

makeCutlery :: CutleryFactory -> KnifeAndForkHolder
makeCutlery factory = KnifeAndForkHolder (makeKnife factory) (makeFork factory)

eatWith :: KnifeAndForkHolder -> String -> IO ()
eatWith (KnifeAndForkHolder knife fork) food = do
    stickFood fork food
    cutFood knife food

pickFactory :: String -> IO CutleryFactory
pickFactory cutleryType = case cutleryType of
    "primitive" -> pure primitiveCutleryFactory
    "silver"    -> pure silverwareCutleryFactory
    unknownType -> do
        putStrLn ("Unrecognized cutlery type: " ++ unknownType)
        exitFailure

main :: IO ()
main = do
    args <- getArgs
    if null args
        then do
            putStrLn "Usage: stack runghc Main.hs -- primitive|silver"
            exitSuccess
        else do
            let cutleryType = head args
            cutleryFactory <- pickFactory cutleryType
            let holder = makeCutlery cutleryFactory
            eatWith holder "sausage"
