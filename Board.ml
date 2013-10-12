open Types

class gameBoard size =
  let initial_array = (Array.make (size * size) Empty) in

  object (self)
    val squares =  ( initial_array : square array)
    method getSquares = squares
  end;;
