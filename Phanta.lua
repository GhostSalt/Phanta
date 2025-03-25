SMODS.Atlas {
  key = "modicon",
  path = "PhantaIcon.png",
  px = 34,
  py = 34
}

SMODS.Atlas {
  key = "Phanta",
  path = "Phanta.png",
  px = 71,
  py = 95
}

SMODS.Atlas {
  key = "PhantaEnhancements",
  path = "PhantaEnhancements.png",
  px = 71,
  py = 95
}

SMODS.Atlas {
  key = "PhantaTarots",
  path = "PhantaTarots.png",
  px = 71,
  py = 95
}

function count_tarots()
  local tarot_counter = 0
    if G.consumeables then
      for _, card in pairs(G.consumeables.cards) do
        if card.ability.set == "Tarot" then
          tarot_counter = tarot_counter + 1
        end
      end
    end
    return tarot_counter
end

function count_planets()
  local planet_counter = 0
    if G.consumeables then
      for _, card in pairs(G.consumeables.cards) do
        if card.ability.set == "Planet" then
          planet_counter = planet_counter + 1
        end
      end
    end
    return planet_counter
end

SMODS.Enhancement {
	object_type = "Enhancement",
	key = "ghostcard",
  loc_txt = {
    name = 'Ghost Card',
    text = {
      "{C:white,X:mult}X#1#{} Mult if held in",
      "hand, gains {C:white,X:mult}X#2#{} Mult",
      "if played and not scored"
    }
  },
	atlas = "PhantaEnhancements",
	pos = { x = 0, y = 0 },
	config = { h_x_mult = 1, extra = { added_xmult = 0.2 } },
	loc_vars = function(self, info_queue)
		return { vars = { self.config.h_x_mult, self.config.extra.added_xmult } }
	end,
  calculate = function(self, card, context)
    if context.cardarea == "unscored" and context.main_scoring then
      self.config.h_x_mult = self.config.h_x_mult + self.config.extra.added_xmult
      G.E_MANAGER:add_event(Event({
        func = function() card_eval_status_text(self, 'extra', nil, nil, nil, {message = localize('k_upgrade_ex')}); return true end}))
		end
  end
}

SMODS.Seal {
	object_type = "Seal",
	key = "ghostseal",
  loc_txt = {
    name = 'Ghost Seal',
    text = {
      "Creates a {C:spectral}Spectral{} card",
      "if played and not scored",
      "on {C:attention}final hand{} of round",
      "{C:inactive}(Must have room){}"
    }
  },
	badge_colour = HEX("cccccc"),
	atlas = "PhantaEnhancements",
	pos = { x = 1, y = 0 },

	calculate = function(self, card, context)
		if context.cardarea == "unscored" and context.main_scoring and G.GAME.current_round.hands_left == 0 and #G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit then
			G.E_MANAGER:add_event(Event({
			  func = function()
					if G.consumeables.config.card_limit > #G.consumeables.cards then
						local new_card = create_card("Spectral", G.consumeables, nil, nil, nil, nil, nil, "ghostseal")
						new_card:add_to_deck()
						G.consumeables:emplace(new_card)
						card:juice_up()
					end
				  return true
				end
      }))
		end
	end
}

SMODS.Tarot {
	object_type = "Consumable",
	set = "Tarot",
	key = "grave",
  loc_txt = {
    name = 'Grave',
    text = {
      "Enhances {C:attention}#1#{}",
      "selected card into a",
      "{C:attention}Ghost Card{}"
    }
  },
	pos = { x = 0, y = 0 },
	config = {
		mod_conv = "phanta_ghost_seal",
		max_highlighted = 1
	},
	atlas = "PhantaTarots",
	loc_vars = function(self, info_queue, center)
		info_queue[#info_queue + 1] = { set = "Other", key = "phanta_ghostseal" }
		return { vars = { center.ability.max_highlighted } }
	end,
	use = function(self, card, area, copier)
		local conv_card = G.hand.highlighted[1]
    G.E_MANAGER:add_event(Event({func = function()
      play_sound('tarot1')
      card:juice_up(0.3, 0.5)
    return true end }))
        
    G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.1,func = function()
      conv_card:set_seal("phanta_ghostseal", nil, true)
    return true end }))
        
    delay(0.5)
    G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.2,func = function() G.hand:unhighlight_all(); return true end }))
	end
}

SMODS.Tarot {
	object_type = "Consumable",
	set = "Spectral",
	key = "jinn",
  loc_txt = {
    name = 'Jinn',
    text = {
      "Add a {C:attention}Ghost Seal{}",
      "to {C:attention}1{} selected",
      "card held in hand"
    }
  },
	pos = { x = 1, y = 0 },
	config = {
		mod_conv = "phanta_ghost_seal",
		max_highlighted = 1
	},
	atlas = "PhantaTarots",
	loc_vars = function(self, info_queue, center)
		info_queue[#info_queue + 1] = { set = "Other", key = "phanta_ghostseal" }
		return { vars = { center.ability.max_highlighted } }
	end,
	use = function(self, card, area, copier)
		local conv_card = G.hand.highlighted[1]
    G.E_MANAGER:add_event(Event({func = function()
      play_sound('tarot1')
      card:juice_up(0.3, 0.5)
    return true end }))
        
    G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.1,func = function()
      conv_card:set_seal("phanta_ghostseal", nil, true)
    return true end }))
        
    delay(0.5)
    G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.2,func = function() G.hand:unhighlight_all(); return true end }))
	end
}

--[[
local zodiac = {
	object_type = "ConsumableType",
	key = "Zodiac",
	primary_colour = HEX("4076cf"),
	secondary_colour = HEX("5998ff"),
	collection_rows = { 3, 4 },
	shop_rate = 0.0,
	loc_txt = {},
	default = "phanta_aries",
	can_stack = true,
	can_divide = true,
}
local zodiac_atlas = {
	object_type = "Atlas",
	key = "zodiac",
	path = "PhantaZodiacs.png",
	px = 71,
	py = 95,
}
SMODS.UndiscoveredSprite({
	key = "Zodiac",
	atlas = "zodiac",
	path = "PhantaBoosters.png",
	pos = { x = 1, y = 3 },
	px = 71,
	py = 95,
}):register()
local pack_atlas = {
	object_type = "Atlas",
	key = "pack",
	path = "PhantaBoosters.png",
	px = 71,
	py = 95,
}
local pack1 = {
	object_type = "Booster",
	key = "phanta_normal1",
	kind = "Zodiac",
	atlas = "pack",
	pos = { x = 0, y = 0 },
	config = { extra = 2, choose = 1 },
	cost = 4,
	order = 1,
	weight = 0.96,
	create_card = function(self, card)
		return create_card("Zodiac", G.pack_cards, nil, nil, true, true, nil, "phanta_zodiac")
	end,
	ease_background_colour = function(self)
		ease_colour(G.C.DYN_UI.MAIN, G.C.SET.Zodiac)
		ease_background_colour({ new_colour = G.C.SET.Zodiac, special_colour = G.C.RED, contrast = 2 })
	end,
	loc_vars = function(self, info_queue, card)
		return { vars = { card.config.center.config.choose, card.ability.extra } }
	end,
	group_key = "k_phanta_zodiac_pack",
}
local pack2 = {
	object_type = "Booster",
	key = "phanta_normal2",
	kind = "Zodiac",
	atlas = "pack",
	pos = { x = 1, y = 0 },
	config = { extra = 2, choose = 1 },
	cost = 4,
	order = 1,
	weight = 0.96,
	create_card = function(self, card)
		return create_card("Zodiac", G.pack_cards, nil, nil, true, true, nil, "phanta_zodiac")
	end,
	ease_background_colour = function(self)
		ease_colour(G.C.DYN_UI.MAIN, G.C.SET.Zodiac)
		ease_background_colour({ new_colour = G.C.SET.Zodiac, special_colour = G.C.RED, contrast = 2 })
	end,
	loc_vars = function(self, info_queue, card)
		return { vars = { card.config.center.config.choose, card.ability.extra } }
	end,
	group_key = "k_phanta_zodiac_pack",
}
local pack3 = {
	object_type = "Booster",
	key = "phanta_normal3",
	kind = "Zodiac",
	atlas = "pack",
	pos = { x = 2, y = 0 },
	config = { extra = 2, choose = 1 },
	cost = 4,
	order = 1,
	weight = 0.96,
	create_card = function(self, card)
		return create_card("Zodiac", G.pack_cards, nil, nil, true, true, nil, "phanta_zodiac")
	end,
	ease_background_colour = function(self)
		ease_colour(G.C.DYN_UI.MAIN, G.C.SET.Zodiac)
		ease_background_colour({ new_colour = G.C.SET.Zodiac, special_colour = G.C.RED, contrast = 2 })
	end,
	loc_vars = function(self, info_queue, card)
		return { vars = { card.config.center.config.choose, card.ability.extra } }
	end,
	group_key = "k_phanta_zodiac_pack",
}
local pack4 = {
	object_type = "Booster",
	key = "phanta_normal4",
	kind = "Zodiac",
	atlas = "pack",
	pos = { x = 3, y = 0 },
	config = { extra = 2, choose = 1 },
	cost = 4,
	order = 1,
	weight = 0.96,
	create_card = function(self, card)
		return create_card("Zodiac", G.pack_cards, nil, nil, true, true, nil, "phanta_zodiac")
	end,
	ease_background_colour = function(self)
		ease_colour(G.C.DYN_UI.MAIN, G.C.SET.Zodiac)
		ease_background_colour({ new_colour = G.C.SET.Zodiac, special_colour = G.C.RED, contrast = 2 })
	end,
	loc_vars = function(self, info_queue, card)
		return { vars = { card.config.center.config.choose, card.ability.extra } }
	end,
	group_key = "k_phanta_zodiac_pack",
}
local packJ1 = {
	object_type = "Booster",
	key = "phanta_jumbo1",
	kind = "Zodiac",
	atlas = "pack",
	pos = { x = 0, y = 1 },
	config = { extra = 4, choose = 1 },
	cost = 6,
	order = 3,
	weight = 0.48,
	create_card = function(self, card)
		return create_card("Zodiac", G.pack_cards, nil, nil, true, true, nil, "phanta_zodiac")
	end,
	ease_background_colour = function(self)
		ease_colour(G.C.DYN_UI.MAIN, G.C.SET.Zodiac)
		ease_background_colour({ new_colour = G.C.SET.Zodiac, special_colour = G.C.RED, contrast = 2 })
	end,
	loc_vars = function(self, info_queue, card)
		return { vars = { card.config.center.config.choose, card.ability.extra } }
	end,
	group_key = "k_phanta_zodiac_pack",
}
local packJ2 = {
	object_type = "Booster",
	key = "phanta_jumbo2",
	kind = "Zodiac",
	atlas = "pack",
	pos = { x = 1, y = 1 },
	config = { extra = 4, choose = 1 },
	cost = 6,
	order = 3,
	weight = 0.48,
	create_card = function(self, card)
		return create_card("Zodiac", G.pack_cards, nil, nil, true, true, nil, "phanta_zodiac")
	end,
	ease_background_colour = function(self)
		ease_colour(G.C.DYN_UI.MAIN, G.C.SET.Zodiac)
		ease_background_colour({ new_colour = G.C.SET.Zodiac, special_colour = G.C.RED, contrast = 2 })
	end,
	loc_vars = function(self, info_queue, card)
		return { vars = { card.config.center.config.choose, card.ability.extra } }
	end,
	group_key = "k_phanta_zodiac_pack",
}
local packM1 = {
	object_type = "Booster",
	key = "phanta_mega1",
	kind = "Zodiac",
	atlas = "pack",
	pos = { x = 2, y = 1 },
	config = { extra = 4, choose = 2 },
	cost = 8,
	order = 4,
	weight = 0.12,
	create_card = function(self, card)
		return create_card("Zodiac", G.pack_cards, nil, nil, true, true, nil, "phanta_zodiac")
	end,
	ease_background_colour = function(self)
		ease_colour(G.C.DYN_UI.MAIN, G.C.SET.Zodiac)
		ease_background_colour({ new_colour = G.C.SET.Zodiac, special_colour = G.C.RED, contrast = 2 })
	end,
	loc_vars = function(self, info_queue, card)
		return { vars = { card.config.center.config.choose, card.ability.extra } }
	end,
	group_key = "k_phanta_zodiac_pack",
}
local packM2 = {
	object_type = "Booster",
	key = "phanta_mega2",
	kind = "Zodiac",
	atlas = "pack",
	pos = { x = 3, y = 1 },
	config = { extra = 4, choose = 2 },
	cost = 8,
	order = 4,
	weight = 0.12,
	create_card = function(self, card)
		return create_card("Zodiac", G.pack_cards, nil, nil, true, true, nil, "phanta_zodiac")
	end,
	ease_background_colour = function(self)
		ease_colour(G.C.DYN_UI.MAIN, G.C.SET.Zodiac)
		ease_background_colour({ new_colour = G.C.SET.Zodiac, special_colour = G.C.RED, contrast = 2 })
	end,
	loc_vars = function(self, info_queue, card)
		return { vars = { card.config.center.config.choose, card.ability.extra } }
	end,
	group_key = "k_phanta_zodiac_pack",
}
]]--

