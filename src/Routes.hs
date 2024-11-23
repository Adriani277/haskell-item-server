module Routes (getAll, createItem) where

import CreateItem (CreateItem, toItem)
import Data.IORef
import Domain (Item)
import Network.HTTP.Types.Status (status201)
import System.Random (randomRIO)
import Web.Scotty

getAll :: IORef [Domain.Item] -> ActionM ()
getAll itemsRef = do
  items <- liftAndCatchIO $ readIORef itemsRef
  json items

createItem :: IORef [Domain.Item] -> CreateItem -> ActionM ()
createItem ref item = do
  _ <- liftAndCatchIO $ do
    itemId <- randomRIO (1, 1000)
    created <- toItem item itemId
    atomicModifyIORef ref (\v -> (v ++ [created], ()))
  status status201
