(*
How to solve this?
*)

let rec list_to_string_aux lst =
  match lst with
  | [] -> ""
  | [t] -> string_of_int t ^ "]"
  | h :: t -> String.concat ", " [string_of_int h; list_to_string_aux t]

let list_to_string lst = "[" ^ (list_to_string_aux lst)

(*A list of the first 100 continued fraction constants.*)
let rec e_values_aux values count =
  if count == 100 then
    values
  else if count == 0 then
    e_values_aux [2] 1
  else if (count + 1) mod 3 == 0 then
    e_values_aux ((count + 1) / 3 * 2 :: values) (count + 1)
  else
    e_values_aux (1 :: values) (count + 1)

let e_values = List.rev (e_values_aux [] 0)

let _ = print_string (list_to_string e_values ^ "\n")