SMODS.Joker {
  key = 'bootleg',
  config = { extra = { chips = 30, mult = 2 } },
  loc_vars = function(self, info_queue, card)
    return { vars = { card.ability.extra.chips, card.ability.extra.mult } }
  end,
  rarity = 1,
  atlas = 'Phanta',
  pos = { x = 4, y = 8 },
  cost = 2,
  blueprint_compat = true,
  calculate = function(self, card, context)
    if context.joker_main then
		return {
			chips = card.ability.extra.chips,
			mult = card.ability.extra.mult,
		}
    end
  end
}

SMODS.Joker {
  key = 'trainstation',
  config = { extra = { added_mult = 1, current_mult = 0 } },
  loc_vars = function(self, info_queue, card)
    return { vars = { card.ability.extra.added_mult, localize((G.GAME.current_round.train_station_card.rank or 2).."", 'ranks'), card.ability.extra.current_mult } }
  end,
  rarity = 1,
  atlas = 'Phanta',
  pos = { x = 5, y = 8 },
  cost = 6,
  blueprint_compat = true,
  calculate = function(self, card, context)
    if context.joker_main then
		return {
      message = localize { type = 'variable', key = 'a_mult', vars = { card.ability.extra.current_mult } },
			mult_mod = card.ability.extra.current_mult,
		}
    end
	if context.individual and context.cardarea == G.play and context.other_card:get_id() == G.GAME.current_round.train_station_card.rank and not context.blueprint then
		card.ability.extra.current_mult = card.ability.extra.current_mult + card.ability.extra.added_mult
		return {
      message = localize('k_upgrade_ex'),
      colour = G.C.FILTER,
      card = card
    }
	end
  end
}

SMODS.Joker {
  key = 'yellow',
  config = { extra = { odd_money = 7, even_money = 1 } },
  rarity = 1,
  atlas = 'Phanta',
  pos = { x = 3, y = 11 },
  cost = 6,
  blueprint_compat = false,
  loc_vars = function(self, info_queue, card)
    return { vars = { card.ability.extra.odd_money, card.ability.extra.even_money } }
  end,
  calc_dollar_bonus = function(self, card)
    if G.GAME.round % 2 == 1 then
      return card.ability.extra.odd_money
    else
      return card.ability.extra.even_money
    end
  end
}

SMODS.Joker {
  key = 'onemanstrash',
  no_pool_flag = "one_mans_trash_sold",
  config = { extra = { added_mult = 1, current_mult = 0 } },
  loc_vars = function(self, info_queue, card)
    return { vars = { card.ability.extra.added_mult, card.ability.extra.current_mult } }
  end,
  rarity = 1,
  atlas = 'Phanta',
  pos = { x = 3, y = 7 },
  cost = 5,
  blueprint_compat = true,
  calculate = function(self, card, context)
    if context.joker_main then
		  return {
  			mult = card.ability.extra.current_mult,
		  }
    end
	  if context.discard and not context.blueprint then
  		card.ability.extra.current_mult = card.ability.extra.current_mult + card.ability.extra.added_mult
	  end
    if context.end_of_round and context.individual and not context.blueprint then
      card.ability.extra.current_mult = 0
    end
    if context.selling_self and not context.blueprint then
      G.GAME.pool_flags.one_mans_trash_sold = true
    end
  end
}

SMODS.Joker {
  key = 'anothermanstreasure',
  yes_pool_flag = "one_mans_trash_sold",
  config = { extra = { added_xmult = 0.1, current_xmult = 1 } },
  loc_vars = function(self, info_queue, card)
    return { vars = { card.ability.extra.added_xmult, card.ability.extra.current_xmult } }
  end,
  rarity = 1,
  atlas = 'Phanta',
  pos = { x = 0, y = 11 },
  cost = 6,
  blueprint_compat = true,
  calculate = function(self, card, context)
    if context.joker_main then
		  return {
  			xmult = card.ability.extra.current_xmult,
		  }
    end
	  if context.discard and not context.blueprint then
  		card.ability.extra.current_xmult = card.ability.extra.current_xmult + card.ability.extra.added_xmult
	  end
    if context.end_of_round and context.individual and not context.blueprint then
      card.ability.extra.current_xmult = 1
    end
  end
}

SMODS.Joker {
  key = 'oracle',
  rarity = 1,
  atlas = 'Phanta',
  pos = { x = 2, y = 8 },
  cost = 4,
  blueprint_compat = false,
  add_to_deck = function(self, card, from_debuff)
		G.E_MANAGER:add_event(Event({func = function()
      G.consumeables.config.card_limit = G.consumeables.config.card_limit + 1
      return true end }))
	end,
	remove_from_deck = function(self, card, from_debuff)
		G.E_MANAGER:add_event(Event({func = function()
      G.consumeables.config.card_limit = G.consumeables.config.card_limit - 1
      return true end }))
  end
}

SMODS.Joker {
  key = 'thief',
  rarity = 1,
  atlas = 'Phanta',
  pos = { x = 3, y = 8 },
  cost = 4,
  blueprint_compat = false,
  add_to_deck = function(self, card, from_debuff)
      G.GAME.round_resets.hands = G.GAME.round_resets.hands + 1
        ease_hands_played(1)
	end,
	remove_from_deck = function(self, card, from_debuff)
		G.GAME.round_resets.hands = G.GAME.round_resets.hands - 1
        ease_hands_played(-1)
  end
}

