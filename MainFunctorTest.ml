open OUnit
open Types
include Types
open MainFunctor
open StrategyInterface

let input = ref "c"
let last_board = ref [[Empty]]
let last_message = ref ""

module MockIO =
  struct
    let get_input u =
      !input
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
      assert_equal "Welcome to Tic-Tac-Toe!" !last_message
    );

    "Matches strings to player strategies" >:: ( fun () ->
      let (module Strategy : STRATEGY) = (Main.get_strategy X) in
      assert_equal [[Full X]] (Strategy.next_move X [[Empty]]);
    );

    "Prints a custom message when selecting player strategies" >:: ( fun () ->
      Main.player_message X;
      assert_equal "Will Player X be a [h]uman or [c]omputer?" !last_message;

      Main.player_message O;
      assert_equal "Will Player O be a [h]uman or [c]omputer?" !last_message;
    );

    "Prints a play again message" >:: ( fun () ->
      Main.play_again_message ();
      assert_equal "Play again? [y]es or [n]o:" !last_message
    );

    "Prompts the user to play again and returns true if yes" >:: ( fun () ->
      input := "y";
      assert (Main.play_again_prompt ())
    );

    "Prompts the user to play again and returns false if no" >:: ( fun () ->
      input := "n";
      assert_equal false (Main.play_again_prompt ())
    );

    "Handles uppercase input" >:: ( fun () ->
      input := "N";
      assert_equal false (Main.play_again_prompt ());

      input := "Y";
      assert (Main.play_again_prompt ())
    );

    "Handles full word input" >:: ( fun () ->
      input := "NO";
      assert_equal false (Main.play_again_prompt ());

      input := "yEs";
      assert (Main.play_again_prompt ())
    );

    "Prints a board size message" >:: ( fun () ->
      Main.board_size_message ();
      assert_equal "Please choose a board size between 3 and 9:" !last_message
    );

    "Prompts for and parses a size" >:: ( fun () ->
      input := "4";
      assert_equal 4 (Main.board_size_prompt ())
    );

    "Rejects invalid sizes" >:: ( fun () ->
      assert_equal false (Main.valid_size 900);
      assert_equal false (Main.valid_size (-3))
    );

  ]

(* Test Runner *)
let _ = run_test_tt_main tests
