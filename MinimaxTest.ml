open OUnit
open Types
include Types
open Minimax
include Minimax

let tests = "Minimax" >:::
  [
    "gets next board states" >:: ( fun () ->
      assert_equal [
        [[Full X; Full X; Empty];
         [Full X; Full O; Empty];
         [Full O; Empty;  Empty]];

        [[Full X; Empty;  Full X];
         [Full X; Full O; Empty ];
         [Full O; Empty;  Empty ]];

        [[Full X; Empty;  Empty ];
         [Full X; Full O; Full X];
         [Full O; Empty;  Empty ]];

        [[Full X; Empty;  Empty];
         [Full X; Full O; Empty];
         [Full O; Full X; Empty]];

        [[Full X; Empty;  Empty];
         [Full X; Full O; Empty];
         [Full O; Empty;  Full X]];
      ]
      (nextMoves X [[Full X; Empty;  Empty];
                    [Full X; Full O; Empty];
                    [Full O; Empty;  Empty]])
    );

    "scores board states" >:: ( fun () ->
      assert_equal (-1)
      (score X [[Full X; Full O;  Empty];
                [Full X; Full O;  Empty];
                [Empty;  Full O; Full X]]);
      assert_equal 1
      (score X [[Full X; Full O; Empty];
                [Full X; Full O; Empty];
                [Full X; Empty;  Empty]]);
      assert_equal 0
      (score X [[Full X; Full O; Empty];
                [Full X; Empty;  Empty];
                [Empty;  Empty;  Empty]])
    );
  ]

(* Test Runner *)
let _ = run_test_tt_main tests
