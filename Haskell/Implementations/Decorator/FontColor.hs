module FontColor
    ( FontColor(..)
    , defaultColor
    ) where

import BaseColor (BaseColor(..))
import Color (Color(..))

newtype FontColor = MkFontColor BaseColor

instance Color FontColor where
    colorCode (MkFontColor c) = "\x001b[" <> cc <> "m"
      where
        cc = case c of
            Black     -> "30"
            Red       -> "31"
            Green     -> "32"
            Yellow    -> "33"
            Blue      -> "34"
            Purple    -> "35"
            LightBlue -> "36"
            White     -> "37"

defaultColor :: FontColor
defaultColor = MkFontColor White
