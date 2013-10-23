open OUnit
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
      (next_moves X [[Full X; Empty;  Empty];
                     [Full X; Full O; Empty];
                     [Full O; Empty;  Empty]]);

      assert_equal [
        [[Full X; Full X; Full O];
         [Full X; Full O; Empty];
         [Full O; Empty;  Empty]];

        [[Full X; Full X; Empty];
         [Full X; Full O; Full O ];
         [Full O; Empty;  Empty ]];

        [[Full X; Full X; Empty ];
         [Full X; Full O; Empty ];
         [Full O; Full O; Empty ]];

        [[Full X; Full X; Empty];
         [Full X; Full O; Empty];
         [Full O; Empty;  Full O]];
      ]
      (next_moves O [[Full X; Full X; Empty];
                     [Full X; Full O; Empty];
                     [Full O; Empty ; Empty]])
    );

    "scores terminal board states" >:: ( fun () ->
      assert_equal (-1)
      (leaf_score X [[Full X; Full O;  Empty];
                     [Full X; Full O;  Empty];
                     [Empty;  Full O; Full X]]);
      assert_equal 1
      (leaf_score X [[Full X; Full O; Empty];
                     [Full X; Full O; Empty];
                     [Full X; Empty;  Empty]]);
      assert_equal 0
      (leaf_score X [[Full X; Full O; Empty];
                     [Full X; Empty;  Empty];
                     [Empty;  Empty;  Empty]]);

      assert_equal 1
      (leaf_score O [[Full X; Full O;  Empty];
                     [Full X; Full O;  Empty];
                     [Empty;  Full O; Full X]]);
      assert_equal (-1)
      (leaf_score O [[Full X; Full O; Empty];
                     [Full X; Full O; Empty];
                     [Full X; Empty;  Empty]]);
      assert_equal 0
      (leaf_score O [[Full X; Full O; Empty];
                     [Full X; Empty;  Empty];
                     [Empty;  Empty;  Empty]])
    );

    "calcluates whether a board is a terminal node" >:: ( fun () ->
      assert_equal true
                   (is_terminal [[Full X; Full X; Full X];
                                 [Empty;  Empty;  Empty ];
                                 [Empty;  Empty;  Empty ]]);
      assert_equal true
                   (is_terminal [[Full O; Empty;  Full X];
                                 [Full X; Full X; Full O];
                                 [Full O; Full O; Full X]]);
      assert_equal false
                   (is_terminal [[Full X; Empty; Full O];
                                 [Empty;  Empty; Empty ];
                                 [Empty;  Empty; Empty ]]);
    );

    "calcluates the maximum in a series of scores" >:: ( fun () ->
      assert_equal 1    (max_score [0; 0; 0; -1; 1]);
      assert_equal 0    (max_score [-1; -1; -1; 0]);
      assert_equal (-1) (max_score [-1; -1])
    );

    "calcluates the minimum in a series of scores" >:: ( fun () ->
      assert_equal (-1) (min_score [0; 0; 0; -1; 1]);
      assert_equal 0    (min_score [1; 1; 1; 0]);
      assert_equal (-1) (min_score [-1; -1])
    );

    "scores terminal boards immediately" >:: ( fun () ->
      assert_equal 1    (alpha_beta 1 min_int max_int X X [[Full X; Full X; Full X]]);
      assert_equal (-1) (alpha_beta 1 min_int max_int O X [[Full O; Full O; Full O]]);
      assert_equal 0    (alpha_beta 1 min_int max_int X X [[Full O; Full X; Full O];
                                                           [Full O; Full O; Full X];
                                                           [Full X; Full O; Full X]]);
      assert_equal 1    (alpha_beta 1 min_int max_int O X [[Full X; Full X; Full X];
                                                           [Full O; Full O; Empty];
                                                           [Empty;  Empty;  Empty]]);
      assert_equal (-1) (alpha_beta 1 min_int max_int X X [[Full O; Full O; Full O];
                                                           [Full X; Full X; Empty];
                                                           [Empty;  Empty;  Empty]]);
    );

    "assigns parents of terminal boards terminal board scores" >:: ( fun () ->
      assert_equal 1    (alpha_beta 1 min_int max_int X X [[Full X; Full X; Empty];
                                                           [Full O; Full O; Empty];
                                                           [Empty;  Empty;  Empty]]);
      assert_equal (-1) (alpha_beta 1 min_int max_int O X [[Full O; Full O; Empty];
                                                           [Full X; Full X; Empty];
                                                           [Empty;  Empty;  Empty]]);
    );

    "assigns pending boards zero scores at depth 0" >:: ( fun () ->
      assert_equal 0    (alpha_beta 0 min_int max_int X X [[Full X; Empty; Empty];
                                                           [Full O; Empty; Empty];
                                                           [Empty;  Empty; Empty]]);
    );

    "prefers wins to blocks" >:: ( fun () ->
      assert_equal  [[Full X; Full X; Full X];
                     [Empty;  Empty;  Empty];
                     [Empty;  Full O; Full O]]
                    (best_move X [[Full X; Full X; Empty];
                                  [Empty;  Empty;  Empty];
                                  [Empty;  Full O; Full O]])
    );

    "prefers blocks to losses" >:: ( fun () ->
      assert_equal  [[Full X; Empty;  Empty];
                     [Empty;  Empty;  Full X];
                     [Full X; Full O; Full O]]
                    (best_move X [[Full X; Empty;  Empty];
                                  [Empty;  Empty;  Full X];
                                  [Empty; Full O; Full O]]);
      assert_equal  [[Full X; Full X; Full O];
                     [Empty;  Full O; Empty ];
                     [Empty;  Empty;  Empty ]]
                    (best_move O [[Full X; Full X; Empty];
                                  [Empty;  Full O; Empty];
                                  [Empty;  Empty;  Empty]]);
    );

    "checks and returns true if board scores are all zero" >:: ( fun () ->
      assert (all_zero [(0, 1); (0, 2); (0, 3)]);
    );

    "checks and returns false if board scores are not all zero" >:: ( fun () ->
      assert_equal false (all_zero [(0, 1); (0, 2); (1, 3)]);
    );
  ]

(* Test Runner *)
let _ = run_test_tt_main tests
