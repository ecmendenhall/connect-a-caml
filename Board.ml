open Types

class gameBoard =
  object (self)
    val squares = ( [] : square list )
    method getSquares = squares
  end;;
