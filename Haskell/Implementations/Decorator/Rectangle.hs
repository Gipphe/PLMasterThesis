module Rectangle
    ( Rectangle(..)
    ) where

import Data.List (genericReplicate)
import Display (Display(..))

data Rectangle = MkRectangle
    { width  :: Word
    , height :: Word
    }

instance Display Rectangle where
    display r =
        "Rectangle of size " <> show w <> "x" <> show h <> "\n" <> rectangle
      where
        w         = width r
        h         = height r
        hor       = genericReplicate w '-'
        vert      = "|" <> genericReplicate (w - 2) ' ' <> "|"
        vertSegs  = genericReplicate (h - 2) vert
        rectangle = unlines $ [hor] <> vertSegs <> [hor]
