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
    if G.consumeables.cards then
      for _, card in pairs(G.consumeables.cards) do
        if card.ability.set == "Tarot" then
          tarot_counter = tarot_counter + 1
        end
      end
    end
    return tarot_counter
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
]]

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
    name = 'Looking Cool, Joker',
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
  key = 'introspection',
  loc_txt = {
    name = 'Introspection',
    text = {
      "When {C:attention}Blind{} is selected,",
      "creates a #1#{} card and",
      "changes type to #2#s{}",
      "{C:inactive}(Must have room){}"
    }
  },
  config = { extra = { chosen_type = 0 } },
  rarity = 2,
  atlas = 'Phanta',
  pos = { x = 0, y = 1 },
  cost = 6,
  loc_vars = function(self, info_queue, card)
    return { vars = { ({'{C:tarot}Tarot', '{C:planet}Planet'})[card.ability.extra.chosen_type + 1], ({'{C:planet}Planet', '{C:tarot}Tarot'})[card.ability.extra.chosen_type + 1] } }
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

--[[SMODS.Joker {
  key = 'blindjoker',
  loc_txt = {
    name = 'Blind Joker',
    text = {
      "{C:attention}+#1#{} hand size,",
      "{C:attention}+#2#{} discards,",
      "{C:green}1 in #3#{} cards are",
      "drawn {C:attention}face down{}"
    }
  },
  config = { extra = { added_hand_size = 2, added_discards = 2, flipped_probability = 2 } },
  rarity = 2,
  atlas = 'Phanta',
  pos = { x = 1, y = 1 },
  cost = 6,
  loc_vars = function(self, info_queue, card)
    return { vars = { ({'{C:tarot}Tarot', '{C:planet}Planet'})[card.ability.extra.chosen_type + 1], ({'{C:planet}Planet', '{C:tarot}Tarot'})[card.ability.extra.chosen_type + 1] } }
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
	  "{C:inactive}or cards with editions){}"
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
	  "each give {C:white,X:mult}X#1#{} Mult",
	  "when scored"
    }
  },
  config = { extra = { xmult = 2 } },
  rarity = 4,
  atlas = 'Phanta',
  pos = { x = 3, y = 1 },
  soul_pos = { x = 4, y = 2 },
  cost = 20,
  loc_vars = function(self, info_queue, card)
    return { vars = { card.ability.extra.xmult } }
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