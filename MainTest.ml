
open OUnit
open Types
include Types
open Main

module MockIO =
  struct
    let get_input u =
      !input
    let show_board board =
      last_board := board
    let show_message message message_type =
      last_message := message;
  end;;

let tests = "Main" >:::
  [
    "Prints a friendly welcome message" >:: ( fun () ->
      let _ = Game.welcome_message () in
      assert_equal "Welcome to Tic-Tac-Toe!" !last_message
    );
  ]

(* Test Runner *)
let _ = run_test_tt_main tests
