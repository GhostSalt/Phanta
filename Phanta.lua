SMODS.Atlas {
  -- Key for code to find it with
  key = "Phanta",
  -- The name of the file, for the code to pull the atlas from
  path = "Phanta.png",
  -- Width of each sprite in 1x size
  px = 71,
  -- Height of each sprite in 1x size
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
  loc_txt = {
    name = 'Bootleg',
    text = {
      "{C:chips}+#1#{} Chips,",
      "{C:mult}+#2#{} Mult"
    }
  },
  config = { extra = { chips = 30, mult = 2 } },
  loc_vars = function(self, info_queue, card)
    return { vars = { card.ability.extra.chips, card.ability.extra.mult } }
  end,
  rarity = 1,
  atlas = 'Phanta',
  pos = { x = 4, y = 8 },
  cost = 2,
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
  loc_txt = {
    name = 'Train Station',
    text = {
      "Gains {C:mult}+#1#{} Mult for each",
	  "played {C:attention}#2#{}, rank changes",
	  "each round",
	  "{C:inactive}(Currently {C:mult}+#3#{C:inactive} Mult){}"
    }
  },
  config = { extra = { added_mult = 2, current_mult = 0 } },
  loc_vars = function(self, info_queue, card)
    return { vars = { card.ability.extra.added_mult, G.GAME.current_round.train_station_card.rank, card.ability.extra.current_mult } }
  end,
  rarity = 1,
  atlas = 'Phanta',
  pos = { x = 5, y = 8 },
  cost = 6,
  calculate = function(self, card, context)
    if context.joker_main then
		return {
			mult = card.ability.extra.current_mult,
		}
    end
	if context.individual and context.cardarea == G.play and context.other_card:get_id() == G.GAME.current_round.train_station_card.rank then
		card.ability.extra.current_mult = card.ability.extra.current_mult + card.ability.extra.added_mult
		return {
			message = localize('k_upgrade_ex'),
			card = card
		}
	end
  end
}

SMODS.Joker {
  key = 'oracle',
  loc_txt = {
    name = 'Oracle',
    text = {
      "{C:attention}+1{} consumable slot"
    }
  },
  rarity = 1,
  atlas = 'Phanta',
  pos = { x = 2, y = 8 },
  cost = 4,
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
  loc_txt = {
    name = 'Thief',
    text = {
      "{C:blue}+1{} hand",
      "each round"
    }
  },
  rarity = 1,
  atlas = 'Phanta',
  pos = { x = 3, y = 8 },
  cost = 4,
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
  key = 'ghostjoker',
  loc_txt = {
    name = 'Ghost',
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

SMODS.Joker {
  key = 'layton',
  loc_txt = {
    name = 'Layton',
    text = {
      "{C:green}#1# in #2#{} chance to",
      "give {C:mult}+#3#{} Mult,",
      "held {C:tarot}Tarot{} cards",
      "increase the odds",
      "{C:inactive,s:0.75}(Guaranteed if with Luke){}"
    }
  },
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
  loc_txt = {
    name = 'Luke',
    text = {
      "{C:green}#1# in #2#{} chance to",
      "give {X:mult,C:white}X#3#{} Mult,",
      "held {C:planet}Planet{} cards",
      "increase the odds",
      "{C:inactive,s:0.75}(Guaranteed if with Layton){}"
    }
  },
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
  loc_txt = {
    name = 'Candle',
    text = {
      "When {C:attention}Blind{} is selected,",
	  "destroys 1 {C:tarot}Tarot{} card",
	  "and gains {C:white,X:mult}X#1#{} Mult",
	  "{C:inactive}(Currently {C:white,X:mult}X#2#{C:inactive} Mult){}"
    }
  },
  config = { extra = { added_xmult = 0.2, current_xmult = 1 } },
  rarity = 2,
  atlas = 'Phanta',
  pos = { x = 5, y = 7 },
  cost = 7,
  blueprint_compat = true,
  loc_vars = function(self, info_queue, card)
    return { vars = { card.ability.extra.added_xmult, card.ability.extra.current_xmult + 1 } }
  end,
  calculate = function(self, card, context)
    if context.setting_blind and not (context.blueprint_card or self).getting_sliced then
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
				if not (context.blueprint_card or self).getting_sliced then
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
  key = 'identity',
  loc_txt = {
    name = 'Identity',
    text = {
      "Create #1# {C:dark_edition}Negative{}",
      "{C:spectral}Spectral{} cards at",
      "the end of the {C:attention}shop",
      "{C:red,E:2}self destructs{}"
    }
  },
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
          play_sound('glass' .. pseudorandom_element({'1', '2', '3', '4', '5', '6'}))
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
  key = 'p5joker',
  loc_txt = {
    name = 'Looking Cool, Joker!',
    text = {
      "Gains {C:mult}+#1#{} Mult per hand",
      "played that is not your",
      "most played {C:attention}poker hand{}",
      "{C:inactive}(Currently {C:mult}+#2#{C:inactive} Mult)"
    }
  },
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
  loc_txt = {
    name = 'Crescent',
    text = {
      "Creates a {C:tarot}Tarot{} card when",
      "a {C:planet}Planet{} card is sold",
      "{C:inactive}(Must have room){}"
    }
  },
  rarity = 1,
  atlas = 'Phanta',
  pos = { x = 3, y = 0 },
  cost = 4,
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
          return true;
        end
      }))
			
			return nil, true
    end
  end
}

