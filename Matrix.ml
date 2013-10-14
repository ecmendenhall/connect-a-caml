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

    let squareMatrix size default_value =
      Util.makeList size (Util.makeList size default_value)

    let valueAt i j matrix = List.nth (List.nth matrix i) j

    let row i matrix =  List.nth matrix i

    let column j matrix = List.nth (transpose matrix) j

    let rec diagonalIter matrix acc n op = match matrix with
      | []      -> List.rev acc
      | x :: xs -> diagonalIter xs (List.nth x n :: acc) (op n 1) op

    let diagonal matrix =
      diagonalIter matrix [] 0 (+)

    let antidiagonal matrix =
      diagonalIter matrix [] (List.length matrix - 1) (-)

    let setValue i j value matrix =
      Util.setNth i (Util.setNth j value (row i matrix)) matrix
  end;;
