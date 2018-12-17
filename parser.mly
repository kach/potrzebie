%{
open List
open Ast
%}

%token EOF
%token OPEN_P SHUT_P OPEN_B SHUT_B COMMA SEMI EQUALS CARETEQUALS
%token NEW UNIT DIMENSION MEASURED IN PREFIX AUTOPREFIX
%token <string> NAME
%token <float> LIT_FLOAT
%token <int> LIT_INT

%token OP_ADD OP_SUB OP_MUL OP_DIV OP_EXP

%type <Ast.expr> expr
%type <Ast.stmt> stmt
%start <Ast.stmt list> main

%%

main:
| ms = separated_list(SEMI, stmt) EOF { ms }
;

stmt:
| e = expr
  { Ast.SExpr ($startpos, e) }
| n = separated_nonempty_list(COMMA, NAME) EQUALS e = expr
  { Ast.SDefn ($startpos, n, e, false) }
| n = separated_nonempty_list(COMMA, NAME) CARETEQUALS e = expr
  { Ast.SDefn ($startpos, n, e, true) }
| NEW UNIT n = separated_nonempty_list(COMMA, NAME)
  { Ast.SNewUnit ($startpos, n) }
| NEW DIMENSION n = NAME MEASURED IN e = expr
  { Ast.SNewDimension ($startpos, n, e) }
| NEW PREFIX n = separated_nonempty_list(COMMA, NAME) EQUALS e = expr
  { Ast.SNewPrefix ($startpos, n, e) }
| AUTOPREFIX n = separated_nonempty_list(COMMA, NAME)
  { Ast.SAutoprefix ($startpos, n) }
;

expr:
| s = sum { s }
;

atom:
| i = LIT_INT { EInt ($startpos, i) }
| f = LIT_FLOAT { EFloat ($startpos, f) }
| OPEN_P e = sum SHUT_P { e }
| n = NAME { Ast.EVar ($startpos, n) }
| f = NAME OPEN_B a = separated_list(COMMA, expr) SHUT_B { Ast.EFun ($startpos, f, a) }
;

pow:
| c = atom { c }
| e1 = atom OP_EXP e2 = pow { Ast.EFun ($startpos, "^", [e1; e2]) }
| e1 = atom OP_EXP OP_SUB e2 = pow
  { Ast.EFun ($startpos, "^", [e1; Ast.EFun ($startpos, "~", [e2])]) }
;

conc:
| OP_SUB e = pow { Ast.EFun ($startpos, "~", [e]) }
| a = pow { a }
| e1 = conc e2 = pow { Ast.EFun ($startpos, "*", [e1; e2]) }
;

prod:
| p = conc { p }
| e1 = prod OP_MUL e2 = conc { Ast.EFun ($startpos, "*", [e1; e2]) }
| e1 = prod OP_DIV e2 = conc { Ast.EFun ($startpos, "/", [e1; e2]) }
;

sum:
| p = prod { p }
| e1 = sum OP_ADD e2 = prod { Ast.EFun ($startpos, "+", [e1; e2]) }
| e1 = sum OP_SUB e2 = prod { Ast.EFun ($startpos, "-", [e1; e2]) }
;
