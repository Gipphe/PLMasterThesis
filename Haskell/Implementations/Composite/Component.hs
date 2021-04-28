{-# LANGUAGE FlexibleContexts #-}
{-# LANGUAGE FlexibleInstances #-}
{-# LANGUAGE MultiParamTypeClasses #-}

module Component
    ( Component(..)
    , BasicInfo(..)
    , CDROM(..)
    , Chassis(..)
    , CPU(..)
    , ClockFrequency(..)
    , Motherboard(..)
    , RAM(..)
    , Capacity(..)
    , mkChassis
    , mkCPU
    , mkRAM
    , mkMotherboard
    , mkCDROM
    , addComponent
    , displayComponent
    , componentPrice
    , componentName
    , componentWattage
    ) where

import Data.Monoid (Sum(..))

data Component t
    = CDROM CDROM
    | Chassis Chassis (t (Component t))
    | CPU CPU
    | Motherboard Motherboard (t (Component t))
    | RAM RAM

newtype Price = MkPrice Int

instance Num Price where
    MkPrice x + MkPrice y = MkPrice (x + y)
    MkPrice x - MkPrice y = MkPrice (x - y)
    MkPrice x * MkPrice y = MkPrice (x * y)
    abs (MkPrice x) = MkPrice (abs x)
    signum (MkPrice x) = MkPrice (signum x)
    fromInteger x = MkPrice (fromInteger x)

instance Semigroup Price where
    (<>) = (+)

instance Monoid Price where
    mempty = MkPrice 0

newtype Wattage = MkWattage Int

instance Num Wattage where
    MkWattage x + MkWattage y = MkWattage (x + y)
    MkWattage x - MkWattage y = MkWattage (x - y)
    MkWattage x * MkWattage y = MkWattage (x * y)
    abs (MkWattage x) = MkWattage (abs x)
    signum (MkWattage x) = MkWattage (signum x)
    fromInteger x = MkWattage (fromInteger x)

instance Semigroup Wattage where
    MkWattage x <> MkWattage y = MkWattage (x + y)

instance Monoid Wattage where
    mempty = MkWattage 0

data BasicInfo = MkBasicInfo
    { name  :: String
    , price :: Price
    }

newtype CDROM = MkCDROM BasicInfo

mkCDROM :: String -> Int -> Component t
mkCDROM n p = CDROM (MkCDROM (MkBasicInfo n (MkPrice p)))

newtype Chassis = MkChassis BasicInfo

mkChassis :: Monoid (t (Component t)) => String -> Int -> Component t
mkChassis n p = Chassis (MkChassis (MkBasicInfo n (MkPrice p))) mempty

data CPU = MkCPU BasicInfo ClockFrequency

mkCPU :: String -> Int -> String -> Component t
mkCPU n p hz = CPU (MkCPU (MkBasicInfo n (MkPrice p)) (MkClockFrequency hz))

newtype ClockFrequency = MkClockFrequency String

newtype Motherboard = MkMotherboard BasicInfo

mkMotherboard :: Monoid (t (Component t)) => String -> Int -> Component t
mkMotherboard n p =
    Motherboard (MkMotherboard (MkBasicInfo n (MkPrice p))) mempty

data RAM = MkRAM BasicInfo Capacity

mkRAM :: String -> Int -> Int -> Component t
mkRAM n p c = RAM (MkRAM (MkBasicInfo n (MkPrice p)) (MkCapacity c))

newtype Capacity = MkCapacity Int

class Add t a where
    add :: a -> t a -> t a

instance Add [] a where
    add x xs = xs <> [x]

componentName :: Component t -> String
componentName c = case c of
    CDROM (MkCDROM x)               -> name x
    CPU   (MkCPU x _)               -> name x
    RAM   (MkRAM x _)               -> name x
    Chassis     (MkChassis     x) _ -> name x
    Motherboard (MkMotherboard x) _ -> name x

componentPrice :: Foldable t => Component t -> Price
componentPrice c = case c of
    CDROM (MkCDROM x)                   -> price x
    CPU   (MkCPU x _)                   -> price x
    RAM   (MkRAM x _)                   -> price x
    Chassis     (MkChassis     x) comps -> price x + sumComponentPrices comps
    Motherboard (MkMotherboard x) comps -> price x + sumComponentPrices comps
    where sumComponentPrices = foldMap componentPrice

componentWattage :: Foldable t => Component t -> Wattage
componentWattage c = case c of
    Chassis     _ comps -> sumComponentWattage comps
    Motherboard _ comps -> ownWattage c + sumComponentWattage comps
    _                   -> ownWattage c
    where sumComponentWattage = foldMap componentWattage

ownWattage :: Component t -> Wattage
ownWattage c = case c of
    CDROM _         -> 20
    CPU   _         -> 140
    RAM   _         -> 30
    Chassis     _ _ -> 0
    Motherboard _ _ -> 40

addComponent :: Add t (Component t) => Component t -> Component t -> Component t
addComponent x xs = case xs of
    Chassis     ch comps -> Chassis ch (add x comps)
    Motherboard mb comps -> Motherboard mb (add x comps)
    leaf                 -> leaf

displayComponent :: (Foldable t, Functor t) => Component t -> String
displayComponent c = case c of
    CDROM (MkCDROM x) -> "CDROM\n" <> indent
        (componentStringJoin
            (displayName x : displayPrice c <> displayWattage c)
        )
    CPU (MkCPU x (MkClockFrequency hz)) -> "CPU\n" <> indent
        (componentStringJoin
            (  displayName x
            :  displayPrice c
            <> displayWattage c
            <> ["Clock frequency: " <> hz]
            )
        )
    RAM (MkRAM x (MkCapacity capacity)) -> "RAM\n" <> indent
        (componentStringJoin
            (  displayName x
            :  displayPrice c
            <> displayWattage c
            <> ["Capacity: " <> show capacity <> " B"]
            )
        )
    Chassis (MkChassis x) comps -> "Chassis\n" <> displayComposite x comps
    Motherboard (MkMotherboard x) comps ->
        "Motherboard\n" <> displayComposite x comps
  where
    displayComposite x comps = indent
        (componentStringJoin
            (  displayName x
            :  displayPrice c
            <> displayWattage c
            <> ["Components:\n" <> indent (indent (displayComponents comps))]
            )
        )

displayComponents :: (Foldable t, Functor t) => t (Component t) -> String
displayComponents =
    collectionStringJoin . fmap (indentAfterFirst . displayComponent)

displayName :: BasicInfo -> String
displayName x = "Name: " <> name x

displayPrice :: Foldable t => Component t -> [String]
displayPrice c = case c of
    Chassis (MkChassis x) _ ->
        [ "Own price: " <> showPrice (price x)
        , "Total price: " <> showPrice (componentPrice c)
        ]
    Motherboard (MkMotherboard x) _ ->
        [ "Own price: " <> showPrice (price x)
        , "Total price: " <> showPrice (componentPrice c)
        ]
    CDROM (MkCDROM x) -> ["Price: " <> showPrice (price x)]
    CPU   (MkCPU x _) -> ["Price: " <> showPrice (price x)]
    RAM   (MkRAM x _) -> ["Price: " <> showPrice (price x)]

displayWattage :: Foldable t => Component t -> [String]
displayWattage c = case c of
    Chassis _ comps ->
        (case ownWattage c of
                MkWattage 0 -> []
                w           -> ["Wattage: " <> showWattage w]
            )
            <> ["Total wattage: " <> showWattage (componentWattage c)]
    Motherboard _ comps ->
        [ "Wattage: " <> showWattage (ownWattage c)
        , "Total wattage: " <> showWattage (componentWattage c)
        ]
    _ -> ["Wattage: " <> showWattage (ownWattage c)]

showPrice :: Price -> String
showPrice (MkPrice x) = show x

showWattage :: Wattage -> String
showWattage (MkWattage x) = show x

indent :: String -> String
indent = unlines . fmap ((<>) "  ") . filter (not . null) . lines

indentAfterFirst :: String -> String
indentAfterFirst s = case lines s of
    (x : xs) -> x <> "\n" <> indent (unlines xs)
    []       -> ""

componentStringJoin :: Foldable t => t String -> String
componentStringJoin = mkStringJoin "{ " "\n, " "\n}"

-- collectionStringJoin :: Foldable t => t String -> String
-- collectionStringJoin = foldl (<>) ""

collectionStringJoin :: Foldable t => t String -> String
collectionStringJoin = mkStringJoin "[ " "\n, " "\n]"

mkStringJoin :: Foldable t => String -> String -> String -> t String -> String
mkStringJoin prefix sep postfix ss = prefix <> middle <> postfix
  where
    middle    = drop (length sep) rawMiddle
    rawMiddle = foldl (\rs r -> rs <> sep <> r) "" ss
