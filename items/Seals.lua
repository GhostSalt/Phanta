SMODS.Seal {
  key = "ghostseal",
  loc_txt = {
    name = 'Ghost Seal',
    text = {
      "Creates a {C:spectral}Spectral{} card",
      "when played and unscored",
      "{C:inactive}(Must have room){}"
    }
  },
  badge_colour = HEX("cccccc"),
  atlas = "PhantaEnhancements",
  pos = { x = 1, y = 0 },
  calculate = function(self, card, context)
    if context.cardarea == "unscored" and context.main_scoring and count_consumables() < G.consumeables.config.card_limit then
      G.E_MANAGER:add_event(Event({
        func = function()
          if count_consumables() < G.consumeables.config.card_limit then
            local new_card = create_card("Spectral", G.consumeables, nil, nil, nil, nil, nil, "ghostseal")
            new_card:add_to_deck()
            G.consumeables:emplace(new_card)
          end
          return true
        end
      }))
      return {
        message = localize { type = 'variable', key = 'a_spectral', vars = { 1 } },
        colour = G.C.SECONDARY_SET.Spectral,
        message_card = card
      }
    end
  end,
  in_pool = function()
    return false
  end
}
