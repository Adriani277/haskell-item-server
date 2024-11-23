{-# LANGUAGE DeriveGeneric #-}

module Domain (Item (..)) where

import Data.Aeson (FromJSON, ToJSON)
import Data.Time (UTCTime)
import GHC.Generics (Generic)
import Prelude hiding (id)

data Item = Item
  { id :: Integer,
    name :: String,
    description :: Maybe String,
    createdAt :: UTCTime
  }
  deriving (Show, Generic)

instance ToJSON Item

instance FromJSON Item
