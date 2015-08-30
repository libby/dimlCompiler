module Lexer where

import Text.Parsec.String 
import Text.Parsec.Language
import Text.ParserCombinators.Parsec hiding (spaces)

import qualified Text.Parsec.Token as Token

ops :: [String]
ops = words "-> + - * \\ = < <= > >= ; : \\n"

keyWords :: [String]
keyWords = words "true false fun if then else let in Int Bool"

lexer :: Token.TokenParser ()
lexer = Token.makeTokenParser style
  where style = emptyDef { 
                  Token.identStart = letter
                , Token.identLetter = alphaNum <|> char '_'
                , Token.reservedNames = keyWords 
                , Token.reservedOpNames = ops
            }

-- Tokens
integer :: Parser Integer
integer = Token.integer lexer           -- parses an integer

identifier :: Parser String
identifier = Token.identifier lexer     -- parses a valid identifier in diML

reserved :: String -> Parser ()
reserved = Token.reserved lexer         -- parses a reserved word like "if"

reservedOp :: String -> Parser ()
reservedOp = Token.reservedOp lexer     -- parses a reserved operation like "<="

parens :: Parser a -> Parser a
parens = Token.parens lexer             -- parses parens surrounding the parser passed to it

whiteSpace :: Parser ()
whiteSpace = Token.whiteSpace lexer     -- parses whitespace (most used token!)

commaSep :: Parser a -> Parser [a]
commaSep = Token.commaSep lexer         -- parses comma (needed for let exprs)

semiSep :: Parser a -> Parser [a]
semiSep = Token.semiSep lexer           -- semicolons (probably not needed)