SMODS.Joker {
  key = 'goldenfiddle',
  loc_txt = {
    name = 'Golden Fiddle',
    text = {
      "When {C:attention}Blind{} is selected,",
      "creates a copy of",
      "{C:tarot}The Devil{} or {C:tarot}The Chariot{}",
      "{C:inactive}(Must have room){}"
    }
  },
  rarity = 2,
  atlas = 'Phanta',
  pos = { x = 4, y = 0 },
  cost = 6,
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
  loc_txt = {
    name = 'Reverie',
    text = {
      "When {C:attention}Blind{} is selected,",
      "creates a copy of",
      "{C:tarot}The Heirophant{} or {C:tarot}Temperance{}",
      "{C:inactive}(Must have room){}"
    }
  },
  rarity = 2,
  atlas = 'Phanta',
  pos = { x = 5, y = 0 },
  cost = 6,
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
  loc_txt = {
    name = 'S.E.E.S.',
    text = {
      "When {C:attention}Blind{} is selected,",
      "creates a copy of",
      "{C:tarot}The Moon{}",
      "{C:inactive}(Must have room){}"
    }
  },
  rarity = 2,
  atlas = 'Phanta',
  pos = { x = 2, y = 4 },
  cost = 6,
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
  key = 'caesarcipher',
  loc_txt = {
    name = 'Caesar Cipher',
    text = {
      "When {C:attention}Blind{} is selected,",
      "creates a {C:planet}Planet{} card or",
      "a copy of {C:tarot}Strength{}",
      "{C:inactive}(Must have room){}"
    }
  },
  rarity = 2,
  atlas = 'Phanta',
  pos = { x = 5, y = 4 },
  cost = 6,
	blueprint_compat = true,
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
  loc_txt = {
    name = 'Timepiece',
    text = {
      "On {C:attention}final hand{} of",
      "round, creates a",
      "copy of {C:tarot}Death{}",
      "{C:inactive}(Must have room){}"
    }
  },
  rarity = 2,
  atlas = 'Phanta',
  pos = { x = 3, y = 4 },
  cost = 6,
	blueprint_compat = true,
  calculate = function(self, card, context)
    if context.cardarea == G.jokers and context.before and G.GAME.current_round.hands_left == 0 and not (context.blueprint_card or self).getting_sliced and #G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit then
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
  loc_txt = {
    name = 'Introspection',
    text = {
      "When {C:attention}Blind{} is selected,",
      "creates a {V:1}#1#{} card and",
      "changes type to {V:2}#2#{}",
      "{C:inactive}(Must have room){}"
    }
  },
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
    if context.setting_blind and not (context.blueprint_card or self).getting_sliced and #G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit then
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
          card_eval_status_text(context.blueprint_card or self, 'extra', nil, nil, nil, {message = localize(({'k_plus_tarot', 'k_plus_planet'})[card.ability.extra.chosen_type + 1]), colour = ({G.C.PURPLE, G.C.BLUE})[card.ability.extra.chosen_type + 1]})                       
        return true
      end)}))
    end
  end
}

