let replaceNth items index value =
  Array.set items index value;
  items

let rec splitBeforeIter n acc items = match n, items with
  | _, []     -> acc, items
  | 0, _      -> acc, items
  | _, x :: xs  -> splitBeforeIter (n - 1) (acc @ [x]) xs

let splitBefore n items = splitBeforeIter n [] items

let take n items = fst (splitBefore n items)

let drop n items = snd (splitBefore n items)

let rec partitionByIter n acc items = match items with
  | [] -> List.rev acc
  | _  -> partitionByIter n ((take n items) :: acc) (drop n items)

let partitionBy n items = partitionByIter n [] items

let rec transpose matrix = match matrix with
  | [] -> []
  | [] :: xs  -> transpose xs
  | (x :: xs) :: xss ->
      (x :: List.map List.hd xss) :: transpose (xs :: List.map List.tl xss)

let makeList size default_value =
  Array.to_list (Array.make size default_value)

let squareMatrix size default_value =
 makeList size (makeList size default_value)

let valueAt i j matrix = List.nth (List.nth matrix i) j

let row i matrix =  List.nth matrix i

let column j matrix = List.nth (transpose matrix) j

let add a b = a + b
let sub a b = a - b

let rec diagonalIter matrix acc n op = match matrix with
  | []      -> List.rev acc
  | x :: xs -> diagonalIter xs (List.nth x n :: acc) (op n 1) op

let diagonal matrix = diagonalIter matrix [] 0 add

let antidiagonal matrix = diagonalIter matrix [] (List.length matrix - 1) sub

let setNth n value items =
  let items_array = Array.of_list items in
  items_array.(n) <- value;
    Array.to_list items_array

let setValue i j value matrix =
  setNth i (setNth j value (row i matrix)) matrix
