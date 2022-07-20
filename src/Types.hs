module Types where

import qualified Data.Text as T

data PrimitiveType
    = Int
    | Float
    | Bool
    | Char
    | String
    
    deriving Show

newtype Type = Primitive PrimitiveType deriving Show

data RecordDeclaration = RecordDeclaration
    { name   :: T.Text
    , fields :: [(T.Text, Type)]
    } deriving Show

newtype TypeDeclaration = Record RecordDeclaration