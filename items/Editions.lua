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
    if card.config.center.set == "Joker" or card.ability.consumeable then
      return { key = key, vars = { self.config.joker_xmult } }
    else
      return { key = key, vars = { self.config.xmult } }
    end
  end,
  calculate = function(self, card, context)
    if context.main_scoring and context.cardarea == G.play then
      return { xmult = self.config.xmult }
    elseif context.post_joker then
      return { xmult = self.config.joker_xmult }
    end
  end
}






SMODS.Shader {
  key = "drilled",
  path = "phanta_drilled.fs"
}

SMODS.Edition {
  key = 'drilled',
  shader = 'drilled',
  disable_base_shader = true,
  in_shop = true,
  sound = { sound = "phanta_drilled_card", per = 1, vol = 0.5 },
  weight = 7,
  badge_colour = HEX('BFC7D5'),
  extra_cost = 1,
  get_weight = function(self)
    return G.GAME.edition_rate * self.weight
  end,
  config = { extra = { chips = 30, mult = 4 } },
  loc_vars = function(self, info_queue, card)
    key = self.key
    if card.config.center.set == "Edition" then
      key = key .. "_showcase"
      return { key = key, vars = { self.config.extra.chips, self.config.extra.mult } }
    end
    if card.config.center.set == "Default" or card.config.center.set == "Enhanced" then
      key = key .. "_playingcard"
      return { key = key, vars = { self.config.extra.chips, self.config.extra.mult } }
    else
      return { key = key }
    end
  end,
  calculate = function(self, card, context)
    if context.main_scoring and context.cardarea == G.play then
      return { chips = self.config.extra.chips, mult = self.config.extra.mult }
    end
  end
}

local atdref = Card.add_to_deck
function Card:add_to_deck(from_debuff)
  if self and self.edition and self.edition.key == "e_phanta_drilled" and self.config and self.config.center and self.added_to_deck and not (self.config.center.set == "Default" or self.config.center.set == "Enhanced")
      and G.consumeables and G.consumeables.config and G.consumeables.config.card_limit then
    handle_drilled_added_to_card(self)
  end
  atdref(self, from_debuff)
end

local set_edition_ref = Card.set_edition
function Card:set_edition(edition, immediate, silent)
  set_edition_ref(self, edition, immediate, silent)
  if self and (edition == "e_phanta_drilled" or self.phanta_drilled_release) and self.config and self.config.center and self.added_to_deck and not (self.config.center.set == "Default" or self.config.center.set == "Enhanced")
      and G.consumeables and G.consumeables.config and G.consumeables.config.card_limit then
    if edition == "e_phanta_drilled" and not self.phanta_drilled_release then
      handle_drilled_added_to_card(self)
    elseif edition ~= "e_phanta_drilled" and self.phanta_drilled_release then
      handle_drilled_removed_from_card(self)
    end
  end
end

function handle_drilled_added_to_card(self)
  G.consumeables.config.card_limit = G.consumeables.config.card_limit + 1

  self.phanta_drilled_release = function()
    G.consumeables.config.card_limit = G.consumeables.config.card_limit - 1
    play_sound("phanta_undo_edition", 0.9, 0.3)
    card_eval_status_text(self, 'extra', nil, nil, nil, { message = localize("minus_consumable_slot"), colour = G.C.FILTER })
  end

  play_sound("foil2", 0.9, 0.3)
  card_eval_status_text(self, 'extra', nil, nil, nil, { message = localize("plus_consumable_slot"), colour = G.C.FILTER })
end

function handle_drilled_removed_from_card(self)
  if self and self.config and self.config.center and self.added_to_deck and not (self.config.center.set == "Default" or self.config.center.set == "Enhanced")
      and G.consumeables and G.consumeables.config and G.consumeables.config.card_limit then
    self:phanta_drilled_release()
    self.phanta_drilled_release = nil
  end
end

SMODS.Sound({
  key = "undo_edition",
  path = "phanta_undo_edition.ogg",
  replace = true
})

local rfdref = Card.remove_from_deck
function Card:remove_from_deck(from_debuff)
  if self.phanta_drilled_release then
    handle_drilled_removed_from_card(self)
  end
  rfdref(self, from_debuff)
end
