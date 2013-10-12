let rec addN items n value = match n with
  | 0 -> items
  | _ -> addN (value :: items) (n - 1) value

let fillN n value = addN [] n value
