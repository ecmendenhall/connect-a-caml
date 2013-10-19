open Types

module type IO =
  sig
    val clear_screen: unit -> unit
    val get_input : unit -> string
    val show_board : Types.square list list -> unit
    val show_message : string -> Types.message -> unit
  end
