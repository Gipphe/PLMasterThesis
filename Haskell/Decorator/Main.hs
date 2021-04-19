{-# LANGUAGE ExistentialQuantification #-}

import Control.Monad (forM_)
import Decorators
    ( BorderColorDecorator(..)
    , BorderWidthDecorator(..)
    , ColorDecorator(..)
    , OpacityDecorator(..)
    , UpperCaseDecorator(..)
    )
import Display
import Screen
import Shapes

data Displayable = forall a . Display a => Displayable a

instance Display Displayable where
    display (Displayable x) = display x

main :: IO ()
main = forM_ shapes displayOnScreen
  where
    rectangle =
        MkColorDecorator "Magenta"
            (MkBorderWidthDecorator 2
                (MkRectangle 10 20))
    circle =
        MkBorderColorDecorator "Cyan"
            (MkBorderWidthDecorator 1
                (MkCircle 314))
    square =
        MkUpperCaseDecorator
            (MkColorDecorator "Black"
                (MkSquare 11))
    shapes =
        [ Displayable rectangle
        , Displayable circle
        , Displayable square
        ]
