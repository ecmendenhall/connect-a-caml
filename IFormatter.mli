open Types

type gamepiece = Types.gamepiece = X | O
type square = Types.square = Empty | Full of gamepiece

module type FORMATTER =
  sig
    type message
    val square_string : square -> string
    val row_string : square list -> string
    val row_separator : int -> string
    val message_string : string -> message -> string
    val board_string : square list list -> string
  end
