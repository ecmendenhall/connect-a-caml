open OUnit
open Types
include Types
open Output
include Output

let tests = "Output" >:::
  [
    "converts a square to a string" >:: ( fun () ->
      assert_equal " O " (print_square (Full O));
      assert_equal " X " (print_square (Full X));
      assert_equal "   " (print_square Empty);
    );

    "converts a row to a string" >:: ( fun () ->
      assert_equal " O |   |   "
                   (print_row [Full O; Empty;  Empty ];)

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
                   (print_board [[Full O; Empty;  Empty ];
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
                   (print_board [[Full X; Empty;   Empty;  Empty];
                                 [Empty;  Full O;  Empty;  Empty];
                                 [Empty;  Empty;   Full X; Empty];
                                 [Empty;  Empty;   Empty;  Full O]])

    );

  ]

(* Test Runner *)
let _ = run_test_tt_main tests
