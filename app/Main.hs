{-# LANGUAGE DeriveGeneric #-}
{-# LANGUAGE OverloadedStrings #-}

import Data.IORef (IORef, newIORef)
import Domain (Item)
import Routes
import Web.Scotty

main :: IO ()
main = do
  str <- itemStorage
  server str

server :: IORef [Item] -> IO ()
server storage =
  scotty 8080 $ do
    get "/items" $ do
      Routes.getAll storage
      
    post "/item" $ do
      inp <- jsonData
      Routes.createItem storage inp

itemStorage :: IO (IORef [Item])
itemStorage = newIORef []
