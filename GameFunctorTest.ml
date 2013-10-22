open OUnit
open GameFunctor
open Types
include Types
open Board

let input = ref "0,0"
let last_board = ref [[Empty]]
let last_message = ref ""
let empty = Board.empty_board 3

let turn_one = [[Full X; Full O; Empty];
                [Empty;  Empty;  Empty];
                [Empty;  Full O; Empty]]

let turn_two = [[Full X; Full O; Empty];
                [Empty;  Full O; Empty];
                [Empty;  Full O;  Empty]]

module MockIO =
  struct
    let get_input u =
      !input
    let clear_screen () = ()
    let show_board board =
      last_board := board
    let show_message message message_type =
      last_message := message;
  end;;

module MockPlayerX =
  struct
    let get_gamepiece () = X
    let next_move board = turn_one
  end;;

module MockPlayerO =
  struct
    let get_gamepiece () = O
    let next_move board = turn_two

  end;;

module Game = GameFunctor (MockIO) (MockPlayerX) (MockPlayerO)

let tests = "Game" >:::
  [

    "Prints a game over message when game state is Draw" >:: ( fun () ->
      let _ = Game.game_over_message Draw in
        assert_equal "Game over: it's a draw." !last_message
    );

    "Prints a game over message when X wins" >:: ( fun () ->
      let _ = Game.game_over_message (Win X) in
        assert_equal "Game over: Player X wins." !last_message
    );

    "Prints a game over message when O wins" >:: ( fun () ->
      let _ = Game.game_over_message (Win O) in
        assert_equal "Game over: Player O wins." !last_message
    );

    "Does nothing when game state is Pending" >:: ( fun () ->
      let _ = last_message := "don't change me!" in
      let _ = Game.game_over_message Pending in
        assert_equal "don't change me!" !last_message
    );


    "Plays a round when it's X's turn" >:: ( fun () ->
      assert_equal turn_one (Game.play_round X empty)
    );

    "Plays a round when it's O's turn" >:: ( fun () ->
      assert_equal turn_two (Game.play_round O (Game.play_round X empty))
    );

    "runs the game loop to completion" >:: ( fun () ->
      (Game.game_loop X empty);
      assert_equal "Game over: Player O wins." !last_message
    );

  ]

(* Test Runner *)
let _ = run_test_tt_main tests
