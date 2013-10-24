open OUnit

open ConsoleIOFunctor
open InputFunctor
open Formatter
open OutputFunctor

let last_printed = ref ""

module MockPervasives =
  struct
    let print_string str =
      last_printed := str

    let read_line () =
      "Hello world!"
  end;;

module Output = OutputFunctor (Formatter) (MockPervasives)
module Input = InputFunctor (MockPervasives)
module ConsoleIO = ConsoleIOFunctor (Input) (Output)

let tests = "Console I/O" >:::
  [
    "console IO prints a prompt" >:: ( fun () ->
      let _ = (ConsoleIO.get_input ()) in
      assert_equal !last_printed ">> "
    );

    "console IO prints a prompt and gets input" >:: ( fun () ->
      assert_equal "Hello world!" (ConsoleIO.get_input ());
    );
  ]

(* Test Runner *)
let _ = run_test_tt_main tests
