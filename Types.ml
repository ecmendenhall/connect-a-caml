module Types =
  struct
    type gamepiece = X | O
    type square = Empty | Full of gamepiece
    type gamestate = Win of gamepiece | Draw | Pending
    type message = Info | Error | Prompt of gamepiece | Normal
  end;;
