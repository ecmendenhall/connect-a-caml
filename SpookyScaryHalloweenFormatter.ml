open Util

module SpookyScaryHalloweenFormatter =
  struct
    open Types
    include Types

    let square_string square = match square with
      | Full X -> " \xf0\x9f\x8e\x83 "
      | Full O -> " \xf0\x9f\x91\xbb "
      | Empty  -> "   "

    let row_string row = String.concat "\xe2\x94\x83" (List.map square_string row)

    let row_separator size =
      let dashes = Util.make_list size "\xe2\x94\x81\xe2\x94\x81\xe2\x94\x81" in
        "\n" ^ (String.concat "\xe2\x95\x8b" dashes) ^ "\n"

    let message_string message message_type = match message_type with
      | Error ->  "\xf0\x9f\x98\xa8  " ^ message
      | _     ->  ("\xf0\x9f\x92\x80 \xf0\x9f\x8e\x83 \xf0\x9f\x91\xbb  " ^
                   message ^
                   " \xf0\x9f\x91\xbb \xf0\x9f\x8e\x83 \xf0\x9f\x92\x80")

    let board_string board =
      let separator = row_separator (List.length board) in
      (String.concat separator (List.map row_string board)) ^ "\n"
  end;;
