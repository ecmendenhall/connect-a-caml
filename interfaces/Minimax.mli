open Types

type gamepiece = Types.gamepiece = X | O
type square = Types.square = Empty | Full of gamepiece
type gamestate = Types.gamestate = Win of gamepiece | Draw | Pending

module Minimax :
    sig
      val best_move :
        int -> gamepiece -> square list list -> (int * square list list) list
    end
