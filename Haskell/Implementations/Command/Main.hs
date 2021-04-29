import MailServer (ConsoleMailServer(..))
import Operator (human1, human2)

main :: IO ()
main = do
    human1 ms
    putStrLn "-----"
    human2 ms
    where ms = MkConsoleMailServer
