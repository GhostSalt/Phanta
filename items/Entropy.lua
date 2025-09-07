SMODS.Atlas {
  key = "PhantaBirthstones",
  path = "PhantaBirthstones.png",
  px = 71,
  py = 95
}

SMODS.ConsumableType {
  key = "phanta_Birthstone",
  primary_colour = HEX("4e7479"),
  secondary_colour = HEX("5e9796"),
  collection_rows = { 4, 4 },
  shop_rate = 0,
  default = "phanta_bloodstone",
  can_stack = true,
  can_divide = true,
  in_pool = function()
    return Phanta.config["zodiac_enabled"]
  end
}

SMODS.UndiscoveredSprite({
  key = "phanta_Birthstone",
  atlas = "PhantaBirthstones",
  path = "PhantaBirthstones.png",
  pos = { x = 1, y = 3 },
  px = 71,
  py = 95,
}):register()

SMODS.Consumable {
  set = "phanta_Birthstone",
  key = "bloodstone",
  inversion = "c_phanta_aries",
  pos = { x = 0, y = 0 },
  atlas = "PhantaBirthstones",
  loc_vars = function(self, info_queue, card)
    return { vars = { count_prognosticators(card) + 1, count_prognosticators(card) == 0 and "" or localize("phanta_plural") } }
  end,
  month_range = { first = { month = 3, day = 21 }, last = { month = 4, day = 19 } },
  calculate = function(self, card, context)
    if context.before and G.GAME.current_round.hands_played == 1 then -- Progs give more Tarots.
      local times = count_prognosticators(card) + 1
      for i = 1, times do
        G.E_MANAGER:add_event(Event({
          trigger = 'before',
          delay = 0.0,
          func = (function()
            local card = create_card('Tarot', G.consumeables, nil, nil, nil, nil, nil, "phantabloodstone")
            card:add_to_deck()
            card:set_edition { negative = true }
            G.consumeables:emplace(card)
            G.GAME.consumeable_buffer = 0
            return true
          end)
        }))
      end
      if times > 0 then
        return {
          message = localize { type = 'variable', key = times == 1 and 'a_tarot' or 'a_tarots', vars = { times } },
          card = card
        }
      end
    end
  end
}

SMODS.Consumable {
  set = "phanta_Birthstone",
  key = "sapphire",
  inversion = "c_phanta_taurus",
  pos = { x = 1, y = 0 },
  atlas = "PhantaBirthstones",
  loc_vars = function(self, info_queue, card)
    return { vars = { count_prognosticators(card) + 1, count_prognosticators(card) > 0 and localize("phanta_plural") or "" } }
  end,
  month_range = { first = { month = 4, day = 20 }, last = { month = 5, day = 20 } },
  calculate = function(self, card, context)
    if context.repetition and context.cardarea == G.play and context.other_card ~= context.scoring_hand[1] then
      return { repetitions = count_prognosticators(card) + 1 } -- Progs add 1 retrigger each.
    end
  end
}

SMODS.Consumable {
  set = "phanta_Birthstone",
  key = "agate",
  inversion = "c_phanta_gemini",
  pos = { x = 2, y = 0 },
  config = { extra = { money = 8 } },
  atlas = "PhantaBirthstones",
  loc_vars = function(self, info_queue, card)
    return { vars = { card.ability.extra.money + (count_prognosticators(card) * 4) } }
  end,
  month_range = { first = { month = 5, day = 21 }, last = { month = 6, day = 21 } },
  calculate = function(self, card, context)
    if context.before and next(context.poker_hands['Four of a Kind']) then
      return { dollars = card.ability.extra.money + (count_prognosticators(card) * 4) } -- Progs add $4 each.
    end
  end
}

SMODS.Consumable {
  set = "phanta_Birthstone",
  key = "emerald",
  inversion = "c_phanta_cancer",
  pos = { x = 3, y = 0 },
  config = { extra = { chips = 100 } },
  atlas = "PhantaBirthstones",
  loc_vars = function(self, info_queue, card)
    return { vars = { card.ability.extra.chips + (count_prognosticators(card) * 50) } }
  end,
  month_range = { first = { month = 6, day = 22 }, last = { month = 7, day = 22 } },
  calculate = function(self, card, context)
    if context.joker_main then
      for _, v in ipairs(context.scoring_hand) do
        if v:is_suit("Clubs") then return { chips = card.ability.extra.chips + (count_prognosticators(card) * 50) } end
      end
    end
  end
}

