open OUnit
open Util

let tests = "Util" >:::
  [
    "adding n elements to the head of a list" >:: ( fun () ->
      assert_equal [1; 1; 1; 1; 1] (addN [] 5 1);
      assert_equal ["ding"; "ding"; "ding"; "ding"; "eringeding!"]
                   (addN ["eringeding!";] 4 "ding")
    );

    "creating a list of n identical elements" >:: ( fun () ->
      assert_equal [0; 0; 0] (fillN 3 0);
      assert_equal ["tro"; "lo"; "lo"; "lo"; "lo"]
                   ("tro" :: (fillN 4 "lo"))
    );
  ]

(* Test Runner *)
let _ = run_test_tt_main tests
