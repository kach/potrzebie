open String
open Lexing

type expr =
  | EInt of (Lexing.position * int)
  | EFloat of (Lexing.position * float)
  | EVar of (Lexing.position * string)
  | EFun of (Lexing.position * string * (expr list))

type stmt =
  | SExpr of (Lexing.position * expr)
  | SDefn of (Lexing.position * string list * expr * bool)

  | SNewUnit of (Lexing.position * string list)
  | SNewDimension of (Lexing.position * string * expr)

  | SNewPrefix of (Lexing.position * string list * expr)
  | SAutoprefix of (Lexing.position * string list)
