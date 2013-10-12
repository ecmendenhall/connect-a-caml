open OUnit
open Types
open Board

let tests = "Board" >:::
  [
    "A gameBoard of size n holds a list of n * n squares" >:: ( fun () ->
      assert_equal [| Empty; Empty; Empty;
                      Empty; Empty; Empty;
                      Empty; Empty; Empty |]
                   (new gameBoard 3)#getSquares;

      assert_equal [| Empty; Empty; Empty; Empty;
                      Empty; Empty; Empty; Empty;
                      Empty; Empty; Empty; Empty;
                      Empty; Empty; Empty; Empty; |]
                   (new gameBoard 4)#getSquares
    );

    "A square can be filled with a gamePiece" >:: ( fun () ->
      let board = (new gameBoard 3) in
      assert_equal [| Empty;  Empty; Empty;
                      Full X; Empty; Empty;
                      Empty;  Empty; Empty; |]
                   (board#fillSquare 3 X)#getSquares;
    );
  ]

(* Test Runner *)
let _ = run_test_tt_main tests
