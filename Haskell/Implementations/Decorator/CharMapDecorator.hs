module CharMapDecorator
    ( CharMapDecorator(..)
    ) where

import Display (Display(..))

data CharMapDecorator a = MkCharMapDecorator (Char -> Char) a

instance Display a => Display (CharMapDecorator a) where
    display (MkCharMapDecorator f x) = f <$> display x
