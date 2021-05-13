import Crypts (intersperseCrypt, macroCrypt, rotCrypt)
import Encrypter (printEncrypted)

main :: IO ()
main = foldl
    (\prev (c, s) -> do
        prev
        printEncrypted s c
    )
    (pure ())
    sets
  where
    sets =
        [ (intersperse, "Mulligan")
        , (reverse    , "Trireme")
        , (rot        , "Basket")
        , (macro      , "Aqua")
        ]
    intersperse = intersperseCrypt "foo"
    rot         = rotCrypt 11
    macro       = macroCrypt [rot, intersperse, reverse]
