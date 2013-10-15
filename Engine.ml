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

    let board_is_draw board =
      List.fold_left (&&) true (List.flatten (Board.map (fun sq -> match sq with
                                                           | Full _ -> true
                                                           | _      -> false)
                                             board))

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
