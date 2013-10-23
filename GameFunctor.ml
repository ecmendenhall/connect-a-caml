open IOInterface
open IOInterface
open PlayerInterface
open Engine

module GameFunctor (IO : IO) (PlayerX : PLAYER) (PlayerO : PLAYER) =
  struct
    open Types
    include Types

    let play_round turn board =
      if turn = X then
        PlayerX.next_move board
      else
        PlayerO.next_move board

    let game_over_message state =
      let prefix = "Game over: " in
        match state with
          | Draw  -> IO.show_message (prefix ^ "it's a draw.") Info
          | Win X -> IO.show_message (prefix ^ "Player X wins.") (Prompt X)
          | Win O -> IO.show_message (prefix ^ "Player O wins.") (Prompt O)
          | _     -> ()

    let rec game_loop turn board =
      IO.show_board board;
      let next_turn = match turn with X -> O | O -> X in
      match Engine.board_state board with
          | Pending  -> game_loop next_turn (play_round turn board)
          | end_type -> game_over_message end_type
  end;;
