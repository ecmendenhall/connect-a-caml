open IReader

module InputFunctor (Reader : READER) =
    struct
      let read_line u = Reader.read_line u
    end;;
