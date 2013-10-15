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
      (next_moves X [[Full X; Empty;  Empty];
                    [Full X; Full O; Empty];
                    [Full O; Empty;  Empty]])
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
                    [Empty;  Empty;  Empty]])
    );

    "leaf_scores next moves" >:: ( fun () ->
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
                    [Empty;  Empty;  Empty]])
    );

    "leaf_scores next moves" >:: ( fun () ->
      assert_equal (-1)
      (leaf_score X [[Full X; Full O;  Empty];
                    [Full X; Full O;  Empty];
                    [Empty;  Full O; Full X]]);
      assert_equal 1
      (leaf_score O [[Full X; Full O;  Empty];
                    [Full X; Full O;  Empty];
                    [Empty;  Full O; Full X]]);
      assert_equal 1
      (leaf_score X [[Full X; Full O; Empty];
                    [Full X; Full O; Empty];
                    [Full X; Empty;  Empty]]);
      assert_equal (-1)
      (leaf_score O [[Full X; Full O; Empty];
                    [Full X; Full O; Empty];
                    [Full X; Empty;  Empty]]);
      assert_equal 0
      (leaf_score X [[Full X; Full O; Empty];
                    [Full X; Empty;  Empty];
                    [Empty;  Empty;  Empty]])
    );

    "calcluates other turn" >:: ( fun () ->
      assert_equal O (other_turn X);
      assert_equal X (other_turn O)
    );

    "calcluates whether a board is a terminal node" >:: ( fun () ->
      assert_equal true
                   (is_terminal [[Full X; Full X; Full X];
                                [Empty;  Empty;  Empty ];
                                [Empty;  Empty;  Empty ]]);
      assert_equal false
                   (is_terminal [[Full X; Empty; Full O];
                                [Empty;  Empty; Empty ];
                                [Empty;  Empty; Empty ]]);
    );

    "assigns winning moves a score of 1" >:: ( fun () ->
      assert_equal 1
                   (minimax 1 X [[Full X; Full X; Full X];
                                 [Empty;  Empty;  Empty ];
                                 [Empty;  Empty;  Empty ]]);
    );

    "assigns losing moves a score of -1" >:: ( fun () ->
      assert_equal (-1)
                   (minimax 1 X [[Full O; Full O; Full O];
                                 [Empty;  Empty;  Empty ];
                                 [Empty;  Empty;  Empty ]]);
    );

    "assigns indeterminate moves a score of 0 at lookahead depth" >:: ( fun () ->
      assert_equal 0
                   (minimax 1 X [[Full X; Empty;  Empty ];
                                 [Empty;  Empty;  Empty ];
                                 [Empty;  Full O; Empty ]]);
    );

    "scores wins above blocks" >:: ( fun () ->
      assert_equal [1; 0]
                   (List.map (fun b -> minimax 2 X b)
                             [[[Full O; Full O; Empty];
                               [Empty;  Empty;  Empty];
                               [Full X; Full X; Full X]];
                              [[Full O; Full O; Full X];
                               [Empty;  Empty;  Empty];
                               [Full X; Full X; Empty]]])

    );

    "scores blocks above losing moves" >:: ( fun () ->
      assert_equal [0; -1]
                   (List.map (fun b -> minimax 2 X b)
                             [[[Full O; Full O; Full X];
                               [Full X; Empty;  Empty ];
                               [Full X; Empty;  Empty ]];
                              [[Full O; Full O; Empty];
                               [Full X; Full X; Empty];
                               [Full X; Empty;  Empty]]])

    );
  ]

(* Test Runner *)
let _ = run_test_tt_main tests
