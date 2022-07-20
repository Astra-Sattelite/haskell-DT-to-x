module LibTests where

import Parsers
import ChadParsers.TypeDeclaration
import Text.Megaparsec (parseTest)
import qualified Data.Text as T

parseRecord :: IO ()
parseRecord = do
    file <- readFile "./TestData.hs"
    parseTest recordDeclaration (T.pack file)
