
{-# LANGUAGE PackageImports #-}

module Main where

import "toy-package-a" Data.Tuple (snd)
import "toy-package-a" Toy.A (test)

main :: IO ()
main = print $ snd (True, test)