SMODS.Joker {
  key = 'nonuniformday',
  config = { extra = { odds = 2 } },
  loc_vars = function(self, info_queue, card)
    info_queue[#info_queue+1] = G.P_CENTERS.m_wild
    return { vars = { (G.GAME.probabilities.normal or 1), card.ability.extra.odds } }
  end,
  rarity = 1,
  atlas = 'Phanta',
  pos = { x = 2, y = 11 },
  cost = 5,
  blueprint_compat = true,
  calculate = function(self, card, context)
    if context.individual and context.cardarea == G.play and #G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit and context.other_card.ability.name == 'Wild Card' and pseudorandom('nonuniformday') < G.GAME.probabilities.normal / card.ability.extra.odds then
      G.GAME.consumeable_buffer = G.GAME.consumeable_buffer + 1
      return { extra = {focus = card, message = localize('k_plus_tarot'), func = function()
      G.E_MANAGER:add_event(Event({
          trigger = 'before',
          delay = 0.0,
          func = function() play_sound("timpani")
          local new_card = create_card("Tarot", G.consumables, nil, nil, nil, nil, nil, "nonuniformday")
          new_card:add_to_deck()
          G.consumeables:emplace(new_card)
          G.GAME.consumeable_buffer = 0
          new_card:juice_up(0.3, 0.5)
          return true
        end
      })) end},
      colour = G.C.SECONDARY_SET.Tarot,
      card = card
    }
    end
  end
}

SMODS.Joker {
  key = 'teastainedjoker',
  config = { extra = { odds = 5, added_mult = 3, current_mult = 0 } },
  loc_vars = function(self, info_queue, card)
    info_queue[#info_queue+1] = G.P_CENTERS.m_lucky
    return { vars = { (G.GAME.probabilities.normal or 1), card.ability.extra.odds, card.ability.extra.added_mult, card.ability.extra.current_mult } }
  end,
  rarity = 2,
  atlas = 'Phanta',
  pos = { x = 7, y = 0 },
  cost = 6,
  blueprint_compat = true,
  calculate = function(self, card, context)
    if context.joker_main and card.ability.extra.current_mult > 0 then
      return {
        mult = card.ability.extra.current_mult
      }
    end

    if context.cardarea == G.hand and not context.blueprint and context.other_card and context.other_card.ability.name == 'Lucky Card' then
      if context.other_card.debuff then
        return {
          message = localize('k_debuffed'),
          colour = G.C.RED,
          card = card
        }
      elseif pseudorandom('teastainedjoker') < G.GAME.probabilities.normal / card.ability.extra.odds then
        card.ability.extra.current_mult = card.ability.extra.current_mult + card.ability.extra.added_mult
				return {
          message = localize('k_upgrade_ex'),
          card = card
        }
      end
    end
  end
}

SMODS.Joker {
  key = 'saltcircle',
  config = { extra = { chips = 200 } },
  rarity = 1,
  atlas = 'Phanta',
  pos = { x = 6, y = 1 },
  cost = 6,
  blueprint_compat = false,
  loc_vars = function(self, info_queue, card)
    return { vars = { card.ability.extra.chips } }
  end,
  calculate = function(self, card, context)
    if context.joker_main then
	  hand_chips = mod_chips(card.ability.extra.chips)
	  update_hand_text({delay = 0}, {chips = hand_chips})
	  return { message = localize("chips_equals")..card.ability.extra.chips, colour = G.C.CHIPS, card = card }
    end
  end
}

SMODS.Joker {
  key = 'ghost',
  config = { extra = { x_mult = 0.75 } },
  rarity = 3,
  atlas = 'Phanta',
  pos = { x = 0, y = 0 },
  cost = 8,
  blueprint_compat = true,
  loc_vars = function(self, info_queue, card)
    return { vars = { card.ability.extra.x_mult, 1 + (count_tarots() * card.ability.extra.x_mult) } }
  end,
  calculate = function(self, card, context)
    if context.joker_main then
      local tarot_count = count_tarots()
      if tarot_count > 0 then
        return {
          message = localize { type = 'variable', key = 'a_xmult', vars = { 1 + (count_tarots() * card.ability.extra.x_mult) } },
          Xmult_mod = 1 + (count_tarots() * card.ability.extra.x_mult)
        }
      end
    end
  end
}

--[[SMODS.Joker {
  key = 'hgdfghghfdghfd',
  loc_txt = {
    name = 'dhgfhgdfhdgfghdffghd',
    text = {
      "Gives {X:mult,C:white}X#1#{} Mult for",
      "each {C:tarot}Tarot{} card in",
      "your {C:attention}consumable{} area",
      "{C:inactive}(Currently {X:mult,C:white}X#2#{C:inactive} Mult)"
    }
  },
  config = { extra = { x_mult = 0.75 } },
  rarity = 3,
  atlas = 'Phanta',
  pos = { x = 8, y = 0 },
  soul_pos = { x = 9, y = 0 },
  cost = 8,
  blueprint_compat = true,
  loc_vars = function(self, info_queue, card)
    return { vars = { card.ability.extra.x_mult, 1 + (count_tarots() * card.ability.extra.x_mult) } }
  end,
  calculate = function(self, card, context)
    if context.joker_main then
      local tarot_count = count_tarots()
      if tarot_count > 0 then
        return {
          message = localize { type = 'variable', key = 'a_xmult', vars = { 1 + (count_tarots() * card.ability.extra.x_mult) } },
          Xmult_mod = 1 + (count_tarots() * card.ability.extra.x_mult)
        }
      end
    end
  end
}]]--

SMODS.Joker {
  key = 'layton',
  config = { extra = { out_of_odds = 4, added_mult = 75 } },
  rarity = 2,
  atlas = 'Phanta',
  pos = { x = 0, y = 8 },
  cost = 7,
  blueprint_compat = true,
  loc_vars = function(self, info_queue, card)
    return { vars = { count_tarots(), card.ability.extra.out_of_odds, card.ability.extra.added_mult } }
  end,
  calculate = function(self, card, context)
    if context.joker_main then
      local tarot_count = count_tarots()
      if next(SMODS.find_card("j_phanta_luke")) or (tarot_count > 0 and pseudorandom('layton') < tarot_count / card.ability.extra.out_of_odds) then
        return {
          message = localize { type = 'variable', key = 'a_mult', vars = { card.ability.extra.added_mult } },
          mult_mod = card.ability.extra.added_mult
        }
      end
    end
  end
}

SMODS.Joker {
  key = 'luke',
  config = { extra = { out_of_odds = 4, x_mult = 3 } },
  rarity = 2,
  atlas = 'Phanta',
  pos = { x = 1, y = 8 },
  cost = 7,
  blueprint_compat = true,
  loc_vars = function(self, info_queue, card)
    return { vars = { count_planets(), card.ability.extra.out_of_odds, card.ability.extra.x_mult } }
  end,
  calculate = function(self, card, context)
    if context.joker_main then
      local planet_count = count_planets()
      if next(SMODS.find_card("j_phanta_layton")) or (planet_count > 0 and pseudorandom('luke') < planet_count / card.ability.extra.out_of_odds) then
        return {
          message = localize { type = 'variable', key = 'a_xmult', vars = { card.ability.extra.x_mult } },
          Xmult_mod = card.ability.extra.x_mult
        }
      end
    end
  end
}

SMODS.Joker {
  key = 'candle',
  config = { extra = { added_xmult = 0.25, current_xmult = 1 } },
  rarity = 2,
  atlas = 'Phanta',
  pos = { x = 5, y = 7 },
  cost = 7,
  blueprint_compat = true,
  loc_vars = function(self, info_queue, card)
    return { vars = { card.ability.extra.added_xmult, card.ability.extra.current_xmult } }
  end,
  calculate = function(self, card, context)
    if context.setting_blind and not (context.blueprint_card or card).getting_sliced then
      local destructable_tarot = {}
			for i = 1, #G.consumeables.cards do
				if G.consumeables.cards[i].ability.set == "Tarot" and not G.consumeables.cards[i].getting_sliced and not G.consumeables.cards[i].ability.eternal then
					destructable_tarot[#destructable_tarot + 1] = G.consumeables.cards[i]
				end
			end
			local tarot_to_destroy = #destructable_tarot > 0 and pseudorandom_element(destructable_tarot, pseudoseed("candle")) or nil

			if tarot_to_destroy then
				tarot_to_destroy.getting_sliced = true
				card.ability.extra.current_xmult = card.ability.extra.current_xmult + card.ability.extra.added_xmult
				G.E_MANAGER:add_event(Event({
					func = function()
						(context.blueprint_card or card):juice_up(0.8, 0.8)
						tarot_to_destroy:start_dissolve({ G.C.RED }, nil, 1.6)
						return true
					end,
				}))
				if not (context.blueprint_card or card).getting_sliced then
					card_eval_status_text(context.blueprint_card or card, "extra", nil, nil, nil, {
							message = localize{ type='variable', key='a_xmult', vars={number_format(to_big(card.ability.extra.current_xmult))}}
						}
					)
				end
				return nil, true
			end
    end

    if context.joker_main then
      return {
        message = localize { type = 'variable', key = 'a_xmult', vars = { card.ability.extra.current_xmult } },
        Xmult_mod = card.ability.extra.current_xmult
      }
    end
  end
}

SMODS.Joker {
  key = 'identity',
  config = { extra = { no_of_cards = 2 } },
  rarity = 2,
  atlas = 'Phanta',
  pos = { x = 1, y = 0 },
  cost = 8,
  loc_vars = function(self, info_queue, card)
    return { vars = { card.ability.extra.no_of_cards } }
  end,
  blueprint_compat = false,
  eternal_compat = false,
  calculate = function(self, card, context)
    if context.ending_shop and not context.repetition then
      G.E_MANAGER:add_event(Event({
        func = function()
          play_sound('glass' .. pseudorandom_element({'1', '2', '3', '4', '5', '6'}), 1, 0.25)
          play_sound('timpani')

          local creation_event = Event({
            delay = 0.3,
            blockable = false,
            func = function()
              local new_card = create_card("Spectral", G.consumables, nil, nil, nil, nil)
              new_card:set_edition({
                negative = true,
              })
              new_card:add_to_deck()
              G.consumeables:emplace(new_card)
              return true;
            end
          })
          for i = 1, card.ability.extra.no_of_cards, 1
          do
            G.E_MANAGER:add_event(creation_event)
          end

          card.T.r = -0.2
          card:juice_up(0.3, 0.4)
          card.states.drag.is = true
          card.children.center.pinch.x = true
          G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0.3,
            blockable = false,
            func = function()
              G.jokers:remove_card(card)
              card:remove()
              card = nil
              return true;
            end
          }))
          return true
        end
      }))
      card_eval_status_text(card, 'extra', nil, nil, nil,
        { message = "Shattered!" })
      return true
    end
  end
}

SMODS.Joker {
  key = 'beadnecklace',
  loc_txt = {
    name = 'Bead Necklace',
    text = {
      "If played hand contains",
      "a {C:attention}Straight{}, gains {C:mult}+#1#{} Mult",
      "for each unique scoring {C:attention}suit{}",
      "{C:inactive}(Currently {C:mult}+#2#{C:inactive} Mult)"
    }
  },
  config = { extra = { added_mult = 2, current_mult = 0 } },
  rarity = 2,
  atlas = 'Phanta',
  pos = { x = 2, y = 9 },
  cost = 5,
  loc_vars = function(self, info_queue, card)
    return { vars = { card.ability.extra.added_mult, card.ability.extra.current_mult } }
  end,
  calculate = function(self, card, context)
    if context.joker_main then
      return {
        mult_mod = card.ability.extra.current_mult,
        message = localize { type = 'variable', key = 'a_mult', vars = { card.ability.extra.current_mult } }
      }
    end

    local suits = {
      ['Hearts'] = 0,
      ['Diamonds'] = 0,
      ['Spades'] = 0,
      ['Clubs'] = 0
  }
  for i = 1, #context.scoring_hand do
      if not SMODS.has_any_suit(context.scoring_hand[i]) then
          if context.scoring_hand[i]:is_suit('Hearts', true) and suits["Hearts"] == 0 then suits["Hearts"] = suits["Hearts"] + 1
          elseif context.scoring_hand[i]:is_suit('Diamonds', true) and suits["Diamonds"] == 0  then suits["Diamonds"] = suits["Diamonds"] + 1
          elseif context.scoring_hand[i]:is_suit('Spades', true) and suits["Spades"] == 0  then suits["Spades"] = suits["Spades"] + 1
          elseif context.scoring_hand[i]:is_suit('Clubs', true) and suits["Clubs"] == 0  then suits["Clubs"] = suits["Clubs"] + 1 end
      end
  end
  for i = 1, #context.scoring_hand do
      if SMODS.has_any_suit(context.scoring_hand[i]) then
          if context.scoring_hand[i]:is_suit('Hearts') and suits["Hearts"] == 0 then suits["Hearts"] = suits["Hearts"] + 1
          elseif context.scoring_hand[i]:is_suit('Diamonds') and suits["Diamonds"] == 0  then suits["Diamonds"] = suits["Diamonds"] + 1
          elseif context.scoring_hand[i]:is_suit('Spades') and suits["Spades"] == 0  then suits["Spades"] = suits["Spades"] + 1
          elseif context.scoring_hand[i]:is_suit('Clubs') and suits["Clubs"] == 0  then suits["Clubs"] = suits["Clubs"] + 1 end
      end
  end
  if suits["Hearts"] > 0 and
  suits["Diamonds"] > 0 and
  suits["Spades"] > 0 and
  suits["Clubs"] > 0 then
      return {
        mult = card.ability.extra.current_mult
      }
  end
  end
}

