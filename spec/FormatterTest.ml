open OUnit
open Formatter
include Formatter

let tests = "Formatter" >:::
  [
    "converts a square to a string" >:: ( fun () ->
      assert_equal " O " (square_string (Full O));
      assert_equal " X " (square_string (Full X));
      assert_equal "   " (square_string Empty);
    );

    "converts a row to a string" >:: ( fun () ->
      assert_equal "0  O |   |   "
                   (row_string 0 [Full O; Empty;  Empty ];)

    );

    "generates a row separator" >:: ( fun () ->
      assert_equal "\n  ---+---+---\n"         (row_separator 3);
      assert_equal "\n  ---+---+---+---\n"     (row_separator 4);
      assert_equal "\n  ---+---+---+---+---\n" (row_separator 5)
    );

    "generates a column header" >:: ( fun () ->
      assert_equal "   0   1   2 \n\n"         (column_header 3);
      assert_equal "   0   1   2   3 \n\n"     (column_header 4);
      assert_equal "   0   1   2   3   4 \n\n" (column_header 5)
    );

    "converts a board to a string" >:: ( fun () ->
      assert_equal ("   0   1   2 \n\n" ^
                    "0  O |   |   \n" ^
                    "  ---+---+---\n" ^
                    "1  X | X | O \n" ^
                    "  ---+---+---\n" ^
                    "2    |   |   \n")
                   (board_string [[Full O; Empty;  Empty ];
                                 [Full X; Full X; Full O];
                                 [Empty;  Empty;  Empty]]);
      assert_equal ("   0   1   2   3 \n\n" ^
                    "0  X |   |   |   \n" ^
                    "  ---+---+---+---\n" ^
                    "1    | O |   |   \n" ^
                    "  ---+---+---+---\n" ^
                    "2    |   | X |   \n" ^
                    "  ---+---+---+---\n" ^
                    "3    |   |   | O \n")
                   (board_string [[Full X; Empty;   Empty;  Empty];
                                 [Empty;  Full O;  Empty;  Empty];
                                 [Empty;  Empty;   Full X; Empty];
                                 [Empty;  Empty;   Empty;  Full O]])

    );

    "ignores message types" >:: ( fun () ->
      assert_equal "Hello world!" (message_string "Hello world!" Error)
    );

    "replaces the unicode prompt with an ASCII one" >:: ( fun () ->
      assert_equal ">>" (message_string "\xe2\x9e\xa4\xe2\x9e\xa4 " Normal)
    );

    "generates a range" >:: ( fun () ->
      assert_equal [0; 1; 2] (range 0 3)
    );
  ]

(* Test Runner *)
let _ = run_test_tt_main tests
