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

    "Many squares can be filled with gamePieces" >:: ( fun () ->
      let board =
        (((new gameBoard 3)#fillSquare 0 O)#fillSquare 3 X)#fillSquare 8 X  in
      assert_equal [| Full O; Empty; Empty;
                      Full X; Empty; Empty;
                      Empty;  Empty; Full X; |]
                   board#getSquares
    );

    "A board's squares can be set" >:: ( fun () ->
      let squares =
          [| Full X; Empty;  Empty;
             Empty;  Full X; Empty;
             Empty;  Empty;  Full X |] in
        let board = (new gameBoard 3)#setSquares squares in
          assert_equal squares board#getSquares
    );

    "A board returns its rows" >:: ( fun () ->
      let board = (new gameBoard 3)#setSquares
                  [| Full X; Full O; Empty;
                     Full X; Full O; Empty;
                     Full O; Empty;  Full X |] in
      assert_equal [[ Full X;  Full O; Empty  ];
                    [ Full X;  Full O; Empty  ];
                    [ Full O;  Empty;  Full X ]]
                   board#getRows

    );
  ]

(* Test Runner *)
let _ = run_test_tt_main tests
