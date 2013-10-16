open Types

type gamepiece = Types.gamepiece = X | O
type square = Types.square = Empty | Full of gamepiece

module Board :
  sig
    val empty_board : int -> square list list
    val get_square : int -> int -> 'a list list -> 'a
    val fill_square :
      int ->
      int ->
      gamepiece -> square list list -> square list list
    val get_columns : 'a list list -> 'a list list
    val get_diagonals : 'a list list -> 'a list list
    val map : ('a -> 'b) -> 'a list list -> 'b list list
    val mapi : (int -> 'a -> 'b) -> 'a list list -> 'b list list
    val map_row_column :
      (int -> int -> 'a -> 'b) -> 'a list list -> 'b list list
  end
