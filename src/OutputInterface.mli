open Types

module type OUTPUT =
  sig
    val clear_print : string -> unit
    val print : string -> unit
    val println : string -> unit
    val print_message : string -> Types.message -> unit
    val print_board : Types.square list list -> unit
  end
