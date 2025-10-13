G.Phanta.centers["ignaize"] = {
  unlocked = false,
  config = { extra = { current_xmult = 1, added_xmult = 0.1 } },
  rarity = 4,
  atlas = 'Phanta',
  pos = { x = 2, y = 1 },
  soul_pos = {
    x = 3,
    y = 2
  },
  phanta_shiny_soul = true,
  cost = 20,
  loc_vars = function(self, info_queue, card)
    return { vars = { card.ability.extra.added_xmult, card.ability.extra.current_xmult } }
  end,
  blueprint_compat = true,
  eternal_compat = true,
  perishable_compat = false,
  calculate = function(self, card, context)
    if context.joker_main and card.ability.extra.current_xmult > 1 then
      return { xmult = card.ability.extra.current_xmult }
    end
    if context.selling_card and context.card.config.center.set ~= "Joker" and not context.blueprint then
      card.ability.extra.current_xmult = card.ability.extra.current_xmult + card.ability.extra.added_xmult
      card_eval_status_text(card, 'extra', nil, nil, nil, { message = localize("k_upgrade_ex") })
      return true
    end
  end
}

G.Phanta.centers["dimere"] = {
  unlocked = false,
  rarity = 4,
  atlas = 'Phanta',
  pos = { x = 3, y = 1 },
  soul_pos = {
    x = 4,
    y = 2
  },
  phanta_shiny_soul = true,
  cost = 20,
  loc_vars = function(self, info_queue, card)
    info_queue[#info_queue + 1] = G.P_CENTERS.e_negative
    return {}
  end,
  blueprint_compat = true,
  eternal_compat = true,
  perishable_compat = true,
  calculate = function(self, card, context)
    if context.end_of_round and not context.individual and not context.repetition and G.GAME.blind.boss then
      --Check if the ability should trigger (i.e. there are valid, non-Dimere Jokers)

      local candidates = {}
      for i = 1, #G.jokers.cards do
        if G.jokers.cards[i].config.center ~= card.config.center and G.jokers.cards[i].ability.set == "Joker" and G.jokers.cards[i].edition == nil then
          candidates[#candidates + 1] = G.jokers.cards[i]
        end
      end

      if #candidates == 0 then
        return nil
      end

      pseudorandom_element(candidates, pseudoseed("dimere")):set_edition { negative = true }
      card_eval_status_text(card, 'extra', nil, nil, nil,
        { message = "+Negative" })
    end
  end
}

G.Phanta.centers["goldor"] = {
  unlocked = false,
  config = { extra = { money = 3, xmult = 3 } },
  rarity = 4,
  atlas = 'Phanta',
  pos = { x = 4, y = 1 },
  soul_pos = {
    x = 5,
    y = 2
  },
  phanta_shiny_soul = true,
  cost = 20,
  loc_vars = function(self, info_queue, card)
    info_queue[#info_queue + 1] = G.P_CENTERS.m_gold
    return { vars = { card.ability.extra.xmult, card.ability.extra.money } }
  end,
  blueprint_compat = true,
  eternal_compat = true,
  perishable_compat = true,
  calculate = function(self, card, context)
    if context.individual and context.cardarea == G.play and SMODS.has_enhancement(context.other_card, "m_gold") then
      G.GAME.dollar_buffer = (G.GAME.dollar_buffer or 0) + card.ability.extra.money
      G.E_MANAGER:add_event(Event({
        func = (function()
          G.GAME.dollar_buffer = 0
          return true
        end)
      }))
      return {
        dollars = card.ability.extra.money,
        x_mult = card.ability.extra.xmult,
        colour = G.C.RED,
        card = card
      }
    end
  end
}

G.Phanta.centers["famalia"] = {
  unlocked = false,
  rarity = 4,
  atlas = 'Phanta',
  pos = { x = 5, y = 1 },
  soul_pos = {
    x = 0,
    y = 3
  },
  phanta_shiny_soul = true,
  cost = 20,
  loc_vars = function(self, info_queue, card)
    --info_queue[#info_queue+1] = G.P_CENTERS.
    return {}
  end,
  blueprint_compat = true,
  eternal_compat = true,
  perishable_compat = true,
  calculate = function(self, card, context)
    if context.first_hand_drawn then
      G.E_MANAGER:add_event(Event({
        func = function()
          local _suit = pseudorandom_element({ 'S', 'H', 'D', 'C' }, pseudoseed('famaliasu'))
          local _card = create_playing_card({ front = G.P_CARDS[_suit .. '_K'], center = G.P_CENTERS.c_base }, G.hand,
            nil, nil, { G.C.SECONDARY_SET.Enhanced })
          _card:set_seal('Purple', true)

          _card:set_edition(poll_edition('famaliaed', nil, true, true, nil))

          G.GAME.blind:debuff_card(_card)
          G.hand:sort()
          if context.blueprint_card then context.blueprint_card:juice_up() else card:juice_up() end
          return true
        end
      }))

      playing_card_joker_effects({ true })
    end
  end
}

G.Phanta.centers["godoor"] = {
  unlocked = false,
  config = { extra = { added_xmult = 1, current_xmult = 1, counted_rerolls = 0 } },
  rarity = 4,
  atlas = 'Phanta',
  pos = { x = 0, y = 2 },
  soul_pos = {
    x = 1,
    y = 3
  },
  phanta_shiny_soul = true,
  cost = 20,
  loc_vars = function(self, info_queue, card)
    return { vars = { card.ability.extra.added_xmult, card.ability.extra.current_xmult } }
  end,
  blueprint_compat = true,
  eternal_compat = true,
  perishable_compat = false,
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

G.Phanta.centers["fainfol"] = {
  unlocked = false,
  config = { extra = { xmult = 1.5 } },
  rarity = 4,
  atlas = 'Phanta',
  pos = { x = 1, y = 2 },
  soul_pos = {
    x = 2,
    y = 3
  },
  phanta_shiny_soul = true,
  cost = 20,
  loc_vars = function(self, info_queue, card)
    return {
      vars = {
        localize(G.GAME.current_round.fainfol_card.suit, 'suits_singular'),
        card.ability.extra.xmult,
        colours = { G.C.SUITS[G.GAME.current_round.fainfol_card.suit] }
      }
    }
  end,
  blueprint_compat = true,
  eternal_compat = true,
  perishable_compat = true,
  calculate = function(self, card, context)
    if context.cardarea == G.hand and not context.end_of_round and not context.repetition and context.other_card and context.other_card:is_suit(G.GAME.current_round.fainfol_card.suit) then
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

    if context.end_of_round and not context.individual and not context.repetition and not context.blueprint then
      return {
        message =
            localize("k_reset"),
        colour = G.FILTER
      }
    end
  end
}

G.Phanta.centers["granwyrm"] = {
  unlocked = false,
  config = { extra = { added_xmult = 0.8, current_unscored = 0, target_unscored = 16, current_xmult = 1 } },
  rarity = 4,
  atlas = 'Phanta',
  pos = { x = 2, y = 2 },
  soul_pos = {
    x = 3,
    y = 3
  },
  phanta_shiny_soul = true,
  cost = 20,
  loc_vars = function(self, info_queue, card)
    return { vars = { card.ability.extra.added_xmult, card.ability.extra.target_unscored, card.ability.extra.target_unscored - card.ability.extra.current_unscored, card.ability.extra.current_xmult } }
  end,
  blueprint_compat = true,
  eternal_compat = true,
  perishable_compat = false,
  calculate = function(self, card, context)
    if context.joker_main and card.ability.extra.current_xmult > 1 then
      return { xmult = card.ability.extra.current_xmult }
    end

    if context.individual and context.cardarea == "unscored" then
      card.ability.extra.current_unscored = card.ability.extra.current_unscored + 1
      if card.ability.extra.current_unscored == card.ability.extra.target_unscored then
        card.ability.extra.current_xmult = card.ability.extra.current_xmult + card.ability.extra.added_xmult
        card.ability.extra.current_unscored = 0
        return {
          message = localize { type = 'variable', key = 'a_xmult', vars = { card.ability.extra.current_xmult } },
          colour = G.C.RED,
          card = card
        }
      else
        return {
          message = (card.ability.extra.target_unscored - card.ability.extra.current_unscored) .. '',
          colour = G.C.FILTER,
          card = card
        }
      end
    end
  end
}
