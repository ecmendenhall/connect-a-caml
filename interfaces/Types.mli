module Types :
  sig
    type gamepiece = X | O
    type square = Empty | Full of gamepiece
    type gamestate = Win of gamepiece | Draw | Pending
  end
