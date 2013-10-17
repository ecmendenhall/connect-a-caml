open IOInterface
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

    let in_range size coord =
      (0 <= coord) && (coord < size)

    let valid_move move board =
      let size = List.length board in
      let valid = (in_range size) in
        match move with
          | row :: col :: [] -> valid row && valid col
          | _                -> false

    let get_move turn =
      turn_prompt turn;
      coord_of_string (IO.get_input ())
  end;;
