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

   let leaf_score player board =
     let score = (if player = X then 1 else -1) in
       match Engine.board_state board with
         | Win X   ->  score
         | Win O   -> -score
         | _       -> 0

   let is_terminal board = Engine.board_state board <> Pending

   let max_score scores = List.fold_left max min_int scores

   let min_score scores = List.fold_left min max_int scores

   let other_turn turn = if turn = X then O else X

   let rec alpha_beta depth alpha beta turn player board =
     if (is_terminal board) || (depth = 0) then
       leaf_score player board
     else
       let next_boards = next_moves turn board in
       let next_turn   = other_turn turn in
       if turn = player then
        max_score (List.map (alpha_beta (depth - 1) alpha beta next_turn player) next_boards)
       else
        min_score (List.map (alpha_beta (depth - 1) alpha beta next_turn player) next_boards)

   let score_board player board = (alpha_beta 2 1 1 (other_turn player) player board), board

   let all_zero boards =
     List.fold_left (&&) true (List.map (fun b -> fst b = 0) boards)

   let random_choice boards =
       List.nth boards (Random.int (List.length boards))

   let best_board boards =
     let sorted = (List.sort (fun a b -> compare (fst b) (fst a)) boards) in
     if all_zero sorted then
      snd (random_choice boards)
     else
      snd (List.hd sorted)

   let best_move player board =
     let next_boards = next_moves player board in
       best_board (List.map (score_board player) next_boards)

   let next_move player board =
     best_move player board

  end;;
