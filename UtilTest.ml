open OUnit
open Types
include Types
open Util
include Util

let tests = "Util" >:::
  [

    "creating a list of size n filled with a default value" >:: (fun () ->
      assert_equal [Empty; Empty; Empty; Empty]
                   (makeList 4 Empty)
    );


    "'setting' the value of the i-th element in a list" >:: (fun () ->
      assert_equal [1; 2; 3; 100]
                   (setNth 3 100 [1; 2; 3; 4])
    );
  ]

(* Test Runner *)
let _ = run_test_tt_main tests
