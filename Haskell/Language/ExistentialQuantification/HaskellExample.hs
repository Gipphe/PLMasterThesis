{-# LANGUAGE ExistentialQuantification #-}

import Control.Monad (forM_)

class Display a where
    display :: a -> String

data AnyDisplay =
    forall a . Display a => MkAnyDisplay a

instance Display AnyDisplay where
    display (MkAnyDisplay x) = display x

data Foo = Foo

instance Display Foo where
    display Foo = "Foo"

data Bar = Bar

instance Display Bar where
    display Bar = "Bar"

data Baz = Baz

instance Display Baz where
    display Baz = "Baz"

main :: IO ()
main = forM_ list (putStrLn . display)
  where
    list :: [AnyDisplay]
    list =
        [ MkAnyDisplay Foo
        , MkAnyDisplay Bar
        , MkAnyDisplay Baz
        ]
