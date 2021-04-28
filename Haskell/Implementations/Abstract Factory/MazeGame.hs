import Data.List (intersperse)
import System.Environment (getArgs)
import System.Exit (exitSuccess)

type MazeGenerator = Int -> Int -> Maze

data MazeComponent
    = Wall
    | Room

isSolid :: MazeComponent -> Bool
isSolid Wall = True
isSolid Room = False

getSymbol :: MazeComponent -> Char
getSymbol Wall = '#'
getSymbol Room = '.'

instance Show MazeComponent where
    show m = [getSymbol m]

newtype Maze = Maze [[MazeComponent]]

instance Show Maze where
    show (Maze maze) = mconcat (addNewlines (showRows maze))
      where
        showRows    = fmap (mconcat . fmap show)
        addNewlines = intersperse "\n"

generateLineMaze :: MazeGenerator
generateLineMaze sizeX sizeY = Maze (firstHalf <> [middleOne] <> secondHalf)
  where
    firstHalf  = replicate endOfFirstHalf (rowOf Wall)
    secondHalf = replicate (sizeY - startOfSecondHalf) (rowOf Wall)
    middleOne  = [Wall] <> replicate (sizeX - 2) Room <> [Wall]
    rowOf c = replicate sizeX c
    middleRow         = sizeY `div` 2
    endOfFirstHalf    = middleRow
    startOfSecondHalf = middleRow + 1

generateBoxMaze :: MazeGenerator
generateBoxMaze sizeX sizeY = Maze
    ([endPiece, horizontalHall] <> verticalHalls <> [horizontalHall, endPiece])
  where
    endPiece       = replicate sizeX Wall
    horizontalHall = [Wall] <> replicate (sizeX - 2) Room <> [Wall]
    verticalHall   = [Wall, Room] <> replicate (sizeX - 4) Wall <> [Room, Wall]
    verticalHalls  = replicate (sizeY - 4) verticalHall

pickGenerator :: String -> IO MazeGenerator
pickGenerator mazeType = case mazeType of
    "box"  -> pure generateBoxMaze
    "line" -> pure generateLineMaze
    x      -> exitSuccess

main :: IO ()
main = do
    args <- getArgs
    if null args
        then do
            putStrLn "Usage: stack runghc MazeGame.hs -- box|line"
            exitSuccess
        else do
            createMaze <- pickGenerator (head args)
            let maze = createMaze 10 10
            print maze
