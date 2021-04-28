{-# LANGUAGE NoImplicitPrelude #-}

import Add (Add(..))
import Foldable (Foldable(..))
import LinkedList (LinkedList(..))
import MyPrelude
import qualified Tree as T

main :: IO ()
main = do
    putStrLn "LinkedList"
    printFoldable finalList
    putStrLn "--------"
    putStrLn "BinaryTree"
    printFoldable finalTree
  where
    ll        = Nil
    t         = T.empty
    finalList = ll |> add 11 |> add 35 |> add 34563298 |> add (-12)
    finalTree =
        t
            |> add 34
            |> add 19846
            |> add 1
            |> add 78656
            |> add 2
            |> add 2
            |> T.addFoldable finalList

printFoldable :: (Foldable f, Show a) => f a -> IO ()
printFoldable = foldl
    (\printPrevStep x -> do
        () <- printPrevStep
        putStrLn (show x)
    )
    (pure ())

(|>) :: a -> (a -> b) -> b
a |> f = f a
infixl 0 |>
