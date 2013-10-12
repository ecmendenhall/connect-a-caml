open OUnit
open Util

let tests = "Util" >:::
  [
    "modifying and returning an array" >:: ( fun () ->
      assert_equal [| "tro"; "lo"; "lo"; "lo"; "lo" |]
                   (replaceNth [| "lo"; "lo"; "lo"; "lo"; "lo" |] 0 "tro");
    );
  ]

(* Test Runner *)
let _ = run_test_tt_main tests
