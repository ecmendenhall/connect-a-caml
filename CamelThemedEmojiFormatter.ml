open Util
open Str

module CamelThemedEmojiFormatter =
  struct
    open Types
    include Types

      type color = Red | Green | Yellow | Blue | Magenta | Cyan

      let ansi_color color =
        let color_prefix = "\x1b[1;3" in
        let color_number = match color with
          | Red     -> "1"
          | Green   -> "2"
          | Yellow  -> "3"
          | Blue    -> "4"
          | Magenta -> "5"
          | Cyan    -> "6" in
        color_prefix ^ color_number ^ "m"

      let colored_string str color = (ansi_color color) ^ str ^ "\x1b[0m"

      let colored_message message message_type = match message_type with
        | Error    -> colored_string message Red
        | Info     -> colored_string message Cyan
        | Prompt X -> colored_string message Green
        | Prompt O -> colored_string message Blue
        | Normal   -> colored_string message Yellow

    let square_string square = match square with
      | Full X -> " \xf0\x9f\x90\xab "
      | Full O -> " \xf0\x9f\x90\xaa "
      | Empty  -> "   "

    let row_string row = String.concat "\xe2\x94\x83" (List.map square_string row)

    let row_separator size =
      let dashes = Util.make_list size "\xe2\x94\x81\xe2\x94\x81\xe2\x94\x81" in
        "\n" ^ (String.concat "\xe2\x95\x8b" dashes) ^ "\n"

    let substitute_camels message =
      let x_regex = (Str.regexp "X") in
      let o_regex = (Str.regexp "O") in
      let x_camel = "\xf0\x9f\x90\xab  (Bactrian)" in
      let o_camel = "\xf0\x9f\x90\xaa  (Dromedary)" in
        Str.global_replace x_regex x_camel (Str.global_replace o_regex o_camel message)

    let message_string message message_type =
      let msg = match message with
      | "Welcome to Tic-Tac-Toe!\n" -> "Welcome to Connect-a-\xf0\x9f\x90\xaa !"
      | _ -> message in
        "\xf0\x9f\x8c\xb4  " ^ (substitute_camels (colored_message msg message_type))

    let board_string board =
      let separator = row_separator (List.length board) in
      (String.concat separator (List.map row_string board)) ^ "\n"
  end;;
