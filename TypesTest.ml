open OUnit
open Types
include Types

let isValidGamePiece value = match value with
  | X -> true
  | O -> true

let isValidSquareState value = match value with
  | Empty -> true
  | Full _ -> true

let isValidGameState value = match value with
  | Win _   -> true
  | Draw    -> true
  | Pending -> true

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

    "a square can be Full of a game piece" >:: ( fun () ->
      assert (isValidSquareState (Full X));
      assert (isValidSquareState (Full O));
    );

    "a game can be a Win for X or O" >:: ( fun () ->
      assert (isValidGameState (Win X));
      assert (isValidGameState (Win O));
    );

    "a game can be Pending" >:: ( fun () ->
      assert (isValidGameState Pending);
    );

    "a game can be a Draw" >:: ( fun () ->
      assert (isValidGameState Draw);
    );
  ]

(* Test Runner *)
let _ = run_test_tt_main tests
