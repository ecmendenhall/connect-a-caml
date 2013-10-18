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
  ]

(* Test Runner *)
let _ = run_test_tt_main tests
