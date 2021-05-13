module BackgroundColor
    ( BackgroundColor(..)
    , defaultColor
    ) where

import BaseColor (BaseColor(..))
import Color (Color(..))

newtype BackgroundColor = MkBackgroundColor BaseColor

instance Color BackgroundColor where
    colorCode (MkBackgroundColor c) = "\x001b[" <> cc <> "m"
      where
        cc = case c of
            Black     -> "40"
            Red       -> "41"
            Green     -> "42"
            Yellow    -> "43"
            Blue      -> "44"
            Purple    -> "45"
            LightBlue -> "46"
            White     -> "47"

defaultColor :: BackgroundColor
defaultColor = MkBackgroundColor Black
