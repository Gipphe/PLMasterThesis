module Knife
    ( Knife(..)
    , SilverKnife(..)
    , WoodenKnife(..)
    , SteelKnife(..)
    , KnifeForkAdapter(..)
    ) where

import Fork (Fork(..))
import Util (sentenceCase)

class Knife knife where
    knifeAppearance :: knife -> String
    knifeType :: knife -> String
    sharpness :: knife -> String
    cutFood :: String -> knife -> String


data SilverKnife = MkSilverKnife

instance Knife SilverKnife where
    knifeAppearance _ = "elegant and exquisite"
    knifeType _ = "silver"
    sharpness _ = "like a razor"
    cutFood food k =
        "You cut the "
            <> food
            <> " with the silver knife. It slices through like the food isn't"
            <> " even there. "
            <> sentenceCase (knifeAppearance k)
            <> "."


data SteelKnife = MkSteelKnife

instance Knife SteelKnife where
    knifeAppearance _ = "dull and boring"
    sharpness _ = "definitely sharp"
    knifeType _ = "steel"
    cutFood food _ =
        "You cut the "
            <> food
            <> " with the steel knife. It cuts the food with ease. It doesn't"
            <> " look spectacular, but it is effective."


data WoodenKnife = MkWoodenKnife

instance Knife WoodenKnife where
    knifeAppearance _ = "like a twig right off of a tree"
    sharpness _ = "nonexistent"
    knifeType _ = "wooden"
    cutFood food _ =
        "You cut the "
            <> food
            <> " with the wooden knife. A challenge, to say the least; you're"
            <> " literally trying to eat a meal with a butter knife..."


newtype KnifeForkAdapter knife = MkKnifeForkAdapter knife

instance Knife knife => Fork (KnifeForkAdapter knife) where
    forkAppearance (MkKnifeForkAdapter k) = knifeAppearance k
    pointiness (MkKnifeForkAdapter k) = "like its sharpness, " <> sharpness k
    stabFood food (MkKnifeForkAdapter k) =
        "You stab the "
            <> food
            <> " with a "
            <> knifeType k
            <> " knife, using it like a single-pronged fork. The knife's"
            <> " sharpness is "
            <> sharpness k
            <> ", which shows in how it handles as a makeshift fork."
