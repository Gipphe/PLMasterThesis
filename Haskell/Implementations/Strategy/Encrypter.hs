module Encrypter
    ( printEncrypted
    ) where

printEncrypted :: String -> (String -> String) -> IO ()
printEncrypted s f = putStrLn ("Original: " <> s <> "\nEncrypted: " <> f s)
