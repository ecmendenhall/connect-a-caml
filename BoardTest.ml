open OUnit
open Board
open Types

let tests = "Board" >:::
  [
    "A gameBoard of size n holds a list of n * n squares" >:: ( fun () ->
      assert_equal [[Empty; Empty; Empty];
                    [Empty; Empty; Empty];
                    [Empty; Empty; Empty]]
                   (Board.empty_board 3);

      assert_equal [[Empty; Empty; Empty; Empty];
                    [Empty; Empty; Empty; Empty];
                    [Empty; Empty; Empty; Empty];
                    [Empty; Empty; Empty; Empty]]
                   (Board.empty_board 4)
    );

    "A square can be filled with a gamePiece" >:: ( fun () ->
      let board = (Board.empty_board 3) in
      assert_equal [[Empty;  Empty; Empty];
                    [Full X; Empty; Empty];
                    [Empty;  Empty; Empty]]
                   (Board.fill_square 1 0 X board);
    );

    "Many squares can be filled with gamePieces" >:: ( fun () ->
      let board =
        Board.fill_square 2 2 X
        (Board.fill_square 1 0 X
         (Board.fill_square 0 0 O
          (Board.empty_board 3))) in
      assert_equal [[Full O; Empty; Empty];
                    [Full X; Empty; Empty];
                    [Empty;  Empty; Full X]]
                   board
    );

    "A board returns its columns" >:: ( fun () ->
      let board = [[Full X; Full O; Empty];
                   [Full X; Full O; Empty];
                   [Full O; Empty;  Full X]] in
      assert_equal [[Full X; Full X; Full O ];
                    [Full O; Full O; Empty  ];
                    [Empty;  Empty;  Full X ]]
                   (Board.get_columns board)
    );

    "A board returns its diagonals" >:: ( fun () ->
      let board = [[Full X; Full O; Empty];
                   [Full X; Full O; Empty];
                   [Full O; Empty;  Full X]] in
      assert_equal [[Full X; Full O; Full X];
                    [Empty;  Full O; Full O]]
                   (Board.get_diagonals board)
    );

    "A board returns the values of its squares" >:: (fun () ->
      let board = [[Full X; Full O; Empty];
                   [Full X; Full O; Empty];
                   [Full O; Empty;  Full X]] in
      assert_equal (Full X)
                   (Board.get_square 1 0 board)
    );

    "map" >:: (fun () ->
      let board = [[Full X; Full O; Empty];
                   [Full X; Full O; Empty];
                   [Full O; Empty;  Full X]] in
      assert_equal [["X"; "O"; "_"];
                    ["X"; "O"; "_"];
                    ["O"; "_"; "X"]]
                   (Board.map (fun sq -> match sq with
                                         | Full X -> "X"
                                         | Full O -> "O"
                                         | _      -> "_")
                               board)
    );

    "mapi" >:: (fun () ->
      let board = [[Full X; Full O; Empty];
                   [Full X; Full O; Empty];
                   [Full O; Empty;  Full X]] in
      assert_equal [[0; 1; 2];
                    [3; 4; 5];
                    [6; 7; 8]]
                   (Board.mapi (fun i _ -> i) board)
    );

    "converting flattened indices to row, column coordinates" >:: (fun () ->
      assert_equal (0, 0) (Board.index_to_row_col 0 3);
      assert_equal (0, 1) (Board.index_to_row_col 1 3);
      assert_equal (0, 2) (Board.index_to_row_col 2 3);
      assert_equal (1, 0) (Board.index_to_row_col 3 3);
    );

    "map_row_column" >:: (fun () ->
      let board = [[Full X; Full O; Empty];
                   [Full X; Full O; Empty];
                   [Full O; Empty;  Full X]] in
      assert_equal [[0, 0; 0, 1; 0, 2];
                    [1, 0; 1, 1; 1, 2];
                    [2, 0; 2, 1; 2, 2]]
                   (Board.map_row_column (fun r c _ -> (r, c)) board)
    );
  ]

(* Test Runner *)
let _ = run_test_tt_main tests
