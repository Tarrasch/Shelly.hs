{-# LANGUAGE OverloadedStrings #-}

module LiftedSpec ( liftedSpec ) where

import Test.HUnit hiding (path)
import Test.Hspec
import Shelly.Lifted
import Control.Concurrent.Async.Lifted
import Control.Monad.Trans.Maybe
import Test.Hspec.HUnit ()

liftedSpec :: Spec
liftedSpec = do
  describe "basic actions" $ do
    it "lifted sub" $ do
      xs <- shelly $
          runMaybeT $ do
              xs <- sub $ withTmpDir $ \p -> async $ do
                  writefile (p </> "test.txt") "hello"
                  readfile (p </> "test.txt")
              echo "Hello!"
              wait xs
      xs @?= Just "hello"
