open Lexer
open Lexing
open Parser
open Ast
open Units
open Math
open List

let context_string_of_quantity context q =
  (string_of_qty q) ^ " (" ^ (context_string_of_dimension_name context q) ^ ")"

let context_string_of_output context =
  context_string_of_quantity context (List.assoc "_" context.environment)

let rec main context =
  try
    let input = read_line () in
    let lexbuf = Lexing.from_string input in
    try
      let stmts = Parser.main Lexer.main lexbuf in
      let context' = List.fold_left eval_stmt context stmts in
        print_string (context_string_of_output context');
        print_newline ();
        main context'
    with
    | Parser.Error ->
      print_string "Syntax error at ";
      print_int (lexbuf.lex_curr_p.pos_lnum);
      print_string ":";
      print_int (lexbuf.lex_curr_p.pos_cnum);
      print_newline ();
      main context
    | Context_not_found name ->
      let choices = misspelling_suggestions context name in
      print_string ("Name not found: " ^ name ^ ", did you mean any of these? " ^ (String.concat ", " choices));
      print_newline ();
      main context
  with
  | End_of_file ->
    print_newline ()

let () = main empty_context
