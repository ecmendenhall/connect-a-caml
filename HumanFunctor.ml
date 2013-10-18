open IOInterface
open Board
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

    let valid_move coord board =
      let size = List.length board in
      let valid = (in_range size) in
        match coord with
          | row :: col :: [] -> valid row && valid col
          | _                -> false

    let row coord = List.hd coord

    let col coord = List.hd (List.tl coord)

    let invalid_move_error board =
        IO.show_message "That's not a valid coordinate. Please try again." Error;
        board

    let full_square_error board =
        IO.show_message "That square is already full. Please pick another." Error;
        board

    let make_move coord turn board =
      if valid_move coord board then
        try Board.fill_square (row coord) (col coord) turn board with
          | Board.FullSquare -> full_square_error board
      else
        invalid_move_error board

    let get_move turn =
      turn_prompt turn;
      IO.show_message "Please enter your move as a row, column coordinate." Normal;
      coord_of_string (IO.get_input ())

    let next_move turn board = [[Empty]]
  end;;
