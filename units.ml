open Ast
open Math
open List

type context = {
  dimensions : (string * dim) list;
  prefixes: (string * qty) list;
  environment : (string * qty) list;
  functions : (string * (qty list -> qty)) list;
  response : string;
}

let context_find_dimension_names context ((a, u) : qty) : string list =
  let matches = List.filter (fun (n, u') -> dim_compliant u u') context.dimensions in
  List.map fst matches

let context_string_of_dimension_name context q =
  let names = context_find_dimension_names context q in
  match names with
  | [] -> "unknown dimensions"
  | _ -> String.concat ", " names
  
let empty_context = {
  dimensions = [];
  prefixes = [];
  environment = [("_", qty_0)];
  functions = [
    ("+", fun a -> qty_add (List.nth a 0) (List.nth a 1));
    ("-", fun a -> qty_sub (List.nth a 0) (List.nth a 1));
    ("*", fun a -> qty_mul (List.nth a 0) (List.nth a 1));
    ("/", fun a -> qty_div (List.nth a 0) (List.nth a 1));
    ("^", fun a -> qty_pow (List.nth a 0) (List.nth a 1));
    ("~", fun a -> qty_neg (List.nth a 0));
  ];
  response = "";
}

exception Context_not_found of string

let levenshtein_memo : ((string * string) * int) list ref = ref []

let rec levenshtein a b : int =
  match List.assoc_opt (a, b) (!levenshtein_memo) with
  | Some x -> x
  | None -> (
    if String.length a = 0 then (
      levenshtein_memo := ((a, b), 0)::!levenshtein_memo;
      String.length b
    ) else if String.length b = 0 then (
      levenshtein_memo := ((a, b), 0)::!levenshtein_memo;
      String.length a
    ) else
      let c1 =
        if String.get a 0 = String.get b 0 then 0 else 1
      in
      let a' = (String.sub a 1 ((String.length a) - 1)) in
      let b' = (String.sub b 1 ((String.length b) - 1)) in
      let l_insert_a = 1 + levenshtein a b' in
      let l_insert_b = 1 + levenshtein a' b in
      let l_mutate = c1 + levenshtein a' b' in
      let answer = min (min l_insert_a l_insert_b) l_mutate in
      levenshtein_memo := ((a, b), answer)::!levenshtein_memo;
      answer
    )

let misspelling_suggestions ctx word =
  let scored = List.map (fun (name, value) -> (name, levenshtein name word)) ctx.environment in
  let sorted = List.filter (fun (name, score) -> score < 3) scored in
  List.map fst sorted

let rec eval_expr context expr : qty =
  match expr with
  | EInt (p, i) -> (RExact (i, 1), dim_none)
  | EFloat (p, f) -> (RFloat f, dim_none)
  | EVar (p, n) -> (
      try List.assoc n context.environment
      with Not_found -> raise (Context_not_found n)
    )
  | EFun (p, f, a) -> (List.assoc f context.functions) (List.map (eval_expr context) a)

let context_make_prefixes context name value =
  List.map
    (fun (pfx, size) -> (pfx ^ name, qty_mul size value))
    context.prefixes

let rec eval_stmt context stmt =
  match stmt with
  | SExpr (p, e) ->
    let e' = eval_expr context e in
    {context with environment = ("_", e') :: context.environment}
  | SDefn (p, [], e, pfx) ->
    let e' = eval_expr context e in
    {context with environment = ("_", e') :: context.environment}
  | SDefn (p, n::ns, e, pfx) ->
    let e' = eval_expr context e in
    let entries = if pfx then context_make_prefixes context n e' else [] in
    eval_stmt
      {context with environment = ((n, e') :: entries) @ context.environment}
      (SDefn (p, ns, e, pfx))
  | SNewUnit (p, []) -> context
  | SNewUnit (p, n::ns) ->
    eval_stmt
      {context with environment = (n, (real_1, dim_of_unit n)) :: context.environment}
      (SNewUnit (p, ns))
  | SNewDimension (p, n, e) ->
    let (a, u) = eval_expr context e in
    {context with dimensions = (n, u) :: context.dimensions}
  | SNewPrefix (p, [], e) -> context
  | SNewPrefix (p, n::ns, e) ->
    let e' = eval_expr context e in
    eval_stmt
      {context with prefixes = (n, e') :: context.prefixes}
      (SNewPrefix (p, ns, e))
  | SAutoprefix (p, []) -> context
  | SAutoprefix (p, n::ns) ->
    let value = List.assoc n context.environment in
    let entries = context_make_prefixes context n value in
    eval_stmt
      {context with environment = entries @ context.environment}
      (SAutoprefix (p, ns))
