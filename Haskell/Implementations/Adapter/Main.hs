import Client (Client(..), eat)
import Data.List (intercalate)
import Fork (SilverFork(..), SteelFork(..), WoodenFork(..))
import Knife
    (KnifeForkAdapter(..), SilverKnife(..), SteelKnife(..), WoodenKnife(..))

main :: IO ()
main = putStrLn eatenMeals
  where
    eatenMeals = intercalate "\n-----\n" (eatPair <$> meals)
    eatPair (c, f) = eat c f
    meals =
        [ (MkClient MkWoodenFork MkWoodenKnife                      , "beef")
        , (MkClient (MkKnifeForkAdapter MkWoodenKnife) MkSteelKnife , "salad")
        , (MkClient MkSteelFork MkSilverKnife, "sandwich")
        , (MkClient MkSilverFork MkSteelKnife                       , "pizza")
        , (MkClient (MkKnifeForkAdapter MkSilverKnife) MkWoodenKnife, "bread")
        ]