SMODS.Consumable {
  set = "phanta_Birthstone",
  key = "onyx",
  inversion = "c_phanta_leo",
  pos = { x = 0, y = 1 },
  config = { extra = { mult = 12 } },
  atlas = "PhantaBirthstones",
  loc_vars = function(self, info_queue, card)
    return { vars = { card.ability.extra.mult + (count_prognosticators(card) * 8) } }
  end,
  month_range = { first = { month = 7, day = 23 }, last = { month = 8, day = 22 } },
  calculate = function(self, card, context)
    if context.joker_main then
      for _, v in ipairs(context.scoring_hand) do
        if v:is_suit("Hearts") then return { mult = card.ability.extra.mult + (count_prognosticators(card) * 8) } end
      end
    end
  end
}

SMODS.Consumable {
  set = "phanta_Birthstone",
  key = "carnelian",
  inversion = "c_phanta_virgo",
  pos = { x = 1, y = 1 },
  config = { extra = { hands = 1 } },
  atlas = "PhantaBirthstones",
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
          add_tag(Tag('tag_rare'))
          play_sound('generic1', 0.9 + math.random() * 0.1, 0.8)
          play_sound('holo1', 1.2 + math.random() * 0.1, 0.4)
          card_eval_status_text(card, 'extra', nil, nil, nil,
            { message = localize("plus_rare_tag"), colour = G.C.FILTER })
          return true
        end
      }))
    end
  end
}


SMODS.Consumable {
  set = "phanta_Birthstone",
  key = "peridot",
  inversion = "c_phanta_libra",
  pos = { x = 2, y = 1 },
  config = { extra = { xmult = 1.5 } },
  atlas = "PhantaBirthstones",
  loc_vars = function(self, info_queue, card)
    return { vars = { card.ability.extra.xmult + (count_prognosticators(card) * 0.5) } }
  end,
  month_range = { first = { month = 9, day = 23 }, last = { month = 10, day = 23 } },
  calculate = function(self, card, context)
    if context.joker_main then
      for _, v in ipairs(context.scoring_hand) do
        if v:is_suit("Spades") then return { xmult = card.ability.extra.xmult + (count_prognosticators(card) * 0.5) } end
      end
    end
  end
}

SMODS.Consumable {
  set = "phanta_Birthstone",
  key = "aquamarine",
  inversion = "c_phanta_scorpio",
  pos = { x = 3, y = 1 },
  atlas = "PhantaBirthstones",
  loc_vars = function(self, info_queue, card)
    return { vars = { count_prognosticators(card) + 1, count_prognosticators(card) == 0 and "" or localize("phanta_plural") } }
  end,
  month_range = { first = { month = 10, day = 24 }, last = { month = 11, day = 21 } },
  calculate = function(self, card, context)
    if context.joker_main then
      for _, v in ipairs(context.scoring_hand) do
        if v:is_suit("Diamonds") then
          local times = count_prognosticators(card) + 1
          for i = 1, times do
            G.E_MANAGER:add_event(Event({
              trigger = 'before',
              delay = 0.0,
              func = (function()
                local card = create_card('Planet', G.consumeables, nil, nil, nil, nil, nil, "phantaaquamarine")
                card:add_to_deck()
                card:set_edition { negative = true }
                G.consumeables:emplace(card)
                G.GAME.consumeable_buffer = 0
                return true
              end)
            }))
          end
          if times > 0 then
            return {
              message = localize { type = 'variable', key = times == 1 and 'a_planet' or 'a_planets', vars = { times } },
              card = card
            }
          end
        end
      end
    end
  end
}

SMODS.Consumable {
  set = "phanta_Birthstone",
  key = "topaz",
  inversion = "c_phanta_sagittarius",
  pos = { x = 0, y = 2 },
  config = { extra = { added_discards = 3 } },
  atlas = "PhantaBirthstones",
  loc_vars = function(self, info_queue, card)
    return { vars = { card.ability.extra.added_discards + (count_prognosticators(card) * 2) } }
  end,
  month_range = { first = { month = 11, day = 21 }, last = { month = 12, day = 20 } },
  calculate = function(self, card, context)
    if context.setting_blind and is_blind_boss() then
      G.E_MANAGER:add_event(Event({
        func = function()
          ease_discard(card.ability.extra.added_discards)
          card_eval_status_text(card, 'extra', nil, nil, nil,
            {
              message = localize { type = 'variable', key = card.ability.extra.added_discards == 1 and 'a_discard' or 'a_discards', vars = { card.ability.extra.added_discards } },
              colour =
                  G.C.RED
            })
          return true
        end
      }))
    end
  end
}

