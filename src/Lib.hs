module Lib
  ( greet,
    getName,
    greetUser,
  )
where

import Control.Monad.Reader

greet :: String -> IO ()
greet name = putStrLn $ "Hello, " ++ name ++ "!"

getName :: IO String
getName = do
  putStrLn "What is your name?"
  getLine

greetUser :: ReaderT String IO ()
greetUser =
  ask >>= \prep -> liftIO $ do
    name <- getName
    _ <- greet $ prep ++ name
    return ()
