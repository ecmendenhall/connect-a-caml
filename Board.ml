open Types
open Util

class gameBoard size =
  let initial_array = (squareMatrix size Empty) in

  object (self)
    val squares = (initial_array : square list list)
    method setSquares newSquares = {< squares = newSquares >}
    method getSquare row col = valueAt row col squares
    method fillSquare row col piece =
      {< squares = setValue row col (Full piece) squares >}
    method getRows = squares
    method getColumns = transpose squares
    method getDiagonals = [diagonal squares; antidiagonal squares]
  end;;
