open OUnit
open Types

let isValidGamePiece value = match value with
  | X -> true
  | O -> true

let isValidSquareState value = match value with
  | Empty -> true
  | Full _ -> true

let isValidPlayerType value = match value with
  | Human -> true
  | Computer -> true

let tests = "Types" >:::
  [
    "X is a type of game piece" >:: ( fun () ->
      assert (isValidGamePiece X);
    );

    "O is a type of game piece" >:: ( fun () ->
      assert (isValidGamePiece O);
    );

    "a square can be Empty" >:: ( fun () ->
      assert (isValidSquareState Empty);
    );

    "a square can be Full of a game piece" >:: ( fun () ->
      assert (isValidSquareState (Full X));
      assert (isValidSquareState (Full O));
    );

    "a player can be Human or Computer" >:: ( fun () ->
      assert (isValidPlayerType Human);
      assert (isValidPlayerType Computer)
    );
  ]

(* Test Runner *)
let _ = run_test_tt_main tests
