open Types

type gamepiece = Types.gamepiece = X | O
type square = Types.square = Empty | Full of gamepiece

module type STRATEGY =
    sig
      val best_move :
        int -> gamepiece -> square list list -> (int * square list list) list
    end
