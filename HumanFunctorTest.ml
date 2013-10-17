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
      assert_equal "Please enter your move as a row, column coordinate." !last_message
    );

    "converts a nice, friendly string to a row, column coordinate" >:: ( fun () ->
      assert_equal [1; 2] (Human.coord_of_string "1, 2")
    );

    "validates user-submitted coordinates" >:: ( fun () ->
      assert_equal false (Human.valid_move [10; -3] (Board.empty_board 3));
      assert_equal false (Human.valid_move [0; 3] (Board.empty_board 3));
      assert_equal true  (Human.valid_move [0; 2] (Board.empty_board 3))
    );

    "fills a square on the game board" >:: ( fun () ->
      assert_equal [[Full X; Empty; Empty];
                    [Empty;  Empty; Empty];
                    [Empty;  Empty; Empty]]
                   (Human.make_move [0; 0] X (Board.empty_board 3))
    );

    "handles trying to fill an occupied square" >:: ( fun () ->
      assert_equal [[Full X; Empty; Empty];
                    [Empty;  Empty; Empty];
                    [Empty;  Empty; Empty]]
                   (Human.make_move [0; 0] O (Board.fill_square 0 0 X (Board.empty_board 3)));
      assert_equal "That square is already full. Please pick another."
                   !last_message
    );

    "handles trying to fill an invalid square" >:: ( fun () ->
      assert_equal [[Empty;  Empty; Empty];
                    [Empty;  Empty; Empty];
                    [Empty;  Empty; Empty]]
                   (Human.make_move [-10; 100] O (Board.empty_board 3));
      assert_equal "That's not a valid coordinate. Please try again."
                   !last_message
    );
  ]

(* Test Runner *)
let _ = run_test_tt_main tests
