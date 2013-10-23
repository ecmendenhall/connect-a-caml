open ConsoleIOFunctor
open FormatterInterface
open InputFunctor
open MainFunctor
open OutputFunctor
open ConsoleArgsFunctor

let _ =
  let module  ArgParser = ConsoleArgsFunctor (Arg) in
  let (module Formatter : FORMATTER) = ArgParser.get_formatter() in

  let module Output    = OutputFunctor (Formatter) (Pervasives) in
  let module Input     = InputFunctor (Pervasives) in
  let module IO        = ConsoleIOFunctor (Input) (Output) in
  let module Main      = MainFunctor (IO) in
    Main.run ();
