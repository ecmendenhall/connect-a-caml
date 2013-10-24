open OUnit

open MainFunctor
open StrategyInterface
open Types

include Types

let input = ref ["m"; "m"; "m"; "r"; "3"]
let last_board = ref [[Empty]]
let last_message = ref ""

module MockIO =
  struct
    let clear_screen () =
      ()
    let get_input () =
      let deqd = List.hd !input in
        input := List.tl !input;
        deqd
    let show_board board =
      last_board := board
    let show_message message message_type =
      last_message := message;
  end;;

module Main = MainFunctor (MockIO)

let tests = "Main" >:::
  [
    "Prints a friendly welcome message" >:: ( fun () ->
      let _ = Main.welcome_message () in
      assert_equal "Welcome to Tic-Tac-Toe!\n" !last_message
    );

    "Matches strings to player strategies" >:: ( fun () ->
      input := ["m"];
      let (module Strategy : STRATEGY) = (Main.get_strategy X) in
      assert_equal [[Full X]] (Strategy.next_move X [[Empty]]);
    );

    "Prints a custom message when selecting player strategies" >:: ( fun () ->
      Main.player_message X;
      assert_equal "Will Player X be a [h]uman, [m]inimax, or [r]andom player?" !last_message;

      Main.player_message O;
      assert_equal "Will Player O be a [h]uman, [m]inimax, or [r]andom player?" !last_message;
    );

    "Prints a play again message" >:: ( fun () ->
      Main.play_again_message ();
      assert_equal "Play again? [y]es or [n]o:" !last_message
    );

    "Prompts the user to play again and returns true if yes" >:: ( fun () ->
      input := ["y"];
      assert (Main.play_again_prompt ())
    );

    "Prompts the user to play again and returns false if no" >:: ( fun () ->
      input := ["n"];
      assert_equal false (Main.play_again_prompt ())
    );

    "Handles uppercase input" >:: ( fun () ->
      input := ["N"];
      assert_equal false (Main.play_again_prompt ());

      input := ["Y"];
      assert (Main.play_again_prompt ())
    );

    "Handles full word input" >:: ( fun () ->
      input := ["NO"];
      assert_equal false (Main.play_again_prompt ());

      input := ["yEs"];
      assert (Main.play_again_prompt ())
    );

    "Prints a board size message" >:: ( fun () ->
      Main.board_size_message ();
      assert_equal "Please choose a board size between 3 and 7:" !last_message
    );

    "Prompts for and parses a size" >:: ( fun () ->
      input := ["4"];
      assert_equal 4 (Main.board_size_prompt ())
    );

    "Handles parse errors" >:: ( fun () ->
      input := ["four"; "4"];
      assert_equal 4 (Main.board_size_prompt ())
    );

    "Rejects invalid sizes" >:: ( fun () ->
      assert_equal false (Main.valid_size 900);
      assert_equal false (Main.valid_size (-3))
    );

    "Checks whether an invalid size is too small" >:: ( fun () ->
      assert_equal "Too small" (Main.validate_size (-3))
    );

    "Checks whether an invalid size is too big" >:: ( fun () ->
      assert_equal "Too big" (Main.validate_size 900)
    );

    "Checks whether a size is OK" >:: ( fun () ->
      assert_equal "OK" (Main.validate_size 3)
    );

    "Prints an error if size is too big" >:: ( fun () ->
      (Main.size_error 900);
      assert_equal "We'll be here forever! Try a smaller board."
                   !last_message
    );

    "Prints an error if size is too small" >:: ( fun () ->
      (Main.size_error 2);
      assert_equal "That's pretty small. How about a bigger board?"
                   !last_message
    );

    "Starts a new game" >:: ( fun () ->
      input := ["r"; "r"; "3"; "n"];
      Main.new_game ();
      assert_equal "Game over" (String.sub !last_message 0 9)
    );

    "Prompts to play again on game over" >:: ( fun () ->
      input := ["r"; "r"; "3"; "n"];
      Main.input_loop ();
      assert_equal "Play again? [y]es or [n]o:" !last_message
    );

    "Prompts to play again on game over" >:: ( fun () ->
      input := ["r"; "r"; "3"; "n"];
      Main.run ();
      assert_equal "Play again? [y]es or [n]o:" !last_message
    );
  ]

(* Test Runner *)
let _ = run_test_tt_main tests
