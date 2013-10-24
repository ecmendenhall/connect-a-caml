open InputInterface
open OutputInterface

module ConsoleIOFunctor (Input : INPUT) (Output : OUTPUT) =
  struct

    let clear_screen () =
      Output.clear_print ""

    let get_input () =
      Output.print ">> ";
      Input.read_line ()

    let show_board board =
      Output.clear_print "\n";
      Output.print_board board

    let show_message message message_type =
      Output.print_message message message_type

  end;;
