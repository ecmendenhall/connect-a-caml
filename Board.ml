open Types
open Util

class gameBoard size =
  let initial_array = (Array.make (size * size) Empty) in

  object (self)
    val squares = (initial_array : square array)
    method getSquares = squares
    method setSquares newSquares = {< squares = newSquares >}
    method fillSquare n piece = {< squares = replaceNth squares n (Full piece) >}
    method getRows = partitionBy 3 (Array.to_list squares)
  end;;
