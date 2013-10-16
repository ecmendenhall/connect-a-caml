open Types
include Types
open Util

module Formatter =
  struct
      let square_string square = match square with
        | Full X -> " X "
        | Full O -> " O "
        | Empty  -> "   "

      let row_string row = String.concat "|" (List.map square_string row)

      let row_separator size =
        let dashes = Util.make_list size "---" in
          "\n" ^ (String.concat "+" dashes) ^ "\n"

      let message_string message _ = message

      let board_string board =
        let separator = row_separator (List.length board) in
        (String.concat separator (List.map row_string board)) ^ "\n"
  end;;
