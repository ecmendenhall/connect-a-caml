open OUnit
open Types
include Types
open Engine
include Engine

let tests = "Engine" >:::
  [
    "checks a row for wins" >:: ( fun () ->
      assert (rowHasWin [Full X; Full X; Full X]);
      assert_equal false (rowHasWin [Full O; Full X; Full X]);
      assert_equal false (rowHasWin [Empty; Empty; Empty; Empty]);
      assert_equal false (rowHasWin [Full X; Empty; Empty; Empty])
    );
  ]

(* Test Runner *)
let _ = run_test_tt_main tests
