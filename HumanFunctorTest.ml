open OUnit
open HumanFunctor
open XToken
open Board
open Types
include Types

let input = ref "0,0"
let last_board = ref [[Empty]]
let last_message = ref ""
let last_message_type = Error

module MockIO =
  struct
    let get_input u =
      !input
    let show_board board =
      last_board := board
    let show_message message message_type =
      last_message := message;
  end;;

module Human = HumanFunctor (MockIO)

let tests = "Human" >:::
  [
    "constructs a 'your turn' message" >:: ( fun () ->
      assert_equal "Your turn, player X" (Human.your_turn X)
    );

    "displays a 'your turn' prompt" >:: ( fun () ->
      Human.turn_prompt X;
      assert_equal "Your turn, player X" !last_message
    );

    "prompts user for a move" >:: ( fun () ->
      assert_equal [0; 0] (Human.get_move X);
      assert_equal "Your turn, player X" !last_message
    );

    "converts a nice, friendly string to a row, column coordinate" >:: ( fun () ->
      assert_equal [1; 2] (Human.coord_of_string "1, 2")
    );

    "validates user-submitted coordinates" >:: ( fun () ->
      assert_equal false (Human.valid_move [10; -3] (Board.empty_board 3));
      assert_equal false (Human.valid_move [0; 3] (Board.empty_board 3));
      assert_equal true  (Human.valid_move [0; 2] (Board.empty_board 3))
    );
  ]

(* Test Runner *)
let _ = run_test_tt_main tests
