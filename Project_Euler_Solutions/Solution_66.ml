(* Returns true iff the integer is a square. *)
let is_square i = sqrt(float_of_int i) == float_of_int(int_of_float(sqrt(float_of_int i)))

(*
Construct a list of the first p-1 constants if p is even, or 2p-1 if p is odd.
Element p has the value 2 * floor(d)

Computing the constants of a CF using integers:
https://math.stackexchange.com/a/4425617
*)
let rec cf_constants (d : int) (found_period : bool) (a_0 : int) (r_n : int) (s_n : int) (current_lst : int list) : int list =
  let () = print_string ((String.concat ", " (List.map string_of_int current_lst)) ^ "\n") in
  match ((r_n + a_0) / s_n) with a_n ->
    match a_n*s_n - r_n with r_n1 ->
      if a_n == 2 * int_of_float(sqrt(float_of_int(d))) then
        if (d mod 2 == 0) || found_period then
          current_lst
        else
          cf_constants (d) (true) (a_0) (r_n1) ((d - r_n1 * r_n1) / s_n) (a_n :: current_lst)
      else
        cf_constants (d) (found_period) (a_0) (r_n1) ((d - r_n1 * r_n1) / s_n) (a_n :: current_lst)

let rec convergent_frac_aux (cf_const_list : int list) : int =
  match cf_const_list with
  | [] -> let () = print_string "ERROR: Encountered a list with 0 elements." in 0
  | [a] -> a
  | [a; _] -> a
  | a :: b :: c -> a * convergent_frac_aux (b :: c) + convergent_frac_aux (c)

(* Compute the numerator of the nth convergent fraction recursively. *)
let convergent_frac_num (cf_const_list : int list) : int =
  convergent_frac_aux (List.concat [cf_const_list; [1; 0]])

(* Compute the denominator of the nth convergent fraction recursively. *)
let convergent_frac_denom (cf_const_list : int list) : int =
  convergent_frac_aux (List.concat [cf_const_list; [0; 1]])

(* Compute the nth convergent fraction recursively, using the a_1, ..., a_n CF constants. *)
let convergent_frac (cf_const_lst : int list) : Q.t = 
  Q.make (Z.of_int (convergent_frac_num cf_const_lst)) (Z.of_int (convergent_frac_denom cf_const_lst))

(*
Returns the minimal x satisfying x^2 - dy^2 = 1.
https://en.wikipedia.org/wiki/Pell%27s_equation#Fundamental_solution_via_continued_fractions
Consider the continued fraction sqrt(d).
Generate the list (a1, a2, ...) of constants, and use it to find the length of the period p of the continued fraction.
Use the list to compute the desired convergent fraction recursively.
- https://en.wikipedia.org/wiki/Continued_fraction#Convergents
The fundamental solution (x_1, y_1) =
(h_p-1, k_p-1) for p even
(h_2p-1, k_2p-1) for p odd
*)
let minimal_x (d : int) : int =
  Z.to_int((convergent_frac (cf_constants (d) (false) (int_of_float(sqrt(float_of_int d))) 0 1 [])).num)

(* Returns the D <= 1000 with the largest minimal x. *)
let rec largest_minimal_x_d current_d largest_d largest_minimal_x =
  if current_d > 1000 then
    largest_d
  else if is_square current_d then
    largest_minimal_x_d (current_d + 1) largest_d largest_minimal_x
  else
    match minimal_x current_d with min_x ->
      if min_x > largest_minimal_x then
        largest_minimal_x_d (current_d + 1) current_d min_x
      else
        largest_minimal_x_d (current_d + 1) largest_d largest_minimal_x 

let () = print_string "CF const list: "
let () = print_string (String.concat ", " (List.map string_of_int (cf_constants 2 false (int_of_float(sqrt(float_of_int(23)))) 0 1 [])))
let () = print_string "\nStarting program."
(* let () = print_string ((string_of_int (largest_minimal_x_d 2 (-1) (-1))) ^ "\n") *)
