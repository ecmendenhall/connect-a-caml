open OUnit
open Types
include Types

let is_valid_game_piece value = match value with
  | X -> true
  | O -> true

let is_valid_square_state value = match value with
  | Empty -> true
  | Full _ -> true

let is_valid_game_state value = match value with
  | Win _   -> true
  | Draw    -> true
  | Pending -> true

let tests = "Types" >:::
  [
    "X is a type of game piece" >:: ( fun () ->
      assert (is_valid_game_piece X);
    );

    "O is a type of game piece" >:: ( fun () ->
      assert (is_valid_game_piece O);
    );

    "a square can be Empty" >:: ( fun () ->
      assert (is_valid_square_state Empty);
    );

    "a square can be Full of a game piece" >:: ( fun () ->
      assert (is_valid_square_state (Full X));
      assert (is_valid_square_state (Full O));
    );

    "a square can be Full of a game piece" >:: ( fun () ->
      assert (is_valid_square_state (Full X));
      assert (is_valid_square_state (Full O));
    );

    "a game can be a Win for X or O" >:: ( fun () ->
      assert (is_valid_game_state (Win X));
      assert (is_valid_game_state (Win O));
    );

    "a game can be Pending" >:: ( fun () ->
      assert (is_valid_game_state Pending);
    );

    "a game can be a Draw" >:: ( fun () ->
      assert (is_valid_game_state Draw););
  ]

(* Test Runner *)
let _ = run_test_tt_main tests
