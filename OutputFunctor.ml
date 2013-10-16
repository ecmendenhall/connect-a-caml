open IFormatter
open IPrinter

module OutputFunctor (Formatter : FORMATTER) (Printer : PRINTER) =
    struct
      let clear_print str = Printer.print_string ("\x1b[2J\x1b[;H" ^ str ^ "\n")
      let print str = Printer.print_string (str ^ "\n")
      let print_message message message_type = print (Formatter.message_string message message_type)
      let print_board board = print (Formatter.board_string board)
    end;;
