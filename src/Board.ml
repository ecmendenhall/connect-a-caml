open Matrix
open Util

module Board =
  struct
    open Types
    include Types
    exception FullSquare

    let empty_board size =
      Matrix.square_matrix size Empty

    let get_square row col board =
      Matrix.value_at row col board

    let fill_square row col piece board =
      match get_square row col board with
        | Full _ -> raise FullSquare
        | Empty  -> Matrix.set_value row col (Full piece) board

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

    let row_of_index index board_size =
      (index / board_size)

    let col_of_index index board_size =
      (index mod board_size)

    let map_row_column fn board =
      let board_size = List.length board in
        mapi (fun i sq -> (fn (row_of_index i board_size) (col_of_index i board_size) sq)) board
  end;;