SMODS.Joker {
  key = 'blindjoker',
  loc_txt = {
    name = 'Blind Joker',
    text = {
      "Creates the {C:planet}Planet{} card",
	  "for hands that contain",
	  "exactly #1# {C:attention}Aces{}",
	  "{C:inactive}(Must have room){}"
    }
  },
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
  key = 'modernart',
  loc_txt = {
    name = 'Modern Art',
    text = {
     "Gains {C:money}$#1#{} of",
     "{C:attention}sell value{} per",
     "{C:attention}High Card{} played"
    }
  },
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
    if context.before and next(context.poker_hands['High Card']) and not context.blueprint then
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
  loc_txt = {
    name = 'Conspiracist',
    text = {
     "{C:green}#1# in #2#{} chance to create",
	 "a copy of {C:blue}Earth{} if",
	 "played hand is a Full House",
	 "{C:inactive}(Must have room){}"
    }
  },
  config = { extra = { odds = 2 } },
  rarity = 1,
  atlas = 'Phanta',
  pos = { x = 0, y = 5 },
  cost = 5,
  loc_vars = function(self, info_queue, card)
    return { vars = { (G.GAME.probabilities.normal or 1), card.ability.extra.odds } }
  end,
  blueprint_compat = true,
  calculate = function(self, card, context)
    if context.cardarea == G.jokers and context.before and not (context.blueprint_card or self).getting_sliced and #G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit
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
  key = 'eyeofprovidence',
  loc_txt = {
    name = 'Eye of Providence',
    text = {
     "Each played",
	 "{C:attention}Ace of Spades{} gives",
	 "{C:white,X:mult}X#1#{} Mult when scored{}"
    }
  },
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
  loc_txt = {
    name = 'Emotional Damage',
    text = {
     "Gains {C:white,X:mult}X#1#{} Mult per",
     "discarded {C:attention}Flush{}",
     "{C:inactive}(Currently {C:white,X:mult}X#2#{C:inactive} Mult)"
    }
  },
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
    elseif context.end_of_round and not context.blueprint and not context.repetition then
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
  loc_txt = {
    name = 'The Spear',
    text = {
     "If played hand contains",
	 "a {C:spades}Spade{}, destroy it",
	 "and upgrade {C:attention}Straight{}"
    }
  },
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
				level_up_hand(self, "Straight", nil, 1)
				update_hand_text({sound = 'button', volume = 0.7, pitch = 0.8, delay = 0.3}, {handname=context.scoring_name,chips = G.GAME.hands[context.scoring_name].chips, mult = G.GAME.hands[context.scoring_name].mult, level=G.GAME.hands[context.scoring_name].level})
				return nil, true
			end
    end
  end
}

