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
open RandomMove
open HumanFunctor

module MainFunctor (IO : IO) =
  struct
    open Types
    include Types
    let welcome_message () =
      IO.clear_screen ();
      IO.show_message "Welcome to Tic-Tac-Toe!\n" Info

    let player_message symbol =
      let suffix = " be a [h]uman, [m]inimax, or [r]andom player?" in
      if symbol = X then
        IO.show_message ("Will Player X" ^ suffix) (Prompt X)
      else
        IO.show_message ("Will Player O" ^ suffix) (Prompt O)

    let rec get_strategy symbol =
      player_message symbol;
      let module Human = HumanFunctor (IO) in
      let raw_input = IO.get_input () in
      let lowercase = String.lowercase raw_input in
      match lowercase with
      | "m"
      | "minimax"  -> (module Minimax : STRATEGY)
      | "r"
      | "random"   -> (module RandomMove : STRATEGY)
      | "h"
      | "human"    -> (module Human : STRATEGY)
      | _          ->
          IO.show_message "Sorry. That's not a player option." Error;
          get_strategy symbol

    let board_size_message () =
      IO.show_message "Please choose a board size between 3 and 9:" Normal

    let rec board_size_prompt () =
      let raw_input = IO.get_input () in
      try int_of_string raw_input with
       | Failure _ ->
           IO.show_message "That's not a valid board size! Try entering a number." Error;
           board_size_prompt ()

    let too_small size = size <= 2

    let too_big  size = size >= 10

    let validate_size size =
      if too_big size then
        "Too big"
      else
        if too_small size then
          "Too small"
        else
          "OK"

    let valid_size size =  validate_size size = "OK"

    let size_error size = match validate_size size with
      | "Too big"   -> IO.show_message "We'll be here forever! Try a smaller board." Error
      | "Too small" -> IO.show_message "That's pretty small. How about a bigger board?" Error
      | _           -> ()

    let rec get_size () =
      board_size_message ();
      let size = board_size_prompt () in
      if valid_size size then
        size
      else
        let _ = size_error size in
        get_size ()

    let new_game () =
      let (module XStrategy : STRATEGY) = get_strategy X in
      let module PlayerX = PlayerFunctor (XStrategy) (XToken) in

      let (module OStrategy : STRATEGY) = get_strategy O in
      let module PlayerO = PlayerFunctor (OStrategy) (OToken) in

      let size = get_size () in
      let module Game    = GameFunctor (IO) (PlayerX) (PlayerO) in
        Game.game_loop X (Board.empty_board size)

    let play_again_message () =
      IO.show_message "Play again? [y]es or [n]o:" Info

    let rec play_again_prompt () =
      let raw_input = IO.get_input () in
      let lowercase  = String.lowercase raw_input in
      match lowercase with
      | "y"
      | "yes" -> true
      | "n"
      | "no"  -> false
      | _     -> play_again_prompt ()

    let rec input_loop () =
      new_game();
      play_again_message();
      let again = play_again_prompt () in
        if again then input_loop () else ()

    let run () =
      welcome_message ();
      input_loop ();

  end;;
