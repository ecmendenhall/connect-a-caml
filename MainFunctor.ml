open IOInterface
open GameFunctor
open PlayerFunctor
open Minimax
open XToken
open OToken
open Board
open Types
include Types
open Board
open String
open StrategyInterface

module MainFunctor (IO : IO) =
  struct
    open Types
    include Types
    let welcome_message () = IO.show_message "Welcome to Tic-Tac-Toe!" Info

    let player_message symbol =
      let suffix = " be a [h]uman or [c]omputer?" in
      match symbol with
      | X -> IO.show_message ("Will Player X" ^ suffix) (Prompt X)
      | O -> IO.show_message ("Will Player O" ^ suffix) (Prompt O)

    let rec get_strategy symbol =
      player_message symbol;
      let raw_input = IO.get_input () in
      let lowercase = String.lowercase raw_input in
      match lowercase with
      | "c" -> (module Minimax : STRATEGY)
      | _   -> get_strategy symbol

    let new_game () =
      let (module XStrategy : STRATEGY) = get_strategy X in
      let module PlayerX = PlayerFunctor (XStrategy) (XToken) in

      let (module OStrategy : STRATEGY) = get_strategy O in
      let module PlayerO = PlayerFunctor (OStrategy) (OToken) in

      let module Game    = GameFunctor (IO) (PlayerX) (PlayerO) in
        Game.game_loop X (Board.empty_board 3)

    let run () =
      welcome_message ();
      while true do new_game(); done

  end;;
