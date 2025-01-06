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
    name = 'Persona 5 Joker',
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