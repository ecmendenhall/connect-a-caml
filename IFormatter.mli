open Types

module type FORMATTER =
  sig
    type message
    val square_string : Types.square -> string
    val row_string : Types.square list -> string
    val row_separator : int -> string
    val message_string : string -> Types.message -> string
    val board_string : Types.square list list -> string
  end
