open Js_of_ocaml.Js
open Js_of_ocaml.Json
open Units
open Lexing
open Lexer
open Parser
open Math

let superscript x = "<sup>" ^ x ^ "</sup>"

let html_of_float f =
  let e = floor (log10 (abs_float f)) in
  if (abs_float e) < 2.0 then
    (string_of_float f)
  else
    (string_of_float (f /. (10. ** e))) ^ " &times; 10" ^ (superscript (string_of_int (int_of_float e)))

let html_of_real r =
  match r with
  | RExact r ->
    (html_of_float (float_of_rat r))
  | RFloat f -> html_of_float f

let html_of_dim d =
  let fmt_piece positive (d, e) =
    if rat_eq e rat_0 then "" else
    if positive && ((rat_sign e) < 0) then "" else
    if (not positive) && ((rat_sign e) > 0) then "" else
    let e' = (rat_abs e) in
    d ^ (if (rat_eq e' rat_1) then "" else (superscript (string_of_rat e')))
  in
  let piecesPositive' = List.map (fmt_piece true)  (DimMap.bindings d) in
  let piecesPositive =  (String.concat " " piecesPositive') in
  let piecesNegative' = List.map (fmt_piece false) (DimMap.bindings d) in
  let piecesNegative = (String.concat " " piecesNegative') in
  (if piecesPositive = "" then "" else piecesPositive) ^
  (if piecesNegative = "" then "" else " &#x2215; " ^ piecesNegative)

let html_of_qty (a, u) = (html_of_real a) ^ " <span class=\"dimension\">" ^ (html_of_dim u) ^ "</span>"

let doit (context : Units.context) (line : string) : Units.context =
  let lexbuf = Lexing.from_string line in
  try
    let stmts = Parser.main Lexer.main lexbuf in
    let result = List.fold_left Units.eval_stmt context stmts in
    let q = (List.assoc "_" context.environment) in
    let outstr = html_of_qty q ^ " <span class=\"quantity\">[" ^ (context_string_of_dimension_name context q) ^ "]</span>" in
    {result with response = outstr}
  with
  | Parser.Error ->
    let errstr = "Syntax error at "
      ^ (string_of_int (lexbuf.lex_curr_p.pos_lnum))
      ^ ":"
      ^ (string_of_int (lexbuf.lex_curr_p.pos_cnum))
    in {context with response = errstr}
  | Units.Context_not_found name ->
    let choices = Units.misspelling_suggestions context name in
    let errstr = ("Name not found: " ^ name ^ ", did you mean any of these? " ^ (String.concat ", " choices)) in
    {context with response = errstr}

let readit (context : Units.context) (name : string) : string = context.response

let _ =
  Js_of_ocaml.Js.export "units"
    (object%js
       method doit (context : Units.context) line = doit context (to_string line)
       method readit (context : Units.context) line =
         Js_of_ocaml.Js.string (readit context (Js_of_ocaml.Js.to_string line))
       val empty = Units.empty_context
     end)
