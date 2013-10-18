open Board

module RandomMove =
  struct
    open Types
    include Types

    let fill_or_pass turn board row column square =
      if square = Empty then
        Board.fill_square row column turn board
      else
        board

    let next_moves turn board =
      List.filter (fun b -> b <> board)
                  (List.flatten
                    (Board.map_row_column (fill_or_pass turn board)
                                          board))

   let random_move moves =
     List.nth moves (Random.int (List.length moves))

   let next_move turn board =
     let next = next_moves turn board in
       random_move next

  end;;
