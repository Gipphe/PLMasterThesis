module Screen
    ( displayOnScreen
    ) where

import qualified BackgroundColor as B
import Color (colorCode)
import Display (Display(..))
import qualified FontColor as F

displayOnScreen :: Display a => a -> IO ()
displayOnScreen x = do
    putStrLn (display x)
    resetColors
    putStrLn ""

resetColors :: IO ()
resetColors = do
    putStr (colorCode B.defaultColor)
    putStr (colorCode F.defaultColor)
