open OUnit
open Types
include Types
open OutputFunctor
open Formatter
open Board

let last_printed = ref ""

module MockPervasives =
  struct
    let print_string str =
      last_printed := str
  end;;

module Output = OutputFunctor (Formatter) (MockPervasives)

let tests = "Output" >:::
  [
    "prints a string" >:: ( fun () ->
        Output.print "Hello world!";
        assert_equal (!last_printed) "Hello world!\n"
    );

    "clears the terminal and prints a string" >:: ( fun () ->
        Output.clear_print "Hello world!";
        assert_equal (!last_printed) "\x1b[2J\x1b[;HHello world!\n"
    );

    "prints messages as returned by the formatter" >:: ( fun () ->
        Output.print_message "Hello world!" Info;
        assert_equal (!last_printed) "Hello world!\n"
    );

    "prints boards as returned by the formatter" >:: ( fun () ->
        Output.print_board (Board.empty_board 3);
        assert_equal (!last_printed)
                     ("   |   |   \n" ^
                      "---+---+---\n" ^
                      "   |   |   \n" ^
                      "---+---+---\n" ^
                      "   |   |   \n\n")
    );

  ]

(* Test Runner *)
let _ = run_test_tt_main tests
