open Util

module EmojiFormatter =
  struct
    open Types
    include Types

    let square_string square = match square with
      | Full X -> " \xe2\x9d\x8c "
      | Full O -> " \xe2\xad\x95 "
      | Empty  -> "   "

    let rec range i j =
      if i >= j then
        []
      else i :: (range (i+1) j)

    let column_header size =
      "   " ^ (String.concat "   " (List.map string_of_int (range 0 size))) ^ " \n\n"

    let row_string i row =
      (string_of_int i) ^ " " ^ (String.concat "\xe2\x94\x83" (List.map square_string row))

    let row_separator size =
      let dashes = Util.make_list size "\xe2\x94\x81\xe2\x94\x81\xe2\x94\x81" in
        "\n  " ^ (String.concat "\xe2\x95\x8b" dashes) ^ "\n"

    let message_string message _ = message

    let board_string board =
      let size = List.length board in
      let header = column_header size in
      let separator = row_separator size in
      header ^ (String.concat separator (List.mapi row_string board)) ^ "\n"
  end;;
