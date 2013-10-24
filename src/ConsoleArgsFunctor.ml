open ArgParserInterface
open CamelThemedEmojiFormatter
open ColorFormatter
open EmojiFormatter
open Formatter
open FormatterInterface
open SpookyScaryHalloweenFormatter

module ConsoleArgsFunctor (ArgParser : ARGPARSER) =
  struct

    let formatter = ref "color"

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
          | "emoji"  -> (module EmojiFormatter : FORMATTER)
          | "spooky" -> (module SpookyScaryHalloweenFormatter : FORMATTER)
          | "camel"  -> (module CamelThemedEmojiFormatter : FORMATTER)
          | _        -> (module ColorFormatter : FORMATTER)

  end;;
