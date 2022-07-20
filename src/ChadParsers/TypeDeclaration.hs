module ChadParsers.TypeDeclaration where
import Types (TypeDeclaration(..), RecordDeclaration(..), Type(..))
import Parsers 
import Text.Megaparsec (between, sepBy1)
import qualified Data.Text as T
import ChadParsers.PrimitiveType (primitiveType)

recordField :: Parser (T.Text, Type)
recordField = do 
    fieldName <- nameL
    symbol "::"
    fieldType <- primitiveType

    pure (fieldName, Primitive fieldType)

recordDeclaration :: Parser RecordDeclaration
recordDeclaration = do
    symbol "data"
    name <- nameU
    symbol "="
    symbol name
    fields <- between (symbol "{") (scn >> symbol "}") (sepBy1 recordField (symbol ","))

    pure $ RecordDeclaration {name, fields}
