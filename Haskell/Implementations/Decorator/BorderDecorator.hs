module BorderDecorator
    ( BorderDecorator(..)
    ) where

import Display (Display(..))

data BorderDecorator a = MkBorderDecorator Int a

instance Display a => Display (BorderDecorator a) where
    display (MkBorderDecorator thickness x) =
        unlines
        $  horBorders
        <> [spacer]
        <> xWithBorders
        <> [spacer]
        <> horBorders
      where
        displayedLines = lines $ display x
        longestLine    = foldr (max . length) 0 displayedLines
        horBorder      = replicate (longestLine + 2 + thickness * 2) '-'
        horBorders     = replicate thickness horBorder
        verticalBorder = replicate thickness '|'
        spacer =
            verticalBorder <> replicate (longestLine + 2) ' ' <> verticalBorder
        xWithBorders = addBorder . padRight ' ' longestLine <$> displayedLines
        addBorder s = verticalBorder <> " " <> s <> " " <> verticalBorder
        padRight c n s = s <> replicate remaining c
            where remaining = n - length s
