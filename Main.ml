open CamelThemedEmojiFormatter
open SpookyScaryHalloweenFormatter
open EmojiFormatter
open Formatter
open ColorFormatter
open ConsoleIOFunctor
open InputFunctor
open MainFunctor
open OutputFunctor
open Types
include Types

module Output  = OutputFunctor (ColorFormatter) (Pervasives)
module Input   = InputFunctor (Pervasives)
module IO      = ConsoleIOFunctor (Input) (Output)
module Main    = MainFunctor (IO)

let _ =
  Main.run ();
