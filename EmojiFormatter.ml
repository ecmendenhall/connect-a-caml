open Util

module EmojiFormatter =
  struct
    open Types
    include Types

    let square_string square = match square with
      | Full X -> " \xe2\x9d\x8c "
      | Full O -> " \xe2\xad\x95 "
      | Empty  -> "   "

    let row_string row = String.concat "\xe2\x94\x83" (List.map square_string row)

    let row_separator size =
      let dashes = Util.make_list size "\xe2\x94\x81\xe2\x94\x81\xe2\x94\x81" in
        "\n" ^ (String.concat "\xe2\x95\x8b" dashes) ^ "\n"

    let message_string message _ = message

    let board_string board =
      let separator = row_separator (List.length board) in
      (String.concat separator (List.map row_string board)) ^ "\n"
  end;;
