open IOInterface
open Board
open String


module MainFunctor (IO : IO) =
  struct
    open Types
    include Types

    let welcome_message () = IO.show_message "Welcome to Tic-Tac-Toe!" Info

    let run () =
      welcome_message ();
      IO.show_message "Will player X be a [h]uman or a [c]omputer?" (Prompt X);
      IO.show_message "Will player O be a [h]uman or a [c]omputer?" (Prompt O);
      let size = IO.get_input () in
       IO.show_message ("Check out this rad board of size " ^ size ^ "!!!") Error;
       IO.show_board (Board.fill_square 2 1 O (Board.fill_square 1 1 X (Board.empty_board (int_of_string size))))
  end;;
