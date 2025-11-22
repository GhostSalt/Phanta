SMODS.ConsumableType {
  key = "phanta_Zodiac",
  primary_colour = HEX("4076cf"),
  secondary_colour = HEX("5998ff"),
  collection_rows = { 4, 4 },
  shop_rate = 0,
  default = "phanta_aries",
  can_stack = true,
  can_divide = true,
  in_pool = function()
    return Phanta.config["zodiac_enabled"]
  end
}

SMODS.UndiscoveredSprite({
  key = "phanta_Zodiac",
  atlas = "PhantaZodiacs",
  path = "PhantaZodiacs.png",
  pos = { x = 1, y = 3 },
  px = 71,
  py = 95,
}):register()







SMODS.Consumable {
  set = "phanta_Zodiac",
  key = "aries",
  pos = { x = 0, y = 0 },
  atlas = "PhantaZodiacs",
  loc_vars = function(self, info_queue, card)
    return { vars = { count_prognosticators(card) > 0 and "" or localize("phanta_aries_second") } }
  end,
  month_range = { first = { month = 3, day = 21 }, last = { month = 4, day = 19 } },
  calculate = function(self, card, context)
    if context.before and (count_prognosticators(card) > 0 or G.GAME.current_round.hands_played == 1) and count_consumables() < G.consumeables.config.card_limit then -- Progs allow Tarots to be made on all hands. (Unstackable)
      G.GAME.consumeable_buffer = G.GAME.consumeable_buffer + 1
      G.E_MANAGER:add_event(Event({
        trigger = 'before',
        delay = 0.0,
        func = (function()
          local card = create_card('Tarot', G.consumeables, nil, nil, nil, nil)
          card:add_to_deck()
          G.consumeables:emplace(card)
          G.GAME.consumeable_buffer = 0
          return true
        end)
      }))
      return {
        message = localize('k_plus_tarot'),
        card = card
      }
    end
  end
}

SMODS.Consumable {
  set = "phanta_Zodiac",
  key = "taurus",
  pos = { x = 1, y = 0 },
  atlas = "PhantaZodiacs",
  loc_vars = function(self, info_queue, card)
    return { vars = { count_prognosticators(card) + 1, count_prognosticators(card) > 0 and localize("phanta_plural") or "" } }
  end,
  month_range = { first = { month = 4, day = 20 }, last = { month = 5, day = 20 } },
  calculate = function(self, card, context)
    if context.repetition and context.cardarea == G.play and context.other_card == context.scoring_hand[1] then
      return { repetitions = count_prognosticators(card) + 1 } -- Progs add 1 retrigger each.
    end
  end
}

SMODS.Consumable {
  set = "phanta_Zodiac",
  key = "gemini",
  pos = { x = 2, y = 0 },
  config = { extra = { money = 4 } },
  atlas = "PhantaZodiacs",
  loc_vars = function(self, info_queue, card)
    return { vars = { card.ability.extra.money + (count_prognosticators(card) * 2) } }
  end,
  month_range = { first = { month = 5, day = 21 }, last = { month = 6, day = 21 } },
  calculate = function(self, card, context)
    if context.before and (next(context.poker_hands['Two Pair']) or next(context.poker_hands['Full House'])) then
      return { dollars = card.ability.extra.money + (count_prognosticators(card) * 2) } -- Progs add $2 each.
    end
  end
}

