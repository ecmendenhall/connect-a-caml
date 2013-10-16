open Types
include Types
open Util

module Output =
  struct
    let print_square square = match square with
      | Full X -> " X "
      | Full O -> " O "
      | Empty  -> "   "

    let print_row row = String.concat "|" (List.map print_square row)

    let row_separator size =
      let dashes = Util.make_list size "---" in
        "\n" ^ (String.concat "+" dashes) ^ "\n"

    let print_board board =
      let separator = row_separator (List.length board) in
      (String.concat separator (List.map print_row board)) ^ "\n"
  end;;
