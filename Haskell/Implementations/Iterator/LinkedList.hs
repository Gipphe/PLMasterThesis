{-# LANGUAGE FlexibleInstances #-}
{-# LANGUAGE MultiParamTypeClasses #-}

module LinkedList
    ( LinkedList(..)
    , empty
    , addFoldable
    ) where

import Add (Add(..))

data LinkedList a
    = Nil
    | Cons a (LinkedList a)

instance Foldable LinkedList where
    foldr _ z Nil         = z
    foldr f z (Cons x xs) = foldr f (f x z) xs

-- LinkedList's Add instance appends to the linked list.
instance Add LinkedList a where
    add x Nil         = Cons x Nil
    add x (Cons y ys) = Cons y (add x ys)

empty :: LinkedList a
empty = Nil

addFoldable :: (Foldable t, Ord a) => t a -> LinkedList a -> LinkedList a
addFoldable f t = foldr add t f
