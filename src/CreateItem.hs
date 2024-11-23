{-# LANGUAGE DeriveGeneric #-}
{-# LANGUAGE RecordWildCards #-}

module CreateItem (CreateItem, toItem) where

import Data.Aeson.Types (FromJSON, ToJSON)
import Data.Time
import Domain (Item (..))
import GHC.Generics (Generic)
import Prelude hiding (id)

data CreateItem = CreateItem
  { name :: String,
    description :: Maybe String
  }
  deriving (Show, Generic)

instance ToJSON CreateItem

instance FromJSON CreateItem

toItem :: CreateItem -> Integer -> IO Item
toItem CreateItem {..} id = do
  time <- Data.Time.getCurrentTime
  return $ Item {id = id, name = name, description = description, createdAt = time}
