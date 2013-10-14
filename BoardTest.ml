open OUnit
open Types
open Board

let tests = "Board" >:::
  [
    "A gameBoard of size n holds a list of n * n squares" >:: ( fun () ->
      assert_equal [[Empty; Empty; Empty];
                    [Empty; Empty; Empty];
                    [Empty; Empty; Empty]]
                   (new gameBoard 3)#getRows;

      assert_equal [[Empty; Empty; Empty; Empty];
                    [Empty; Empty; Empty; Empty];
                    [Empty; Empty; Empty; Empty];
                    [Empty; Empty; Empty; Empty]]
                   (new gameBoard 4)#getRows
    );

    "A square can be filled with a gamePiece" >:: ( fun () ->
      let board = (new gameBoard 3) in
      assert_equal [[Empty;  Empty; Empty];
                    [Full X; Empty; Empty];
                    [Empty;  Empty; Empty]]
                   (board#fillSquare 1 0 X)#getRows;
    );

    "Many squares can be filled with gamePieces" >:: ( fun () ->
      let board =
        (((new gameBoard 3)#fillSquare 0 0 O)#fillSquare 1 0 X)#fillSquare 2 2 X  in
      assert_equal [[Full O; Empty; Empty];
                    [Full X; Empty; Empty];
                    [Empty;  Empty; Full X]]
                   board#getRows
    );

    "A board's squares can be set" >:: ( fun () ->
      let squares =
        [[Full X; Empty;  Empty];
         [Empty;  Full X; Empty];
         [Empty;  Empty;  Full X]] in
        let board = (new gameBoard 3)#setSquares squares in
          assert_equal squares board#getRows
    );

    "A board returns its rows" >:: ( fun () ->
      let board = (new gameBoard 3)#setSquares
                  [[Full X; Full O; Empty];
                   [Full X; Full O; Empty];
                   [Full O; Empty;  Full X]] in
      assert_equal [[Full X; Full O; Empty  ];
                    [Full X; Full O; Empty  ];
                    [Full O; Empty;  Full X ]]
                   board#getRows

    );

    "A board returns its columns" >:: ( fun () ->
      let board = (new gameBoard 3)#setSquares
                  [[Full X; Full O; Empty];
                   [Full X; Full O; Empty];
                   [Full O; Empty;  Full X]] in
      assert_equal [[Full X; Full X; Full O ];
                    [Full O; Full O; Empty  ];
                    [Empty;  Empty;  Full X ]]
                   board#getColumns
    );

    "A board returns its diagonals" >:: ( fun () ->
      let board = (new gameBoard 3)#setSquares
                  [[Full X; Full O; Empty];
                   [Full X; Full O; Empty];
                   [Full O; Empty;  Full X]] in
      assert_equal [[Full X; Full O; Full X ];
                    [Empty;  Full O; Full O  ]]
                   board#getDiagonals
    );

    "A board returns the values of its squares" >:: (fun () ->
      let board = (new gameBoard 3)#setSquares
                  [[Full X; Full O; Empty];
                   [Full X; Full O; Empty];
                   [Full O; Empty;  Full X]] in
      assert_equal (Full X)
                   (board#getSquare 1 0)
    );

  ]

(* Test Runner *)
let _ = run_test_tt_main tests