SMODS.Joker {
  key = 'p5joker',
  config = { extra = { mult_per_hand = 2, current_mult = 0 } },
  rarity = 2,
  atlas = 'Phanta',
  pos = { x = 2, y = 0 },
  cost = 5,
  loc_vars = function(self, info_queue, card)
    return { vars = { card.ability.extra.mult_per_hand, card.ability.extra.current_mult } }
  end,
  calculate = function(self, card, context)
    if context.joker_main then
      return {
        mult_mod = card.ability.extra.current_mult,
        message = localize { type = 'variable', key = 'a_mult', vars = { card.ability.extra.current_mult } }
      }
    end

    if context.before and not context.blueprint then
			local is_not_mph = false
			local play_more_than = (G.GAME.hands[context.scoring_name].played or 0)
			for i, j in pairs(G.GAME.hands) do
				if i ~= context.scoring_name and j.played >= play_more_than and j.visible then
					is_not_mph = true
				end
			end
			if is_not_mph then
				card.ability.extra.current_mult = card.ability.extra.current_mult + card.ability.extra.mult_per_hand
				return {
          message = localize('k_upgrade_ex'),
          card = card
        }
			end
		end
  end
}

SMODS.Joker {
  key = 'crescent',
  rarity = 1,
  atlas = 'Phanta',
  pos = { x = 3, y = 0 },
  cost = 4,
  blueprint_compat = true,
  calculate = function(self, card, context)
    if context.selling_card and context.card.config.center.set == "Planet" then
      G.E_MANAGER:add_event(Event({
        delay = 0.3,
        blockable = false,
        func = function()
          play_sound("timpani")
          local new_card = create_card("Tarot", G.consumables, nil, nil, nil, nil)
          new_card:add_to_deck()
          G.consumeables:emplace(new_card)
          new_card:juice_up(0.3, 0.5)
          return true
        end
      }))
      return nil, true
    end
  end
}

SMODS.Joker {
  key = 'ransomnote',
  config = { extra = { money = 25, joker_tally = 0, jokers_required = 5 } },
  rarity = 2,
  atlas = 'Phanta',
  pos = { x = 3, y = 10 },
  cost = 6,
  loc_vars = function(self, info_queue, card)
    return { vars = { card.ability.extra.money, card.ability.extra.jokers_required, card.ability.extra.jokers_required - card.ability.extra.joker_tally } }
  end,
  blueprint_compat = true,
  calculate = function(self, card, context)
    if context.selling_card and context.card.config.center.set == "Joker" and not card.getting_sliced then
	  card.ability.extra.joker_tally = card.ability.extra.joker_tally + 1
	  if card.ability.extra.joker_tally == card.ability.extra.jokers_required then
        card.ability.extra.joker_tally = 0
		return { dollars = card.ability.extra.money }
	  else
	    return { message = card.ability.extra.joker_tally.."/"..card.ability.extra.jokers_required, colour = G.C.FILTER, card = card }
	  end
    end
  end
}

SMODS.Joker {
  key = 'purplejoker',
  config = { extra = { mult_per_hand = 1, current_mult = 0 } },
  rarity = 1,
  atlas = 'Phanta',
  pos = { x = 3, y = 9 },
  cost = 4,
  loc_vars = function(self, info_queue, card)
    return { vars = { card.ability.extra.mult_per_hand, card.ability.extra.current_mult } }
  end,
  blueprint_compat = true,
  calculate = function(self, card, context)
    if context.joker_main then
      return { mult = card.ability.extra.current_mult }
    end
    if context.before and not context.blueprint then
			if count_tarots() > 0 then
				card.ability.extra.current_mult = card.ability.extra.current_mult + card.ability.extra.mult_per_hand
				return {
          message = localize('k_upgrade_ex'),
          card = card
        }
			end
		end
  end
}

SMODS.Joker {
  key = 'monetjoker',
  rarity = 3,
  atlas = 'Phanta',
  pos = { x = 4, y = 9 },
  cost = 8,
  blueprint_compat = true,
  calculate = function(self, card, context)
    if context.discard and #context.full_hand == 1 then
      G.GAME.consumeable_buffer = G.GAME.consumeable_buffer + 1
      G.E_MANAGER:add_event(Event({
        trigger = 'before',
        delay = 0.0,
        func = (function()
            local card = create_card('Tarot', G.consumeables, nil, nil, nil, nil, nil, 'monetjoker')
            card:add_to_deck()
            G.consumeables:emplace(card)
            G.GAME.consumeable_buffer = 0
          return true
        end)}))
      return {
        message = localize('k_plus_tarot'),
        card = card
      }
    end
  end
}

