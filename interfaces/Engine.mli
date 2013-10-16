open Types

type gamepiece = Types.gamepiece = X | O
type square = Types.square = Empty | Full of gamepiece
type gamestate = Types.gamestate = Win of gamepiece | Draw | Pending

module Engine :
    sig
      val board_state : square list list -> gamestate
    end
