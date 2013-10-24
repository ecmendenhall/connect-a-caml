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
      assert_equal " O |   |   "
                   (row_string [Full O; Empty;  Empty ];)

    );

    "generates a row separator" >:: ( fun () ->
      assert_equal "\n---+---+---\n"         (row_separator 3);
      assert_equal "\n---+---+---+---\n"     (row_separator 4);
      assert_equal "\n---+---+---+---+---\n" (row_separator 5)
    );

    "converts a board to a string" >:: ( fun () ->
      assert_equal (" O |   |   \n" ^
                    "---+---+---\n" ^
                    " X | X | O \n" ^
                    "---+---+---\n" ^
                    "   |   |   \n")
                   (board_string [[Full O; Empty;  Empty ];
                                 [Full X; Full X; Full O];
                                 [Empty;  Empty;  Empty]]);
      assert_equal (
                    " X |   |   |   \n" ^
                    "---+---+---+---\n" ^
                    "   | O |   |   \n" ^
                    "---+---+---+---\n" ^
                    "   |   | X |   \n" ^
                    "---+---+---+---\n" ^
                    "   |   |   | O \n")
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
  ]

(* Test Runner *)
let _ = run_test_tt_main tests
