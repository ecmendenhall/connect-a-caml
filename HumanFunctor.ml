open IIO
open Str
open String

module HumanFunctor (IO : IO) =
  struct
    open Types
    include Types

    let your_turn turn =
      let prefix = "Your turn, player " in
      match turn with
        | X -> prefix ^ "X"
        | O -> prefix ^ "O"

    let turn_prompt turn =
      IO.show_message (your_turn turn) (Prompt turn)

    let coord_of_string str =
      List.map (fun c -> int_of_string (String.trim c)) (Str.split (Str.regexp ",") str)

    let get_move turn =
      turn_prompt turn;
      coord_of_string (IO.get_input ())
  end;;
