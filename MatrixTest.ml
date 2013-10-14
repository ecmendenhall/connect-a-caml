open OUnit
open Types
open Matrix
include Matrix

let tests = "Util" >:::
  [

    "transposing a matrix" >:: (fun () ->
      assert_equal [[1; 1; 1];
                    [0; 1; 1];
                    [0; 0; 1]]
                   (transpose [[1; 0; 0];
                               [1; 1; 0];
                               [1; 1; 1]])
    );

    "creating a square matrix" >:: (fun () ->
      assert_equal [[0; 0; 0];
                    [0; 0; 0];
                    [0; 0; 0] ]
                   (squareMatrix 3 0)
    );

    "creating a matrix filled with a default value" >:: (fun () ->
      assert_equal [[Empty; Empty; Empty];
                    [Empty; Empty; Empty];
                    [Empty; Empty; Empty]]
                   (squareMatrix 3 Empty)
    );

    "getting an entry from the i-th row and j-th column of a matrix" >:: (fun () ->
      let matrix = [[0; 1; 2; 3];
                    [4; 5; 6; 7];
                    [8; 9; 0; 5];
                    [4; 3; 2; 1]] in
        assert_equal 5
                     (valueAt 2 3 matrix);
        assert_equal 2
                     (valueAt 0 2 matrix)
    );

    "getting the i-th row of a matrix" >:: (fun () ->
      let matrix = [[0; 1; 2; 3];
                    [4; 5; 6; 7];
                    [8; 9; 0; 5];
                    [4; 3; 2; 1]] in
       assert_equal [4; 5; 6; 7]
                    (row 1 matrix)
    );

    "getting the j-th column of a matrix" >:: (fun () ->
      let matrix = [[0; 1; 2; 3];
                    [4; 5; 6; 7];
                    [8; 9; 0; 5];
                    [4; 3; 2; 1]] in

        assert_equal [1; 5; 9; 3]
                     (column 1 matrix)
    );

    "getting the diagonal of a matrix" >:: (fun () ->
      let matrix = [[0; 1; 2; 3];
                    [4; 5; 6; 7];
                    [8; 9; 0; 5];
                    [4; 3; 2; 1]] in

        assert_equal [0; 5; 0; 1]
                     (diagonal matrix)
    );

    "getting the antidiagonal of a matrix" >:: (fun () ->
      let matrix = [[0; 1; 2; 3];
                    [4; 5; 6; 7];
                    [8; 9; 0; 5];
                    [4; 3; 2; 1]] in

        assert_equal [3; 6; 9; 4]
                     (antidiagonal matrix)
    );

    "'setting' the i-th row, j-th column value of a matrix" >:: (fun () ->
      let matrix = [[0; 1; 2; 3];
                    [4; 5; 6; 7];
                    [8; 9; 0; 5];
                    [4; 3; 2; 1]] in

        assert_equal [[0; 1; 2; 3];
                      [4; 5; 6; 100];
                      [8; 9; 0; 5];
                      [4; 3; 2; 1]]
                     (setValue 1 3 100 matrix)
    );
  ]

(* Test Runner *)
let _ = run_test_tt_main tests
