{-# LANGUAGE FlexibleInstances #-}
{-# LANGUAGE InstanceSigs #-}
{-# LANGUAGE MultiParamTypeClasses #-}
{-# LANGUAGE NoImplicitPrelude #-}

module LinkedList
    ( LinkedList(..)
    ) where

import Add (Add(..))
import Foldable (Foldable(..))
import MyPrelude

data LinkedList a
    = Nil
    | Cons a (LinkedList a)

instance Foldable LinkedList where
    foldl :: (b -> a -> b) -> b -> LinkedList a -> b
    foldl f z Nil         = z
    foldl f z (Cons x xs) = foldl f (f z x) xs

-- LinkedList's Add instance appends to the linked list.
instance Add LinkedList a where
    add :: a -> LinkedList a -> LinkedList a
    add x Nil         = Cons x Nil
    add x (Cons y ys) = Cons y (add x ys)
