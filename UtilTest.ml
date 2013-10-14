open OUnit
open Util
open Types

let tests = "Util" >:::
  [
    "modifying and returning an array" >:: ( fun () ->
      assert_equal [| "tro"; "lo"; "lo"; "lo"; "lo" |]
                   (replaceNth [| "lo"; "lo"; "lo"; "lo"; "lo" |] 0 "tro");
    );

    "splitting a list into two lists" >:: ( fun () ->
      assert_equal ([ "tro"; "lo"; "lo" ], [ "lo"; "lo"])
                   (splitBefore 3 [ "tro"; "lo"; "lo"; "lo"; "lo" ]);
    );

    "taking the first n items from a list" >:: ( fun () ->
      assert_equal [ "tro"; "lo"; "lo" ]
                   (take 3 [ "tro"; "lo"; "lo"; "lo"; "lo" ]);
    );

    "dropping the first n items from a list" >:: ( fun () ->
      assert_equal [ "lo"; "lo" ]
                   (drop 3 [ "tro"; "lo"; "lo"; "lo"; "lo" ]);
    );

    "partitioning a list into groups of n items" >:: (fun () ->
      assert_equal [["wha"; "pa"; "pa"];
                    ["pa";  "pa"; "pa"];
                    ["pow!"]]
                   (partitionBy 3 [ "wha"; "pa"; "pa"; "pa"; "pa"; "pa"; "pow!" ])
    );

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

    "creating a list of size n filled with a default value" >:: (fun () ->
      assert_equal [Empty; Empty; Empty; Empty]
                   (makeList 4 Empty)
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

    "'setting' the value of the i-th element in a list" >:: (fun () ->
      assert_equal [1; 2; 3; 100]
                   (setNth 3 100 [1; 2; 3; 4])
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
