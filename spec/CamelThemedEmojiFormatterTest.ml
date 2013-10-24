open OUnit
open CamelThemedEmojiFormatter
include CamelThemedEmojiFormatter

let separator = ("\n\xe2\x94\x81\xe2\x94\x81\xe2\x94\x81\xe2\x95\x8b" ^
                   "\xe2\x94\x81\xe2\x94\x81\xe2\x94\x81\xe2\x95\x8b" ^
                   "\xe2\x94\x81\xe2\x94\x81\xe2\x94\x81\n")

let tests = "Camel-Themed Emoji Formatter" >:::
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

    "converts a square to an emoji string" >:: ( fun () ->
      assert_equal " \xf0\x9f\x90\xab "  (square_string (Full X));
      assert_equal " \xf0\x9f\x90\xaa "  (square_string (Full O));
      assert_equal "   " (square_string Empty);
    );

    "converts a row to a string" >:: ( fun () ->
      assert_equal (square_string (Full O) ^ "\xe2\x94\x83   \xe2\x94\x83   ")
                   (row_string [Full O; Empty;  Empty ];)

    );

    "generates a row separator" >:: ( fun () ->
      assert_equal separator (row_separator 3);
    );

    "converts a board to a string" >:: ( fun () ->
      let o = (square_string (Full O)) in
      let x = (square_string (Full X)) in
        assert_equal (o ^ "\xe2\x94\x83   \xe2\x94\x83   " ^
                      separator ^
                      x ^ "\xe2\x94\x83" ^ x ^ "\xe2\x94\x83" ^ o ^
                      separator ^
                      "   \xe2\x94\x83   \xe2\x94\x83   \n")
                     (board_string [[Full O; Empty;  Empty ];
                                    [Full X; Full X; Full O];
                                    [Empty;  Empty;  Empty]])

    );

    "colors messages by type" >:: ( fun () ->
      assert_equal ("\xf0\x9f\x8c\xb4  " ^ (colored_string "Hello world!" Red))
                   (message_string "Hello world!" Error);
      assert_equal ("\xf0\x9f\x8c\xb4  " ^ (colored_string "Hello world!" Cyan))
                   (message_string "Hello world!" Info);
      assert_equal ("\xf0\x9f\x8c\xb4  " ^ (colored_string "Hello world!" Green))
                   (message_string "Hello world!" (Prompt X));
      assert_equal ("\xf0\x9f\x8c\xb4  " ^ (colored_string "Hello world!" Blue))
                   (message_string "Hello world!" (Prompt O));
      assert_equal ("\xf0\x9f\x8c\xb4  " ^ (colored_string "Hello world!" Yellow))
                   (message_string "Hello world!" Normal)
    );

    "replaces X and O with camels" >:: ( fun () ->
      assert_equal "\xf0\x9f\x90\xab  (Bactrian) is my favorite camel!"
                   (substitute_camels "X is my favorite camel!");
      assert_equal "\xf0\x9f\x90\xaa  (Dromedary) is my favorite camel!"
                   (substitute_camels "O is my favorite camel!");
    );

    "matches and replaces the startup message" >:: ( fun () ->
      assert_equal ("\xf0\x9f\x8c\xb4  " ^
                    (colored_message "Welcome to Connect-a-\xf0\x9f\x90\xaa !" Info))
                   (message_string "Welcome to Tic-Tac-Toe!\n" Info)
    );


  ]

(* Test Runner *)
let _ = run_test_tt_main tests
