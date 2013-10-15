open Types
include Types
open Matrix
open Util

module Board =
  struct
    let empty_board size =
      Matrix.square_matrix size Empty

    let get_square row col board =
      Matrix.value_at row col board

    let fill_square row col piece board =
      Matrix.set_value row col (Full piece) board

    let get_columns board =
      Matrix.transpose board

    let get_diagonals board =
      [Matrix.diagonal board; Matrix.antidiagonal board]

    let map fn board =
      let board_size = List.length board in
        Util.partition_by board_size (List.map fn (List.flatten board))

    let mapi fn board =
      let board_size = List.length board in
        Util.partition_by board_size (List.mapi fn (List.flatten board))

    let index_to_row index board_size =
      (index / board_size)

    let index_to_col index board_size =
      (index mod board_size)

    let index_to_row_col index board_size =
      (index_to_row index board_size, index_to_col index board_size)

    let map_row_column fn board =
      let board_size = List.length board in
        mapi (fun i sq -> (fn (index_to_row i board_size) (index_to_col i board_size) sq)) board
  end;;
