open OUnit
open Types

let isValidGamePiece value = match value with
  | X -> true
  | O -> true

let isValidSquareState value = match value with
  | Empty -> true
  | Full -> true

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

    "a square can be Full" >:: ( fun () ->
      assert (isValidSquareState Full);
    );
  ]

(* Test Runner *)
let _ = run_test_tt_main tests
