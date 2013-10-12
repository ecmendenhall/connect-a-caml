open Types
open Util

class gameBoard size =
  let initial_list = (fillN (size * size) Empty) in

  object (self)
    val squares = (initial_list : square list)
    method getSquares = squares
  end;;
