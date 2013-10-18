open OUnit
open RandomMove
include RandomMove

let tests = "RandomMove" >:::
  [
    "gets next board states" >:: ( fun () ->
      assert_equal [
        [[Full X; Full X; Empty];
         [Full X; Full O; Empty];
         [Full O; Empty;  Empty]];

        [[Full X; Empty;  Full X];
         [Full X; Full O; Empty ];
         [Full O; Empty;  Empty ]];

        [[Full X; Empty;  Empty ];
         [Full X; Full O; Full X];
         [Full O; Empty;  Empty ]];

        [[Full X; Empty;  Empty];
         [Full X; Full O; Empty];
         [Full O; Full X; Empty]];

        [[Full X; Empty;  Empty];
         [Full X; Full O; Empty];
         [Full O; Empty;  Full X]];
      ]
      (next_moves X [[Full X; Empty;  Empty];
                    [Full X; Full O; Empty];
                    [Full O; Empty;  Empty]])
    );

    "picks a move at random" >:: ( fun () ->
      assert_equal 1 (random_move [1;]);
    );
  ]

(* Test Runner *)
let _ = run_test_tt_main tests
