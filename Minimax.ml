open Types
include Types
open Board
open Engine

module Minimax =
  struct
    let nextMoves turn board =
      List.filter (fun b -> b <> board)
                  (List.flatten
                    (Board.mapRowColumn (fun r c sq ->
                                          if sq = Empty then
                                            Board.fillSquare r c turn board
                                          else board)
                                        board))

   let leafScore turn board =
     let x_score = (if turn = X then 1 else -1) in
       match Engine.boardState board with
         | Win X   ->  x_score
         | Win O   -> -x_score
         | _       -> 0

   let otherTurn turn = match turn with
     | X -> O
     | O -> X

   let isTerminal board = Engine.boardState board <> Pending

   let rec miniMax depth turn board =
     if (depth = 0) || (isTerminal board) then
       leafScore turn board
     else
       let next = nextMoves turn board in
       if (turn = X) then
         List.fold_left max min_int (List.map (miniMax (depth - 1) (otherTurn turn)) next)
       else
         List.fold_left min max_int (List.map (miniMax (depth - 1) (otherTurn turn)) next)

  end;;
