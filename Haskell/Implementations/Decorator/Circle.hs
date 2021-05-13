module Circle
    ( Circle(..)
    ) where

import Display (Display(..))

newtype Circle = MkCircle
    { circleRadius :: Int
    }

instance Display Circle where
    display (MkCircle radius) =
        "Circle with radius "
            <> show radius
            <> "\nDrawing circles\nin a terminal\nis too hard."