SMODS.Consumable {
  set = "phanta_Zodiac",
  key = "cancer",
  pos = { x = 3, y = 0 },
  config = { extra = { chips = 20 } },
  atlas = "PhantaZodiacs",
  loc_vars = function(self, info_queue, card)
    return { vars = { card.ability.extra.chips + (count_prognosticators(card) * 30) } }
  end,
  month_range = { first = { month = 6, day = 22 }, last = { month = 7, day = 22 } },
  calculate = function(self, card, context)
    if context.individual and context.cardarea == G.play and context.other_card:is_suit("Clubs") then
      return { chips = card.ability.extra.chips + (count_prognosticators(card) * 30) } -- Progs add 30 Chips. (hardcoded so Cryptid doesn't make this nonsensical)
    end
  end
}

SMODS.Consumable {
  set = "phanta_Zodiac",
  key = "leo",
  pos = { x = 0, y = 1 },
  config = { extra = { mult = 2 } },
  atlas = "PhantaZodiacs",
  loc_vars = function(self, info_queue, card)
    return { vars = { card.ability.extra.mult + (count_prognosticators(card) * 4) } }
  end,
  month_range = { first = { month = 7, day = 23 }, last = { month = 8, day = 22 } },
  calculate = function(self, card, context)
    if context.individual and context.cardarea == G.play and context.other_card:is_suit("Hearts") then
      return { mult = card.ability.extra.mult + (count_prognosticators(card) * 4) } -- Progs add 4 Mult.
    end
  end
}

SMODS.Consumable {
  set = "phanta_Zodiac",
  key = "virgo",
  pos = { x = 1, y = 1 },
  config = { extra = { hands = 1 } },
  atlas = "PhantaZodiacs",
  loc_vars = function(self, info_queue, card)
    return {
      vars = { count_prognosticators(card) > 0 and localize("phanta_virgo_at_most") or "",
        card.ability.extra.hands + count_prognosticators(card),
        count_prognosticators(card) > 0 and localize("phanta_plural") or "",
        count_prognosticators(card) == 0 and localize("phanta_virgo_creates_a") or "",
        count_prognosticators(card) > 0 and localize("phanta_virgo_creates_b") or "" }
    }
  end,
  month_range = { first = { month = 8, day = 23 }, last = { month = 9, day = 22 } },
  calculate = function(self, card, context)
    if context.end_of_round and not context.individual and not context.repetition and G.GAME.current_round.hands_played <= card.ability.extra.hands + count_prognosticators(card) then -- Prog makes Virgo easier to proc.
      G.E_MANAGER:add_event(Event({
        func = function()
          add_tag(Tag('tag_standard'))
          play_sound('generic1', 0.9 + math.random() * 0.1, 0.8)
          play_sound('holo1', 1.2 + math.random() * 0.1, 0.4)
          card_eval_status_text(card, 'extra', nil, nil, nil,
            { message = localize("plus_standard_tag"), colour = G.C.FILTER })
          return true
        end
      }))
    end
  end
}

SMODS.Consumable {
  set = "phanta_Zodiac",
  key = "libra",
  pos = { x = 2, y = 1 },
  config = { extra = { xmult = 1.2 } },
  atlas = "PhantaZodiacs",
  loc_vars = function(self, info_queue, card)
    return { vars = { card.ability.extra.xmult + (count_prognosticators(card) * 0.2) } }
  end,
  month_range = { first = { month = 9, day = 23 }, last = { month = 10, day = 23 } },
  calculate = function(self, card, context)
    if context.individual and context.cardarea == G.play and context.other_card:is_suit("Spades") then
      return { xmult = card.ability.extra.xmult + (count_prognosticators(card) * 0.2) } -- Prog adds X0.2 Mult.
    end
  end
}

SMODS.Consumable {
  set = "phanta_Zodiac",
  key = "scorpio",
  pos = { x = 3, y = 1 },
  atlas = "PhantaZodiacs",
  loc_vars = function(self, info_queue, card)
    return {
      vars = { count_prognosticators(card) > 0 and localize("phanta_scorpio_extra_a") or "",
        count_prognosticators(card) > 0 and localize("phanta_scorpio_extra_b") or "" }
    }
  end,
  month_range = { first = { month = 10, day = 24 }, last = { month = 11, day = 21 } },
  calculate = function(self, card, context)
    if context.individual and context.cardarea == G.play and context.other_card:is_suit("Diamonds") and count_consumables() < G.consumeables.config.card_limit then
      G.GAME.consumeable_buffer = G.GAME.consumeable_buffer + 1
      G.E_MANAGER:add_event(Event({
        trigger = 'before',
        delay = 0.0,
        func = (function()
          local planet = 0
          for i, j in pairs(G.P_CENTER_POOLS.Planet) do
            if j.config.hand_type == G.GAME.last_hand_played then
              planet = j.key
            end
          end
          local card = create_card('Planet', G.consumeables, nil, nil, nil, nil,
            count_prognosticators(card) > 0 and planet or nil, "scorpio") -- Prog makes the created Planets specific to the played hand.
          card:add_to_deck()
          G.consumeables:emplace(card)
          G.GAME.consumeable_buffer = 0
          return true
        end)
      }))
      return {
        message = localize('k_plus_planet'),
        card = card
      }
    end
  end
}

SMODS.Consumable {
  set = "phanta_Zodiac",
  key = "sagittarius",
  pos = { x = 0, y = 2 },
  config = { extra = { added_discards = 1 } },
  atlas = "PhantaZodiacs",
  loc_vars = function(self, info_queue, card)
    return { vars = { card.ability.extra.added_discards + count_prognosticators(card), count_prognosticators(card) > 0 and localize("phanta_plural") or "" } }
  end,
  month_range = { first = { month = 11, day = 21 }, last = { month = 12, day = 20 } },
  add_to_deck = function(self, card, from_debuff)
    G.GAME.round_resets.discards = G.GAME.round_resets.discards + card.ability.extra.added_discards +
        count_prognosticators(card) -- Prog adds 1 discard.
    ease_discard(card.ability.extra.added_discards + count_prognosticators(card))
  end,
  remove_from_deck = function(self, card, from_debuff)
    G.GAME.round_resets.discards = G.GAME.round_resets.discards - card.ability.extra.added_discards -
        count_prognosticators(card)
    ease_discard(-(card.ability.extra.added_discards + count_prognosticators(card)))
  end,
  add_progs = function(self, count)
    G.GAME.round_resets.discards = G.GAME.round_resets.discards + (count * self.config.extra.added_discards)
    ease_discard(count * self.config.extra.added_discards)
  end,
  remove_progs = function(self, count)
    G.GAME.round_resets.discards = G.GAME.round_resets.discards - (count * self.config.extra.added_discards)
    ease_discard(-(count * self.config.extra.added_discards))
  end
}

SMODS.Consumable {
  set = "phanta_Zodiac",
  key = "capricorn",
  pos = { x = 1, y = 2 },
  config = { extra = { money = 2 } },
  atlas = "PhantaZodiacs",
  loc_vars = function(self, info_queue, card)
    return { vars = { card.ability.extra.money + (count_prognosticators(card) * 2) } }
  end,
  month_range = { first = { month = 12, day = 22 }, last = { month = 1, day = 19 } },
  calculate = function(self, card, context)
    if context.reroll_shop then return { dollars = card.ability.extra.money + (count_prognosticators(card) * 2) } end -- Prog adds $2 to each reroll reward.
  end
}

SMODS.Consumable {
  set = "phanta_Zodiac",
  key = "aquarius",
  pos = { x = 2, y = 2 },
  config = { extra = { added_hands = 1 } },
  atlas = "PhantaZodiacs",
  loc_vars = function(self, info_queue, card)
    return { vars = { card.ability.extra.added_hands + count_prognosticators(card), count_prognosticators(card) > 0 and localize("phanta_plural") or "" } }
  end,
  month_range = { first = { month = 1, day = 20 }, last = { month = 2, day = 18 } },
  add_to_deck = function(self, card, from_debuff)
    G.GAME.round_resets.hands = G.GAME.round_resets.hands + card.ability.extra.added_hands + count_prognosticators(card)
    ease_hands_played(card.ability.extra.added_hands + count_prognosticators(card))
  end,
  remove_from_deck = function(self, card, from_debuff)
    G.GAME.round_resets.hands = G.GAME.round_resets.hands - card.ability.extra.added_hands - count_prognosticators(card)
    ease_hands_played(-(card.ability.extra.added_hands + count_prognosticators(card)))
  end,
  add_progs = function(self, count)
    G.GAME.round_resets.hands = G.GAME.round_resets.hands + (count * self.config.extra.added_hands)
    ease_hands_played(count * self.config.extra.added_hands)
  end,
  remove_progs = function(self, count)
    G.GAME.round_resets.hands = G.GAME.round_resets.hands - (count * self.config.extra.added_hands)
    ease_hands_played(-(count * self.config.extra.added_hands))
  end
}

SMODS.Consumable {
  set = "phanta_Zodiac",
  key = "pisces",
  pos = { x = 3, y = 2 },
  config = { extra = { added_value = 5 } },
  atlas = "PhantaZodiacs",
  loc_vars = function(self, info_queue, card)
    return { vars = { card.ability.extra.added_value + (count_prognosticators(card) * 3) } }
  end,
  month_range = { first = { month = 2, day = 19 }, last = { month = 3, day = 20 } },
  calculate = function(self, card, context)
    if context.skipping_booster then
      card.ability.extra_value = card.ability.extra_value + card.ability.extra.added_value +
          (count_prognosticators(card) * 3) -- Prog adds $3 extra sell value.
      card:set_cost()
      return {
        message = localize('k_val_up'),
        colour = G.C.MONEY
      }
    end
  end
}



SMODS.Consumable {
  set = "phanta_Zodiac",
  key = "darkhour",
  pos = { x = 0, y = 3 },
  config = { extra = { xmult = 2 } },
  atlas = "PhantaZodiacs",
  atlas_extra = "phanta_PhantaZodiacUpgradesDarkHour",
  loc_vars = function(self, info_queue, card)
    return { vars = { card.ability.extra.xmult + (count_prognosticators(card) * 2) } }
  end,
  calculate = function(self, card, context)
    if context.individual and context.cardarea == "unscored" and context.other_card:is_suit("Clubs") then
      return { xmult = card.ability.extra.xmult + (count_prognosticators(card) * 2) } -- Prog adds X2 Mult.
    end
  end,

  hidden = true,
  soul_set = false,
  soul_rate = 0.005,
  can_repeat_soul = false
}