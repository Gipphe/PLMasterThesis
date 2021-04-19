module Screen
    ( displayOnScreen
    ) where

import Display (Display(..))

displayOnScreen :: Display a => a -> IO ()
displayOnScreen x = do
    putStrLn (display x)
    putStrLn "-------"
