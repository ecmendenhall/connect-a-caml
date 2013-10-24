open OUnit

open ColorFormatter
include ColorFormatter

let tests = "Color Formatter" >:::
  [
    "maps colors to ANSI escapes" >:: ( fun () ->
      assert_equal "\x1b[1;31m" (ansi_color Red);
      assert_equal "\x1b[1;32m" (ansi_color Green);
      assert_equal "\x1b[1;33m" (ansi_color Yellow);
      assert_equal "\x1b[1;34m" (ansi_color Blue);
      assert_equal "\x1b[1;35m" (ansi_color Magenta);
      assert_equal "\x1b[1;36m" (ansi_color Cyan);
    );

    "constructs colored strings" >:: ( fun () ->
      assert_equal "\x1b[1;31mHello World!\x1b[0m" (colored_string "Hello World!" Red);
    );

    "converts a square to a colored string" >:: ( fun () ->
      assert_equal (colored_string " O " Blue)  (square_string (Full O));
      assert_equal (colored_string " X " Green) (square_string (Full X));
      assert_equal "   " (square_string Empty);
    );

    "converts a row to a string" >:: ( fun () ->
      assert_equal ("0 " ^ (colored_string " O " Blue) ^ "|   |   ")
                   (row_string 0 [Full O; Empty;  Empty ];)

    );

    "generates a row separator" >:: ( fun () ->
      assert_equal "\n  ---+---+---\n"         (row_separator 3);
      assert_equal "\n  ---+---+---+---\n"     (row_separator 4);
      assert_equal "\n  ---+---+---+---+---\n" (row_separator 5)
    );

    "converts a board to a string" >:: ( fun () ->
      let o = (colored_string " O " Blue)  in
      let x = (colored_string " X " Green) in
        assert_equal ("   0   1   2 \n\n" ^
                      "0 " ^ o ^ "|   |   \n" ^
                      "  ---+---+---\n" ^
                      "1 " ^ x ^ "|" ^ x ^ "|" ^ o ^ "\n" ^
                      "  ---+---+---\n" ^
                      "2    |   |   \n")
                     (board_string [[Full O; Empty;  Empty ];
                                   [Full X; Full X; Full O];
                                   [Empty;  Empty;  Empty]])

    );

    "colors messages by type" >:: ( fun () ->
      assert_equal (colored_string "Hello world!" Red)   (message_string "Hello world!" Error);
      assert_equal (colored_string "Hello world!" Cyan)  (message_string "Hello world!" Info);
      assert_equal (colored_string "Hello world!" Green) (message_string "Hello world!" (Prompt X));
      assert_equal (colored_string "Hello world!" Blue)  (message_string "Hello world!" (Prompt O))
    );

    "generates a column header" >:: ( fun () ->
      assert_equal "   0   1   2 \n\n"         (column_header 3);
      assert_equal "   0   1   2   3 \n\n"     (column_header 4);
      assert_equal "   0   1   2   3   4 \n\n" (column_header 5)
    );

    "generates a range" >:: ( fun () ->
      assert_equal [0; 1; 2] (range 0 3)
    );

  ]

(* Test Runner *)
let _ = run_test_tt_main tests
