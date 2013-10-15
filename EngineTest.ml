open OUnit
open Types
include Types
open Engine
include Engine

let tests = "Engine" >:::
  [
    "checks a row for wins" >:: ( fun () ->
      assert (rowHasWin [Full X; Full X; Full X]);
      assert_equal false (rowHasWin [Full O; Full X; Full X]);
      assert_equal false (rowHasWin [Empty; Empty; Empty; Empty]);
      assert_equal false (rowHasWin [Full X; Empty; Empty; Empty])
    );

    "returns a row's winner or Pending" >:: ( fun () ->
      assert_equal (Win X) (rowState [Full X; Full X; Full X]);
      assert_equal (Win O) (rowState [Full O; Full O; Full O]);
      assert_equal Pending (rowState [Empty;  Full O; Full X]);
    );

    "checks a board for horizontal wins" >:: ( fun () ->
      assert_equal (Win X)
                   (boardState [[Full X; Full X; Full X];
                                [Empty;  Empty;  Empty ];
                                [Empty;  Empty;  Empty ]]);
      assert_equal (Win O)
                   (boardState [[Empty;  Empty;  Empty; Empty];
                                [Full O; Full O; Full O; Full O];
                                [Empty;  Empty;  Empty; Empty];
                                [Empty;  Empty;  Empty; Empty]]);

      assert_equal Pending
                   (boardState [[Full X; Empty;  Full X];
                                [Empty;  Empty;  Empty ];
                                [Empty;  Empty;  Empty ]]);
    );

    "checks a board for vertical wins" >:: ( fun () ->
     assert_equal (Win O)
                  (boardState [[Full O; Empty; Empty];
                               [Full O; Empty; Empty];
                               [Full O; Empty; Empty]]);
     assert_equal (Win O)
                  (boardState [[Empty; Empty; Full O; Empty; Empty];
                               [Empty; Empty; Full O; Empty; Empty];
                               [Empty; Empty; Full O; Empty; Empty];
                               [Empty; Empty; Full O; Empty; Empty];
                               [Empty; Empty; Full O; Empty; Empty]]);
    );

    "checks a board for diagonal wins" >:: ( fun () ->
     assert_equal (Win X)
                  (boardState [[Full X; Empty;  Empty];
                               [Empty;  Full X; Empty];
                               [Empty;  Empty;  Full X]]);

     assert_equal (Win O)
                  (boardState [[Empty;  Empty;  Full O];
                               [Empty;  Full O; Empty];
                               [Full O;  Empty;  Empty]])
    );

    "checks a board for simple draws" >:: ( fun () ->
     assert_equal Draw
                  (boardState [[Full X; Full O; Full X];
                               [Full O; Full X; Full X];
                               [Full O; Full X; Full O]]);
    );
  ]

(* Test Runner *)
let _ = run_test_tt_main tests
