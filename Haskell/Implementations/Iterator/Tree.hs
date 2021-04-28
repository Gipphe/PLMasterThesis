{-# LANGUAGE FlexibleInstances #-}
{-# LANGUAGE InstanceSigs #-}
{-# LANGUAGE MultiParamTypeClasses #-}
{-# LANGUAGE NoImplicitPrelude #-}

module Tree
    ( Tree
    , empty
    , addFoldable
    ) where

import Add (Add(..))
import Foldable (Foldable(..))
import MyPrelude

data Tree a
    = Leaf
    | Node a (Tree a) (Tree a)

instance Foldable Tree where
    foldl :: (b -> a -> b) -> b -> Tree a -> b
    foldl f z Leaf         = z
    foldl f z (Node x l r) = foldl f (f (foldl f z l) x) r

instance Ord a => Add Tree a where
    add :: a -> Tree a -> Tree a
    add x Leaf = Node x Leaf Leaf
    add x (Node y l r)
        | x < y     = Node y (add x l) r
        | otherwise = Node y l (add x r)

empty :: Tree a
empty = Leaf

addFoldable :: (Foldable t, Ord a) => t a -> Tree a -> Tree a
addFoldable f t = foldl (flip add) t f
