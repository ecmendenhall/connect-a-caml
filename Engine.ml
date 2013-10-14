open Types
include Types

module Engine =
  struct
    let rowHasWin row = match row with
      | []          -> false
      | Empty :: xs -> false
      | x :: xs     ->
        List.fold_left (&&) true (List.map (fun i -> i = x) xs)
  end;;
