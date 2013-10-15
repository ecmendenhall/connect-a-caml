open Types
include Types
open Board
open Engine

module Minimax =
  struct

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

   let other_turn turn = match turn with
     | X -> O
     | O -> X

   let is_terminal board = Engine.board_state board <> Pending

   let rec minimax depth turn board =
     if depth = 0 || is_terminal board then
       leaf_score turn board
     else
       let next = next_moves turn board in
       if turn = X then
         List.fold_left max min_int (List.map (minimax (depth - 1) (other_turn turn)) next)
       else
         List.fold_left min max_int (List.map (minimax (depth - 1) (other_turn turn)) next)

  end;;
