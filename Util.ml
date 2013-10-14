open Types
include Types

module Util =
  struct
    let rec splitBeforeIter n acc items = match n, items with
      | _, []     -> acc, items
      | 0, _      -> acc, items
      | _, x::xs  -> splitBeforeIter (n - 1) (acc @ [x]) xs

    let splitBefore n items = splitBeforeIter n [] items

    let take n items = fst (splitBefore n items)

    let drop n items = snd (splitBefore n items)

    let rec partitionByIter n acc items = match items with
      | [] -> List.rev acc
      | _  -> partitionByIter n ((take n items) :: acc) (drop n items)

    let partitionBy n items = partitionByIter n [] items

    let makeList size default_value =
      Array.to_list (Array.make size default_value)

    let setNth n value items =
      let items_array = Array.of_list items in
      items_array.(n) <- value;
        Array.to_list items_array
end;;
