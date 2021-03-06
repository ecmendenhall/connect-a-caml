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

   let rec minimax depth turn player board =
     if (is_terminal board) || (depth = 0) then
       leaf_score player board
     else
       let next_boards = next_moves turn board in
       let next_turn   = other_turn turn in
       if turn = player then
        max_score (List.map (minimax (depth - 1) next_turn player) next_boards)
       else
        min_score (List.map (minimax (depth - 1) next_turn player) next_boards)

   let board_depth board =
     match List.length board with
       | 3 -> 5
       | 4 -> 3
       | 5 -> 3
       | 6 -> 3
       | _ -> 2

   let score_board player board = (minimax (board_depth board) (other_turn player) player board), board

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
