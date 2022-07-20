module Parsers where

import Text.Megaparsec (Parsec, between, some, many)
import qualified Data.Text                  as T
import           Control.Applicative        ((<|>))
import           Control.Monad              (void)
import           Data.Void
import qualified Text.Megaparsec.Char.Lexer as Lexer
import Text.Megaparsec.Char (char, lowerChar, alphaNumChar, upperChar, space1)

type Parser = Parsec Void T.Text

-- Coments
lineComment :: Parser ()
lineComment = Lexer.skipLineComment "--"

blockComment :: Parser ()
blockComment = Lexer.skipBlockCommentNested "{-" "-}"

-- skip space characters and comments
sc :: Parser ()
sc = Lexer.space (void $ some $ char ' ' <|> char '\t') lineComment blockComment

-- skip one or more space characters and comments
scn :: Parser ()
scn = Lexer.space space1 lineComment blockComment

-- modify parser with the ability to skip infinite spaces
lexeme :: Parser a -> Parser a
lexeme = Lexer.lexeme sc

-- looks for keyword
symbol :: T.Text -> Parser T.Text
symbol = Lexer.symbol scn

-- looks for something in parentheses
parens :: Parser a -> Parser a
parens = between (symbol "(") (symbol ")")

-- looks for word that starts from LOWER char
nameL :: Parser T.Text
nameL = lexeme $ do 
    firstChar <- lowerChar
    restChars <- T.pack <$> many alphaNumChar
    pure $ T.cons firstChar restChars

-- looks for word that starts from UPPER char
nameU :: Parser T.Text
nameU = lexeme $ do
    firstChar <- upperChar
    restChars <- T.pack <$> many alphaNumChar
    pure $ T.cons firstChar restChars