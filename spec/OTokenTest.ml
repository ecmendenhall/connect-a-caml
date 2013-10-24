open OUnit
open OToken
open Types
include Types

let tests = "O Token wrapper" >:::
  [
    "OToken returns O" >:: ( fun () ->
      assert_equal O (OToken.get_gamepiece ())
    );
  ]

(* Test Runner *)
let _ = run_test_tt_main tests
