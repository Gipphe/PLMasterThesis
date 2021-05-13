import Add (Add(..))
import qualified LinkedList as L
import qualified Tree as T

main :: IO ()
main = do
    putStrLn "LinkedList"
    printFoldable finalList
    putStrLn "--------"
    putStrLn "BinaryTree"
    printFoldable finalTree
  where
    ll = L.empty
    t  = T.empty
    finalList :: L.LinkedList Int
    finalList = add (-12) $ add 34563298 $ add 35 $ add 11 ll
    finalTree :: T.Tree Int
    finalTree =
        T.addFoldable finalList
            $ add 2
            $ add 2
            $ add 78656
            $ add 1
            $ add 19846
            $ add 34 t

printFoldable :: (Foldable f, Show a) => f a -> IO ()
printFoldable = foldl
    (\evalPrevStep x -> do
        () <- evalPrevStep
        print x
    )
    (pure ())
