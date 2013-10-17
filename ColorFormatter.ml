open Util

module ColorFormatter =
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

      let square_string square = match square with
        | Full X -> colored_string " X " Green
        | Full O -> colored_string " O " Blue
        | Empty  -> "   "

      let row_string row = String.concat "|" (List.map square_string row)

      let row_separator size =
        let dashes = Util.make_list size "---" in
          "\n" ^ (String.concat "+" dashes) ^ "\n"

      let message_string message message_type = match message_type with
        | Error    -> colored_string message Red
        | Info     -> colored_string message Cyan
        | Prompt X -> colored_string message Green
        | Prompt O -> colored_string message Blue
        | Normal   -> message

      let board_string board =
        let separator = row_separator (List.length board) in
        (String.concat separator (List.map row_string board)) ^ "\n"
  end;;
