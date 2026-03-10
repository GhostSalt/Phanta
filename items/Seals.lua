SMODS.Seal {
  key = "ghostseal",
  loc_txt = {
    name = 'Ghost Seal',
    text = {
      "{C:green}#1# in #2#{} chance to create",
      "a {C:spectral}Spectral{} card when",
      "played and {C:attention}unscored{}",
      "{C:inactive}(Must have room){}"
    }
  },
  config = { extra = { odds = 2 } },
  badge_colour = HEX("cccccc"),
  atlas = "PhantaEnhancements",
  pos = { x = 1, y = 0 },
  loc_vars = function(self, info_queue, card)
    local num, denom = SMODS.get_probability_vars(card, 1, card.ability.seal.extra.odds, "ghostseal")
    return { vars = { num, denom } }
  end,
  calculate = function(self, card, context)
    if context.cardarea == "unscored" and context.main_scoring and count_consumables() < G.consumeables.config.card_limit and SMODS.pseudorandom_probability(card, "ghostseal", 1, card.ability.seal.extra.odds) then
      return {
        extra = {
          message = localize { type = 'variable', key = 'a_spectral', vars = { 1 } },
          colour = G.C.SECONDARY_SET.Spectral,
          message_card = card,
          func = function()
            G.E_MANAGER:add_event(Event({
              func = (function()
                if count_consumables() < G.consumeables.config.card_limit then
                  card:juice_up()
                  SMODS.add_card {
                    set = "Spectral",
                    key_append = "ghostseal"
                  }
                  G.GAME.consumeable_buffer = 0
                end
                return true
              end)
            }))
          end
        }
      }
    end
  end,
  in_pool = function()
    return false
  end
}
