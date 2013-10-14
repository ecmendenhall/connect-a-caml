open Types
include Types
open Matrix

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
  end;;
