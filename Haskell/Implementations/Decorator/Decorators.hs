module Decorators
    ( BorderColorDecorator(..)
    , BorderWidthDecorator(..)
    , ColorDecorator(..)
    , OpacityDecorator(..)
    , UpperCaseDecorator(..)
    ) where

import Data.Char (toUpper)
import Display (Display(..))

data BorderColorDecorator a = MkBorderColorDecorator
    { borderColor          :: String
    , borderColorContained :: a
    }

instance Display a => Display (BorderColorDecorator a) where
    display (MkBorderColorDecorator borderColor x) =
        display x <> "\nBorder color: " <> borderColor

data BorderWidthDecorator a = MkBorderWidthDecorator
    { borderWidth          :: Int
    , borderWidthContained :: a
    }

instance Display a => Display (BorderWidthDecorator a) where
    display (MkBorderWidthDecorator borderWidth x) =
        display x <> "\nBorder width: " <> show borderWidth

data ColorDecorator a = MkColorDecorator
    { color          :: String
    , colorContained :: a
    }

instance Display a => Display (ColorDecorator a) where
    display (MkColorDecorator color x) = display x <> "\nColor: " <> color

data OpacityDecorator a = MkOpacityDecorator
    { opacity          :: Int
    , opacityContained :: a
    }

instance Display a => Display (OpacityDecorator a) where
    display (MkOpacityDecorator opacity x) =
        display x <> "\nOpacity: " <> show opacity

data UpperCaseDecorator a = MkUpperCaseDecorator a

instance Display a => Display (UpperCaseDecorator a) where
    display (MkUpperCaseDecorator x) = fmap toUpper (display x)
