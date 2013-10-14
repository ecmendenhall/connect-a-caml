module Types =
  struct
    type gamePiece = X | O
    type square = Empty | Full of gamePiece
  end;;
