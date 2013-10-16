module type READER =
  sig
    val read_line : unit -> string
  end
