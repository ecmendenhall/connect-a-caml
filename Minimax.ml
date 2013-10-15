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

   let score turn board =
     let x_score = (if turn = X then 1 else -1) in
       match Engine.boardState board with
         | Win X   ->  x_score
         | Win O   -> -x_score
         | Pending -> 0

  end;;
