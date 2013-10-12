open OUnit
open Board

let tests = "Board" >:::
  [
    "A Board holds a list of squares" >:: ( fun () ->
      assert_equal [] (new gameBoard)#getSquares
    );
  ]

(* Test Runner *)
let _ = run_test_tt_main tests
