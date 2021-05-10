module Cutlery
    ( CutleryFactory
    , makeCutlery
    , primitiveCutleryFactory
    , silverwareCutleryFactory
    ) where

import Fork (Fork, mkPrimitiveFork, mkSilverwareFork)
import Knife (Knife, mkPrimitiveKnife, mkSilverwareKnife)

data CutleryFactory = CutleryFactory
    { makeFork  :: Fork
    , makeKnife :: Knife
    }

makeCutlery :: CutleryFactory -> (Knife, Fork)
makeCutlery factory = (makeKnife factory, makeFork factory)


primitiveCutleryFactory :: CutleryFactory
primitiveCutleryFactory =
    CutleryFactory { makeFork = mkPrimitiveFork, makeKnife = mkPrimitiveKnife }


silverwareCutleryFactory :: CutleryFactory
silverwareCutleryFactory = CutleryFactory
    { makeFork  = mkSilverwareFork
    , makeKnife = mkSilverwareKnife
    }
