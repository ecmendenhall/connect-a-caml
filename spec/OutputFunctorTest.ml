open OUnit

open Board
open Formatter
open OutputFunctor
open Types

include Types

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
        assert_equal (!last_printed) "Hello world!"
    );

    "printlns a string" >:: ( fun () ->
        Output.println "Hello world!";
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
                     ("   0   1   2 \n\n" ^
                      "0    |   |   \n" ^
                      "  ---+---+---\n" ^
                      "1    |   |   \n" ^
                      "  ---+---+---\n" ^
                      "2    |   |   \n\n")
    );

  ]

(* Test Runner *)
let _ = run_test_tt_main tests
