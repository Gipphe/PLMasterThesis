{-# LANGUAGE FlexibleInstances #-}
{-# LANGUAGE MultiParamTypeClasses #-}

module Tree
    ( Tree
    , empty
    , addFoldable
    ) where

import Add (Add(..))

data Tree a
    = Leaf
    | Node a (Tree a) (Tree a)

instance Foldable Tree where
    foldr _ z Leaf         = z
    foldr f z (Node x l r) = foldr f (f x (foldr f z r)) l

instance Ord a => Add Tree a where
    add x Leaf = Node x Leaf Leaf
    add x (Node y l r)
        | x < y     = Node y (add x l) r
        | otherwise = Node y l (add x r)

empty :: Tree a
empty = Leaf

addFoldable :: (Foldable t, Ord a) => t a -> Tree a -> Tree a
addFoldable f t = foldl (flip add) t f
