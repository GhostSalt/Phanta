SMODS.Consumable {
  set = "Planet",
  key = "rubbish",
  pos = { x = 3, y = 1 },
  config = {
    hand_type = "phanta_junk",
    softlock = true
  },
  atlas = "PhantaTarots",
  loc_vars = function(self, info_queue, card)
    return {
      vars = {
        G.GAME.hands[card.ability.hand_type].level,
        localize(card.ability.hand_type, 'poker_hands'),
        G.GAME.hands[card.ability.hand_type].l_mult * (count_tricks(card) + 1),
        G.GAME.hands[card.ability.hand_type].l_chips * (count_tricks(card) + 1),
        colours = { (to_big(G.GAME.hands[card.ability.hand_type].level) == to_big(1) and G.C.UI.TEXT_DARK or G.C.HAND_LEVELS[math.min(7, G.GAME.hands[card.ability.hand_type].level)]) }
      }
    }
  end,
  in_pool = function()
    return Phanta.config["junk_enabled"]
  end,
  phanta_thetrick_supported = true
}
