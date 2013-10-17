open InputInterface
open OutputInterface

module ConsoleIOFunctor (Input : INPUT) (Output : OUTPUT) =
  struct

    let get_input u =
      Output.print ">> ";
      Input.read_line u

    let show_board board =
      Output.print_board board

    let show_message message message_type =
      Output.print_message message_type

  end;;