SMODS.Joker {
  key = 'thefuse',
  loc_txt = {
    name = 'The Fuse',
    text = {
     "If played hand contains",
	 "a {C:hearts}Heart{}, destroy it",
	 "and gain {C:white,X:mult}X#1#{} Mult",
	 "{C:inactive}(Currently {C:white,X:mult}X#2#{C:inactive} Mult){}"
    }
  },
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
				if not (context.blueprint_card or self).getting_sliced then
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
  loc_txt = {
    name = 'The Mace',
    text = {
     "If played hand contains",
	 "a {C:clubs}Club{}, destroy it",
	 "and gain {C:money}$#1#{}"
    }
  },
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
  loc_txt = {
    name = 'The Dagger',
    text = {
     "If played hand contains",
	 "a {C:diamonds}Diamond{}, destroy it",
	 "and gain {C:mult}+#1#{} Mult",
	 "{C:inactive}(Currently {C:mult}+#2#{C:inactive} Mult){}"
    }
  },
  config = { extra = { added_mult = 10, current_mult = 0 } },
  rarity = 3,
  atlas = 'Phanta',
  pos = { x = 3, y = 6 },
  cost = 8,
  blueprint_compat = true,
  loc_vars = function(self, info_queue, card)
    return { vars = { card.ability.extra.added_mult, card.ability.extra.current_mult } }
  end,
  calculate = function(self, card, context)
  if context.joker_main and card.ability.extra.current_mult > 0 then
      return {
        mult_mod = card.ability.extra.current_mult,
        message = localize { type = 'variable', key = 'a_mult', vars = { card.ability.extra.current_mult } }
      }
    end
    if context.cardarea == G.jokers and context.before then
      local destructable_card = {}
			for i = 1, #context.scoring_hand do
				if context.scoring_hand[i]:is_suit("Diamonds") and not context.scoring_hand[i].getting_sliced then
					destructable_card[#destructable_card + 1] = context.scoring_hand[i]
				end
			end
			local card_to_destroy = #destructable_card > 0 and pseudorandom_element(destructable_card, pseudoseed("thedagger")) or nil

			if card_to_destroy then
				card_to_destroy.getting_sliced = true
				card.ability.extra.current_mult = card.ability.extra.current_mult + card.ability.extra.added_mult
				G.E_MANAGER:add_event(Event({
					func = function()
						(context.blueprint_card or card):juice_up(0.8, 0.8)
						card_to_destroy:start_dissolve({ G.C.RED }, nil, 1.6)
						return true
					end,
				}))
				if not (context.blueprint_card or self).getting_sliced then
						card_eval_status_text(context.blueprint_card or card, "extra", nil, nil, nil, {
							message = localize{ type='variable', key='a_mult', vars={number_format(to_big(card.ability.extra.current_mult))}}
						}
					)
				end
				return nil, true
			end
    end
  end
}

--[[SMODS.Joker {
  key = 'caniossoul',
  loc_txt = {
    name = 'Canio\'s Soul',
    text = {
     "If played hand contains",
	 "a {C:diamonds}Diamond{}, destroy it",
	 "and gain {C:mult}+#1#{} Mult",
	 "{C:inactive}(Currently {C:mult}+#2#{C:inactive} Mult){}"
    }
  },
  config = { extra = { added_mult = 10, current_mult = 0 } },
  rarity = 3,
  atlas = 'Phanta',
  pos = { x = 3, y = 6 },
  cost = 8,
  blueprint_compat = true,
  loc_vars = function(self, info_queue, card)
    return { vars = { card.ability.extra.added_mult, card.ability.extra.current_mult } }
  end,
  calculate = function(self, card, context)
  if context.joker_main and card.ability.extra.current_mult > 0 then
      return {
        mult_mod = card.ability.extra.current_mult,
        message = localize { type = 'variable', key = 'a_mult', vars = { card.ability.extra.current_mult } }
      }
    end
    if context.cardarea == G.jokers and context.before then
      local destructable_card = {}
			for i = 1, #context.scoring_hand do
				if context.scoring_hand[i]:is_suit("Diamonds") and not context.scoring_hand[i].getting_sliced then
					destructable_card[#destructable_card + 1] = context.scoring_hand[i]
				end
			end
			local card_to_destroy = #destructable_card > 0 and pseudorandom_element(destructable_card, pseudoseed("thedagger")) or nil

			if card_to_destroy then
				card_to_destroy.getting_sliced = true
				card.ability.extra.current_mult = card.ability.extra.current_mult + card.ability.extra.added_mult
				G.E_MANAGER:add_event(Event({
					func = function()
						(context.blueprint_card or card):juice_up(0.8, 0.8)
						card_to_destroy:start_dissolve({ G.C.RED }, nil, 1.6)
						return true
					end,
				}))
				if not (context.blueprint_card or self).getting_sliced then
						card_eval_status_text(context.blueprint_card or card, "extra", nil, nil, nil, {
							message = localize{ type='variable', key='a_mult', vars={number_format(to_big(card.ability.extra.current_mult))}}
						}
					)
				end
				return nil, true
			end
    end
  end
}]]--

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
  loc_txt = {
    name = 'Ignaize',
    text = {
      "Gains {X:mult,C:white}X#1#{} Mult when a",
	  "{C:attention}consumable{} card is {C:attention}sold{}",
	  "{C:inactive}(Currently {X:mult,C:white}X#2#{C:inactive} Mult)"
    }
  },
  config = { extra = { current_xmult = 1, added_xmult = 0.2 } },
  rarity = 4,
  atlas = 'Phanta',
  pos = { x = 2, y = 1 },
  soul_pos = { x = 3, y = 2 },
  cost = 20,
  loc_vars = function(self, info_queue, card)
    return { vars = { card.ability.extra.added_xmult, card.ability.extra.current_xmult,  } }
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
  loc_txt = {
    name = 'Dimere',
    text = {
      "When {C:attention}Boss Blind{} is defeated,",
      "#1# random {C:attention}Joker{} becomes",
      "{C:negative}Negative{} {C:inactive}(except Dimeres{}",
	  "{C:inactive}or Jokers with editions){}"
    }
  },
  config = { extra = { cards_turned = 1 } },
  rarity = 4,
  atlas = 'Phanta',
  pos = { x = 3, y = 1 },
  soul_pos = { x = 4, y = 2 },
  cost = 20,
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
  loc_txt = {
    name = 'Goldor',
    text = {
      "Played {C:attention}Gold{} cards",
	  "each give {C:money}$#2#{} and",
	  "{C:white,X:mult}X#1#{} Mult when scored"
    }
  },
  config = { extra = { money = 3, xmult = 3 } },
  rarity = 4,
  atlas = 'Phanta',
  pos = { x = 4, y = 1 },
  soul_pos = { x = 5, y = 2 },
  cost = 20,
  loc_vars = function(self, info_queue, card)
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
  loc_txt = {
    name = 'Famalia',
    text = {
     "When {C:attention}Blind{} is selected,",
	 "add a {C:attention}King{} with a",
	 "{C:purple}Purple seal{} and edition",
	 "to your hand"
    }
  },
  rarity = 4,
  atlas = 'Phanta',
  pos = { x = 5, y = 1 },
  soul_pos = { x = 0, y = 3 },
  cost = 20,
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
  loc_txt = {
    name = 'Godoor',
    text = {
     "When {C:attention}Blind{} is selected,",
	 "add a {C:attention}King{} with a",
	 "{C:purple}Purple seal{} and edition",
	 "to your hand"
    }
  },
  config = { extra = { money = 2, xmult = 2 } },
  rarity = 4,
  atlas = 'Phanta',
  pos = { x = 0, y = 2 },
  soul_pos = { x = 1, y = 3 },
  cost = 20,
  loc_vars = function(self, info_queue, card)
    return { vars = { card.ability.extra.xmult, card.ability.extra.money } }
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
  key = 'fainfol',
  loc_txt = {
    name = 'Fainfol',
    text = {
      "Each {V:1}#1#{} card held",
      "in hand gives {C:white,X:mult}X#2#{} Mult,",
      "suit changes every round"
    }
  },
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
  ret.current_round.train_station_card = { rank = 2 } 
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
  if G.GAME.current_round.train_station_card.rank == 14 then
	G.GAME.current_round.train_station_card.rank = 2
	else
	G.GAME.current_round.train_station_card.rank = G.GAME.current_round.train_station_card.rank + 1
	end
end