open OUnit
open Engine
include Engine

let tests = "Engine" >:::
  [
    "checks a winning row for wins" >:: ( fun () ->
      assert (row_has_win [Full X; Full X; Full X]);
    );

    "checks a mixed row for wins" >:: ( fun () ->
      assert_equal false (row_has_win [Full O; Full X; Full X]);
    );

    "checks an empty row for wins" >:: ( fun () ->
      assert_equal false (row_has_win [Empty; Empty; Empty; Empty]);
    );

    "checks an all-but-empty row for wins" >:: ( fun () ->
      assert_equal false (row_has_win [Full X; Empty; Empty; Empty])
    );

    "checks a three-square row for draws" >:: ( fun () ->
      assert (row_is_drawn [Full X; Full O; Empty]);
    );

    "checks an n-square row for draws" >:: ( fun () ->
      assert (row_is_drawn [Empty; Empty; Empty; Empty; Full O; Full X]);
      assert_equal false (row_is_drawn [Full X; Empty; Empty]);
      assert_equal false (row_is_drawn [Empty; Empty; Empty]);
      assert_equal false (row_is_drawn [Full O; Full O; Full O; Full O]);
      assert_equal false (row_is_drawn [Empty; Empty; Empty; Empty; Full O; Empty]);
    );

    "does not count rows with Empty squares as draws" >:: ( fun () ->
      assert_equal false (row_is_drawn [Full X; Empty; Empty]);
      assert_equal false (row_is_drawn [Empty; Empty; Empty]);
      assert_equal false (row_is_drawn [Empty; Empty; Empty; Empty; Full O; Empty]);
    );

    "does not count rows with wins as draws" >:: ( fun () ->
      assert_equal false (row_is_drawn [Full O; Full O; Full O; Full O]);
      assert_equal false (row_is_drawn [Full X; Full X; Full X]);
    );

    "returns a row's winner or Pending" >:: ( fun () ->
      assert_equal (Win X) (row_state [Full X; Full X; Full X]);
      assert_equal (Win O) (row_state [Full O; Full O; Full O]);
    );

    "returns Pending when there is no winner" >:: ( fun () ->
      assert_equal Pending (row_state [Empty;  Full O; Full X]);
    );

    "checks a board for horizontal wins" >:: ( fun () ->
      assert_equal (Win X)
                   (board_state [[Full X; Full X; Full X];
                                 [Empty;  Empty;  Empty ];
                                 [Empty;  Empty;  Empty ]]);
      assert_equal (Win O)
                   (board_state [[Empty;  Empty;  Empty; Empty];
                                 [Full O; Full O; Full O; Full O];
                                 [Empty;  Empty;  Empty; Empty];
                                 [Empty;  Empty;  Empty; Empty]]);

      assert_equal Pending
                   (board_state [[Full X; Empty;  Full X];
                                 [Empty;  Empty;  Empty ];
                                 [Empty;  Empty;  Empty ]]);
    );

    "checks a board for vertical wins" >:: ( fun () ->
     assert_equal (Win O)
                  (board_state [[Full O; Empty; Empty];
                                [Full O; Empty; Empty];
                                [Full O; Empty; Empty]]);
     assert_equal (Win O)
                  (board_state [[Empty; Empty; Full O; Empty; Empty];
                                [Empty; Empty; Full O; Empty; Empty];
                                [Empty; Empty; Full O; Empty; Empty];
                                [Empty; Empty; Full O; Empty; Empty];
                                [Empty; Empty; Full O; Empty; Empty]]);
    );

    "checks a board for diagonal wins" >:: ( fun () ->
     assert_equal (Win X)
                  (board_state [[Full X; Empty;  Empty];
                                [Empty;  Full X; Empty];
                                [Empty;  Empty;  Full X]]);

     assert_equal (Win O)
                  (board_state [[Empty;  Empty;  Full O];
                                [Empty;  Full O; Empty];
                                [Full O;  Empty;  Empty]])
    );

    "checks a board for simple draws" >:: ( fun () ->
     assert_equal Draw
                  (board_state [[Full X; Full O; Full X];
                                [Full O; Full X; Full X];
                                [Full O; Full X; Full O]]);
    );

    "checks a board for early draws" >:: ( fun () ->
     assert_equal Draw
                  (board_state [[Full X; Empty;  Empty;  Full O; Empty];
                                [Full O; Full O; Full X; Full O; Empty];
                                [Empty;  Full O; Empty;  Full X;  Empty];
                                [Empty;  Full X; Full O; Empty;  Full X];
                                [Empty;  Full X; Empty;  Empty;  Full O]]);
    );
  ]

(* Test Runner *)
let _ = run_test_tt_main tests
