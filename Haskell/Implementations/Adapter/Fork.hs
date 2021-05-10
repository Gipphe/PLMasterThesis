module Fork
    ( Fork(..)
    , SilverFork(..)
    , SteelFork(..)
    , WoodenFork(..)
    ) where

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
