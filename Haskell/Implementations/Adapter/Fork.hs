module Fork
    ( Fork(..)
    , SilverFork(..)
    , SteelFork(..)
    , WoodenFork(..)
    , KnifeForkAdapter(..)
    ) where

import Knife (Knife(..))

class Fork fork where
    forkAppearance :: fork -> String
    pointiness :: fork -> String
    stabFood :: String -> fork -> String

data SilverFork = MkSilverFork

instance Fork SilverFork where
    forkAppearance _ = "elegant and exquisite"
    pointiness _ = "flawless"
    stabFood food f =
        "You stab the "
            <> food
            <> " with the silver fork. It looks "
            <> forkAppearance f
            <> ", and its pointiness is "
            <> pointiness f
            <> "."

data SteelFork = MkSteelFork

instance Fork SteelFork where
    forkAppearance _ = "dull and boring"
    pointiness _ = "adequate for any meal"
    stabFood food f =
        "You stab the "
            <> food
            <> " with the steel fork. Its pointiness is "
            <> pointiness f
            <> ", even though its apperance is "
            <> forkAppearance f

data WoodenFork = MkWoodenFork

instance Fork WoodenFork where
    forkAppearance _ = "like a twig right off of a tree"
    pointiness _ = "lackluster at best, blunt at worst"
    stabFood food _ =
        "You stab the "
            <> food
            <> " with the wooden fork. The fork isn't very pointy, and you end"
            <> " up smushing your "
            <> food

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
