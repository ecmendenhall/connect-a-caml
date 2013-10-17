open Types

module type PLAYER =
  sig
    val get_gamepiece : unit -> Types.gamepiece
    val next_move : Types.square list list -> Types.square list list
  end
