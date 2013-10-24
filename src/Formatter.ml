open Util

module Formatter =
  struct
    open Types
    include Types

    let square_string square = match square with
      | Full X -> " X "
      | Full O -> " O "
      | Empty  -> "   "

    let row_string i row =
      (string_of_int i) ^ " " ^ (String.concat "|" (List.map square_string row))

    let rec range i j =
      if i >= j then
        []
      else i :: (range (i+1) j)

    let column_header size =
      "   " ^ (String.concat "   " (List.map string_of_int (range 0 size))) ^ " \n\n"

    let row_separator size =
      let dashes = Util.make_list size "---" in
        "\n  " ^ (String.concat "+" dashes) ^ "\n"

    let message_string message _ = match message with
      | "\xe2\x9e\xa4\xe2\x9e\xa4 " -> ">>"
      | _ -> message

    let board_string board =
      let size = List.length board in
      let header = column_header size in
      let separator = row_separator size in
      header ^ (String.concat separator (List.mapi row_string board)) ^ "\n"
  end;;
