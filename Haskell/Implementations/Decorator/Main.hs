{-# LANGUAGE ExistentialQuantification #-}

import BackgroundColor (BackgroundColor(..))
import BaseColor (BaseColor(..))
import BorderDecorator (BorderDecorator(..))
import CharMapDecorator (CharMapDecorator(..))
import Circle (Circle(..))
import ColorDecorator (ColorDecorator(..))
import Control.Monad (forM_)
import Data.Char (toLower, toUpper)
import Display (Display(..))
import FontColor (FontColor(..))
import Rectangle (Rectangle(..))
import Screen (displayOnScreen)
import Square (Square(..))

data Displayable = forall a . Display a => Displayable a

instance Display Displayable where
    display (Displayable x) = display x

main :: IO ()
main = forM_ shapes displayOnScreen
  where
    shapes =
        [ Displayable $ MkBorderDecorator 1 $ MkRectangle 40 10
        , Displayable
            $ MkColorDecorator (MkBackgroundColor Purple)
            $ MkBorderDecorator 2
            $ MkRectangle 10 20
        , Displayable
            $ MkColorDecorator (MkBackgroundColor Green)
            $ MkCharMapDecorator toLower
            $ MkBorderDecorator 1
            $ MkCircle 314
        , Displayable
            $ MkColorDecorator (MkFontColor Red)
            $ MkCharMapDecorator toUpper
            $ MkSquare 11
        ]
