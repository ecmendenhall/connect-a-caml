module Types =
  struct
    type gamePiece = X | O
    type square = Empty | Full of gamePiece
    type gameState = Win of gamePiece | Pending
  end;;
