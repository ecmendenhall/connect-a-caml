open OUnit
open Util

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
  ]

(* Test Runner *)
let _ = run_test_tt_main tests
