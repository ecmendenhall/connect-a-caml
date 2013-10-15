open Types
include Types
open Matrix
open Util

module Board =
  struct
    let emptyBoard size =
      Matrix.squareMatrix size Empty

    let getSquare row col board =
      Matrix.valueAt row col board

    let fillSquare row col piece board =
      Matrix.setValue row col (Full piece) board

    let getColumns board =
      Matrix.transpose board

    let getDiagonals board =
      [Matrix.diagonal board; Matrix.antidiagonal board]

    let map fn board =
      let board_size = List.length board in
        (Util.partitionBy board_size (List.map fn (List.flatten board)))

    let mapi fn board =
      let board_size = List.length board in
        (Util.partitionBy board_size (List.mapi fn (List.flatten board)))

    let indexToRow index board_size =
      (index / board_size)

    let indexToCol index board_size =
      (index mod board_size)

    let indexToRowCol index board_size =
      (indexToRow index board_size), (indexToCol index board_size)

    let mapRowColumn fn board =
      let board_size = List.length board in
        mapi (fun i sq -> (fn (indexToRow i board_size) (indexToCol i board_size) sq)) board
  end;;
