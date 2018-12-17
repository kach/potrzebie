open Js_of_ocaml.Js
open Js_of_ocaml.Json
open Units
open Lexing
open Lexer
open Parser
open Math

let superscript x = "<sup>" ^ x ^ "</sup>"
  
let html_of_real r =
  match r with
  | RExact r ->
    (string_of_rat r) ^ " " ^
    "(&approx;&nbsp;" ^ (string_of_float (float_of_rat r)) ^ ")"
  | RFloat f -> string_of_float f

let html_of_dim d =
  let fmt_piece (d, e) =
    if rat_eq e rat_0 then "" else
    d ^ (if (rat_eq e rat_1) then "" else (superscript (string_of_rat e)))
  in
  let pieces = List.map fmt_piece (DimMap.bindings d) in
  String.concat " " pieces

let html_of_qty (a, u) = (html_of_real a) ^ " " ^ (html_of_dim u)

let doit (context : Units.context) (line : string) : Units.context =
  let lexbuf = Lexing.from_string line in
  let stmts = Parser.main Lexer.main lexbuf in
  List.fold_left Units.eval_stmt context stmts

let readit (context : Units.context) (name : string) : string =
  let q = (List.assoc name context.environment) in
  html_of_qty q ^ " [" ^ (context_string_of_dimension_name context q) ^ "]"

let _ =
  Js_of_ocaml.Js.export "units"
    (object%js
       method doit (context : Units.context) line = doit context (to_string line)
       method readit (context : Units.context) line =
         Js_of_ocaml.Js.string (readit context (Js_of_ocaml.Js.to_string line))
       val empty = Units.empty_context
     end)
