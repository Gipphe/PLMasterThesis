module ColorDecorator
    ( ColorDecorator(..)
    ) where

import Color (Color(..))
import Display (Display(..))

data ColorDecorator c a = MkColorDecorator c a

instance (Display a, Color c) => Display (ColorDecorator c a) where
    display (MkColorDecorator color x) = colorCode color <> display x
