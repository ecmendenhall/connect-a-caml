open IStrategy
open IGameToken

module PlayerFunctor (Strategy : STRATEGY) (GameToken : GAMETOKEN) =
  struct
    let get_gamepiece =
      GameToken.get_gamepiece

    let next_move board =
      Strategy.next_move (get_gamepiece) board
  end;;
