open IReader

module InputFunctor (Reader : READER) =
    struct
      let read_line = Reader.read_line ()
    end;;
