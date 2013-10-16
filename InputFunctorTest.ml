open OUnit
open Types
include Types
open InputFunctor

module MockPervasives =
  struct
    let read_line unit =
      "Hello world!"
  end;;

module Input = InputFunctor (MockPervasives)

let tests = "Input" >:::
  [
    "Reads lines from its input source" >:: ( fun () ->
      assert_equal "Hello world!" Input.read_line
    );

  ]

(* Test Runner *)
let _ = run_test_tt_main tests
