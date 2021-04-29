{-# LANGUAGE ExistentialQuantification #-}

import Data.List (intercalate)
import Fork
    ( Fork(..)
    , KnifeForkAdapter(..)
    , SilverFork(..)
    , SteelFork(..)
    , WoodenFork(..)
    )
import Knife (Knife(..), SilverKnife(..), SteelKnife(..), WoodenKnife(..))

main :: IO ()
main = putStrLn eatenMeals
  where
    eatenMeals = intercalate "\n-----\n" (eatMeal <$> meals)
    meals =
        [ MkMeal wf   wk  "beef"
        , MkMeal waf  stk "salad"
        , MkMeal stf  sik "sandwich"
        , MkMeal sif  stk "pizza"
        , MkMeal siaf wk  "bread"
        ]

    wk   = MkWoodenKnife
    sik  = MkSilverKnife
    stk  = MkSteelKnife
    wf   = MkWoodenFork
    sif  = MkSilverFork
    stf  = MkSteelFork
    waf  = MkKnifeForkAdapter MkWoodenKnife
    siaf = MkKnifeForkAdapter MkSilverKnife

data Meal = forall k f . (Fork f, Knife k) => MkMeal f k String

eatMeal :: Meal -> String
eatMeal m = case m of
    MkMeal f k food -> cutFood food k <> "\n" <> stabFood food f <> "\nNom"
