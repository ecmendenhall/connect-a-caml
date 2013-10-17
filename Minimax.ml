open Board
open Engine

module Minimax =
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

   let leaf_score turn board =
     let score = (if turn = X then 1 else -1) in
       match Engine.board_state board with
         | Win X   ->  score
         | Win O   -> -score
         | _       -> 0

   let is_terminal board = Engine.board_state board <> Pending

   let max_score scores = List.fold_left max min_int scores

   let min_score scores = List.fold_left min max_int scores

   let rec minimax depth turn board =
     if (depth = 0) || (is_terminal board) then
       leaf_score turn board
     else
       let next = next_moves turn board in
       if turn = X then
         max_score (List.map (minimax (depth - 1) O) next)
       else
         min_score (List.map (minimax (depth - 1) X) next)

   let best_move depth turn board =
     let next = next_moves turn board in
     let scores = List.map (fun board -> (minimax depth turn board), board) next in
       (List.sort (fun a b -> compare (fst b) (fst a)) scores)

  end;;
