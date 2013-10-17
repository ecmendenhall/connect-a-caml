open OUnit
open Types
include Types
open MainFunctor

let input = ref "0,0"
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
  ]

(* Test Runner *)
let _ = run_test_tt_main tests
