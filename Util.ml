open Types
include Types

module Util =
  struct
    let makeList size default_value =
      Array.to_list (Array.make size default_value)

    let setNth n value items =
      let items_array = Array.of_list items in
      items_array.(n) <- value;
        Array.to_list items_array
end;;
