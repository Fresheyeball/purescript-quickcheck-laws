module Test.QuickCheck.Laws.Control.Extend where

import Console (log)
import Control.Extend (Extend, (<<=))
import Test.QuickCheck (QC(..), quickCheck)
import Test.QuickCheck.Arbitrary (Arbitrary, Coarbitrary)
import Type.Proxy (Proxy(), Proxy2())

-- | - Associativity: `extend f <<< extend g = extend (f <<< extend g)`
checkExtend :: forall w a b c. (Extend w,
                                Arbitrary (w a),
                                Arbitrary (w a -> b),
                                Arbitrary (w b -> c),
                                Eq (w c)) => Proxy2 w
                                          -> Proxy a
                                          -> Proxy b
                                          -> Proxy c
                                          -> QC Unit
checkExtend _ _ _ _ = do

  log "Checking 'Associativity' law for Extend"
  quickCheck associativity

  where

  associativity :: (w b -> c) -> (w a -> b) -> w a -> Boolean
  associativity f g x = ((f <<=) <<< (g <<=) $ x) == (f <<< (g <<=) <<= x)