SMODS.Consumable {
  set = "phanta_Birthstone",
  key = "ruby",
  inversion = "c_phanta_capricorn",
  pos = { x = 1, y = 2 },
  config = { extra = { money = 10, active = true } },
  atlas = "PhantaBirthstones",
  loc_vars = function(self, info_queue, card)
    return { vars = { card.ability.extra.money + (count_prognosticators(card) * 8) } }
  end,
  month_range = { first = { month = 12, day = 22 }, last = { month = 1, day = 19 } },
  calculate = function(self, card, context)
    if context.reroll_shop then card.ability.extra.active = false end
    if context.ending_shop then
      if not card.ability.extra.active then
        card.ability.extra.active = true
      else
        return { dollars = card.ability.extra.money + (count_prognosticators(card) * 8) }
      end -- Prog adds $8 to each reward.
    end
  end
}

SMODS.Consumable {
  set = "phanta_Birthstone",
  key = "garnet",
  inversion = "c_phanta_aquarius",
  pos = { x = 2, y = 2 },
  config = { extra = { added_hands = 3 } },
  atlas = "PhantaBirthstones",
  loc_vars = function(self, info_queue, card)
    return { vars = { card.ability.extra.added_hands + (count_prognosticators(card) * 2) } }
  end,
  month_range = { first = { month = 1, day = 20 }, last = { month = 2, day = 18 } },
  calculate = function(self, card, context)
    if context.setting_blind and is_blind_boss() then
      G.E_MANAGER:add_event(Event({
        func = function()
          ease_hands_played(card.ability.extra.added_hands)
          card_eval_status_text(card, 'extra', nil, nil, nil,
            {
              message = localize { type = 'variable', key = card.ability.extra.added_hands == 1 and 'a_hand' or 'a_hands', vars = { card.ability.extra.added_hands } },
              colour =
                  G.C.BLUE
            })
          return true
        end
      }))
    end
  end
}

SMODS.Consumable {
  set = "phanta_Birthstone",
  key = "amethyst",
  inversion = "c_phanta_pisces",
  pos = { x = 3, y = 2 },
  config = { extra = { added_value = 5 } },
  atlas = "PhantaBirthstones",
  loc_vars = function(self, info_queue, card)
    return { vars = { card.ability.extra.added_value + (count_prognosticators(card) * 3) } }
  end,
  month_range = { first = { month = 2, day = 19 }, last = { month = 3, day = 20 } },
  calculate = function(self, card, context)
    if context.ending_shop then
      if #count_boosters() > 0 then
        card.ability.extra_value = card.ability.extra_value +
            (#count_boosters() * (card.ability.extra.added_value + (count_prognosticators(card) * 3))) -- Prog adds $3 extra sell value.
        card:set_cost()
        return {
          message = localize('k_val_up'),
          colour = G.C.MONEY
        }
      end
    end
  end
}

SMODS.Atlas {
  key = "PhantaBirthstoneUpgradesMoonstone",
  path = "PhantaBirthstoneUpgradesMoonstone.png",
  px = 71,
  py = 95,
}

SMODS.Consumable {
  set = "phanta_Birthstone",
  key = "moonstone",
  inversion = "c_phanta_darkhour",
  pos = { x = 0, y = 3 },
  config = { extra = { xmult = 2 } },
  atlas = "PhantaBirthstones",
  atlas_extra = "phanta_PhantaBirthstoneUpgradesMoonstone",
  loc_vars = function(self, info_queue, card)
    return { vars = { card.ability.extra.xmult + (count_prognosticators(card) * 2) } }
  end,
  calculate = function(self, card, context)
    if context.individual and context.cardarea == G.play and context.other_card:is_suit("Clubs") then
      return { xmult = card.ability.extra.xmult + (count_prognosticators(card) * 2) } -- Prog adds X2 Mult.
    end
  end,

  hidden = true,
  soul_rate = 0.005,
  can_repeat_soul = false
}
