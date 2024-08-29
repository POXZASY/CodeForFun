(*
How to solve this?
*)

module ConstList = struct 
  let rec list_to_string_aux (lst : int list) : string =
    match lst with
    | [] -> ""
    | [t] -> string_of_int t ^ "]"
    | h :: t -> String.concat ", " [string_of_int h; list_to_string_aux t]
  
  let list_to_string (lst : int list) : string = "[" ^ (list_to_string_aux lst)
  
  let rec e_values_aux (values : int list) (num_values : int) : int list =
    if num_values == 100 then
      values
    else if num_values == 0 then
      e_values_aux [2] 1
    else if (num_values + 1) mod 3 == 0 then
      e_values_aux ((num_values + 1) / 3 * 2 :: values) (num_values + 1)
    else
      e_values_aux (1 :: values) (num_values + 1)
  
  (*A list of the first 100 continued fraction constants, starting with the last one.*)
  let e_values : int list = e_values_aux [] 0
end

module Fraction = struct
  include Q

  let rec frac_aux (denom : Q.t) (e_values : int list) : Q.t = 
    match e_values with
    | [] -> denom
    | h :: t -> frac_aux (Q.of_int h + Q.make (denom.den) (denom.num)) (t)
    
  let frac (e_values: int list) : Q.t =
    match e_values with
    | [] -> Q.of_int 0
    | h :: t -> frac_aux (Q.of_int h) t

  let numerator = (frac ConstList.e_values).num
end

module Solution = struct
  include Z

  let rec sum_digits (remainder : Z.t) (sum : Z.t) : Z.t =
    if remainder == Z.of_int 0 then
      sum
    else
      sum_digits (remainder / (Z.of_int 10)) (sum + (remainder mod (Z.of_int 10)))

  let _ = print_string ((string_of_int (Z.to_int (sum_digits (Fraction.numerator) (Z.of_int 0)))) ^ "\n");
end





(* let _ = print_string ConstList.(list_to_string e_values ^ "\n"); *)