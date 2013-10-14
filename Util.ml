let replaceNth items index value =
  Array.set items index value;
  items

let rec splitBeforeIter n acc items = match n, items with
  | _, [] -> acc, items
  | 0, _  -> acc, items
  | _, _  -> splitBeforeIter (n - 1) (acc @ [List.hd items]) (List.tl items)

let splitBefore n items = splitBeforeIter n [] items

let take n items = fst (splitBefore n items)

let drop n items = snd (splitBefore n items)

let rec partitionByIter n acc items = match items with
  | [] -> List.rev acc
  | _  -> partitionByIter n ((take n items) :: acc) (drop n items)

let partitionBy n items = partitionByIter n [] items

let rec transpose items = match items with
  | [] -> []
  | [] :: xs  -> transpose xs
  | (x :: xs) :: xss ->
      (x :: List.map List.hd xss) :: transpose (xs :: List.map List.tl xss)
