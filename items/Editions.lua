SMODS.Edition {
  key = 'waxed',
  shader = 'waxed',
  in_shop = true,
  sound = { sound = "phanta_waxed_card", per = 1, vol = 0.5 },
  weight = 20,
  badge_colour = HEX('C2B482'),
  extra_cost = 1,
  get_weight = function(self)
    return G.GAME.edition_rate * self.weight
  end,
  config = { xmult = 1.1, joker_xmult = 1.3 },
  loc_vars = function(self, info_queue, card)
    key = self.key
    if card.fake_card or card.config.center.set == "Edition" then
      key = key .. "_showcase"
      return { key = key, vars = { self.config.xmult, self.config.joker_xmult } }
    end
    if card.config.center.set == "Joker" then
      return { key = key, vars = { self.config.joker_xmult } }
    else
      return { key = key, vars = { self.config.xmult } }
    end
  end,
  calculate = function(self, card, context)
    if (context.main_scoring and context.cardarea == G.play) then
      return {
        xmult = self.config.xmult
      }
    elseif context.post_joker then
      return {
        xmult = self.config.joker_xmult
      }
    end
  end
}




--[[

SMODS.Shader {
  key = "drilled",
  path = "phanta_drilled.fs"
}

SMODS.Shader {
  key = "drilled_consistent",
  path = "phanta_drilled_consistent.fs"
}

SMODS.Edition {
  key = 'drilled',
  shader = 'drilled',
  disable_base_shader = true,
  in_shop = true,
  sound = { sound = "phanta_drilled_card", per = 1, vol = 0.5 },
  weight = 5,
  badge_colour = HEX('BFC7D5'),
  extra_cost = 1,
  get_weight = function(self)
    return G.GAME.edition_rate * self.weight
  end,
  config = { extra = { slots = 1, discards = 1 } },
  loc_vars = function(self, info_queue, card)
    key = self.key
    if card.config.center.set == "Edition" then
      key = key .. "_showcase"
      return { key = key, vars = { self.config.extra.discards, self.config.extra.slots } }
    end
    if card.config.center.set == "Joker" then
      return { key = key, vars = { self.config.extra.slots } }
    else
      key = key .. "_playingcard"
      return { key = key, vars = { self.config.extra.discards } }
    end
  end,
  calculate = function(self, card, context)
    if (context.main_scoring and context.cardarea == G.play) then
      ease_discard(self.config.extra.discards)
      return {
        message = localize { type = 'variable', key = 'a_discard', vars = { self.config.extra.discards } },
        colour = G.C.RED
      }
    end
  end
}

local atdref = Card.add_to_deck
function Card:add_to_deck(from_debuff)
  if self and self.edition and self.edition.key == "e_phanta_drilled" and self.config and self.config.center and self.config.center.set == "Joker"
      and G.consumeables and G.consumeables.config and G.consumeables.config.card_limit then
    G.consumeables.config.card_limit = G.consumeables.config.card_limit + self.edition.extra.slots
    play_sound("foil2", 0.9, 0.3)
    card_eval_status_text(self, 'extra', nil, nil, nil, { message = localize("plus_consumable_slot"), colour = G.C.FILTER })
  end
  atdref(self, from_debuff)
end

SMODS.Sound({
  key = "undo_edition",
  path = "phanta_undo_edition.ogg",
  replace = true
})

local rfdref = Card.remove_from_deck
function Card:remove_from_deck(from_debuff)
  if self and self.edition and self.edition.key == "e_phanta_drilled" and self.config and self.config.center and self.config.center.set == "Joker"
      and G.consumeables and G.consumeables.config and G.consumeables.config.card_limit then
    G.consumeables.config.card_limit = G.consumeables.config.card_limit - self.edition.extra.slots
    play_sound("phanta_undo_edition", 0.9, 0.3)
    card_eval_status_text(self, 'extra', nil, nil, nil, { message = localize("minus_consumable_slot"), colour = G.C.FILTER })
  end
  rfdref(self, from_debuff)
end]] --