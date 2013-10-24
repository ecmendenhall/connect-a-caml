open Types

module type GAMETOKEN =
  sig
    val get_gamepiece : unit -> Types.gamepiece
  end
