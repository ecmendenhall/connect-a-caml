open Types
include Types
open Util

module Matrix =
  struct
    let rec transpose matrix = match matrix with
      | [] -> []
      | [] :: xs  -> transpose xs
      | (x :: xs) :: xss ->
          (x :: List.map List.hd xss) :: transpose (xs :: List.map List.tl xss)

    let square_matrix size default_value =
      Util.make_list size (Util.make_list size default_value)

    let value_at i j matrix = List.nth (List.nth matrix i) j

    let row i matrix =  List.nth matrix i

    let column j matrix = List.nth (transpose matrix) j

    let rec diagonal_iter matrix acc n op = match matrix with
      | []      -> List.rev acc
      | x :: xs -> diagonal_iter xs (List.nth x n :: acc) (op n 1) op

    let diagonal matrix =
      diagonal_iter matrix [] 0 (+)

    let antidiagonal matrix =
      diagonal_iter matrix [] (List.length matrix - 1) (-)

    let set_value i j value matrix =
      Util.set_nth i (Util.set_nth j value (row i matrix)) matrix
  end;;
