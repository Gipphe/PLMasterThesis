module Shapes
    ( Rectangle(..)
    , Square(..)
    , Circle(..)
    ) where

import Display (Display(..))

data Rectangle = MkRectangle
    { rectangleWidth  :: Int
    , rectangleHeight :: Int
    }

instance Display Rectangle where
    display (MkRectangle width height) =
        "Rectangle of size " <> show width <> "x" <> show height

data Square = MkSquare
    { squareSize :: Int
    }

instance Display Square where
    display (MkSquare size) =
        "Square of size " <> show size <> "x" <> show size

data Circle = MkCircle
    { circleRadius :: Int
    }

instance Display Circle where
    display (MkCircle radius) = "Circle with radius " <> show radius
