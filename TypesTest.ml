open OUnit
open Types

let isGamePiece value = match value with
  | X -> true
  | O -> true

let tests = "Types" >:::
  [
    "X is a type of game piece" >:: ( fun () ->
      assert (isGamePiece X);
    );

    "O is a type of game piece" >:: ( fun () ->
      assert (isGamePiece O);
    );
  ]

(* Test Runner *)
let _ = run_test_tt_main tests
