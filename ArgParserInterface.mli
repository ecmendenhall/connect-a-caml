module type ARGPARSER =
  sig
    type spec =
      Unit of (unit -> unit)
    | Bool of (bool -> unit)
    | Set of bool ref
    | Clear of bool ref
    | String of (string -> unit)
    | Set_string of string ref
    | Int of (int -> unit)
    | Set_int of int ref
    | Float of (float -> unit)
    | Set_float of float ref
    | Tuple of spec list
    | Symbol of string list * (string -> unit)
    | Rest of (string -> unit)
    type key = string
    type doc = string
    type usage_msg = string
    type anon_fun = string -> unit
    val parse : (key * spec * doc) list -> anon_fun -> usage_msg -> unit
  end
