open Types
include Types
open Board

module Engine =
  struct

    let rowHasWin row = match row with
      | []          -> false
      | Empty :: xs -> false
      | x :: xs     ->
        List.fold_left (&&) true (List.map (fun i -> i = x) xs)

    let rowState row =
      if (rowHasWin row) then match List.hd row with
        | Empty  -> Pending
        | Full O -> Win O
        | Full X -> Win X
      else
        Pending

    let getState states =
      let wins = (List.filter (fun state -> state <> Pending) states) in
        match wins with
          | [] -> Pending
          | _  -> List.hd wins

    let rowStates board =
      List.map rowState (board @
                         Board.getColumns board @
                         Board.getDiagonals board)

   let boardState board = getState (rowStates board)
  end;;
