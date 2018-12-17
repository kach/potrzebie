{
open Lexing
open Parser
}

let open_comment = "(*"
let shut_comment = "*)"
let whitespace = [' ' '\t' '\n']

rule main = parse
| eof { EOF }

| "new" { NEW }
| "unit" { UNIT }
| "dimension" { DIMENSION }
| "measured" { MEASURED }
| "in" { IN }

| "prefix" { PREFIX }
| "autoprefix" { AUTOPREFIX }

| "(" { OPEN_P }
| ")" { SHUT_P }
| "[" { OPEN_B }
| "]" { SHUT_B }
| "," { COMMA }
| ";" { SEMI }
| "=" { EQUALS }
| "^=" { CARETEQUALS }

| "+" { OP_ADD }
| "-" { OP_SUB }
| "*" { OP_MUL }
| "/" { OP_DIV }
| "^" { OP_EXP }

| ['0'-'9']+ "." ['0'-'9']* ("e" ['+' '-']? ['0'-'9']+)? as f { LIT_FLOAT (float_of_string f) }
| "." ['0'-'9']+ ("e" ['+' '-']? ['0'-'9']+)? as f { LIT_FLOAT (float_of_string f) }
| ['0'-'9']+ as i { LIT_INT (int_of_string i) }
| ['a'-'z' 'A'-'Z' '_']+ as n { NAME n }

| open_comment { comment 1 lexbuf }
| whitespace   { main lexbuf }
| _ { EOF }

and comment depth = parse
| open_comment { comment (depth + 1) lexbuf }
| shut_comment { if depth = 1 then main lexbuf else comment (depth - 1) lexbuf }
| _ { comment depth lexbuf }
