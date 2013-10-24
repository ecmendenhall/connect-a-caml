open OUnit
open Types
include Types
open Util
include Util

let tests = "Util" >:::
  [

    "splitting a list into two lists" >:: ( fun () ->
      assert_equal ([ "tro"; "lo"; "lo" ], [ "lo"; "lo"])
                   (split_before 3 [ "tro"; "lo"; "lo"; "lo"; "lo" ]);
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
                   (partition_by 3 [ "wha"; "pa"; "pa"; "pa"; "pa"; "pa"; "pow!" ])
    );
    "creating a list of size n filled with a default value" >:: (fun () ->
      assert_equal [Empty; Empty; Empty; Empty]
                   (make_list 4 Empty)
    );


    "'setting' the value of the i-th element in a list" >:: (fun () ->
      assert_equal [1; 2; 3; 100]
                   (set_nth 3 100 [1; 2; 3; 4])
    );
  ]

(* Test Runner *)
let _ = run_test_tt_main tests
