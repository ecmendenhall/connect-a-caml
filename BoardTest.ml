open OUnit
open Types
open Board

let tests = "Board" >:::
  [
    "A Board of size n holds an array of n * n squares" >:: ( fun () ->
      assert_equal [| Empty; Empty; Empty;
                      Empty; Empty; Empty;
                      Empty; Empty; Empty |]
                   (new gameBoard 3)#getSquares
    );
  ]

(* Test Runner *)
let _ = run_test_tt_main tests
