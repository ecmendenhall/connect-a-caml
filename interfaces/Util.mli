module Util :
  sig
    val split_before : int -> 'a list -> 'a list * 'a list
    val take : int -> 'a list -> 'a list
    val drop : int -> 'a list -> 'a list
    val partition_by : int -> 'a list -> 'a list list
    val make_list : int -> 'a -> 'a list
    val set_nth : int -> 'a -> 'a list -> 'a list
  end
