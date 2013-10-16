open Types

module Matrix :
    sig
      val transpose : 'a list list -> 'a list list
      val square_matrix : int -> 'a -> 'a list list
      val value_at : int -> int -> 'a list list -> 'a
      val row : int -> 'a list -> 'a
      val column : int -> 'a list list -> 'a list
      val diagonal : 'a list list -> 'a list
      val antidiagonal : 'a list list -> 'a list
      val set_value : int -> int -> 'a -> 'a list list -> 'a list list
   end
