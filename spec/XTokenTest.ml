open OUnit

open Types
open XToken

include Types

let tests = "X Token wrapper" >:::
  [
    "XToken returns X" >:: ( fun () ->
      assert_equal X (XToken.get_gamepiece ())
    );
  ]

(* Test Runner *)
let _ = run_test_tt_main tests
