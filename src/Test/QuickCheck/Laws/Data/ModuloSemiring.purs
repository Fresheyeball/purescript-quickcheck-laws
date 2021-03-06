module Test.QuickCheck.Laws.Data.ModuloSemiring where

import Console (log)
import Test.QuickCheck (QC(..), quickCheck)
import Test.QuickCheck.Arbitrary (Arbitrary, Coarbitrary)
import Type.Proxy (Proxy())

-- | - Remainder: ```a / b * b + (a `mod` b) = a```
checkModuloSemiring :: forall a. (ModuloSemiring a, Arbitrary a, Eq a) => Proxy a -> QC Unit
checkModuloSemiring _ = do

  log "Checking 'Remainder' law for ModuloSemiring"
  quickCheck remainder

  where

  remainder :: a -> a -> Boolean
  remainder a b = a / b * b + (a `mod` b) == a
