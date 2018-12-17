open List
open Map
open String

type rat = (int * int)
let rat_0 = (0, 1)
let rat_1 = (1, 1)

let rat_eq (n1, d1) (n2, d2) =
  n1 * d2 = n2 * d1

let rec rat_gcd d1 d2 =
  if d1 < 0 then rat_gcd (-d1) d2 else
  if d2 < 0 then rat_gcd d1 (-d2) else
  if d1 > d2 then rat_gcd d2 d1 else
  if d1 = 0 then d2 else
  rat_gcd d1 (d2 mod d1)

let rat_lcm d1 d2 =
  d1 * d2 / (rat_gcd d1 d2)

let rat_simplify (n, d) =
  let gcd = rat_gcd n d in
  if d < 0 then
    (-n / gcd, -d / gcd)
  else
    (n / gcd, d / gcd)

let string_of_rat r =
  let (n, d) = rat_simplify r in
  if d = 1 then (string_of_int n) else
  (string_of_int n) ^ "/" ^ (string_of_int d)

let rat_add (n1, d1) (n2, d2) =
  let lcm = rat_lcm d1 d2 in
  let g1 = lcm / d1 in
  let g2 = lcm / d2 in
  rat_simplify (n1 * g1 + n2 * g2, lcm)

let rat_neg (n1, d1) = (-n1, d1)
let rat_sub a b = rat_add a (rat_neg b)
let rat_mul (n1, d1) (n2, d2) = rat_simplify (n1 * n2, d1 * d2)
let rat_inv (n, d) = rat_simplify (d, n)
let rat_div a b = rat_mul a (rat_inv b)
let float_of_rat (n, d) = (float_of_int n) /. (float_of_int d)

let rec int_pow_z b e =
  if e < 0 then raise (invalid_arg "int_pow_z: negative exponent") else
  if e = 0 then 1 else
  if e = 1 then b else
  let rest = int_pow_z (b * b) (e / 2) in
  if (e mod 2) = 0 then
    rest
  else
    b * rest

let rec rat_pow_z (n, d) e =
  if e < 0 then
    rat_pow_z (d, n) (-e)
  else
    (int_pow_z n e, int_pow_z d e)

let int_root_z n e =
  let rec binary_search lo hi test =
    let mid = (lo + hi) / 2 in
    let t = test mid in
    if t = 0 then Some mid else
    if lo = hi then None else
    if t > 0 then binary_search lo mid test else
    if t < 0 then binary_search (mid + 1) hi test else
    None
  in
  let lo = 0 in
  let hi = n in
  let test b = (int_pow_z b e) - n in
    binary_search lo hi test

let rat_root_z (n, d) e =
  let n' = int_root_z n e in
  let d' = int_root_z d e in
  match n', d' with
  | Some n, Some d -> Some (n, d)
  | _ -> None

let rat_pow r (n, d) =
  let rn = rat_pow_z r n in
  rat_root_z rn d








type real =
  | RExact of rat
  | RFloat of float

let real_0 = RExact rat_0
let real_1 = RExact rat_1

let string_of_real q =
  match q with
  | RFloat f -> string_of_float f
  | RExact r -> string_of_rat r

let real_neg q =
  match q with
  | RExact r -> RExact (rat_neg r)
  | RFloat f -> RFloat (-. f)

let real_binop rop fop q1 q2 =
  match (q1, q2) with
  | (RFloat f1, RFloat f2) -> RFloat (fop f1 f2)
  | (RExact r , RFloat f ) -> RFloat (fop (float_of_rat r) f)
  | (RFloat f , RExact r ) -> RFloat (fop f (float_of_rat r))
  | (RExact r1, RExact r2) -> RExact (rop r1 r2)

let real_add = real_binop rat_add ( +.)
let real_sub = real_binop rat_sub ( -.)
let real_mul = real_binop rat_mul ( *.)
let real_div = real_binop rat_div ( /.)
let real_pow q1 q2 =
  match q1, q2 with
  | RFloat f1, RFloat f2 -> RFloat (f1 ** f2)
  | RExact r,  RFloat f  -> RFloat ((float_of_rat r) ** f)
  | RFloat f,  RExact r  -> RFloat (f ** (float_of_rat r))
  | RExact r1, RExact r2 ->
    match rat_pow r1 r2 with
    | Some r -> RExact r
    | None -> RFloat ((float_of_rat r1) ** (float_of_rat r2))

let real_neg q =
  match q with
  | RFloat f -> RFloat (-. f)
  | RExact r -> RExact (rat_neg r)









module DimMap = Map.Make(String)

type dim = rat DimMap.t

let dim_none = DimMap.empty
let dim_of_unit x = DimMap.singleton x rat_1

let rec string_of_dim d =
  let fmt_piece (d, e) =
    if rat_eq e rat_0 then "" else
    d ^ (if (rat_eq e rat_1) then "" else "^" ^ (string_of_rat e))
  in
  let pieces = List.map fmt_piece (DimMap.bindings d) in
  String.concat " " pieces

let dim_compliant = DimMap.equal rat_eq

let dim_inv = DimMap.map rat_neg

let dim_mul = DimMap.merge
  (fun k a b ->
    match a, b with
    | None, None -> None
    | None, Some b' -> Some b'
    | Some a', None -> Some a'
    | Some a', Some b' ->
      let sum = rat_add a' b' in
      if rat_eq sum rat_0 then None else Some sum)

let dim_div a b = dim_mul a (dim_inv b)

let dim_add d1 d2 =
  if dim_compliant d1 d2 then
    d1
  else
    raise (invalid_arg "dimensions are not compliant!")

let dim_sub d1 d2 =
  if dim_compliant d1 d2 then
    d1
  else
    raise (invalid_arg "dimensions are not compliant!")

let dim_pow d e =
  if dim_compliant d dim_none then dim_none else
  match e with
  | RFloat _ -> raise (invalid_arg "can only exponentiate dimensions to rational powers")
  | RExact r -> DimMap.map (rat_mul r) d



type qty = (real * dim)
let string_of_qty (a, u) =
  (string_of_real a) ^ " " ^ (string_of_dim u)
let qty_op (real_op : real -> real -> real)
           (dim_op  : dim  -> dim  -> dim)
           (a1, u1)
           (a2, u2)
           : qty =
  (real_op a1 a2, dim_op u1 u2)

let qty_add = qty_op real_add dim_add
let qty_sub = qty_op real_sub dim_sub
let qty_mul = qty_op real_mul dim_mul
let qty_div = qty_op real_div dim_div
let qty_pow (a1, u1) (a2, u2) : qty =
  if not (dim_compliant u2 dim_none) then
    raise (invalid_arg "can only exponentiate to dimensionless values")
  else
    (real_pow a1 a2, dim_pow u1 a2)

let qty_neg (a, u) = (real_neg a, u)

let qty_0 : qty = (RExact rat_0, dim_none)
let qty_1 : qty = (RExact rat_1, dim_none)
