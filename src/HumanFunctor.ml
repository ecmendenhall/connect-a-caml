open Board
open IOInterface
open Str
open String

module HumanFunctor (IO : IO) =
  struct
    open Types
    include Types

    let your_turn turn =
      let prefix = "Your turn, player " in
      let player = if turn = X then "X" else "O" in
        prefix ^ player

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

    let invalid_move_error () =
        IO.show_message "That's not a valid coordinate. Please try again." Error

    let full_square_error () =
        IO.show_message "That square is already full. Please pick another." Error

    let rec get_coord () =
      try coord_of_string (IO.get_input ()) with
        | Failure _ ->
            invalid_move_error ();
            get_coord ()

    let rec get_move turn =
      turn_prompt turn;
      IO.show_message "Please enter your move as a row, column coordinate." Normal;
      get_coord ()

    let rec make_move coord turn board =
      if valid_move coord board then
        try Board.fill_square (row coord) (col coord) turn board with
          | Board.FullSquare ->
              full_square_error ();
              make_move (get_coord ()) turn board
      else
        let _ = invalid_move_error () in
          make_move (get_coord ()) turn board

    let next_move turn board =
      let coord = get_move turn in
        make_move coord turn board

  end;;
