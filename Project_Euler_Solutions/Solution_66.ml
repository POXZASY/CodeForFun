(* Returns true iff the integer is a square. *)
let is_square i = sqrt(float_of_int i) == float_of_int(int_of_float(sqrt(float_of_int i)))

(*
Construct a list of the first p-1 constants if p is even, or 2p-1 if p is odd.
Element p has the value 2 * floor(d)

Computing the constants of a CF using integers:
https://math.stackexchange.com/a/4425617
*)
let rec cf_constants (d: int) (a0 : int) (current_r : int) (current_s : int) (current_lst : int list) : int list =
  

(* TODO
Returns the minimal x satisfying x^2 - dy^2 = 1.
https://en.wikipedia.org/wiki/Pell%27s_equation#Fundamental_solution_via_continued_fractions
Consider the continued fraction sqrt(d).
Generate the list (a1, a2, ...) of constants, and use it to find the length of the period p of the continued fraction.
Use the list to compute the desired convergent fraction recursively.
The fundamental solution (x_1, y_1) =
(h_p-1, k_p-1) for p even
(h_2p-1, k_2p-1) for p odd
*)
let minimal_x (d : int) : int = d

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

let () = print_string ((string_of_int (largest_minimal_x_d 2 (-1) (-1))) ^ "\n")