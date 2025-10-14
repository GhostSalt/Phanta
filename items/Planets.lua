SMODS.Consumable {
  set = "Planet",
  key = "rubbish",
  pos = { x = 0, y = 2 },
  config = {
    hand_type = "phanta_junk",
    softlock = true
  },
  atlas = "PhantaTarots",
  loc_vars = function(self, info_queue, center)
    return {
      vars = {
        G.GAME.hands["phanta_junk"].level,
        localize("phanta_junk"),
        G.GAME.hands["phanta_junk"].l_mult,
        G.GAME.hands["phanta_junk"].l_chips,
        colours = { (to_big(G.GAME.hands["phanta_junk"].level) == to_big(1) and G.C.UI.TEXT_DARK or G.C.HAND_LEVELS[math.min(7, G.GAME.hands["phanta_junk"].level)]) }
      }
    }
  end,
  in_pool = function()
    return Phanta.config["junk_enabled"]
  end
}