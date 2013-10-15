open Types
include Types

module Util =
  struct
    let rec split_before_iter n acc items = match n, items with
      | _, []     -> acc, items
      | 0, _      -> acc, items
      | _, x::xs  -> split_before_iter (n - 1) (acc @ [x]) xs

    let split_before n items = split_before_iter n [] items

    let take n items = fst (split_before n items)

    let drop n items = snd (split_before n items)

    let rec partition_by_iter n acc items = match items with
      | [] -> List.rev acc
      | _  -> partition_by_iter n ((take n items) :: acc) (drop n items)

    let partition_by n items = partition_by_iter n [] items

    let make_list size default_value =
      Array.to_list (Array.make size default_value)

    let set_nth n value items =
      let items_array = Array.of_list items in
        items_array.(n) <- value;
        Array.to_list items_array
end;;
