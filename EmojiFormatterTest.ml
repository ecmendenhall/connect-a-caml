open OUnit
open EmojiFormatter
include EmojiFormatter

let separator = ("\n\xe2\x94\x81\xe2\x94\x81\xe2\x94\x81\xe2\x95\x8b" ^
                   "\xe2\x94\x81\xe2\x94\x81\xe2\x94\x81\xe2\x95\x8b" ^
                   "\xe2\x94\x81\xe2\x94\x81\xe2\x94\x81\n")

let tests = "Emoji Formatter" >:::
  [
    "converts a square to an emoji string" >:: ( fun () ->
      assert_equal " \xe2\x9d\x8c "  (square_string (Full X));
      assert_equal " \xe2\xad\x95 "  (square_string (Full O));
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
  ]

(* Test Runner *)
let _ = run_test_tt_main tests
