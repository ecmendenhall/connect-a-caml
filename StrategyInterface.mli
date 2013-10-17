open Types

module type STRATEGY =
    sig
      val next_move :
        Types.gamepiece -> Types.square list list -> Types.square list list
    end
