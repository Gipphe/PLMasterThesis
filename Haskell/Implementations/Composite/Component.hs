{-# LANGUAGE FlexibleContexts #-}
{-# LANGUAGE FlexibleInstances #-}
{-# LANGUAGE MultiParamTypeClasses #-}

module Component
    ( Component(..)
    , BasicInfo(..)
    , ClockFrequency(..)
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
    = CDROM BasicInfo
    | Chassis BasicInfo (t (Component t))
    | CPU BasicInfo ClockFrequency
    | Motherboard BasicInfo (t (Component t))
    | RAM BasicInfo Capacity

newtype ClockFrequency = MkClockFrequency String

newtype Capacity = MkCapacity Int

type Price = Int

type Wattage = Int

data BasicInfo = MkBasicInfo
    { name  :: String
    , price :: Price
    }

mkCDROM :: String -> Int -> Component t
mkCDROM n p = CDROM (MkBasicInfo n p)

mkChassis :: Monoid (t (Component t)) => String -> Int -> Component t
mkChassis n p = Chassis (MkBasicInfo n p) mempty

mkCPU :: String -> Int -> String -> Component t
mkCPU n p hz = CPU (MkBasicInfo n p) (MkClockFrequency hz)

mkMotherboard :: Monoid (t (Component t)) => String -> Int -> Component t
mkMotherboard n p = Motherboard (MkBasicInfo n p) mempty

mkRAM :: String -> Int -> Int -> Component t
mkRAM n p c = RAM (MkBasicInfo n p) (MkCapacity c)

class Add t a where
    add :: a -> t a -> t a

instance Add [] a where
    add x xs = xs <> [x]

componentName :: Component t -> String
componentName c = case c of
    CDROM x         -> name x
    CPU         x _ -> name x
    RAM         x _ -> name x
    Chassis     x _ -> name x
    Motherboard x _ -> name x

componentPrice :: Foldable t => Component t -> Price
componentPrice c = case c of
    CDROM x             -> price x
    CPU         x _     -> price x
    RAM         x _     -> price x
    Chassis     x comps -> price x + sumComponentPrices comps
    Motherboard x comps -> price x + sumComponentPrices comps
    where sumComponentPrices = getSum . foldMap (Sum . componentPrice)

componentWattage :: Foldable t => Component t -> Wattage
componentWattage c = case c of
    Chassis     _ comps -> sumComponentWattage comps
    Motherboard _ comps -> ownWattage c + sumComponentWattage comps
    _                   -> ownWattage c
    where sumComponentWattage = getSum . foldMap (Sum . componentWattage)

ownWattage :: Component t -> Wattage
ownWattage c = case c of
    CDROM _         -> 20
    CPU         _ _ -> 140
    RAM         _ _ -> 30
    Chassis     _ _ -> 0
    Motherboard _ _ -> 40

addComponent :: Add t (Component t) => Component t -> Component t -> Component t
addComponent x xs = case xs of
    Chassis     ch comps -> Chassis ch (add x comps)
    Motherboard mb comps -> Motherboard mb (add x comps)
    leaf                 -> leaf

displayComponent :: (Foldable t, Functor t) => Component t -> String
displayComponent c = case c of
    CDROM x -> "CDROM\n" <> indent
        (componentStringJoin
            (displayName x : displayPrice c <> displayWattage c)
        )
    CPU x (MkClockFrequency hz) -> "CPU\n" <> indent
        (componentStringJoin
            (  displayName x
            :  displayPrice c
            <> displayWattage c
            <> ["Clock frequency: " <> hz]
            )
        )
    RAM x (MkCapacity capacity) -> "RAM\n" <> indent
        (componentStringJoin
            (  displayName x
            :  displayPrice c
            <> displayWattage c
            <> ["Capacity: " <> show capacity <> " B"]
            )
        )
    Chassis     x comps -> "Chassis\n" <> displayComposite x comps
    Motherboard x comps -> "Motherboard\n" <> displayComposite x comps
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
    Chassis x _ ->
        [ "Own price: " <> show (price x)
        , "Total price: " <> show (componentPrice c)
        ]
    Motherboard x _ ->
        [ "Own price: " <> show (price x)
        , "Total price: " <> show (componentPrice c)
        ]
    CDROM x -> ["Price: " <> show (price x)]
    CPU x _ -> ["Price: " <> show (price x)]
    RAM x _ -> ["Price: " <> show (price x)]

displayWattage :: Foldable t => Component t -> [String]
displayWattage c = case c of
    Chassis _ _ ->
        (case ownWattage c of
                0 -> []
                w -> ["Wattage: " <> show w]
            )
            <> ["Total wattage: " <> show (componentWattage c)]
    Motherboard _ _ ->
        [ "Wattage: " <> show (ownWattage c)
        , "Total wattage: " <> show (componentWattage c)
        ]
    _ -> ["Wattage: " <> show (ownWattage c)]

indent :: String -> String
indent = unlines . fmap ((<>) "  ") . filter (not . null) . lines

indentAfterFirst :: String -> String
indentAfterFirst s = case lines s of
    (x : xs) -> x <> "\n" <> indent (unlines xs)
    []       -> ""

componentStringJoin :: Foldable t => t String -> String
componentStringJoin = mkStringJoin "{ " "\n, " "\n}"

collectionStringJoin :: Foldable t => t String -> String
collectionStringJoin = mkStringJoin "[ " "\n, " "\n]"

mkStringJoin :: Foldable t => String -> String -> String -> t String -> String
mkStringJoin prefix sep postfix ss = prefix <> middle <> postfix
  where
    middle    = drop (length sep) rawMiddle
    rawMiddle = foldl (\rs r -> rs <> sep <> r) "" ss
