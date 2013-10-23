open ArgParserInterface
open FormatterInterface
open Formatter
open ColorFormatter
open EmojiFormatter
open SpookyScaryHalloweenFormatter
open CamelThemedEmojiFormatter

module ConsoleArgsFunctor (ArgParser : ARGPARSER) =
  struct

    let formatter = ref "camel"

    let speclist = [
      ("-f",
       ArgParser.String (fun s -> formatter := s),
       ": choose a formatter. Options are 'normal', 'color', 'camel', 'emoji', or 'spooky'."
      );
    ]

    let get_formatter () =
      let _ = ArgParser.parse speclist (fun arg -> ()) "Usage:" in
        match String.lowercase !formatter with
          | "normal" -> (module Formatter : FORMATTER)
          | "color"  -> (module ColorFormatter : FORMATTER)
          | "emoji"  -> (module EmojiFormatter : FORMATTER)
          | "spooky" -> (module SpookyScaryHalloweenFormatter : FORMATTER)
          | _        -> (module CamelThemedEmojiFormatter : FORMATTER)

  end;;
