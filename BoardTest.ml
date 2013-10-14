open OUnit
open Board
open Types

let tests = "Board" >:::
  [
    "A gameBoard of size n holds a list of n * n squares" >:: ( fun () ->
      assert_equal [[Empty; Empty; Empty];
                    [Empty; Empty; Empty];
                    [Empty; Empty; Empty]]
                   (Board.emptyBoard 3);

      assert_equal [[Empty; Empty; Empty; Empty];
                    [Empty; Empty; Empty; Empty];
                    [Empty; Empty; Empty; Empty];
                    [Empty; Empty; Empty; Empty]]
                   (Board.emptyBoard 4)
    );

    "A square can be filled with a gamePiece" >:: ( fun () ->
      let board = (Board.emptyBoard 3) in
      assert_equal [[Empty;  Empty; Empty];
                    [Full X; Empty; Empty];
                    [Empty;  Empty; Empty]]
                   (Board.fillSquare 1 0 X board);
    );

    "Many squares can be filled with gamePieces" >:: ( fun () ->
      let board =
        Board.fillSquare 2 2 X
        (Board.fillSquare 1 0 X
         (Board.fillSquare 0 0 O
          (Board.emptyBoard 3))) in
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
                   (Board.getColumns board)
    );

    "A board returns its diagonals" >:: ( fun () ->
      let board = [[Full X; Full O; Empty];
                   [Full X; Full O; Empty];
                   [Full O; Empty;  Full X]] in
      assert_equal [[Full X; Full O; Full X ];
                    [Empty;  Full O; Full O  ]]
                   (Board.getDiagonals board)
    );

    "A board returns the values of its squares" >:: (fun () ->
      let board = [[Full X; Full O; Empty];
                   [Full X; Full O; Empty];
                   [Full O; Empty;  Full X]] in
      assert_equal (Full X)
                   (Board.getSquare 1 0 board)
    );

  ]

(* Test Runner *)
let _ = run_test_tt_main tests