SMODS.Joker {
  key = 'goldenfiddle',
  rarity = 2,
  atlas = 'Phanta',
  pos = { x = 4, y = 0 },
  cost = 6,
  loc_vars = function(self, info_queue, card)
    info_queue[#info_queue+1] = G.P_CENTERS.c_devil
    info_queue[#info_queue+1] = G.P_CENTERS.c_chariot
    return {  }
  end,
	blueprint_compat = true,
  calculate = function(self, card, context)
    if context.setting_blind and not (context.blueprint_card or self).getting_sliced and #G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit then
      G.GAME.consumeable_buffer = G.GAME.consumeable_buffer + 1
      G.E_MANAGER:add_event(Event({
        func = function()
          local chosen_message = '+1 Devil'
          G.E_MANAGER:add_event(Event({
            func = function()
              local chosen_card = 'c_devil'
              if pseudorandom('goldenfiddle', 1, 2) == 1 then
                chosen_card = 'c_chariot'
                chosen_message = '+1 Chariot'
              end
              local new_card = create_card("Tarot", G.consumables, nil, nil, nil, nil, chosen_card, 'goldenfiddle')
              new_card:add_to_deck()
              G.consumeables:emplace(new_card)
              G.GAME.consumeable_buffer = 0
              new_card:juice_up(0.3, 0.5)
              return true
            end}))
              card_eval_status_text(context.blueprint_card or card, 'extra', nil, nil, nil, {message = chosen_message, colour = G.C.PURPLE})
          return true
        end
      }))
    end
  end
}

SMODS.Joker {
  key = 'reverie',
  rarity = 2,
  atlas = 'Phanta',
  pos = { x = 5, y = 0 },
  cost = 6,
  loc_vars = function(self, info_queue, card)
    info_queue[#info_queue+1] = G.P_CENTERS.c_heirophant
    info_queue[#info_queue+1] = G.P_CENTERS.c_temperance
    return {  }
  end,
	blueprint_compat = true,
  calculate = function(self, card, context)
    if context.setting_blind and not (context.blueprint_card or self).getting_sliced and #G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit then
      G.GAME.consumeable_buffer = G.GAME.consumeable_buffer + 1
      G.E_MANAGER:add_event(Event({
        func = function()
          local chosen_message = '+1 Heirophant'
          G.E_MANAGER:add_event(Event({
            func = function()
              local chosen_card = 'c_heirophant'
              if pseudorandom('reverie', 1, 2) == 1 then
                chosen_card = 'c_temperance'
                chosen_message = '+1 Temperance'
              end
              local new_card = create_card("Tarot", G.consumables, nil, nil, nil, nil, chosen_card, 'reverie')
              new_card:add_to_deck()
              G.consumeables:emplace(new_card)
              G.GAME.consumeable_buffer = 0
              new_card:juice_up(0.3, 0.5)
              return true
            end}))
              card_eval_status_text(context.blueprint_card or card, 'extra', nil, nil, nil, {message = chosen_message, colour = G.C.PURPLE})
          return true
        end
      }))
    end
  end
}

SMODS.Joker {
  key = 'sees',
  rarity = 2,
  atlas = 'Phanta',
  pos = { x = 2, y = 4 },
  cost = 6,
  loc_vars = function(self, info_queue, card)
    info_queue[#info_queue+1] = G.P_CENTERS.c_moon
    return {  }
  end,
	blueprint_compat = true,
  calculate = function(self, card, context)
    if context.setting_blind and not (context.blueprint_card or self).getting_sliced and #G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit then
      G.GAME.consumeable_buffer = G.GAME.consumeable_buffer + 1
      G.E_MANAGER:add_event(Event({
        func = function()
          G.E_MANAGER:add_event(Event({
            func = function()
              local new_card = create_card("Tarot", G.consumables, nil, nil, nil, nil, "c_moon", 'sees')
              new_card:add_to_deck()
              G.consumeables:emplace(new_card)
              G.GAME.consumeable_buffer = 0
              new_card:juice_up(0.3, 0.5)
              return true
            end}))
              card_eval_status_text(context.blueprint_card or card, 'extra', nil, nil, nil, {message = "+1 Moon", colour = G.C.PURPLE})
          return true
        end
      }))
    end
  end
}

SMODS.Joker {
  key = 'scissorsaresharp',
  rarity = 2,
  atlas = 'Phanta',
  pos = { x = 4, y = 7 },
  cost = 7,
  loc_vars = function(self, info_queue, card)
    info_queue[#info_queue+1] = G.P_CENTERS.c_judgement
    return {  }
  end,
  blueprint_compat = true,
  calculate = function(self, card, context)
    if context.setting_blind and not (context.blueprint_card or self).getting_sliced and #G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit then
      G.GAME.consumeable_buffer = G.GAME.consumeable_buffer + 1
      G.E_MANAGER:add_event(Event({
        func = function()
          G.E_MANAGER:add_event(Event({
            func = function()
              local new_card = create_card("Tarot", G.consumables, nil, nil, nil, nil, "c_judgement", 'scissorsaresharp')
              new_card:add_to_deck()
              G.consumeables:emplace(new_card)
              G.GAME.consumeable_buffer = 0
              new_card:juice_up(0.3, 0.5)
              return true
            end}))
              card_eval_status_text(context.blueprint_card or card, 'extra', nil, nil, nil, {message = "+1 Judgement", colour = G.C.PURPLE})
          return true
        end
      }))
    end
  end
}

SMODS.Joker {
  key = 'caesarcipher',
  rarity = 2,
  atlas = 'Phanta',
  pos = { x = 5, y = 4 },
  cost = 6,
	blueprint_compat = true,
  loc_vars = function(self, info_queue, card)
    info_queue[#info_queue+1] = G.P_CENTERS.c_strength
    return {  }
  end,
  calculate = function(self, card, context)
    if context.setting_blind and not (context.blueprint_card or self).getting_sliced and #G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit then
      G.GAME.consumeable_buffer = G.GAME.consumeable_buffer + 1
      G.E_MANAGER:add_event(Event({
        func = function()
          local random_card = pseudorandom('caesarcipher', 1, 2)
          G.E_MANAGER:add_event(Event({
            func = function()
              if random_card == 1 then
                local new_card = create_card("Planet", G.consumables, nil, nil, nil, nil)
                new_card:add_to_deck()
                G.consumeables:emplace(new_card)
                G.GAME.consumeable_buffer = 0
                new_card:juice_up(0.3, 0.5)
              else
                local new_card = create_card("Tarot", G.consumables, nil, nil, nil, nil, "c_strength", "caesarcipher")
                new_card:add_to_deck()
                G.consumeables:emplace(new_card)
                G.GAME.consumeable_buffer = 0
                new_card:juice_up(0.3, 0.5)
              end
              return true
            end}))
            if random_card == 1 then
              card_eval_status_text(context.blueprint_card or card, 'extra', nil, nil, nil, {message = "+1 Planet", colour = G.C.BLUE})
            else
              card_eval_status_text(context.blueprint_card or card, 'extra', nil, nil, nil, {message = "+1 Strength", colour = G.C.PURPLE})
            end
          return true
        end
      }))
    end
  end
}

--[[SMODS.Joker {
  key = 'forsakenscroll',
  loc_txt = {
    name = 'Forsaken Scroll',
    text = {
      "{C:inactive,s:0.75}The prophecy says:{}",
	  "“Each used {C:tarot}#1#{}",
	  "gives $#2#, {C:tarot}Tarot{} card",
	  "changes every round”"
    }
  },
  config = { extra = { chosen_tarot = 0, money = 6 } },
  rarity = 1,
  atlas = 'Phanta',
  pos = { x = 2, y = 5 },
  cost = 4,
  blueprint_compat = true,
  loc_vars = function(self, info_queue, card)
    return { vars = { card.ability.extra.chosen_tarot, card.ability.extra.money } }
  end,
  calculate = function(self, card, context)
    
  end
}]]--

SMODS.Joker {
  key = 'timepiece',
  rarity = 2,
  atlas = 'Phanta',
  pos = { x = 3, y = 4 },
  cost = 6,
	blueprint_compat = true,
  loc_vars = function(self, info_queue, card)
    info_queue[#info_queue+1] = G.P_CENTERS.c_death
    return {  }
  end,
  calculate = function(self, card, context)
    if context.cardarea == G.jokers and context.before and G.GAME.current_round.hands_left == 0 and not (context.blueprint_card or card).getting_sliced and #G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit then
      G.GAME.consumeable_buffer = G.GAME.consumeable_buffer + 1
      G.E_MANAGER:add_event(Event({
        func = function()
          G.E_MANAGER:add_event(Event({
            func = function()
              local new_card = create_card("Tarot", G.consumables, nil, nil, nil, nil, "c_death", 'timepiece')
              new_card:add_to_deck()
              G.consumeables:emplace(new_card)
              G.GAME.consumeable_buffer = 0
              new_card:juice_up(0.3, 0.5)
              return true
            end}))
              card_eval_status_text(context.blueprint_card or card, 'extra', nil, nil, nil, {message = "+1 Death", colour = G.C.PURPLE})
          return true
        end
      }))
    end
  end
}

SMODS.Joker {
  key = 'introspection',
  config = { extra = { chosen_type = 0 } },
  rarity = 2,
  atlas = 'Phanta',
  pos = { x = 0, y = 1 },
  cost = 6,
  loc_vars = function(self, info_queue, card)
    return { vars = { ({'Tarot', 'Planet'})[card.ability.extra.chosen_type + 1], ({'Planets', 'Tarots'})[card.ability.extra.chosen_type + 1],
  colours = { ({ G.C.SECONDARY_SET.Tarot, G.C.SECONDARY_SET.Planet })[card.ability.extra.chosen_type + 1], ({ G.C.SECONDARY_SET.Planet, G.C.SECONDARY_SET.Tarot })[card.ability.extra.chosen_type + 1] } } }
  end,
	blueprint_compat = true,
  calculate = function(self, card, context)
    if context.setting_blind and not (context.blueprint_card or card).getting_sliced and #G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit then
      G.GAME.consumeable_buffer = G.GAME.consumeable_buffer + 1
      G.E_MANAGER:add_event(Event({
      func = (function()
        G.E_MANAGER:add_event(Event({
          func = function() 
            local new_card = create_card(({'Tarot', 'Planet'})[card.ability.extra.chosen_type + 1], G.consumeables, nil, nil, nil, nil, nil, 'introspection')
            new_card:add_to_deck()
            G.consumeables:emplace(new_card)
            G.GAME.consumeable_buffer = 0
            card.ability.extra.chosen_type = 1 - card.ability.extra.chosen_type
            return true
          end}))   
          card_eval_status_text(context.blueprint_card or card, 'extra', nil, nil, nil, {message = localize(({'k_plus_tarot', 'k_plus_planet'})[card.ability.extra.chosen_type + 1]), colour = ({G.C.PURPLE, G.C.BLUE})[card.ability.extra.chosen_type + 1]})                       
        return true
      end)}))
    end
  end
}

SMODS.Joker {
  key = 'blindjoker',
  config = { extra = { no_of_aces = 2 } },
  rarity = 2,
  atlas = 'Phanta',
  pos = { x = 1, y = 1 },
  cost = 6,
  loc_vars = function(self, info_queue, card)
    return { vars = { card.ability.extra.no_of_aces } }
  end,
	blueprint_compat = true,
  calculate = function(self, card, context)
    
	if context.joker_main and #G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit then
    local aces = 0
    for i = 1, #context.scoring_hand do
        if context.scoring_hand[i]:get_id() == 14 then
			aces = aces + 1
		end
    end
    if aces == card.ability.extra.no_of_aces then
        G.GAME.consumeable_buffer = G.GAME.consumeable_buffer + 1
        G.E_MANAGER:add_event(Event({
            trigger = 'before',
            func = function()
                local planet = 0
                for i, j in pairs(G.P_CENTER_POOLS.Planet) do
                    if j.config.hand_type == G.GAME.last_hand_played then
                        planet = j.key
                    end
                end
                local card = create_card("Planet", G.consumeables, nil, nil, nil, nil, planet, 'blindjoker')
                card:add_to_deck()
                G.consumeables:emplace(card)
                G.GAME.consumeable_buffer = 0
                return true
            end}))
        return {
            message = localize('k_plus_planet'),
            colour = G.C.SECONDARY_SET.Planet,
            card = card
        }
    end
	end
  end
}

SMODS.Joker {
  key = 'witchsmark',
  rarity = 3,
  atlas = 'Phanta',
  pos = { x = 0, y = 10 },
  cost = 8,
  blueprint_compat = true,
  calculate = function(self, card, context)
    if context.joker_main and #G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit then
	  local contains_nonface = false
	  for i = 1, #G.play.cards do
	    if not G.play.cards[i]:is_face() then
		  contains_nonface = true
		end
	  end
	  if not contains_nonface then
      G.GAME.consumeable_buffer = G.GAME.consumeable_buffer + 1
      G.E_MANAGER:add_event(Event({
        trigger = 'before',
        delay = 0.0,
        func = (function()
            local card = create_card('Tarot', G.consumeables, nil, nil, nil, nil, nil, 'witchsmark')
            card:add_to_deck()
            G.consumeables:emplace(card)
            G.GAME.consumeable_buffer = 0
          return true
        end)}))
      return {
        message = localize('k_plus_tarot'),
        card = card
      }
	end
    end
  end
}

SMODS.Joker {
  key = 'modernart',
  config = { extra = { bonus_cash = 3 } },
  rarity = 1,
  atlas = 'Phanta',
  pos = { x = 4, y = 3 },
  cost = 4,
  loc_vars = function(self, info_queue, card)
    return { vars = { card.ability.extra.bonus_cash } }
  end,
  blueprint_compat = false,
  calculate = function(self, card, context)
    if context.before and context.scoring_name == "High Card" then
      card.ability.extra_value = card.ability.extra_value + card.ability.extra.bonus_cash
      card:set_cost()
      return {
        message = localize('k_val_up'),
        colour = G.C.MONEY
      }
    end
  end
}

SMODS.Joker {
  key = 'sketch',
  loc_txt = {
    name = 'Sketch',
    text = {
     "Gives {C:white,X:mult}X#1#{} Mult for",
     "each played card",
     "that {C:attention}doesn't score{}"
    }
  },
  config = { extra = { xmult = 0.5 } },
  rarity = 3,
  atlas = 'Phanta',
  pos = { x = 5, y = 3 },
  cost = 8,
  loc_vars = function(self, info_queue, card)
    return { vars = { card.ability.extra.xmult } }
  end,
  blueprint_compat = true,
  calculate = function(self, card, context)
    if context.joker_main and #G.play.cards > #context.scoring_hand then
      return {
        message = localize { type = 'variable', key = 'a_xmult', vars = { 1 + (card.ability.extra.xmult * (#G.play.cards - #context.scoring_hand)) } },
        Xmult_mod = 1 + (card.ability.extra.xmult * (#G.play.cards - #context.scoring_hand)),
        colour = G.C.RED,
        card = card
      }
    end
  end
}

SMODS.Joker {
  key = 'conspiracist',
  config = { extra = { odds = 2 } },
  rarity = 1,
  atlas = 'Phanta',
  pos = { x = 0, y = 5 },
  cost = 5,
  loc_vars = function(self, info_queue, card)
    info_queue[#info_queue+1] = G.P_CENTERS.c_earth
    return { vars = { (G.GAME.probabilities.normal or 1), card.ability.extra.odds } }
  end,
  blueprint_compat = true,
  calculate = function(self, card, context)
    if context.cardarea == G.jokers and context.before and not (context.blueprint_card or card).getting_sliced and #G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit
	and pseudorandom('conspiracist') < G.GAME.probabilities.normal / card.ability.extra.odds and next(context.poker_hands['Full House']) then
      G.GAME.consumeable_buffer = G.GAME.consumeable_buffer + 1
      G.E_MANAGER:add_event(Event({
        func = function()
          G.E_MANAGER:add_event(Event({
            func = function()
              local new_card = create_card("Planet", G.consumables, nil, nil, nil, nil, "c_earth", 'conspiracist')
              new_card:add_to_deck()
              G.consumeables:emplace(new_card)
              G.GAME.consumeable_buffer = 0
              new_card:juice_up(0.3, 0.5)
              return true
            end}))
              card_eval_status_text(context.blueprint_card or card, 'extra', nil, nil, nil, {message = "+1 Earth", colour = G.C.BLUE})
          return true
        end
      }))
    end
  end
}

SMODS.Joker {
  key = 'diningtable',
  config = {  },
  rarity = 2,
  atlas = 'Phanta',
  pos = { x = 1, y = 10 },
  cost = 7,
  loc_vars = function(self, info_queue, card)
    info_queue[#info_queue+1] = G.P_CENTERS.m_glass
    return {  }
  end,
  blueprint_compat = false,
  calculate = function(self, card, context)
    if context.cardarea == G.jokers and context.before and not card.getting_sliced and next(context.poker_hands['Full House']) then
      local rank_tallies = {}
	  for k, v in ipairs(context.scoring_hand) do
	    if not rank_tallies[v.rank] then
		  rank_tallies[v.rank] = 0
		end
		rank_tallies[v.rank] = rank_tallies[v.rank] + 1
		sendInfoMessage("rank "..v.rank, self.key)
	  end
	  sendInfoMessage(""..(rank_tallies[2]  or 0), self.key)
	  sendInfoMessage(""..(rank_tallies[3]  or 0), self.key)
	  sendInfoMessage(""..(rank_tallies[4]  or 0), self.key)
	  sendInfoMessage(""..(rank_tallies[5]  or 0), self.key)
	  sendInfoMessage(""..(rank_tallies[6]  or 0), self.key)
	  sendInfoMessage(""..(rank_tallies[7]  or 0), self.key)
	  sendInfoMessage(""..(rank_tallies[8]  or 0), self.key)
	  sendInfoMessage(""..(rank_tallies[9]  or 0), self.key)
	  sendInfoMessage(""..(rank_tallies[10] or 0), self.key)
	  sendInfoMessage(""..(rank_tallies[11] or 0), self.key)
	  sendInfoMessage(""..(rank_tallies[12] or 0), self.key)
	  sendInfoMessage(""..(rank_tallies[13] or 0), self.key)
	  sendInfoMessage(""..(rank_tallies[14] or 0), self.key)
	  
	  local candidates = {}
	  for k, v in ipairs(context.scoring_hand) do
	    if rank_tallies[v.rank] == 2 then
		  candidates[#candidates + 1] = v
		end
	  end
	  
	  if #candidates > 0 then
	    for c in candidates do
		  c:set_ability(G.P_CENTERS.m_glass, nil, true)
          G.E_MANAGER:add_event(Event({
            func = function()
              c:juice_up()
              return true
            end
          }))
		end
		return { message = localize("become_glass"), colour = G.C.FILTER, card = card }
	  end
    end
  end
}

SMODS.Joker {
  key = 'eyeofprovidence',
  config = { extra = { xmult = 2 } },
  rarity = 3,
  atlas = 'Phanta',
  pos = { x = 1, y = 5 },
  cost = 8,
  loc_vars = function(self, info_queue, card)
    return { vars = { card.ability.extra.xmult } }
  end,
  blueprint_compat = true,
  calculate = function(self, card, context)
    if context.individual and context.cardarea == G.play and context.other_card:get_id() == 14 and context.other_card:is_suit("Spades") then
      return {
        message = localize { type = 'variable', key = 'a_xmult', vars = { card.ability.extra.xmult } },
        x_mult = card.ability.extra.xmult,
        colour = G.C.RED,
        card = card
      }
    end
  end
}

SMODS.Joker {
  key = 'emotionaldamage',
  config = { extra = { added_xmult = 0.2, current_xmult = 1 } },
  rarity = 3,
  atlas = 'Phanta',
  pos = { x = 1, y = 4 },
  cost = 8,
  loc_vars = function(self, info_queue, card)
    return { vars = { card.ability.extra.added_xmult, card.ability.extra.current_xmult } }
  end,
  blueprint_compat = true,
  calculate = function(self, card, context)
    if context.joker_main then
      return {
        message = localize { type = 'variable', key = 'a_xmult', vars = { card.ability.extra.current_xmult } },
        Xmult_mod = card.ability.extra.current_xmult
      }
    end

    if context.pre_discard and not context.blueprint then
      local text,disp_text = G.FUNCS.get_poker_hand_info(G.hand.highlighted)
      if disp_text == "Flush" then
				card.ability.extra.current_xmult = card.ability.extra.current_xmult + card.ability.extra.added_xmult
        card_eval_status_text(context.blueprint_card or card, 'extra', nil, nil, nil, {message = localize('k_upgrade_ex')})
			end
		end
  end
}

SMODS.Joker {
  key = 'inception',
  loc_txt = {
    name = 'Inception',
    text = {
     "{C:mult}+#1#{} Mult per hand",
     "played this {C:attention}Blind{}",
     "{C:inactive}(Will give {C:mult}+#2#{C:inactive} Mult){}"
    }
  },
  config = { extra = { current_mult = 0, added_mult = 6 } },
  rarity = 1,
  atlas = 'Phanta',
  pos = { x = 0, y = 4 },
  cost = 5,
  loc_vars = function(self, info_queue, card)
    return { vars = { card.ability.extra.added_mult, card.ability.extra.current_mult + card.ability.extra.added_mult } }
  end,
  blueprint_compat = true,
  calculate = function(self, card, context)
    if context.joker_main then
      if not context.blueprint then
        card.ability.extra.current_mult = card.ability.extra.current_mult + card.ability.extra.added_mult
      end
      return {
        message = localize { type = 'variable', key = 'a_mult', vars = { card.ability.extra.current_mult } },
        mult_mod = card.ability.extra.current_mult,
        colour = G.C.RED,
        card = card
      }
    elseif context.end_of_round and not context.individual and not context.repetition and not context.blueprint then
      card.ability.extra.current_mult = 0
      return {
        message = localize('k_reset'),
        colour = G.C.RED,
        card = card
      }
    end
  end
}

SMODS.Joker {
  key = 'thespear',
  rarity = 3,
  atlas = 'Phanta',
  pos = { x = 0, y = 6 },
  cost = 8,
  blueprint_compat = true,
  calculate = function(self, card, context)
    if context.cardarea == G.jokers and context.before then
      local destructable_card = {}
			for i = 1, #context.scoring_hand do
				if context.scoring_hand[i]:is_suit("Spades") and not context.scoring_hand[i].getting_sliced then
					destructable_card[#destructable_card + 1] = context.scoring_hand[i]
				end
			end
			local card_to_destroy = #destructable_card > 0 and pseudorandom_element(destructable_card, pseudoseed("thespear")) or nil

			if card_to_destroy then
				card_to_destroy.getting_sliced = true
				G.E_MANAGER:add_event(Event({
					func = function()
						(context.blueprint_card or card):juice_up(0.8, 0.8)
						card_to_destroy:start_dissolve({ G.C.RED }, nil, 1.6)
						return true
					end,
				}))
				update_hand_text({sound = 'button', volume = 0.7, pitch = 0.8, delay = 0.3}, {handname="Straight",chips = G.GAME.hands["Straight"].chips, mult = G.GAME.hands["Straight"].mult, level=G.GAME.hands["Straight"].level})
				level_up_hand(card, "Straight", nil, 1)
				update_hand_text({sound = 'button', volume = 0.7, pitch = 0.8, delay = 0.3}, {handname=context.scoring_name,chips = G.GAME.hands[context.scoring_name].chips, mult = G.GAME.hands[context.scoring_name].mult, level=G.GAME.hands[context.scoring_name].level})
				return nil, true
			end
    end
  end
}

SMODS.Joker {
  key = 'thefuse',
  config = { extra = { added_xmult = 0.1, current_xmult = 1 } },
  rarity = 3,
  atlas = 'Phanta',
  pos = { x = 1, y = 6 },
  cost = 8,
  blueprint_compat = true,
  loc_vars = function(self, info_queue, card)
    return { vars = { card.ability.extra.added_xmult, card.ability.extra.current_xmult } }
  end,
  calculate = function(self, card, context)
  if context.joker_main and card.ability.extra.current_xmult > 1 then
      return {
        Xmult_mod = card.ability.extra.current_xmult,
        message = localize { type = 'variable', key = 'a_xmult', vars = { card.ability.extra.current_xmult } }
      }
    end
    if context.cardarea == G.jokers and context.before then
      local destructable_card = {}
			for i = 1, #context.scoring_hand do
				if context.scoring_hand[i]:is_suit("Hearts") and not context.scoring_hand[i].getting_sliced then
					destructable_card[#destructable_card + 1] = context.scoring_hand[i]
				end
			end
			local card_to_destroy = #destructable_card > 0 and pseudorandom_element(destructable_card, pseudoseed("thefuse")) or nil

			if card_to_destroy then
				card_to_destroy.getting_sliced = true
				card.ability.extra.current_xmult = card.ability.extra.current_xmult + card.ability.extra.added_xmult
				G.E_MANAGER:add_event(Event({
					func = function()
						(context.blueprint_card or card):juice_up(0.8, 0.8)
						card_to_destroy:start_dissolve({ G.C.RED }, nil, 1.6)
						return true
					end,
				}))
				if not (context.blueprint_card or card).getting_sliced then
						card_eval_status_text(context.blueprint_card or card, "extra", nil, nil, nil, {
							message = localize{ type='variable', key='a_xmult', vars={number_format(to_big(card.ability.extra.current_xmult))}}
						}
					)
				end
				return nil, true
			end
    end
  end
}

SMODS.Joker {
  key = 'themace',
  config = { extra = { money = 5 } },
  rarity = 3,
  atlas = 'Phanta',
  pos = { x = 2, y = 6 },
  cost = 8,
  blueprint_compat = true,
  loc_vars = function(self, info_queue, card)
    return { vars = { card.ability.extra.money } }
  end,
  calculate = function(self, card, context)
    if context.cardarea == G.jokers and context.before then
      local destructable_card = {}
			for i = 1, #context.scoring_hand do
				if context.scoring_hand[i]:is_suit("Mace") and not context.scoring_hand[i].getting_sliced then
					destructable_card[#destructable_card + 1] = context.scoring_hand[i]
				end
			end
			local card_to_destroy = #destructable_card > 0 and pseudorandom_element(destructable_card, pseudoseed("themace")) or nil

			if card_to_destroy then
				card_to_destroy.getting_sliced = true
				G.E_MANAGER:add_event(Event({
					func = function()
						(context.blueprint_card or card):juice_up(0.8, 0.8)
						card_to_destroy:start_dissolve({ G.C.RED }, nil, 1.6)
						return true
					end,
				}))
				ease_dollars(card.ability.extra.money)
				G.E_MANAGER:add_event(Event({
					func = function()
                return {
                    message = localize('$')..card.ability.extra.money,
                    colour = G.C.MONEY,
                    delay = 0.45, 
                    remove = true,
                    card = card
                }
					end,
				}))
				return nil, true
			end
		end
  end
}

SMODS.Joker {
  key = 'thedagger',
  config = { extra = { added_mult = 10, current_mult = 0, selected_card = nil } },
  rarity = 3,
  atlas = 'Phanta',
  pos = { x = 3, y = 6 },
  cost = 8,
  blueprint_compat = true,
  loc_vars = function(self, info_queue, card)
    return { vars = { card.ability.extra.added_mult, card.ability.extra.current_mult } }
  end,
  calculate = function(self, card, context)
    if context.joker_main then
      if not context.blueprint then
        local diamond_cards = {}
        for k, v in ipairs(context.scoring_hand) do
          if v:is_suit("Diamonds") then 
            diamond_cards[#diamond_cards + 1] = v
          end
        end
        if diamond_cards then
          card.ability.extra.selected_card = pseudorandom_element(diamond_cards, pseudoseed("thedagger"))
        else
          card.ability.extra.selected_card = nil
        end
      end
      return { mult = card.ability.extra.current_mult }
    end

    if context.destroying_card and card.ability.extra.selected_card and context.other_card == card.ability.extra.selected_card then
      card.ability.extra.current_mult = card.ability.extra.current_mult + card.ability.extra.added_mult
      return {remove = true}
    end
  end
}

SMODS.Joker {
  key = 'selfportrait',
  config = { extra = { current_rounds = 0, rounds_required = 3 } },
  rarity = 3,
  atlas = 'Phanta',
  pos = { x = 1, y = 11 },
  cost = 8,
  blueprint_compat = false,
  loc_vars = function(self, info_queue, card)
    return { vars = { card.ability.extra.current_rounds, card.ability.extra.rounds_required } }
  end,
  calculate = function(self, card, context)
    if context.end_of_round and not context.individual and not context.repetition and not context.blueprint then
      card.ability.extra.current_rounds = card.ability.extra.current_rounds + 1
      if card.ability.extra.current_rounds == card.ability.extra.rounds_required then 
        local eval = function(card) return not card.REMOVED end
        juice_card_until(card, eval, true)
      end
      return {
        message = (card.ability.extra.current_rounds < card.ability.extra.rounds_required) and (card.ability.extra.current_rounds..'/'..card.ability.extra.rounds_required) or localize('k_active_ex'),
        colour = G.C.FILTER
      }
    end

    if context.buying_card and context.card.config.center.set == "Joker" and card.ability.extra.current_rounds >= card.ability.extra.rounds_required then
      local eval = function(card) return (card.ability.extra.current_rounds == card.ability.extra.rounds_required) and not G.RESET_JIGGLES end juice_card_until(card, eval, true)
      if #G.jokers.cards <= G.jokers.config.card_limit then 
        card_eval_status_text(context.blueprint_card or card, 'extra', nil, nil, nil, {message = localize('k_duplicated_ex')})
        local new_card = copy_card(context.card, nil, nil, nil, context.card.edition and context.card.edition.negative)
        card.ability.extra.current_rounds = 0
        G.E_MANAGER:add_event(Event({
          func = function()
            play_sound('tarot1')
            card.T.r = -0.2
            card:juice_up(0.3, 0.4)
            card.states.drag.is = true
            card.children.center.pinch.x = true
            G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.3, blockable = false,
              func = function()
                  G.jokers:remove_card(card)
                  card:remove()
                  card = nil
                return true; end})) 
            return true
          end
        }))
        card:add_to_deck()
        G.jokers:emplace(card)
      else
        card_eval_status_text(context.blueprint_card or card, 'extra', nil, nil, nil, {message = localize('k_no_room_ex')})
      end
    end
  end,
  set_ability = function(self, card, initial, delay_sprites)
    card.ability.extra.current_rounds = 0
  end
}

SMODS.Joker {
  key = 'caniossoul',
  config = { extra = { lost_xmult = 0.5, current_xmult = 3 } },
  rarity = 3,
  atlas = 'Phanta',
  pos = { x = 4, y = 6 },
  cost = 8,
  blueprint_compat = true,
  loc_vars = function(self, info_queue, card)
    return { vars = { card.ability.extra.lost_xmult, card.ability.extra.current_xmult } }
  end,
  calculate = function(self, card, context)
    if context.joker_main and card.ability.extra.current_xmult > 1 then
      return { xmult = card.ability.extra.current_xmult }
    end
	
    if context.cardarea == G.jokers and context.before and not context.blueprint then
      local faces = false
      for i = 1, #context.scoring_hand do
        if context.scoring_hand[i]:is_face() then faces = true end
      end
      if faces then
	    card.ability.extra.current_xmult = card.ability.extra.current_xmult - card.ability.extra.lost_xmult
        if card.ability.extra.current_xmult <= 1 then 
          G.E_MANAGER:add_event(Event({
            func = function()
              play_sound('tarot1')
              card.T.r = -0.2
              card:juice_up(0.3, 0.4)
              card.states.drag.is = true
              card.children.center.pinch.x = true
              G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.3, blockable = false,
                func = function()
                    G.jokers:remove_card(card)
                    card:remove()
                    card = nil
                  return true; end})) 
              return true
            end
          })) 
          return {
            message = "Drained!",
            colour = G.C.FILTER
          }
        else
          return {
            message = localize{type='variable',key='a_xmult_minus',vars={card.ability.extra.lost_xmult}},
            colour = G.C.MULT
          }
        end
      end
    end
  end
}

SMODS.Joker {
  key = 'tribouletssoul',
  config = { extra = { given_xmult = 3, remaining_hands = 2, added_hands = 2  } },
  rarity = 3,
  atlas = 'Phanta',
  pos = { x = 5, y = 6 },
  cost = 8,
  blueprint_compat = true,
  loc_vars = function(self, info_queue, card)
    return { vars = { card.ability.extra.given_xmult, card.ability.extra.remaining_hands, (function() if card.ability.extra.remaining_hands == 1 then return "" else return "s" end end)(), card.ability.extra.added_hands } }
  end,
  calculate = function(self, card, context)
    if context.joker_main then
      return { xmult = card.ability.extra.given_xmult }
    end
	
    if context.cardarea == G.jokers and context.before and not context.blueprint then
      local kings = false
      local queens = false
      for i = 1, #context.scoring_hand do
        if context.scoring_hand[i]:get_id() == 12 then queens = true end
        if context.scoring_hand[i]:get_id() == 13 then kings = true end
      end
      if kings and queens then
	      card.ability.extra.remaining_hands = card.ability.extra.remaining_hands + card.ability.extra.added_hands
        return {
          message = "+"..card.ability.extra.added_hands.." Hands",
          colour = G.C.BLUE
        }
      end
	  end

    if context.cardarea == G.jokers and context.after and not context.blueprint then
	    card.ability.extra.remaining_hands = card.ability.extra.remaining_hands - 1
      if card.ability.extra.remaining_hands == 0 then 
        G.E_MANAGER:add_event(Event({
          func = function()
            play_sound('tarot1')
            card.T.r = -0.2
            card:juice_up(0.3, 0.4)
            card.states.drag.is = true
            card.children.center.pinch.x = true
            G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.3, blockable = false,
              func = function()
                G.jokers:remove_card(card)
                card:remove()
                card = nil
              return true; end})) 
            return true
          end
        })) 
        return {
          message = "Drained!",
          colour = G.C.FILTER
        }
		  else
        return {
          message = card.ability.extra.remaining_hands.."",
          colour = G.C.FILTER
        }
      end
    end
  end
}

SMODS.Joker {
  key = 'perkeossoul',
  config = { extra = { lost_xmult = 0.5, current_xmult = 3 } },
  rarity = 3,
  atlas = 'Phanta',
  pos = { x = 2, y = 7 },
  cost = 8,
  blueprint_compat = true,
  loc_vars = function(self, info_queue, card)
    return { vars = { card.ability.extra.lost_xmult, card.ability.extra.current_xmult } }
  end,
  calculate = function(self, card, context)
    if context.joker_main and card.ability.extra.current_xmult > 1 then
      return { xmult = card.ability.extra.current_xmult }
    end
	
    if context.end_of_round and not context.individual and not context.repetition and #G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit then
	    card.ability.extra.current_xmult = card.ability.extra.current_xmult - card.ability.extra.lost_xmult
        if card.ability.extra.current_xmult <= 1 then 
          G.E_MANAGER:add_event(Event({
            func = function()
              play_sound('tarot1')
              card.T.r = -0.2
              card:juice_up(0.3, 0.4)
              card.states.drag.is = true
              card.children.center.pinch.x = true
              G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.3, blockable = false,
                func = function()
                    G.jokers:remove_card(card)
                    card:remove()
                    card = nil
                  return true; end})) 
              return true
            end
          })) 
          return {
            message = "Drained!",
            colour = G.C.FILTER
          }
        else
          return {
            message = localize{type='variable',key='a_xmult_minus',vars={card.ability.extra.lost_xmult}},
            colour = G.C.MULT
          }
        end
      end
    end
}

SMODS.Joker {
  key = 'possession',
  config = { extra = { odds = 13 } },
  rarity = 3,
  atlas = 'Phanta',
  pos = { x = 8, y = 0 },
  soul_pos = { x = 9, y = 0 },
  cost = 8,
  blueprint_compat = true,
  loc_vars = function(self, info_queue, card)
    return { vars = { (G.GAME.probabilities.normal or 1), card.ability.extra.odds } }
  end,
  calculate = function(self, card, context)
    if context.buying_card and context.card.config.center.set == "Joker" and not context.card.edition and pseudorandom('possession') < G.GAME.probabilities.normal / card.ability.extra.odds then
      G.E_MANAGER:add_event(Event({
        func = function()
          context.card:set_edition{negative = true}
		      card_eval_status_text(card, 'extra', nil, nil, nil, { message = "Possessed!" })
          return true
        end
      })) 
    end
  end
}

--[[SMODS.Joker {
  key = 'shackles',
  loc_txt = {
    name = 'Shackles',
    text = {
     "{C:chips}+#1#{} Chips,",
     "forces 1 card to",
     "always be selected"
    }
  },
  config = { extra = { chips = 250 } },
  rarity = 3,
  atlas = 'Phanta',
  pos = { x = 5, y = 5 },
  cost = 8,
  loc_vars = function(self, info_queue, card)
    return { vars = { card.ability.extra.chips } }
  end,
  blueprint_compat = true,
  calculate = function(self, card, context)
    if context.joker_main then
      return {
        chip_mod = card.ability.extra.chips,
        message = localize { type = 'variable', key = 'a_chips', vars = { card.ability.extra.chips } }
      }
    end
    if context.drawn_to_hand then
      local any_forced = nil
      for i, j in ipairs(G.hand.cards) do
          if j.ability.forced_selection then
              any_forced = true
          end
      end
      if not any_forced then 
          G.hand:unhighlight_all()
          local forced_card = pseudorandom_element(G.hand.cards, pseudoseed('shackles'))
          forced_card.ability.forced_selection = true
          G.hand:add_to_highlighted(forced_card)
      end
    end
  end
}]]--

SMODS.Joker {
  key = 'ignaize',
  config = { extra = { current_xmult = 1, added_xmult = 0.1 } },
  rarity = 4,
  atlas = 'Phanta',
  pos = { x = 2, y = 1 },
  soul_pos = { x = 3, y = 2 },
  cost = 20,
  loc_vars = function(self, info_queue, card)
    return { vars = { card.ability.extra.added_xmult, card.ability.extra.current_xmult } }
  end,
	blueprint_compat = true,
  calculate = function(self, card, context)
  if context.joker_main and card.ability.extra.current_xmult > 1 then
      return {
        Xmult_mod = card.ability.extra.current_xmult,
        message = localize { type = 'variable', key = 'a_xmult', vars = { card.ability.extra.current_xmult } }
      }
    end
  if context.selling_card and context.card.config.center.set ~= "Joker" then
		card.ability.extra.current_xmult = card.ability.extra.current_xmult + card.ability.extra.added_xmult
      card_eval_status_text(card, 'extra', nil, nil, nil,
        { message = localize("k_upgrade_ex") })
      return true
  end
  end
}

SMODS.Joker {
  key = 'dimere',
  config = { extra = { cards_turned = 1 } },
  rarity = 4,
  atlas = 'Phanta',
  pos = { x = 3, y = 1 },
  soul_pos = { x = 4, y = 2 },
  cost = 20,
  loc_vars = function(self, info_queue, card)
    info_queue[#info_queue+1] = G.P_CENTERS.e_negative
    return {  }
  end,
  loc_vars = function(self, info_queue, card)
    return { vars = { card.ability.extra.cards_turned } }
  end,
	blueprint_compat = true,
  calculate = function(self, card, context)
	if context.end_of_round and not context.individual and not context.repetition and G.GAME.blind.boss then
	
		--Check if the ability should trigger (i.e. there are valid, non-Dimere Jokers)
		
		local candidates = {}
		for i = 1, #G.jokers.cards do
			if G.jokers.cards[i].ability.name ~= card.ability.name and G.jokers.cards[i].ability.set == "Joker" and G.jokers.cards[i].edition == nil then
				candidates[#candidates + 1] = G.jokers.cards[i]
			end
		end
		
		if not candidates then
			return nil
		end
		
		pseudorandom_element(candidates, pseudoseed("dimere")):set_edition{negative = true}
		card_eval_status_text(card, 'extra', nil, nil, nil,
        { message = "+Negative" })
		
	end
  end
}

SMODS.Joker {
  key = 'goldor',
  config = { extra = { money = 3, xmult = 3 } },
  rarity = 4,
  atlas = 'Phanta',
  pos = { x = 4, y = 1 },
  soul_pos = { x = 5, y = 2 },
  cost = 20,
  loc_vars = function(self, info_queue, card)
    info_queue[#info_queue+1] = G.P_CENTERS.m_gold
    return { vars = { card.ability.extra.xmult, card.ability.extra.money } }
  end,
  blueprint_compat = true,
  calculate = function(self, card, context)
	if context.individual and context.cardarea == G.play and context.other_card.ability.name == 'Gold Card' then
        G.GAME.dollar_buffer = (G.GAME.dollar_buffer or 0) + card.ability.extra.money
        G.E_MANAGER:add_event(Event({func = (function() G.GAME.dollar_buffer = 0; return true end)}))
        return {
			dollars = card.ability.extra.money,
			x_mult = card.ability.extra.xmult,
			colour = G.C.RED,
			card = card
		}
	end
  end
}

SMODS.Joker {
  key = 'famalia',
  rarity = 4,
  atlas = 'Phanta',
  pos = { x = 5, y = 1 },
  soul_pos = { x = 0, y = 3 },
  cost = 20,
  loc_vars = function(self, info_queue, card)
    --info_queue[#info_queue+1] = G.P_CENTERS.
    return { }
  end,
  blueprint_compat = true,
  calculate = function(self, card, context)
	if context.first_hand_drawn then
		G.E_MANAGER:add_event(Event({
            func = function() 
				local _suit = pseudorandom_element({'S','H','D','C'}, pseudoseed('famaliasu'))
                local _card = create_playing_card({front = G.P_CARDS[_suit..'_K'], center = G.P_CENTERS.c_base}, G.hand, nil, nil, {G.C.SECONDARY_SET.Enhanced})
                _card:set_seal('Purple', true)
				
				local edition = pseudorandom(pseudoseed('famaliaed'))
				if edition < 0.5 then _card:set_edition('e_foil')
				elseif edition < 0.85 then _card:set_edition('e_holo')
				else _card:set_edition('e_polychrome') end
                
                G.GAME.blind:debuff_card(_card)
                G.hand:sort()
                if context.blueprint_card then context.blueprint_card:juice_up() else card:juice_up() end
                return true
            end}))

        playing_card_joker_effects({true})
	end
  end
}

SMODS.Joker {
  key = 'godoor',
  config = { extra = { added_xmult = 1, current_xmult = 1, counted_rerolls = 0 } },
  rarity = 4,
  atlas = 'Phanta',
  pos = { x = 0, y = 2 },
  soul_pos = { x = 1, y = 3 },
  cost = 20,
  loc_vars = function(self, info_queue, card)
    return { vars = { card.ability.extra.added_xmult, card.ability.extra.current_xmult } }
  end,
  blueprint_compat = true,
  calculate = function(self, card, context)
    if context.joker_main and card.ability.extra.current_xmult > 1 then
	  return { xmult = card.ability.extra.current_xmult }
	end
	
	if context.reroll_shop and not context.blueprint then
	  card.ability.extra.counted_rerolls = card.ability.extra.counted_rerolls + 1
	  if card.ability.extra.counted_rerolls == 1 then
	    return {
		  message = "Upgrade?",
		  colour = G.C.FILTER,
		  card = card
		}
	  elseif card.ability.extra.counted_rerolls == 2 then
	    return {
		  message = "Nevermind!",
		  colour = G.C.RED,
		  card = card
		}
	  end
	end
	
	if context.ending_shop and not context.blueprint then
	  if card.ability.extra.counted_rerolls == 1 then
	    card.ability.extra.current_xmult = card.ability.extra.current_xmult + card.ability.extra.added_xmult
	    card.ability.extra.counted_rerolls = 0
	    return {
		  message = localize('k_upgrade_ex'),
		  colour = G.C.FILTER,
		  card = card
		}
	  end
	  card.ability.extra.counted_rerolls = 0
	end
  end
}

SMODS.Joker {
  key = 'fainfol',
  config = { extra = { xmult = 1.5 } },
  rarity = 4,
  atlas = 'Phanta',
  pos = { x = 1, y = 2 },
  soul_pos = { x = 2, y = 3 },
  cost = 20,
  loc_vars = function(self, info_queue, card)
    return { vars = { 
	localize(G.GAME.current_round.fainfol_card.suit, 'suits_singular'),
	card.ability.extra.xmult,
	colours = {G.C.SUITS[G.GAME.current_round.fainfol_card.suit]}
	} }
  end,
  blueprint_compat = true,
  calculate = function(self, card, context)
	if context.cardarea == G.hand and context.other_card and context.other_card:is_suit(G.GAME.current_round.fainfol_card.suit) then
        if context.other_card.debuff then
            return {
                message = localize('k_debuffed'),
                colour = G.C.RED,
                card = card,
            }
        else
            return {
                x_mult = card.ability.extra.xmult,
                card = card
            }
        end
	
	end
  end
}

local igo = Game.init_game_object
function Game:init_game_object()
  local ret = igo(self)
  ret.current_round.train_station_card = { rank = nil } 
  ret.current_round.fainfol_card = { suit = 'Spades' } 
  return ret
end

function SMODS.current_mod.reset_game_globals(run_start)
  G.GAME.current_round.fainfol_card = { suit = 'Spades' }
  local valid_cards = {}
  for i, j in ipairs(G.playing_cards) do
    if not SMODS.has_no_suit(j) then
        valid_cards[#valid_cards + 1] = j
    end
  end
  if valid_cards[1] then 
      local chosen_card = pseudorandom_element(valid_cards, pseudoseed('fainfol'..G.GAME.round_resets.ante))
      G.GAME.current_round.fainfol_card.suit = chosen_card.base.suit
  end
  if not G.GAME.current_round.train_station_card.rank then
    G.GAME.current_round.train_station_card.rank = 2
  elseif G.GAME.current_round.train_station_card.rank == 14 then
	G.GAME.current_round.train_station_card.rank = 2
	else
	G.GAME.current_round.train_station_card.rank = G.GAME.current_round.train_station_card.rank + 1
	end
end