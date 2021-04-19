{-# LANGUAGE ExistentialQuantification #-}

-- | Example code used to explain the metrics used
-- in this thesis.

import Data.Foldable (traverse_)

class Speaker a where
    speak :: a -> IO ()

newtype Canine = Canine { sound :: String }

instance Speaker Canine where
    speak (Canine sound) = putStrLn sound

type Dog = Canine

type Wolf = Canine

mkDog :: Dog
mkDog = Canine "Woof"

mkWolf :: Wolf
mkWolf = Canine "Awoo"

newtype Cat = Cat { size :: Int }

mkCat :: Int -> Cat
mkCat = Cat

instance Speaker Cat where
    speak (Cat size) = if size > 2
        then rawr
        else meow
      where
        meow = putStrLn "Meow"
        rawr = putStrLn "Rawr"

-- ExistentialQuantification used here
data SomeSpeaker =
    forall a . Speaker a => SomeSpeaker a

instance Speaker SomeSpeaker where
    speak (SomeSpeaker x) = speak x

main :: IO ()
main = do
    let
        zoo =
            [ SomeSpeaker (mkCat 1)
            , SomeSpeaker (mkCat 3)
            , SomeSpeaker mkDog
            , SomeSpeaker mkWolf
            ]
    traverse_ speak zoo
