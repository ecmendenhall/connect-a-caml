open Types
include Types
open Board

module Engine =
  struct

    let row_has_win row = match row with
      | []          -> false
      | Empty :: xs -> false
      | x :: xs     ->
        List.fold_left (&&) true (List.map (fun i -> i = x) xs)

    let row_state row =
      if (row_has_win row) then match List.hd row with
        | Empty  -> Pending
        | Full O -> Win O
        | Full X -> Win X
      else
        Pending

    let rec contains_O row = match row with
      | []           -> false
      | Full O :: xs -> true
      | _ :: xs      -> contains_O xs

    let rec contains_X row = match row with
      | []           -> false
      | Full X :: xs -> true
      | _ :: xs      -> contains_X xs

    let rec row_is_drawn row =
      let full_squares = List.filter (fun sq -> sq <> Empty) row in
      match full_squares with
        | Full X :: xs -> contains_O xs
        | Full O :: xs -> contains_X xs
        | []           -> false
        | _ :: xs      -> row_is_drawn xs

    let board_is_draw board =
       List.fold_left (&&) true (List.map row_is_drawn (board @
                                                        Board.get_columns board @
                                                        Board.get_diagonals board))
    let get_state states =
      let wins = List.filter (fun state -> state <> Pending) states in
        match wins with
          | [] -> Pending
          | _  -> List.hd wins

    let row_states board =
      List.map row_state (board @
                          Board.get_columns board @
                          Board.get_diagonals board)

   let board_state board =
     if board_is_draw board then
       Draw
      else
        get_state (row_states board)
  end;;
