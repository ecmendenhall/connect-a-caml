open OUnit
open Types
include Types
open PlayerFunctor
open Minimax
open XToken
open OToken
open Board

module MockStrategy =
  struct
    let next_move turn board = [[Empty]]
  end;;

module PlayerX = PlayerFunctor (MockStrategy) (XToken)
module PlayerO = PlayerFunctor (MockStrategy) (OToken)

let tests = "Player" >:::
  [
    "is parameterized by a Strategy" >:: ( fun () ->
      assert_equal [[Empty]] (PlayerX.next_move (Board.empty_board 3));
      assert_equal [[Empty]] (PlayerO.next_move (Board.empty_board 3))
    );

    "is parameterized by a GameToken" >:: ( fun () ->
      assert_equal X (PlayerX.get_gamepiece ());
      assert_equal O (PlayerO.get_gamepiece ())
    );
  ]

(* Test Runner *)
let _ = run_test_tt_main tests
