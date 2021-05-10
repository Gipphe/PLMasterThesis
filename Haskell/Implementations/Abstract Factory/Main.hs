import Cutlery
    ( CutleryFactory
    , makeCutlery
    , primitiveCutleryFactory
    , silverwareCutleryFactory
    )
import Fork (Fork(..))
import Knife (Knife(..))
import System.Environment (getArgs)
import System.Exit (exitFailure, exitSuccess)

eatWith :: (Knife, Fork) -> String -> IO ()
eatWith (knife, fork) food = do
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
    go "primitive" "sausage"
    putStrLn "-----"
    go "silver" "salad"
  where
    go t f = do
        cutleryFactory <- pickFactory t
        let knifeAndFork = makeCutlery cutleryFactory
        eatWith knifeAndFork f
    safeHead (x : _) = Just x
    safeHead _       = Nothing
