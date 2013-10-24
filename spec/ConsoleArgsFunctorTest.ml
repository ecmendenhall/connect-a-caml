open OUnit

open CamelThemedEmojiFormatter
open ConsoleArgsFunctor
open ColorFormatter
open EmojiFormatter
open Formatter
open FormatterInterface
open SpookyScaryHalloweenFormatter
open Types

include Types

let arg = ref "color"

module MockArg =
  struct
    type anon_fun = string -> unit
    type usage_msg = string
    type doc = string
    type key = string
    type spec =
      Unit of (unit -> unit)
    | Bool of (bool -> unit)
    | Set of bool ref
    | Clear of bool ref
    | String of (string -> unit)
    | Set_string of string ref
    | Int of (int -> unit)
    | Set_int of int ref
    | Float of (float -> unit)
    | Set_float of float ref
    | Tuple of spec list
    | Symbol of string list * (string -> unit)
    | Rest of (string -> unit)
    let parse (speclist : (key * spec * doc) list) func usage  =
      let _, f, _ = (List.hd speclist) in
       match f with
        | String func -> func !arg
        | _ -> ()
  end;;

module ConsoleArgs = ConsoleArgsFunctor (MockArg)

let tests = "ConsoleArgs Functor" >:::
  [
    "gets a normal formatter" >:: ( fun () ->
      arg := "normal";
      let (module Formatter : FORMATTER) = ConsoleArgs.get_formatter () in
        assert_equal " X " (Formatter.square_string (Full X))
    );

    "gets a color formatter" >:: ( fun () ->
      arg := "color";
      let (module Formatter : FORMATTER) = ConsoleArgs.get_formatter () in
      assert_equal "\x1b[1;32m X \x1b[0m" (Formatter.square_string (Full X))
    );

    "gets an emoji formatter" >:: ( fun () ->
      arg := "emoji";
      let (module Formatter : FORMATTER) = ConsoleArgs.get_formatter () in
      assert_equal " \xe2\x9d\x8c " (Formatter.square_string (Full X))
    );

    "gets a spooky halloween formatter" >:: ( fun () ->
      arg := "spooky";
      let (module Formatter : FORMATTER) = ConsoleArgs.get_formatter () in
      assert_equal " \xf0\x9f\x8e\x83 " (Formatter.square_string (Full X))
    );

    "gets a camel-themed formatter" >:: ( fun () ->
      arg := "camel";
      let (module Formatter : FORMATTER) = ConsoleArgs.get_formatter () in
      assert_equal " \xf0\x9f\x90\xab " (Formatter.square_string (Full X))
    );

    "gets a colored formatter by default" >:: ( fun () ->
      arg := "banana";
      let (module Formatter : FORMATTER) = ConsoleArgs.get_formatter () in
      assert_equal "\x1b[1;32m X \x1b[0m" (Formatter.square_string (Full X))
    );
  ]

(* Test Runner *)
let _ = run_test_tt_main tests
