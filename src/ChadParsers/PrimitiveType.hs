module ChadParsers.PrimitiveType where
import Parsers (Parser, parens)
import Text.Megaparsec (choice)
import Types (PrimitiveType(..))

primitiveType :: Parser PrimitiveType
primitiveType = choice 
    [ parens primitiveType
    , Int <$ "Int"
    , Float <$ "Float"
    , Bool <$ "Bool"
    , Char <$ "Char"
    , String <$ "String"
    ]