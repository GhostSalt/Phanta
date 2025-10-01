SMODS.current_mod.optional_features = { cardareas = { unscored = true } }

to_big = to_big or function(x) return x end
to_number = to_number or function(x) return x end

SMODS.Atlas {
  key = "Phanta",
  path = "PhantaJokers1.png",
  px = 71,
  py = 95
}

SMODS.Atlas {
  key = "PhantaLaytonAnims",
  path = "PhantaLaytonAnims.png",
  px = 71,
  py = 95
}

SMODS.Atlas {
  key = "PhantaMiscAnims1",
  path = "PhantaMiscAnims1.png",
  px = 71,
  py = 95
}

SMODS.Atlas {
  key = "PhantaMiscAnims2",
  path = "PhantaMiscAnims2.png",
  px = 71,
  py = 95
}

SMODS.Atlas {
  key = "PhantaMiscAnims3",
  path = "PhantaMiscAnims3.png",
  px = 71,
  py = 95
}

SMODS.Atlas {
  key = "PhantaMiscAnims4",
  path = "PhantaMiscAnims4.png",
  px = 71,
  py = 95
}

SMODS.Atlas {
  key = "PhantaMiscAnims5",
  path = "PhantaMiscAnims5.png",
  px = 71,
  py = 95
}

SMODS.Atlas {
  key = "PhantaKnowledgeOfTheCollegeAnim",
  path = "PhantaKnowledgeOfTheCollegeAnim.png",
  px = 71,
  py = 95
}

G.Phanta.centers["bootleg"] = {
  config = { extra = { chips = 30, mult = 2 } },
  loc_vars = function(self, info_queue, card)
    return { vars = { card.ability.extra.chips, card.ability.extra.mult } }
  end,
  rarity = 1,
  atlas = 'Phanta',
  pos = { x = 4, y = 8 },
  cost = 2,
  blueprint_compat = true,
  eternal_compat = true,
  perishable_compat = true,
  calculate = function(self, card, context)
    if context.joker_main then
      return {
        chips = card.ability.extra.chips,
        mult = card.ability.extra.mult,
      }
    end
  end
}

G.Phanta.centers["dropdownlist"] = {
  rarity = 1,
  atlas = 'Phanta',
  pos = { x = 11, y = 3 },
  cost = 2,
  blueprint_compat = true,
  eternal_compat = false,
  perishable_compat = true,
  calculate = function(self, card, context)
    if context.selling_self and #G.jokers.cards <= G.jokers.config.card_limit then
      G.E_MANAGER:add_event(Event({
        func = function()
          play_sound('timpani')
          local new_card = create_card('Joker', G.jokers, nil, nil, nil, nil, nil, 'dropdownlist')
          new_card:add_to_deck()
          G.jokers:emplace(new_card)
          new_card:juice_up(0.3, 0.5)
          return true
        end
      }))
    end
  end
}

G.Phanta.centers["trainstation"] = {
  config = { extra = { added_mult = 1, current_mult = 0 } },
  loc_vars = function(self, info_queue, card)
    return { vars = { card.ability.extra.added_mult, localize((G.GAME.current_round.train_station_card.value or 2) .. "", 'ranks'), card.ability.extra.current_mult } }
  end,
  rarity = 1,
  atlas = 'Phanta',
  pos = { x = 5, y = 8 },
  cost = 4,
  blueprint_compat = true,
  eternal_compat = true,
  perishable_compat = false,
  calculate = function(self, card, context)
    if context.joker_main and card.ability.extra.current_mult > 0 then return { mult = card.ability.extra.current_mult } end

    if context.individual and context.cardarea == G.play and context.other_card:get_id() == G.GAME.current_round.train_station_card.id and not context.blueprint then
      card.ability.extra.current_mult = card.ability.extra.current_mult + card.ability.extra.added_mult
      return {
        message = localize('k_upgrade_ex'),
        colour = G.C.FILTER
      }
    end

    if context.end_of_round and not context.individual and not context.repetition and not context.blueprint then
      return {
        message =
            localize("phanta_increased"),
        colour = G.FILTER
      }
    end
  end
}

G.Phanta.centers["hintcoin"] = {
  config = { extra = { money = 5 } },
  rarity = 1,
  atlas = 'PhantaLaytonAnims',
  pos = { x = 8, y = 1 }, --[[
  phanta_anim = {
    { x = 0, y = 7, t = 4 },
    { x = 1, y = 7, t = 0.15 },
    { x = 2, y = 7, t = 0.15 },
    { x = 3, y = 7, t = 1 },
    { x = 2, y = 7, t = 0.15 },
    { x = 1, y = 7, t = 0.15 },
},]] --
  cost = 4,
  blueprint_compat = true,
  eternal_compat = true,
  perishable_compat = true,
  loc_vars = function(self, info_queue, card)
    return { vars = { card.ability.extra.money } }
  end,
  calculate = function(self, card, context)
    if context.before and G.GAME.current_round.hands_played == 1 then
      return { dollars = card.ability.extra.money }
    end
  end
}

G.Phanta.centers["dollarsign"] = {
  config = { extra = { money = 5 } },
  rarity = 1,
  atlas = 'Phanta',
  pos = { x = 10, y = 0 },
  cost = 5,
  blueprint_compat = true,
  eternal_compat = true,
  perishable_compat = true,
  loc_vars = function(self, info_queue, card)
    return { vars = { card.ability.extra.money } }
  end,
  calculate = function(self, card, context)
    if context.before then
      local money_string = tostring(G.GAME.dollars)
      for i = 1, #money_string do
        if string.sub(money_string, i, i) == '5' then return { dollars = card.ability.extra.money } end
      end
    end
  end
}

G.Phanta.centers["yellow"] = {
  config = { extra = { odd_money = 7, even_money = 1 } },
  rarity = 1,
  atlas = 'Phanta',
  pos = { x = 3, y = 11 },
  cost = 6,
  blueprint_compat = false,
  eternal_compat = true,
  perishable_compat = true,
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

G.Phanta.centers["purplegoldenjoker"] = {
  config = { extra = { money = 3 } },
  rarity = 1,
  atlas = 'Phanta',
  pos = { x = 8, y = 6 },
  cost = 6,
  blueprint_compat = false,
  eternal_compat = true,
  perishable_compat = true,
  loc_vars = function(self, info_queue, card)
    return { vars = { card.ability.extra.money, count_tarots() * card.ability.extra.money } }
  end,
  calc_dollar_bonus = function(self, card)
    if count_tarots() > 0 then
      return count_tarots() * card.ability.extra.money
    end
  end
}

G.Phanta.centers["holeinthejoker"] = {
  config = { extra = { money = 3 } },
  rarity = 1,
  atlas = 'Phanta',
  pos = { x = 7, y = 3 },
  cost = 4,
  blueprint_compat = true,
  eternal_compat = true,
  perishable_compat = true,
  loc_vars = function(self, info_queue, card)
    return {
      vars = { card.ability.extra.money,
        (G.jokers and G.jokers.cards and G.jokers.config and G.jokers.config.card_limit and (G.jokers.config.card_limit - (#G.jokers.cards - #SMODS.find_card("j_phanta_holeinthejoker"))) * card.ability.extra.money)
        or card.ability.extra.money * 5 }
    }
  end,
  calc_dollar_bonus = function(self, card)
    if G.jokers.config.card_limit - (#G.jokers.cards - #SMODS.find_card("j_phanta_holeinthejoker")) > 0 then
      return (G.jokers.config.card_limit - (#G.jokers.cards - #SMODS.find_card("j_phanta_holeinthejoker"))) *
          card.ability.extra.money
    end
  end
}

G.Phanta.centers["shootingstar"] = {
  config = { extra = { money = 1, added_money = 1 } },
  rarity = 2,
  atlas = 'Phanta',
  pos = { x = 10, y = 4 },
  cost = 5,
  blueprint_compat = true,
  eternal_compat = true,
  perishable_compat = false,
  loc_vars = function(self, info_queue, card)
    return { vars = { card.ability.extra.money, card.ability.extra.added_money } }
  end,
  calculate = function(self, card, context)
    if context.remove_playing_cards then
      local reward = 0
      for k, v in ipairs(context.removed) do
        if v:is_suit("Diamonds") then
          reward = reward + card.ability.extra.money
          card.ability.extra.money = card.ability.extra.money + card.ability.extra.added_money
        end
      end
      if reward > 0 then return { dollars = reward } end
    end
  end
}

G.Phanta.centers["puzzle"] = {
  config = { extra = { given_money = 3 } },
  rarity = 1,
  atlas = 'PhantaLaytonAnims',
  pos = { x = 0, y = 8 },
  phanta_anim = {
    { xrange = { first = 11, last = 10 }, y = 0, t = 0.05 },
    { xrange = { first = 5, last = 9 },   y = 0, t = 0.05 },
    { xrange = { first = 8, last = 6 },   y = 0, t = 0.05 },
    { x = 5,                              y = 0, t = 4 },
    { xrange = { first = 6, last = 7 },   y = 1, t = 0.05 },
    { x = 5,                              y = 2, t = 0.5 },
  },
  cost = 4,
  loc_vars = function(self, info_queue, card)
    return { vars = { card.ability.extra.given_money } }
  end,
  blueprint_compat = true,
  eternal_compat = true,
  perishable_compat = true,
  calculate = function(self, card, context)
    if context.individual and context.cardarea == G.play and context.other_card:get_id() == G.GAME.current_round.puzzle_card.id then
      return { dollars = card.ability.extra.given_money }
    end

    if context.end_of_round and not context.individual and not context.repetition and not context.blueprint and G.GAME.last_blind and G.GAME.last_blind.boss then
      return { message = localize("k_reset"), colour = G.FILTER }
    end
  end
}

G.Phanta.centers["binman"] = {
  config = { extra = { given_money = 4 } },
  rarity = 1,
  atlas = 'Phanta',
  pos = { x = 6, y = 8 },
  cost = 4,
  loc_vars = function(self, info_queue, card)
    return { vars = { card.ability.extra.given_money } }
  end,
  blueprint_compat = true,
  eternal_compat = true,
  perishable_compat = true,
  calculate = function(self, card, context)
    if context.pre_discard then
      local text, disp_text = G.FUNCS.get_poker_hand_info(G.hand.highlighted)
      if text == "phanta_junk" then return { dollars = card.ability.extra.given_money } end
    end
  end,
  in_pool = function()
    return G.GAME.hands["phanta_junk"].visible and Phanta.config["junk_enabled"]
  end
}

G.Phanta.centers["onemanstrash"] = {
  no_pool_flag = "one_mans_trash_sold",
  config = { extra = { added_mult = 1, current_mult = 0 } },
  loc_vars = function(self, info_queue, card)
    return { vars = { card.ability.extra.added_mult, card.ability.extra.current_mult } }
  end,
  rarity = 1,
  atlas = 'Phanta',
  pos = { x = 3, y = 7 },
  cost = 4,
  blueprint_compat = true,
  eternal_compat = false,
  perishable_compat = true,
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

G.Phanta.centers["anothermanstreasure"] = {
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
  eternal_compat = false, -- I wanna make sure Another Man's Treasure is able to be spawned.
  perishable_compat = true,
  calculate = function(self, card, context)
    if context.joker_main then
      return { xmult = card.ability.extra.current_xmult }
    end
    if context.discard and not context.blueprint then
      card.ability.extra.current_xmult = card.ability.extra.current_xmult + card.ability.extra.added_xmult
    end
    if context.end_of_round and context.individual and not context.blueprint then
      card.ability.extra.current_xmult = 1
    end
  end
}

G.Phanta.centers["oracle"] = {
  rarity = 1,
  atlas = 'PhantaMiscAnims1',
  pos = { x = 4, y = 11 },
  phanta_anim = {
    { xrange = { first = 4, last = 11 }, y = 11, t = 0.2 }
  },
  cost = 4,
  blueprint_compat = false,
  eternal_compat = true,
  perishable_compat = true,
  add_to_deck = function(self, card, from_debuff)
    G.E_MANAGER:add_event(Event({
      func = function()
        G.consumeables.config.card_limit = G.consumeables.config.card_limit + 1
        return true
      end
    }))
  end,
  remove_from_deck = function(self, card, from_debuff)
    G.E_MANAGER:add_event(Event({
      func = function()
        G.consumeables.config.card_limit = G.consumeables.config.card_limit - 1
        return true
      end
    }))
  end
}

G.Phanta.centers["thief"] = {
  rarity = 1,
  atlas = 'PhantaMiscAnims2',
  pos = { x = 10, y = 10 },
  phanta_anim = {
    { xrange = { first = 10, last = 11 }, y = 10, t = 0.05 },
    { xrange = { first = 0, last = 8 },   y = 11, t = 0.05 },
    { x = 9,                              y = 11, t = 0.5 },
    { x = 10,                             y = 11, t = 0.2 },
    { x = 11,                             y = 11, t = 0.05 },
    { xrange = { first = 0, last = 2 },   y = 12, t = 0.05 }
  },
  cost = 4,
  blueprint_compat = false,
  eternal_compat = true,
  perishable_compat = true,
  add_to_deck = function(self, card, from_debuff)
    G.GAME.round_resets.hands = G.GAME.round_resets.hands + 1
    ease_hands_played(1)
  end,
  remove_from_deck = function(self, card, from_debuff)
    G.GAME.round_resets.hands = G.GAME.round_resets.hands - 1
    ease_hands_played(-1)
  end
}

G.Phanta.centers["detective"] = {
  rarity = 2,
  atlas = 'PhantaMiscAnims3',
  pos = { x = 0, y = 1 },
  phanta_anim = {
    { x = 0, y = 2, t = 0.9 },
    { x = 1, y = 2, t = 0.3 }, { x = 0, y = 2, t = 0.6 },
    { x = 2, y = 2, t = 0.3 }, { x = 0, y = 2, t = 0.9 },
    { x = 1, y = 2, t = 0.2 }, { x = 0, y = 2, t = 0.2 },
    { x = 2, y = 2, t = 1.3 }, { x = 0, y = 2, t = 0.2 }, { x = 1, y = 2, t = 1.8 },
    { x = 0, y = 2, t = 0.3 }, { xrange = { first = 3, last = 6 }, y = 2, t = 0.1 }, { x = 0, y = 2, t = 0.1 }, { xrange = { first = 3, last = 6 }, y = 2, t = 0.1 },
    { x = 0, y = 2, t = 1.4 }, { xrange = { first = 3, last = 6 }, y = 2, t = 0.1 },
  },
  cost = 5,
  blueprint_compat = false,
  eternal_compat = true,
  perishable_compat = true,
  add_to_deck = function(self, card, from_debuff)
    change_shop_size(1)
  end,
  remove_from_deck = function(self, card, from_debuff)
    change_shop_size(-1)
  end
}

G.Phanta.centers["timetable"] = {
  config = { extra = { discards = 1, hands = 1, hand_size = 1, is_happening = false } },
  loc_vars = function(self, info_queue, card)
    return { vars = { card.ability.extra.discards, card.ability.extra.hands, card.ability.extra.hand_size } }
  end,
  rarity = 1,
  atlas = 'Phanta',
  pos = { x = 11, y = 1 },
  cost = 4,
  blueprint_compat = false,
  eternal_compat = true,
  perishable_compat = true,
  add_to_deck = function(self, card, from_debuff)
    card.ability.extra.is_happening = false
  end,
  remove_from_deck = function(self, card, from_debuff)
    if is_blind_boss() and card.ability.extra.is_happening then
      G.hand:change_size(-card.ability.extra.hand_size)
      card.ability.extra.is_happening = false
    end
  end,
  calculate = function(self, card, context)
    if context.setting_blind then
      if is_blind_small() then
        G.E_MANAGER:add_event(Event({
          func = function()
            ease_discard(card.ability.extra.discards)
            card_eval_status_text(card, 'extra', nil, nil, nil,
              {
                message = localize { type = 'variable', key = 'a_discard', vars = { card.ability.extra.discards } },
                colour =
                    G.C.RED
              })
            return true
          end
        }))
      end
      if is_blind_big() then
        G.E_MANAGER:add_event(Event({
          func = function()
            ease_hands_played(card.ability.extra.hands)
            card_eval_status_text(card, 'extra', nil, nil, nil,
              {
                message = localize { type = 'variable', key = 'a_hand', vars = { card.ability.extra.hands } },
                colour = G
                    .C.BLUE
              })
            return true
          end
        }))
      end
      if is_blind_boss() then
        G.E_MANAGER:add_event(Event({
          func = function()
            G.hand:change_size(card.ability.extra.hand_size)
            card_eval_status_text(card, 'extra', nil, nil, nil,
              {
                message = localize { type = 'variable', key = 'a_handsize', vars = { card.ability.extra.hand_size } },
                colour =
                    G.C.FILTER
              })
            return true
          end
        }))
        card.ability.extra.is_happening = true
      end
    end

    if context.end_of_round and not context.individual and not context.repetition then
      if is_blind_boss() and card.ability.extra.is_happening then
        G.hand:change_size(-card.ability.extra.hand_size)
        card.ability.extra.is_happening = false
      end
    end
  end
}

G.Phanta.centers["mazebean"] = {
  config = { extra = { current_hand_size = 0, target_antes = 2, current_antes = 0 } },
  loc_vars = function(self, info_queue, card)
    return { vars = { card.ability.extra.current_hand_size, card.ability.extra.target_antes, card.ability.extra.target_antes - card.ability.extra.current_antes } }
  end,
  rarity = 2,
  atlas = 'Phanta',
  pos = { x = 8, y = 10 },
  cost = 6,
  blueprint_compat = false,
  eternal_compat = false,
  perishable_compat = false,
  calculate = function(self, card, context)
    if context.selling_self then
      G.hand:change_size(card.ability.extra.current_hand_size)
      return {
        message = localize { type = 'variable', key = 'a_handsize', vars = { card.ability.extra.current_hand_size } },
        colour =
            G.C.FILTER
      }
    end

    if context.end_of_round and not context.individual and not context.repetition and G.GAME.last_blind and G.GAME.last_blind.boss then
      card.ability.extra.current_antes = card.ability.extra.current_antes + 1
      if card.ability.extra.current_antes >= card.ability.extra.target_antes then
        card.ability.extra.current_hand_size = card.ability.extra.current_hand_size + 1
        card.ability.extra.current_antes = 0
        return { message = localize("k_upgrade_ex"), colour = G.C.FILTER }
      else
        return {
          message = card.ability.extra.current_antes .. '/' .. card.ability.extra.target_antes,
          colour = G.C
              .FILTER
        }
      end
    end
  end
}

SMODS.Sound({
  key = "xhands",
  path = "phanta_xhands.ogg",
  replace = true
})

G.Phanta.centers["new2dsxl"] = {
  config = { extra = { lost_hand_size = 2, given_xhands = 2 } },
  loc_vars = function(self, info_queue, card)
    return { vars = { card.ability.extra.lost_hand_size, card.ability.extra.given_xhands } }
  end,
  rarity = 3,
  atlas = 'PhantaMiscAnims5',
  pos = { x = 0, y = 0 },
  phanta_anim_states = {
    ["normal"] = {
      anim = {
        { x = 0, y = 0, t = 1 }
      },
      loop = false
    },

    ["streetpass"] = {
      anim = {
        { x = 0,                            y = 0, t = 0.1 },
        { xrange = { first = 2, last = 3 }, y = 0, t = 0.1 },
        { x = 4,                            y = 0, t = 1 }
      },
      loop = false
    },

    ["streetpass off"] = {
      anim = {
        { x = 4,                            y = 0, t = 0.1 },
        { xrange = { first = 2, last = 3 }, y = 0, t = 0.1 },
        { x = 0,                            y = 0, t = 1 }
      },
      loop = false
    },

    ["low battery"] = {
      anim = {
        { x = 1, y = 0, t = 0.125 },
        { x = 0, y = 0, t = 0.125 }
      },
      loop = true
    },
  },
  cost = 8,
  blueprint_compat = true,
  eternal_compat = true,
  perishable_compat = true,
  add_to_deck = function(self, card, from_debuff)
    G.hand:change_size(-card.ability.extra.lost_hand_size)
    set_phanta_new2dsxl_streetpass(card)
  end,
  remove_from_deck = function(self, card, from_debuff)
    G.hand:change_size(card.ability.extra.lost_hand_size)
    set_phanta_new2dsxl_streetpass(card, true)
  end,
  calculate = function(self, card, context)
    if context.setting_blind and not (context.blueprint_card or card).getting_sliced then
      G.E_MANAGER:add_event(Event({
        trigger = 'before',
        delay = 0.5,
        func = function()
          play_sound("phanta_xhands")
          ease_hands_played(G.GAME.current_round.hands_left * (card.ability.extra.given_xhands - 1), true)
          --[[card_eval_status_text(context.blueprint_card or card, 'extra', nil, nil, nil,
            { message = "X" .. card.ability.extra.given_xhands .. " Hands", colour = G.C.BLUE, card = context.blueprint_card or card })]] --
          return true
        end
      }))

      return {
        message = "X" .. card.ability.extra.given_xhands .. " Hands",
        colour = G.C.BLUE,
        card = context
            .blueprint_card or card
      }
    end

    if card.config.center.phanta_anim_current_state ~= "streetpass" then
      if context.after and G.GAME.current_round.hands_left == 1 and not context.blueprint and card.config.center.phanta_anim_current_state ~= "low battery" then
        card:phanta_set_anim_state("low battery")
      end

      if context.end_of_round and not context.individual and not context.repetition and not context.blueprint then
        card:phanta_set_anim_state("normal")
      end
    end
  end
}

G.Phanta.centers["playerpin"] = {
  --config = { extra = {  } },
  loc_vars = function(self, info_queue, card)
    local _vars = -- Brace yourself.

        not (card.area and card.area == G.jokers) and
        { "Unknown", "", "", "(Obtain this Joker", "", "", "to learn this info)", "", "" }
        or not G.GAME.blind.in_blind and { "Unknown", "", "", "(Not currently in", "", "", "a round)", "", "" }
        or (G.deck and G.deck.cards[1] and {

          ((G.deck.cards[#G.deck.cards].base.value and not SMODS.has_no_rank(G.deck.cards[#G.deck.cards]) and localize(G.deck.cards[#G.deck.cards].base.value or 14, 'ranks'))
            or G.deck.cards[#G.deck.cards].ability.name),

          (not SMODS.has_no_rank(G.deck.cards[#G.deck.cards]) and not SMODS.has_no_suit(G.deck.cards[#G.deck.cards])) and " of " or "",

          ((SMODS.has_no_suit(G.deck.cards[#G.deck.cards]) and "")
            or localize(G.deck.cards[#G.deck.cards].base.suit, 'suits_plural')),

          G.deck.cards[#G.deck.cards - 1] and ((G.deck.cards[#G.deck.cards - 1].base.value and not SMODS.has_no_rank(G.deck.cards[#G.deck.cards - 1]) and localize(G.deck.cards[#G.deck.cards - 1].base.value or 14, 'ranks'))
            or G.deck.cards[#G.deck.cards - 1].ability.name) or "None",

          G.deck.cards[#G.deck.cards - 1] and (not SMODS.has_no_rank(G.deck.cards[#G.deck.cards - 1]) and not SMODS.has_no_suit(G.deck.cards[#G.deck.cards - 1])) and " of " or "",

          G.deck.cards[#G.deck.cards - 1] and ((SMODS.has_no_suit(G.deck.cards[#G.deck.cards - 1]) and "")
            or localize(G.deck.cards[#G.deck.cards - 1].base.suit, 'suits_plural')) or "",

          G.deck.cards[#G.deck.cards - 2] and ((G.deck.cards[#G.deck.cards - 2].base.value and not SMODS.has_no_rank(G.deck.cards[#G.deck.cards - 2]) and localize(G.deck.cards[#G.deck.cards - 2].base.value or 14, 'ranks'))
            or G.deck.cards[#G.deck.cards - 2].ability.name) or "None",

          G.deck.cards[#G.deck.cards - 2] and (not SMODS.has_no_rank(G.deck.cards[#G.deck.cards - 2]) and not SMODS.has_no_suit(G.deck.cards[#G.deck.cards - 2])) and " of " or "",

          G.deck.cards[#G.deck.cards - 2] and ((SMODS.has_no_suit(G.deck.cards[#G.deck.cards - 2]) and "")
            or localize(G.deck.cards[#G.deck.cards - 2].base.suit, 'suits_plural')) or "" })
        or { "None", "", "", "None", "", "", "None", "", "" }

    if not (card.area and card.area == G.jokers) or not G.GAME.blind.in_blind then
      _vars.colours = { G.C.JOKER_GREY, G.C.JOKER_GREY, G.C.JOKER_GREY, G.C.JOKER_GREY, G.C.JOKER_GREY, G.C.JOKER_GREY }
    else
      _vars.colours = {
        (G.deck and G.deck.cards[#G.deck.cards] and G.C.IMPORTANT) or G.C.JOKER_GREY,
        (G.deck and G.deck.cards[#G.deck.cards] and G.C.SUITS[G.deck.cards[#G.deck.cards].base.suit]) or G.C.JOKER_GREY,
        (G.deck and G.deck.cards[#G.deck.cards - 1] and G.C.IMPORTANT) or G.C.JOKER_GREY,
        (G.deck and G.deck.cards[#G.deck.cards - 1] and G.C.SUITS[G.deck.cards[#G.deck.cards - 1].base.suit]) or
        G.C.JOKER_GREY,
        (G.deck and G.deck.cards[#G.deck.cards - 2] and G.C.IMPORTANT) or G.C.JOKER_GREY,
        (G.deck and G.deck.cards[#G.deck.cards - 2] and G.C.SUITS[G.deck.cards[#G.deck.cards - 2].base.suit]) or
        G.C.JOKER_GREY,
      }
    end

    return { vars = _vars }
  end,
  rarity = 1,
  atlas = 'Phanta',
  pos = { x = 9, y = 6 },
  cost = 5,
  blueprint_compat = false,
  eternal_compat = true,
  perishable_compat = true
}

G.Phanta.centers["junpei"] = {
  config = { extra = { given_mult = 9 } },
  loc_vars = function(self, info_queue, card)
    return { vars = { card.ability.extra.given_mult } }
  end,
  rarity = 1,
  atlas = 'Phanta',
  pos = { x = 10, y = 7 },
  cost = 5,
  blueprint_compat = true,
  eternal_compat = true,
  perishable_compat = true,
  calculate = function(self, card, context)
    if context.individual and context.cardarea == G.play and context.other_card:get_id() == 5 then
      return { mult = card.ability.extra.given_mult }
    end
  end
}

G.Phanta.centers["sigma"] = {
  loc_vars = function(self, info_queue, card)
    info_queue[#info_queue + 1] = G.P_CENTERS.m_bonus
    return {}
  end,
  rarity = 1,
  atlas = 'Phanta',
  pos = { x = 11, y = 7 },
  cost = 5,
  blueprint_compat = true,
  eternal_compat = true,
  perishable_compat = true,
  calculate = function(self, card, context)
    if context.repetition and context.cardarea == G.play and SMODS.has_enhancement(context.other_card, "m_bonus") then
      return { repetitions = 1 }
    end
  end,
  enhancement_gate = "m_bonus"
}

G.Phanta.centers["carlos"] = {
  config = { extra = { added_hands = 1, current_hands = 0 } },
  loc_vars = function(self, info_queue, card)
    return { vars = { card.ability.extra.current_hands, card.ability.extra.current_hands == 1 and "" or localize("phanta_plural"), card.ability.extra.added_hands } }
  end,
  rarity = 1,
  atlas = 'Phanta',
  pos = { x = 10, y = 8 },
  cost = 5,
  blueprint_compat = true,
  eternal_compat = true,
  perishable_compat = true,
  calculate = function(self, card, context)
    if context.selling_card and context.card.ability.consumeable then
      card.ability.extra.current_hands = card.ability.extra.current_hands + card.ability.extra.added_hands
      return { message = localize("k_upgrade_ex"), colour = G.C.FILTER }
    end

    if context.setting_blind and card.ability.extra.current_hands > 0 then
      ease_hands_played(card.ability.extra.current_hands)
      local temp_hands = card.ability.extra.current_hands
      if not context.blueprint then card.ability.extra.current_hands = 0 end
      return {
        message = card.ability.extra.current_hands == 1 and localize("a_hand") or
            localize { type = 'variable', key = 'a_hands', vars = { temp_hands } },
        colour = G.C.BLUE
      }
    end
  end
}

G.Phanta.centers["q"] = {
  config = { extra = { given_xmult = 1.5, queens = {} } },
  loc_vars = function(self, info_queue, card)
    return { vars = { card.ability.extra.given_xmult } }
  end,
  rarity = 1,
  atlas = 'Phanta',
  pos = { x = 11, y = 8 },
  cost = 5,
  blueprint_compat = true,
  eternal_compat = true,
  perishable_compat = true,
  calculate = function(self, card, context)
    if context.before and not context.blueprint then
      card.ability.extra.queens = {}
      for k, v in ipairs(context.scoring_hand) do
        if #card.ability.extra.queens < 2 then
          if v:get_id() == 12 then card.ability.extra.queens[#card.ability.extra.queens + 1] = v end
        end
      end
    end

    if context.individual and context.cardarea == G.play then
      if context.other_card == card.ability.extra.queens[1] or context.other_card == card.ability.extra.queens[2] then
        return {
          xmult =
              card.ability.extra.given_xmult
        }
      end
    end
  end
}

G.Phanta.centers["diana"] = {
  config = { extra = { added_mult = 1, current_mult = 0 } },
  loc_vars = function(self, info_queue, card)
    info_queue[#info_queue + 1] = G.P_CENTERS.m_bonus
    return { vars = { card.ability.extra.added_mult, card.ability.extra.current_mult } }
  end,
  rarity = 1,
  atlas = 'Phanta',
  pos = { x = 10, y = 9 },
  cost = 5,
  blueprint_compat = true,
  eternal_compat = true,
  perishable_compat = true,
  calculate = function(self, card, context)
    if context.joker_main and card.ability.extra.current_mult > 0 then return { mult = card.ability.extra.current_mult } end

    if context.individual and context.cardarea == G.play and SMODS.has_enhancement(context.other_card, "m_bonus") then
      card.ability.extra.current_mult = card.ability.extra.current_mult + card.ability.extra.added_mult
      return { message = localize("k_upgrade_ex"), colour = G.C.FILTER, card = card }
    end
  end,
  enhancement_gate = "m_bonus"
}

G.Phanta.centers["redkeycards"] = {
  config = { extra = { added_discards = 3, will_be_spent = false, is_spent = false } },
  loc_vars = function(self, info_queue, card)
    info_queue[#info_queue + 1] = G.P_CENTERS.m_mult
    return {
      vars = { card.ability.extra.added_discards, (function()
        if card.ability.extra.is_spent then
          return
          'inactive'
        else
          return 'active'
        end
      end)() }
    }
  end,
  rarity = 2,
  atlas = 'Phanta',
  pos = { x = 6, y = 9 },
  cost = 5,
  blueprint_compat = true,
  eternal_compat = true,
  perishable_compat = true,
  calculate = function(self, card, context)
    if context.individual and context.cardarea == "unscored" and SMODS.has_enhancement(context.other_card, "m_mult") and not card.ability.extra.is_spent then
      card.ability.extra.will_be_spent = true
      ease_discard(card.ability.extra.added_discards)

      local _card = context.other_card

      G.E_MANAGER:add_event(Event({
        func = function()
          _card:juice_up()
          return true
        end
      }))
      return {
        message = localize { type = 'variable', key = 'a_discards', vars = { card.ability.extra.added_discards } },
        colour = G.C.RED
      }
    end

    -- The whole will be / is spent thing is for Blueprint compat.
    if context.after and card.ability.extra.will_be_spent then
      card.ability.extra.will_be_spent = false
      card.ability.extra.is_spent = true
    end

    if context.end_of_round then card.ability.extra.is_spent = false end
  end,
  enhancement_gate = "m_mult"
}

G.Phanta.centers["bluekeycards"] = {
  config = { extra = { added_hands = 3, will_be_spent = false, is_spent = false } },
  loc_vars = function(self, info_queue, card)
    info_queue[#info_queue + 1] = G.P_CENTERS.m_bonus
    return {
      vars = { card.ability.extra.added_hands, (function()
        if card.ability.extra.is_spent then
          return 'inactive'
        else
          return
          'active'
        end
      end)() }
    }
  end,
  rarity = 2,
  atlas = 'Phanta',
  pos = { x = 7, y = 9 },
  cost = 5,
  blueprint_compat = true,
  eternal_compat = true,
  perishable_compat = true,
  calculate = function(self, card, context)
    if context.individual and context.cardarea == "unscored" and SMODS.has_enhancement(context.other_card, "m_bonus") and not card.ability.extra.is_spent then
      card.ability.extra.will_be_spent = true
      ease_hands_played(card.ability.extra.added_hands)

      local _card = context.other_card

      G.E_MANAGER:add_event(Event({
        func = function()
          _card:juice_up()
          return true
        end
      }))
      return {
        message = localize { type = 'variable', key = 'a_hands', vars = { card.ability.extra.added_hands } },
        colour = G.C.BLUE
      }
    end

    if context.after and card.ability.extra.will_be_spent then
      card.ability.extra.will_be_spent = false
      card.ability.extra.is_spent = true
    end

    if context.end_of_round then card.ability.extra.is_spent = false end
  end,
  enhancement_gate = "m_bonus"
}

G.Phanta.centers["kylehyde"] = {
  config = { extra = { odds = 4 } },
  loc_vars = function(self, info_queue, card)
    info_queue[#info_queue + 1] = G.P_CENTERS.m_stone
    local num, denom = SMODS.get_probability_vars(card, 1, card.ability.extra.odds, "kylehyde")
    return { vars = { num, denom } }
  end,
  rarity = 2,
  atlas = 'Phanta',
  pos = { x = 7, y = 6 },
  cost = 5,
  blueprint_compat = true,
  eternal_compat = true,
  perishable_compat = true,
  calculate = function(self, card, context)
    if context.individual and context.cardarea == G.play and (context.other_card:is_suit("Hearts") or context.other_card:is_suit("Diamonds")) and SMODS.pseudorandom_probability(card, "kylehyde", 1, card.ability.extra.odds) then
      local card_temp = context.other_card
      card_temp:set_ability(G.P_CENTERS.m_stone, nil, true)
      G.E_MANAGER:add_event(Event({
        func = function()
          card_temp:juice_up()
          return true
        end
      }))
      return {
        message = "Stone",
        colour = G.C.RED,
        card = card
      }
    end
  end
}

G.Phanta.centers["inception"] = {
  config = { extra = { current_mult = 0, added_mult = 5 } },
  rarity = 1,
  atlas = 'PhantaMiscAnims4',
  pos = { x = 10, y = 4 },
  phanta_anim = {
    { x = 10, y = 4, t = 0.6 },
    { x = 11, y = 4, t = 0.08 },
    { x = 10, y = 5, t = 0.08 },
    { x = 11, y = 5, t = 0.08 }
  },
  cost = 5,
  loc_vars = function(self, info_queue, card)
    return { vars = { card.ability.extra.added_mult, card.ability.extra.current_mult + card.ability.extra.added_mult } }
  end,
  blueprint_compat = true,
  eternal_compat = true,
  perishable_compat = true,
  calculate = function(self, card, context)
    if context.joker_main then
      if not context.blueprint then
        card.ability.extra.current_mult = card.ability.extra.current_mult + card.ability.extra.added_mult
      end
      return { mult = card.ability.extra.current_mult, }
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

G.Phanta.centers["a1z26"] = {
  config = { extra = { mult = 10 } },
  rarity = 1,
  atlas = 'Phanta',
  pos = { x = 4, y = 4 },
  cost = 5,
  loc_vars = function(self, info_queue, card)
    return { vars = { card.ability.extra.mult } }
  end,
  blueprint_compat = true,
  eternal_compat = true,
  perishable_compat = true,
  calculate = function(self, card, context)
    if context.cardarea == G.play and context.individual and context.other_card == context.scoring_hand[1] and context.other_card:get_id() == 14 then
      return {
        mult =
            card.ability.extra.mult
      }
    end
  end
}

G.Phanta.centers["nonuniformday"] = {
  config = { extra = { odds = 2 } },
  loc_vars = function(self, info_queue, card)
    info_queue[#info_queue + 1] = G.P_CENTERS.m_wild
    local num, denom = SMODS.get_probability_vars(card, 1, card.ability.extra.odds, "nonuniformday")
    return { vars = { num, denom } }
  end,
  rarity = 1,
  atlas = 'Phanta',
  pos = { x = 2, y = 11 },
  cost = 5,
  blueprint_compat = true,
  eternal_compat = true,
  perishable_compat = true,
  calculate = function(self, card, context)
    if context.individual and context.cardarea == G.play and count_consumables() < G.consumeables.config.card_limit and SMODS.has_enhancement(context.other_card, "m_wild") and SMODS.pseudorandom_probability(card, "nonuniformday", 1, card.ability.extra.odds) then
      G.GAME.consumeable_buffer = G.GAME.consumeable_buffer + 1
      return {
        extra = {
          focus = card,
          message = localize('k_plus_tarot'),
          func = function()
            G.E_MANAGER:add_event(Event({
              trigger = 'before',
              delay = 0.0,
              func = function()
                play_sound("timpani")
                local new_card = create_card("Tarot", G.consumables, nil, nil, nil, nil, nil, "nonuniformday")
                new_card:add_to_deck()
                G.consumeables:emplace(new_card)
                G.GAME.consumeable_buffer = 0
                new_card:juice_up(0.3, 0.5)
                return true
              end
            }))
          end
        },
        colour = G.C.SECONDARY_SET.Tarot,
        card = card
      }
    end
  end,
  enhancement_gate = "m_wild"
}

G.Phanta.centers["badhairday"] = {
  config = { extra = { odds = 2 } },
  loc_vars = function(self, info_queue, card)
    info_queue[#info_queue + 1] = G.P_CENTERS.m_wild
    info_queue[#info_queue + 1] = G.P_CENTERS.c_lovers
    local num, denom = SMODS.get_probability_vars(card, 1, card.ability.extra.odds, "badhairday")
    return { vars = { num, denom } }
  end,
  rarity = 2,
  atlas = 'PhantaMiscAnims5',
  pos = { x = 3, y = 2 },
  phanta_anim = {
    { x = 3, y = 2, t = 1.5 }, { x = 4, y = 2, t = 0.1 },
    { x = 3, y = 2, t = 0.1 }, { x = 4, y = 2, t = 0.1 },
    { x = 3, y = 2, t = 1.8 }, { x = 4, y = 2, t = 0.1 },
    { x = 3, y = 2, t = 0.9 }, { x = 4, y = 2, t = 0.1 },
    { x = 3, y = 2, t = 2.1 }, { x = 4, y = 2, t = 0.1 },
    { x = 3, y = 2, t = 0.5 }, { x = 4, y = 2, t = 0.1 },

    { x = 5, y = 2, t = 0.15 }, { x = 6, y = 2, t = 0.1 },
    { x = 7, y = 2, t = 0.15 }, { x = 8, y = 2, t = 0.1 },
    { x = 5, y = 2, t = 0.15 }, { x = 6, y = 2, t = 0.1 },
    { x = 7, y = 2, t = 0.15 }, { x = 8, y = 2, t = 0.1 },
    { x = 5, y = 2, t = 0.15 }, { x = 6, y = 2, t = 0.1 },
    { x = 7, y = 2, t = 0.15 }, { x = 8, y = 2, t = 0.1 },

    { x = 9, y = 2, t = 0.15 },
  },
  cost = 6,
  blueprint_compat = true,
  eternal_compat = true,
  perishable_compat = true,
  calculate = function(self, card, context)
    if context.destroy_card and context.cardarea == G.hand and SMODS.has_enhancement(context.destroy_card, "m_wild") and SMODS.pseudorandom_probability(card, "badhairday", 1, card.ability.extra.odds) then
      if count_consumables() < G.consumeables.config.card_limit then
        G.GAME.consumeable_buffer = G.GAME.consumeable_buffer + 1
        G.E_MANAGER:add_event(Event({
          func = function()
            G.E_MANAGER:add_event(Event({
              func = function()
                local new_card = create_card("Tarot", G.consumables, nil, nil, nil, nil, "c_lovers", 'badhairday')
                new_card:add_to_deck()
                G.consumeables:emplace(new_card)
                G.GAME.consumeable_buffer = 0
                new_card:juice_up(0.3, 0.5)
                return true
              end
            }))
            card_eval_status_text(context.blueprint_card or card, 'extra', nil, nil, nil,
              { message = "+1 Lovers", colour = G.C.PURPLE })
            return true
          end
        }))
      end
      return { remove = true }
    end
  end,
  enhancement_gate = "m_wild"
}

G.Phanta.centers["scratchart"] = {
  config = { extra = { odds = 2 } },
  loc_vars = function(self, info_queue, card)
    info_queue[#info_queue + 1] = G.P_CENTERS.m_wild
    local num, denom = SMODS.get_probability_vars(card, 1, card.ability.extra.odds, "scratchart")
    return { vars = { num, denom } }
  end,
  rarity = 3,
  atlas = 'Phanta',
  pos = { x = 11, y = 6 },
  cost = 8,
  blueprint_compat = true,
  eternal_compat = true,
  perishable_compat = true,
  calculate = function(self, card, context)
    if context.individual and context.cardarea == "unscored" and SMODS.has_enhancement(context.other_card, "m_wild") and SMODS.pseudorandom_probability(card, "scratchart", 1, card.ability.extra.odds) then
      local _card = context.other_card
      G.E_MANAGER:add_event(Event({
        func = function()
          _card:set_edition('e_polychrome', true, true)
          _card:juice_up()
          return true
        end
      }))
      return {
        message = localize { type = 'name_text', key = 'e_polychrome', set = 'Edition' },
        colour = G.C.FILTER,
        card =
            card
      }
    end
  end,
  enhancement_gate = "m_wild"
}

G.Phanta.centers["animalinstinct"] = {
  config = { extra = { added_xmult = 0.15, current_xmult = 1 } },
  loc_vars = function(self, info_queue, card)
    return { vars = { card.ability.extra.added_xmult, card.ability.extra.current_xmult } }
  end,
  rarity = 2,
  atlas = 'Phanta',
  pos = { x = 6, y = 3 },
  cost = 6,
  blueprint_compat = true,
  eternal_compat = true,
  perishable_compat = false,
  calculate = function(self, card, context)
    if context.joker_main and card.ability.extra.current_xmult > 0 then return { xmult = card.ability.extra.current_xmult } end

    if context.remove_playing_cards and not context.blueprint then
      card.ability.extra.current_xmult = card.ability.extra.current_xmult +
          (#context.removed * card.ability.extra.added_xmult)
      return { message = localize("k_upgrade_ex"), colour = G.C.FILTER, card = card }
    end
  end
}

G.Phanta.centers["target"] = {
  config = { extra = { added_mult = 7, current_mult = 0 } },
  loc_vars = function(self, info_queue, card)
    return { vars = { card.ability.extra.added_mult, card.ability.extra.current_mult } }
  end,
  rarity = 2,
  atlas = 'PhantaMiscAnims1',
  pos = { x = 0, y = 0 },
  phanta_anim = {
    { x = 0, y = 0, t = 2 },
    { x = 1, y = 0, t = 0.1 },
    { x = 2, y = 0, t = 0.1 },
    { x = 3, y = 0, t = 0.1 },
    { x = 4, y = 0, t = 0.1 },
    { x = 5, y = 0, t = 0.1 },
    { x = 6, y = 0, t = 1 },
    { x = 7, y = 0, t = 0.1 }, { x = 8, y = 0, t = 0.1 },
    { x = 9, y = 0, t = 0.1 }, { x = 10, y = 0, t = 0.1 }, { x = 11, y = 0, t = 0.1 },
    { x = 0, y = 1, t = 0.1 }, { x = 1, y = 1, t = 0.1 }, { x = 2, y = 1, t = 0.1 },
    { x = 3, y = 1, t = 0.1 }, { x = 4, y = 1, t = 0.1 }, { x = 5, y = 1, t = 0.1 },
    { x = 6, y = 1, t = 0.1 }, { x = 7, y = 1, t = 0.1 }, { x = 8, y = 1, t = 0.1 },
    { x = 9, y = 1, t = 0.1 }, { x = 10, y = 1, t = 0.1 }, { x = 11, y = 1, t = 0.1 },
    { x = 0, y = 2, t = 0.1 }, { x = 1, y = 2, t = 0.1 }, { x = 2, y = 2, t = 0.1 },
    { x = 3, y = 2, t = 0.1 }, { x = 4, y = 2, t = 0.1 }, { x = 5, y = 2, t = 0.1 },
    { x = 6, y = 2, t = 0.1 }, { x = 7, y = 2, t = 0.1 }, { x = 8, y = 2, t = 0.1 },
    { x = 9, y = 2, t = 0.1 }, { x = 10, y = 2, t = 0.1 }, { x = 11, y = 2, t = 0.1 },
  },
  cost = 6,
  blueprint_compat = true,
  eternal_compat = true,
  perishable_compat = false,
  calculate = function(self, card, context)
    if context.joker_main and card.ability.extra.current_mult > 0 then return { mult = card.ability.extra.current_mult } end

    if context.cardarea == G.jokers and context.before and G.GAME.current_round.hands_left == 0 and not context.blueprint then
      card.ability.extra.current_mult = card.ability.extra.current_mult + card.ability.extra.added_mult
      return { message = localize("k_upgrade_ex"), colour = G.C.FILTER, card = card }
    end
  end
}

G.Phanta.centers["teastainedjoker"] = {
  config = { extra = { odds = 5, added_mult = 3, current_mult = 0 } },
  loc_vars = function(self, info_queue, card)
    info_queue[#info_queue + 1] = G.P_CENTERS.m_lucky
    local num, denom = SMODS.get_probability_vars(card, 1, card.ability.extra.odds, "teastainedjoker")
    return { vars = { num, denom, card.ability.extra.added_mult, card.ability.extra.current_mult } }
  end,
  rarity = 2,
  atlas = 'Phanta',
  pos = { x = 7, y = 0 },
  cost = 6,
  blueprint_compat = true,
  eternal_compat = true,
  perishable_compat = false,
  calculate = function(self, card, context)
    if context.joker_main and card.ability.extra.current_mult > 0 then
      return {
        mult = card.ability.extra.current_mult
      }
    end

    if context.cardarea == G.hand and not context.blueprint and context.other_card and SMODS.has_enhancement(context.other_card, "m_lucky") then
      if context.other_card.debuff then
        return {
          message = localize('k_debuffed'),
          colour = G.C.RED,
          card = card
        }
      elseif SMODS.pseudorandom_probability(card, "teastainedjoker", 1, card.ability.extra.odds) then
        card.ability.extra.current_mult = card.ability.extra.current_mult + card.ability.extra.added_mult
        return {
          message = localize('k_upgrade_ex'),
          card = card
        }
      end
    end
  end,
  enhancement_gate = "m_lucky"
}

SMODS.Sound({
  key = "teabag",
  path = "phanta_teabag.ogg",
  replace = true
})

G.Phanta.centers["teabag"] = {
  loc_vars = function(self, info_queue, card)
    info_queue[#info_queue + 1] = G.P_CENTERS.m_lucky
  end,
  rarity = 2,
  atlas = 'Phanta',
  pos = { x = 9, y = 5 },
  cost = 6,
  blueprint_compat = true,
  eternal_compat = true,
  perishable_compat = true,
  calculate = function(self, card, context)
    if context.before and G.GAME.current_round.hands_played == 1 then
      local card_a = pseudorandom_element(G.hand.cards, pseudoseed('teabaga'))
      local card_b = pseudorandom_element(G.hand.cards, pseudoseed('teabagb'))
      while card_a == card_b do
        card_b = pseudorandom_element(G.hand.cards, pseudoseed('teabagb'))
      end

      card_a:set_ability(G.P_CENTERS.m_lucky, nil, true)
      card_b:set_ability(G.P_CENTERS.m_lucky, nil, true)

      G.E_MANAGER:add_event(Event({
        func = function()
          play_sound("phanta_teabag", 1, 0.75)
          card_a:juice_up()
          card_b:juice_up()
          return true
        end
      }))

      return { message = localize("phanta_lucky") }
    end
  end
}

G.Phanta.centers["forsakenscroll"] = {
  config = { extra = { odds = 25, given_xmult = 3 } },
  loc_vars = function(self, info_queue, card)
    info_queue[#info_queue + 1] = G.P_CENTERS.m_lucky
    local num, denom = SMODS.get_probability_vars(card, count_lucky_cards(), card.ability.extra.odds, "forsakenscroll")
    return { vars = { num, denom, card.ability.extra.given_xmult } }
  end,
  rarity = 2,
  atlas = 'Phanta',
  pos = { x = 2, y = 5 },
  cost = 6,
  blueprint_compat = true,
  eternal_compat = true,
  perishable_compat = false,
  calculate = function(self, card, context)
    if context.joker_main and SMODS.pseudorandom_probability(card, "forsakenscroll", count_lucky_cards(), card.ability.extra.odds) then
      return { xmult = card.ability.extra.given_xmult }
    end
  end,
  enhancement_gate = "m_lucky"
}

G.Phanta.centers["exitsign"] = {
  config = { extra = { money_given = 10 } },
  rarity = 1,
  atlas = 'Phanta',
  pos = { x = 8, y = 1 },
  cost = 5,
  blueprint_compat = true,
  eternal_compat = true,
  perishable_compat = true,
  loc_vars = function(self, info_queue, card)
    return { vars = { card.ability.extra.money_given } }
  end,
  calculate = function(self, card, context)
    if context.joker_main and G.GAME.current_round.hands_left == 0 and G.GAME.current_round.discards_left == 0 then
      return { dollars = card.ability.extra.money_given }
    end
  end
}

G.Phanta.centers["task"] = {
  config = { extra = { added_money = 2, current_money = 0 } },
  rarity = 2,
  atlas = 'PhantaMiscAnims1',
  pos = { x = 0, y = 3 },
  phanta_anim = {
    { x = 0,                            y = 3, t = 4 },
    { x = 1,                            y = 3, t = 0.1 },
    { x = 2,                            y = 3, t = 0.075 },
    { x = 3,                            y = 3, t = 0.075 },
    { x = 4,                            y = 3, t = 0.15 },
    { x = 5,                            y = 3, t = 0.075 },
    { x = 6,                            y = 3, t = 0.075 },
    { x = 7,                            y = 3, t = 0.5 },
    { x = 8,                            y = 3, t = 0.1 },
    { x = 9,                            y = 3, t = 0.1 },
    { x = 10,                           y = 3, t = 0.1 },
    { x = 11,                           y = 3, t = 0.1 },
    { x = 0,                            y = 4, t = 0.1 },
    { x = 1,                            y = 4, t = 0.9 },
    { xrange = { first = 2, last = 6 }, y = 4, t = 0.075 },
    { x = 7,                            y = 4, t = 0.8 },
    { x = 8,                            y = 4, t = 0.3 },
    { x = 9,                            y = 4, t = 0.5 },
    { x = 10,                           y = 4, t = 1 },
    { x = 11,                           y = 4, t = 0.1 }
  },
  cost = 5,
  blueprint_compat = true,
  eternal_compat = true,
  perishable_compat = false,
  loc_vars = function(self, info_queue, card)
    return { vars = { card.ability.extra.added_money, card.ability.extra.current_money } }
  end,
  calculate = function(self, card, context)
    if context.using_consumeable and not context.blueprint then
      card.ability.extra.current_money = card.ability.extra.current_money + card.ability.extra.added_money
      return { message = localize("k_upgrade_ex"), colour = G.C.FILTER }
    end

    if context.skip_blind and card.ability.extra.current_money > 0 then
      local money = card.ability.extra.current_money
      card.ability.extra.current_money = 0
      return { dollars = money }
    end
  end
}

G.Phanta.centers["saltcircle"] = {
  config = { extra = { chips = 177 } },
  rarity = 1,
  atlas = 'PhantaMiscAnims4',
  pos = { x = 8, y = 1 },
  pos_extra = { x = 11, y = 1 },
  phanta_anim = {
    { xrange = { first = 8, last = 10 }, y = 1, t = 0.15 },
  },
  phanta_anim_extra = {
    { x = 11,                           y = 1, t = 3 },
    { xrange = { first = 0, last = 6 }, y = 2, t = 0.1 },
    { xrange = { first = 5, last = 0 }, y = 2, t = 0.1 }
  },
  cost = 4,
  blueprint_compat = false,
  eternal_compat = true,
  perishable_compat = true,
  loc_vars = function(self, info_queue, card)
    return { vars = { card.ability.extra.chips } }
  end,
  calculate = function(self, card, context)
    if context.joker_main then
      hand_chips = mod_chips(card.ability.extra.chips)
      update_hand_text({ delay = 0 }, { chips = hand_chips })
      return { message = localize("phanta_chips_equals") .. card.ability.extra.chips, colour = G.C.CHIPS, card = card }
    end
  end
}

G.Phanta.centers["thenecronomicon"] = {
  config = { extra = { chips = 666 } },
  rarity = 3,
  atlas = 'Phanta',
  pos = { x = 9, y = 8 },
  cost = 8,
  blueprint_compat = true,
  eternal_compat = true,
  perishable_compat = true,
  loc_vars = function(self, info_queue, card)
    return { vars = { card.ability.extra.chips, #count_rank(6) == 0 and localize("phanta_active") or localize("phanta_inactive") } }
  end,
  calculate = function(self, card, context)
    if context.joker_main and #count_rank(6) == 0 then
      hand_chips = mod_chips(card.ability.extra.chips)
      update_hand_text({ delay = 0 }, { chips = hand_chips })
      return { message = localize("phanta_chips_equals") .. card.ability.extra.chips, colour = G.C.CHIPS, card = card }
    end
  end
}

G.Phanta.centers["stitchintime"] = {
  config = { extra = { added_chips = 9, current_chips = 0 } },
  rarity = 2,
  atlas = 'Phanta',
  pos = { x = 8, y = 9 },
  cost = 6,
  loc_vars = function(self, info_queue, card)
    return { vars = { card.ability.extra.added_chips, card.ability.extra.current_chips } }
  end,
  blueprint_compat = true,
  eternal_compat = true,
  perishable_compat = false,
  calculate = function(self, card, context)
    if context.joker_main and card.ability.extra.current_chips > 0 then
      return {
        chips = card.ability.extra
            .current_chips
      }
    end

    if context.end_of_round and context.individual and context.cardarea == G.hand and context.other_card:get_id() == 9 and not context.blueprint then
      card.ability.extra.current_chips = card.ability.extra.current_chips + card.ability.extra.added_chips
      return { message = localize("k_upgrade_ex"), colour = G.C.FILTER }
    end
  end
}

G.Phanta.centers["shackles"] = {
  config = { extra = { chips = 250 } },
  rarity = 3,
  atlas = 'Phanta',
  pos = { x = 5, y = 5 },
  cost = 8,
  loc_vars = function(self, info_queue, card)
    return { vars = { card.ability.extra.chips } }
  end,
  blueprint_compat = true,
  eternal_compat = true,
  perishable_compat = true,
  calculate = function(self, card, context)
    if context.joker_main then return { chips = card.ability.extra.chips } end

    if context.hand_drawn and not context.blueprint then
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
}

G.Phanta.centers["ghost"] = {
  config = { extra = { x_mult = 1 } },
  rarity = 3,
  atlas = 'Phanta',
  individual_quips = true,
  pos = { x = 0, y = 0 },
  draw = function(self, card, layer)
    if self.discovered or card.params.bypass_discovery_center then
      card.children.center:draw_shader('voucher', nil, card.ARGS.send_to_shader)
    end
  end,
  cost = 8,
  blueprint_compat = true,
  eternal_compat = true,
  perishable_compat = true,
  loc_vars = function(self, info_queue, card)
    return { vars = { card.ability.extra.x_mult, 1 + (count_tarots() * card.ability.extra.x_mult) } }
  end,
  calculate = function(self, card, context)
    if context.joker_main then
      local tarot_count = count_tarots()
      if tarot_count > 0 then return { xmult = 1 + (tarot_count * card.ability.extra.x_mult) } end
    end
  end
}

G.Phanta.centers["html"] = {
  config = { extra = { given_mult = 6 } },
  rarity = 1,
  atlas = 'Phanta',
  pos = { x = 9, y = 3 },
  cost = 4,
  blueprint_compat = true,
  eternal_compat = true,
  perishable_compat = true,
  loc_vars = function(self, info_queue, card)
    return { vars = { card.ability.extra.given_mult } }
  end,
  calculate = function(self, card, context)
    if context.individual and context.cardarea == "unscored" then
      return { mult = card.ability.extra.given_mult }
    end
  end
}

G.Phanta.centers["knowledgeofthecollege"] = {
  config = { extra = { given_xmult = 3 } },
  rarity = 3,
  atlas = 'PhantaKnowledgeOfTheCollegeAnim',
  pos = { x = 0, y = 0 },
  phanta_anim = {
    { xrange = { first = 0, last = 11 }, yrange = { first = 0, last = 4 }, t = 0.15 },
    { xrange = { first = 0, last = 10 }, y = 5,                            t = 0.15 }
  },
  cost = 7,
  blueprint_compat = true,
  eternal_compat = true,
  perishable_compat = true,
  loc_vars = function(self, info_queue, card)
    return { vars = { card.ability.extra.given_xmult } }
  end,
  calculate = function(self, card, context)
    if context.individual and context.cardarea == "unscored" and context.other_card:get_id() == 14 then
      return { xmult = card.ability.extra.given_xmult }
    end
  end
}

G.Phanta.centers["theapparition"] = {
  rarity = 2,
  atlas = 'Phanta',
  pos = { x = 7, y = 1 },
  draw = function(self, card, layer)
    if self.discovered or card.params.bypass_discovery_center then
      card.children.center:draw_shader('voucher', nil, card.ARGS.send_to_shader)
    end
  end,
  cost = 6,
  blueprint_compat = true,
  eternal_compat = true,
  perishable_compat = true,
  calculate = function(self, card, context)
    if context.repetition and context.cardarea == "unscored" then
      return {
        message = localize("k_again_ex"),
        repetitions = 1
      }
    end
  end
}

G.Phanta.centers["willothewisp"] = {
  rarity = 3,
  atlas = 'Phanta',
  pos = { x = 6, y = 10 },
  cost = 8,
  blueprint_compat = true,
  eternal_compat = true,
  perishable_compat = true,
  calculate = function(self, card, context)
    if context.individual and context.cardarea == "unscored" and SMODS.has_enhancement(context.other_card, "m_phanta_ghostcard") then
      return { xmult = context.other_card.ability.h_x_mult }
    end
  end,
  enhancement_gate = "m_phanta_ghostcard"
}

G.Phanta.centers["stickercollection"] = {
  config = { extra = { retriggers = 3 } },
  rarity = 2,
  atlas = 'Phanta',
  pos = { x = 2, y = 10 },
  cost = 5,
  loc_vars = function(self, info_queue, card)
    return { vars = { card.ability.extra.retriggers } }
  end,
  blueprint_compat = true,
  eternal_compat = true,
  perishable_compat = true,
  calculate = function(self, card, context)
    if context.repetition and context.scoring_name == "phanta_junk" and get_lowest(context.scoring_hand)[1][1]:get_id() == context.other_card:get_id() and context.cardarea == G.play then
      return {
        message = localize("k_again_ex"),
        repetitions = card.ability.extra.retriggers
      }
    end
  end,
  in_pool = function()
    return G.GAME.hands["phanta_junk"].visible and Phanta.config["junk_enabled"]
  end
}

G.Phanta.centers["photocopy"] = {
  config = { extra = { odds = 2 } },
  rarity = 2,
  atlas = 'Phanta',
  pos = { x = 5, y = 11 },
  cost = 6,
  loc_vars = function(self, info_queue, card)
    local num, denom = SMODS.get_probability_vars(card, 1, card.ability.extra.odds, "photocopy")
    return { vars = { num, denom } }
  end,
  blueprint_compat = true,
  eternal_compat = true,
  perishable_compat = true,
  calculate = function(self, card, context)
    if context.cardarea == G.play and context.repetition and SMODS.pseudorandom_probability(card, "photocopy", 1, card.ability.extra.odds) then
      return { repetitions = 1 }
    end
  end
}

G.Phanta.centers["doubledice"] = {
  config = { extra = { added_mult = 4 } },
  rarity = 2,
  atlas = 'Phanta',
  pos = { x = 11, y = 10 },
  cost = 6,
  loc_vars = function(self, info_queue, card)
    return { vars = { card.ability.extra.added_mult, count_common_jokers() * card.ability.extra.added_mult } }
  end,
  blueprint_compat = true,
  eternal_compat = true,
  perishable_compat = true,
  calculate = function(self, card, context)
    if context.individual and context.cardarea == G.play and context.other_card:get_id() == 7 then
      return { mult = count_common_jokers() * card.ability.extra.added_mult }
    end
  end
}

G.Phanta.centers["prognosticator"] = {
  rarity = 2,
  atlas = 'Phanta',
  pos = { x = 9, y = 10 },
  cost = 5,
  blueprint_compat = false,
  eternal_compat = true,
  perishable_compat = true,
  add_to_deck = function(self, card, from_debuff)
    if G.consumeables then
      for _, card in pairs(G.consumeables.cards) do
        if card.ability.set == "phanta_Zodiac" and card.config.center.add_progs then
          card.config.center:add_progs(1)
        end
      end
    end
  end,
  remove_from_deck = function(self, card, from_debuff)
    if G.consumeables then
      for _, card in pairs(G.consumeables.cards) do
        if card.ability.set == "phanta_Zodiac" and card.config.center.remove_progs then
          card.config.center:remove_progs(1)
        end
      end
    end
  end,
  in_pool = function()
    return Phanta.config["zodiac_enabled"]
  end
}

G.Phanta.centers["calendar"] = {
  rarity = 2,
  atlas = 'Phanta',
  pos = { x = 10, y = 10 },
  cost = 5,
  blueprint_compat = false,
  eternal_compat = true,
  perishable_compat = true,
  loc_vars = function(self, info_queue, card)
    return { vars = { table.concat(get_names_from_zodiacs(find_current_zodiacs()), ", ") } }
  end,
  add_to_deck = function(self, card, from_debuff)
    if G.consumeables then
      for _, card in pairs(G.consumeables.cards) do
        if card.ability.set == "phanta_Zodiac" and card.config.center.add_progs and is_current_month(card) then
          card.config.center:add_progs(2)
        end
      end
    end
  end,
  remove_from_deck = function(self, card, from_debuff)
    if G.consumeables then
      for _, card in pairs(G.consumeables.cards) do
        if card.ability.set == "phanta_Zodiac" and card.config.center.remove_progs and is_current_month(card) then
          card.config.center:remove_progs(2)
        end
      end
    end
  end,
  in_pool = function()
    return Phanta.config["zodiac_enabled"]
  end
}

G.Phanta.centers["grimreaper"] = {
  rarity = 3,
  atlas = 'Phanta',
  pos = { x = 9, y = 4 },
  cost = 8,
  blueprint_compat = false,
  eternal_compat = true,
  perishable_compat = true,
  loc_vars = function(self, info_queue, card)
    info_queue[#info_queue + 1] = G.P_CENTERS.c_death
    return {}
  end,
  calculate = function(self, card, context)
    if context.destroy_card and context.cardarea == G.play and count_tarots() > 0 then
      local has_death = false
      for _, v in pairs(G.consumeables.cards) do
        if not has_death and v.ability.set == "Tarot" and v.config.center.key == "c_death" then has_death = true end
      end

      if has_death then return { remove = true } end
    end

    --[[
    if context.destroy_card and context.cardarea == G.hand and count_tarots() > 0 then
      for _, v in pairs(G.consumeables.cards) do
        if v.grim_reaper_queued_to_destroy and not v.getting_sliced then
          v.getting_sliced = true
          G.E_MANAGER:add_event(Event({
            func = function()
              card:juice_up(0.8, 0.8)
              v:start_dissolve({ G.C.RED }, nil, 1.6)
              return true
            end
          }))
        end
      end

      return false
    end
    ]] --
  end
}

G.Phanta.centers["professorlayton"] = {
  config = { extra = { out_of_odds = 4, added_mult = 50 } },
  rarity = 2,
  atlas = 'PhantaLaytonAnims',
  pos = { x = 0, y = 0 },
  phanta_anim = {
    { x = 0, y = 0, t = 1.6 }, { x = 1, y = 0, t = 0.1 },
    { x = 0, y = 0, t = 0.1 }, { x = 1, y = 0, t = 0.1 },
    { x = 0, y = 0, t = 2.4 }, { x = 1, y = 0, t = 0.1 },
    { x = 0, y = 0, t = 2.1 }, { x = 1, y = 0, t = 0.1 },
    { x = 0, y = 0, t = 1.2 }, { x = 1, y = 0, t = 0.1 }, { x = 0, y = 0, t = 0.3 },
    { x = 2, y = 0, t = 0.15 }, { x = 3, y = 0, t = 0.25 },
    { x = 4, y = 0, t = 0.25 }, { x = 3, y = 0, t = 0.25 }, { x = 4, y = 0, t = 0.2 }, { x = 3, y = 0, t = 0.35 }, { x = 2, y = 0, t = 0.15 }, { x = 1, y = 0, t = 0.1 }
  },
  cost = 6,
  blueprint_compat = true,
  eternal_compat = true,
  perishable_compat = true,
  loc_vars = function(self, info_queue, card)
    local num, denom = SMODS.get_probability_vars(card,
      next(SMODS.find_card("j_phanta_luketriton")) and card.ability.extra.out_of_odds or count_tarots(),
      card.ability.extra.out_of_odds, "professorlayton")
    return { vars = { num, denom, card.ability.extra.added_mult } }
  end,
  calculate = function(self, card, context)
    if context.joker_main then
      if next(SMODS.find_card("j_phanta_luketriton")) or SMODS.pseudorandom_probability(card, "layton", count_tarots(), card.ability.extra.out_of_odds) then
        return { mult = card.ability.extra.added_mult }
      end
    end
  end
}

G.Phanta.centers["luketriton"] = {
  config = { extra = { out_of_odds = 4, x_mult = 3 } },
  rarity = 2,
  atlas = 'PhantaLaytonAnims',
  pos = { x = 0, y = 1 },
  phanta_anim = {
    { x = 0, y = 1, t = 1.4 }, { x = 1, y = 1, t = 0.1 },
    { x = 0, y = 1, t = 1.9 }, { x = 1, y = 1, t = 0.1 },
    { x = 0, y = 1, t = 0.1 }, { x = 1, y = 1, t = 0.1 },
    { x = 0, y = 1, t = 0.1 }, { x = 1, y = 1, t = 0.1 },
    { x = 0, y = 1, t = 2.4 }, { x = 1, y = 1, t = 0.1 },
    { x = 0, y = 1, t = 1.6 }, { x = 1, y = 1, t = 0.1 }, { x = 0, y = 1, t = 0.5 },
    { x = 2, y = 1, t = 0.7 }, { x = 3, y = 1, t = 0.8 },
    { x = 5, y = 1, t = 0.15 }, { x = 4, y = 1, t = 0.15 },
    { x = 5, y = 1, t = 0.15 }, { x = 4, y = 1, t = 0.15 },
    { x = 5, y = 1, t = 0.15 }, { x = 4, y = 1, t = 0.15 },
    { x = 5, y = 1, t = 0.15 }, { x = 4, y = 1, t = 0.15 },
    { x = 5, y = 1, t = 0.15 }, { x = 4, y = 1, t = 0.15 },
    { x = 5, y = 1, t = 0.15 }, { x = 4, y = 1, t = 0.15 },
    { x = 3, y = 1, t = 0.6 }, { x = 2, y = 1, t = 0.2 },
  },
  cost = 6,
  blueprint_compat = true,
  eternal_compat = true,
  perishable_compat = true,
  loc_vars = function(self, info_queue, card)
    local num, denom = SMODS.get_probability_vars(card,
      next(SMODS.find_card("j_phanta_professorlayton")) and card.ability.extra.out_of_odds or count_planets(),
      card.ability.extra.out_of_odds, "luketriton")
    return { vars = { num, denom, card.ability.extra.x_mult } }
  end,
  calculate = function(self, card, context)
    if context.joker_main then
      if next(SMODS.find_card("j_phanta_professorlayton")) or SMODS.pseudorandom_probability(card, "luke", count_planets(), card.ability.extra.out_of_odds) then
        return { xmult = card.ability.extra.x_mult }
      end
    end
  end
}

G.Phanta.centers["jeandescole"] = {
  rarity = 2,
  atlas = 'PhantaLaytonAnims',
  pos = { x = 0, y = 6 },
  phanta_anim = {
    { x = 0, y = 6, t = 3 },
    { x = 1, y = 6, t = 0.15 },
    { x = 2, y = 6, t = 0.15 },
    { x = 3, y = 6, t = 0.175 },
    { x = 4, y = 6, t = 0.175 },
    { x = 5, y = 6, t = 0.2 },
    { x = 6, y = 6, t = 0.2 },
    { x = 5, y = 6, t = 0.2 },
    { x = 4, y = 6, t = 0.175 },
    { x = 3, y = 6, t = 0.175 },
    { x = 2, y = 6, t = 0.15 },
    { x = 1, y = 6, t = 0.15 }
  },
  cost = 6,
  blueprint_compat = false,
  eternal_compat = true,
  perishable_compat = true,
  loc_vars = function(self, info_queue, card)
    info_queue[#info_queue + 1] = G.P_CENTERS.m_stone
    info_queue[#info_queue + 1] = G.P_CENTERS.c_devil
    return {}
  end,
  calculate = function(self, card, context)
    if context.discard and context.other_card and SMODS.has_enhancement(context.other_card, "m_stone") then
      if count_consumables() < G.consumeables.config.card_limit then
        G.GAME.consumeable_buffer = G.GAME.consumeable_buffer + 1
        G.E_MANAGER:add_event(Event({
          func = function()
            G.E_MANAGER:add_event(Event({
              func = function()
                local new_card = create_card("Tarot", G.consumables, nil, nil, nil, nil, 'c_devil', 'descole')
                new_card:add_to_deck()
                G.consumeables:emplace(new_card)
                G.GAME.consumeable_buffer = 0
                new_card:juice_up(0.3, 0.5)
                return true
              end
            }))
            card_eval_status_text(card, 'extra', nil, nil, nil, { message = '+1 Devil', colour = G.C.PURPLE })
            return true
          end
        }))
      end
      return { remove = true }
    end
  end,
  enhancement_gate = "m_stone"
}

G.Phanta.centers["engineer"] = {
  rarity = 2,
  atlas = 'Phanta',
  pos = { x = 7, y = 8 },
  cost = 6,
  blueprint_compat = true,
  eternal_compat = true,
  perishable_compat = true,
  calculate = function(self, card, context)
    if context.joker_main then
      if context.scoring_name == "phanta_junk" and count_consumables() < G.consumeables.config.card_limit then
        G.GAME.consumeable_buffer = G.GAME.consumeable_buffer + 1
        G.E_MANAGER:add_event(Event({
          trigger = 'before',
          delay = 0.0,
          func = function()
            local new_card = create_card("Tarot", G.consumables, nil, nil, nil, nil, 'c_chariot', 'engineer')
            new_card:add_to_deck()
            G.consumeables:emplace(new_card)
            G.GAME.consumeable_buffer = 0
            new_card:juice_up(0.3, 0.5)
            return true
          end
        }))
        return { message = '+1 Chariot', colour = G.C.PURPLE }
      end
    end
  end,
  in_pool = function()
    return G.GAME.hands["phanta_junk"].visible and Phanta.config["junk_enabled"]
  end
}

G.Phanta.centers["medic"] = {
  rarity = 2,
  atlas = 'Phanta',
  pos = { x = 6, y = 6 },
  cost = 6,
  loc_vars = function(self, info_queue, card)
    info_queue[#info_queue + 1] = G.P_CENTERS.c_death
    return {}
  end,
  blueprint_compat = true,
  eternal_compat = true,
  perishable_compat = true,
  calculate = function(self, card, context)
    if context.first_hand_drawn then
      local eval = function() return G.GAME.current_round.hands_played == 0 end
      juice_card_until(card, eval, true)
    end

    if G.GAME.current_round.hands_played == 0 and context.cardarea == G.jokers and context.before and not (context.blueprint_card or card).getting_sliced and count_consumables() < G.consumeables.config.card_limit and #G.play.cards >= 5 then
      local counted_hearts = 0
      for i = 1, #G.play.cards do
        if G.play.cards[i]:is_suit("Hearts") then
          counted_hearts = counted_hearts + 1
        end
      end
      if counted_hearts >= 5 then
        G.GAME.consumeable_buffer = G.GAME.consumeable_buffer + 1
        G.E_MANAGER:add_event(Event({
          func = function()
            local new_card = create_card("Tarot", G.consumables, nil, nil, nil, nil, "c_death", 'medic')
            new_card:add_to_deck()
            G.consumeables:emplace(new_card)
            G.GAME.consumeable_buffer = 0
            new_card:juice_up(0.3, 0.5)
            return true
          end
        }))
        return { message = "+1 Death", colour = G.C.PURPLE }
      end
    end
  end
}

G.Phanta.centers["psychelock"] = {
  config = { extra = { xmult = 0.6 } },
  rarity = 3,
  atlas = 'PhantaMiscAnims1',
  pos = { x = 0, y = 5 },
  phanta_anim = {
    { x = 0, y = 5, t = 0.13 }, { x = 1, y = 5, t = 0.13 }, { x = 2, y = 5, t = 0.13 }, { x = 3, y = 5, t = 0.13 }, { x = 4, y = 5, t = 0.13 },
    { x = 0, y = 5, t = 0.13 }, { x = 1, y = 5, t = 0.13 }, { x = 2, y = 5, t = 0.13 }, { x = 3, y = 5, t = 0.13 }, { x = 4, y = 5, t = 0.13 },
    { x = 0, y = 5, t = 0.13 }, { x = 1, y = 5, t = 0.06 }, { x = 5, y = 5, t = 0.06 }, { x = 6, y = 5, t = 0.06 }, { x = 7, y = 5, t = 0.06 }, { x = 3, y = 5, t = 0.13 }, { x = 4, y = 5, t = 0.13 },
    { x = 0, y = 5, t = 0.13 }, { x = 1, y = 5, t = 0.13 }, { x = 2, y = 5, t = 0.13 }, { x = 3, y = 5, t = 0.13 }, { x = 4, y = 5, t = 0.13 },

    { x = 0, y = 5, t = 0.13 }, { x = 8, y = 5, t = 0.13 }, { x = 9, y = 5, t = 0.13 }, { x = 10, y = 5, t = 0.13 }, { x = 11, y = 5, t = 0.13 }, { x = 0, y = 6, t = 0.13 },
    { x = 1, y = 6, t = 0.06 }, { x = 2, y = 6, t = 0.06 }, { x = 3, y = 6, t = 0.06 }, { x = 4, y = 6, t = 0.06 }, { x = 3, y = 5, t = 0.13 }, { x = 5, y = 6, t = 0.13 },

    { x = 0, y = 5, t = 0.13 }, { x = 8, y = 5, t = 0.13 }, { x = 9, y = 5, t = 0.13 }, { x = 10, y = 5, t = 0.13 }, { x = 11, y = 5, t = 0.13 }, { x = 0, y = 6, t = 0.13 },
    { x = 1, y = 6, t = 0.06 }, { x = 2, y = 6, t = 0.06 }, { x = 3, y = 6, t = 0.06 }, { x = 4, y = 6, t = 0.06 }, { x = 3, y = 5, t = 0.13 }, { x = 5, y = 6, t = 0.13 },

    { x = 0, y = 5, t = 0.13 }, { x = 8, y = 5, t = 0.13 }, { x = 9, y = 5, t = 0.13 }, { x = 10, y = 5, t = 0.13 }, { x = 11, y = 5, t = 0.13 }, { x = 0, y = 6, t = 0.13 },
    { x = 1, y = 6, t = 0.06 }, { x = 2, y = 6, t = 0.06 }, { x = 3, y = 6, t = 0.06 }, { x = 4, y = 6, t = 0.06 }, { x = 3, y = 5, t = 0.13 }, { x = 5, y = 6, t = 0.13 },
  },
  cost = 8,
  loc_vars = function(self, info_queue, card)
    return { vars = { card.ability.extra.xmult } }
  end,
  blueprint_compat = true,
  eternal_compat = true,
  perishable_compat = true,
  calculate = function(self, card, context)
    if context.joker_main then
      local nine_count = 0
      for i = 1, #G.play.cards do
        if G.play.cards[i]:get_id() == 9 then nine_count = nine_count + 1 end
      end
      if nine_count > 0 then
        return { xmult = 1 + (nine_count * card.ability.extra.xmult) }
      end
    end
  end
}

G.Phanta.centers["milesedgeworth"] = {
  config = { extra = { xmult = 0.5 } },
  rarity = 3,
  atlas = 'Phanta',
  pos = { x = 7, y = 5 },
  cost = 8,
  loc_vars = function(self, info_queue, card)
    info_queue[#info_queue + 1] = G.P_CENTERS.m_steel
    return { vars = { card.ability.extra.xmult, 1 + (#count_steel_kings() * card.ability.extra.xmult) } }
  end,
  blueprint_compat = true,
  eternal_compat = true,
  perishable_compat = true,
  calculate = function(self, card, context)
    if context.joker_main and #count_steel_kings() * card.ability.extra.xmult > 0 then
      return { xmult = 1 + (#count_steel_kings() * card.ability.extra.xmult) }
    end
  end
}

G.Phanta.centers["apollosbracelet"] = {
  rarity = 3,
  atlas = 'PhantaMiscAnims3',
  pos = { x = 7, y = 2 },
  pos_extra = { x = 11, y = 3 },
  phanta_anim = {
    { xrange = { first = 7, last = 11 }, y = 2, t = 0.125 },
    { xrange = { first = 0, last = 10 }, y = 3, t = 0.125 },
  },
  phanta_anim_extra = {
    { x = 11,                           y = 3, t = 0.15 },
    { xrange = { first = 0, last = 4 }, y = 4, t = 0.15 },
  },
  cost = 8,
  blueprint_compat = true,
  eternal_compat = true,
  perishable_compat = true,
  calculate = function(self, card, context)
    if context.repetition and context.cardarea == G.play and next(SMODS.get_enhancements(context.other_card)) then
      return {
        message = localize("k_again_ex"),
        repetitions = 1
      }
    end
  end
}

SMODS.Sound({
  key = "diamondaxe",
  path = "phanta_diamondaxe.ogg",
  replace = true
})

G.Phanta.centers["diamondaxe"] = {
  rarity = 2,
  atlas = 'Phanta',
  pos = { x = 10, y = 2 },
  cost = 5,
  loc_vars = function(self, info_queue, card)
    info_queue[#info_queue + 1] = G.P_CENTERS.m_phanta_coppergratefresh
    return {}
  end,
  blueprint_compat = true,
  eternal_compat = true,
  perishable_compat = true,
  calculate = function(self, card, context)
    if context.individual and context.cardarea == G.play and (SMODS.has_enhancement(context.other_card, "m_phanta_coppergrateexposed") or SMODS.has_enhancement(context.other_card, "m_phanta_coppergrateweathered") or SMODS.has_enhancement(context.other_card, "m_phanta_coppergrateoxidised")) then
      if SMODS.has_enhancement(context.other_card, "m_phanta_coppergrateexposed") then
        context.other_card:set_ability(G.P_CENTERS.m_phanta_coppergratefresh, nil, true)
      elseif SMODS.has_enhancement(context.other_card, "m_phanta_coppergrateweathered") then
        context.other_card:set_ability(G.P_CENTERS.m_phanta_coppergrateexposed, nil, true)
      else
        context.other_card:set_ability(G.P_CENTERS.m_phanta_coppergrateweathered, nil, true)
      end

      local _card = context.other_card

      G.E_MANAGER:add_event(Event({
        func = function()
          card:juice_up()
          _card:juice_up()
          play_sound("phanta_diamondaxe", 0.9 + math.random() * 0.1, 0.5)
          return true
        end
      }))
    end
  end
}

G.Phanta.centers["honeydew"] = {
  rarity = 2,
  atlas = 'PhantaMiscAnims3',
  pos = { x = 0, y = 0 },
  pos_extra = { x = 9, y = 0 },
  phanta_anim = {
    { xrange = { first = 0, last = 11 }, y = 0, t = 0.125 },
    { xrange = { first = 0, last = 5 },  y = 1, t = 0.125 },
  },
  phanta_anim_extra = {
    { x = 6, y = 1, t = 0.9 }, { x = 7, y = 1, t = 0.1 },
    { x = 6, y = 1, t = 0.3 }, { x = 7, y = 1, t = 0.1 },
    { x = 6, y = 1, t = 1.6 }, { x = 7, y = 1, t = 0.1 },
    { x = 6, y = 1, t = 1.9 }, { x = 7, y = 1, t = 0.1 },
    { x = 6, y = 1, t = 0.3 }, { x = 7, y = 1, t = 0.1 },
    { x = 6, y = 1, t = 0.6 }, { x = 7, y = 1, t = 0.1 },
    { x = 6, y = 1, t = 0.15 }, { x = 8, y = 1, t = 0.15 }, { x = 9, y = 1, t = 0.15 }, { x = 8, y = 1, t = 0.15 },
    { x = 6, y = 1, t = 0.15 }, { x = 8, y = 1, t = 0.15 }, { x = 9, y = 1, t = 0.15 }, { x = 8, y = 1, t = 0.15 },
    { x = 6, y = 1, t = 0.05 }, { x = 7, y = 1, t = 0.1 }, { x = 8, y = 1, t = 0.15 }, { x = 9, y = 1, t = 0.15 }, { x = 8, y = 1, t = 0.15 },
    { x = 6, y = 1, t = 1.7 }, { x = 7, y = 1, t = 0.1 },
    { x = 6, y = 1, t = 0.3 }, { x = 7, y = 1, t = 0.1 },
    { x = 6, y = 1, t = 0.2 }, { x = 7, y = 1, t = 0.1 }, { x = 10, y = 1, t = 0.1 }, { x = 11, y = 1, t = 0.1 }, { x = 10, y = 1, t = 0.1 },
  },
  cost = 6,
  loc_vars = function(self, info_queue, card)
    info_queue[#info_queue + 1] = G.P_CENTERS.e_phanta_waxed
    return {}
  end,
  blueprint_compat = true,
  eternal_compat = true,
  perishable_compat = true,
  calculate = function(self, card, context)
    if context.first_hand_drawn then
      local candidates = {}
      for i = 1, #G.hand.cards do
        if not (G.hand.cards[i].edition and G.hand.cards[i].edition.key ~= nil) then
          candidates[#candidates + 1] = G
              .hand.cards[i]
        end
      end
      if #candidates > 0 then
        local chosen_card = pseudorandom_element(candidates, pseudoseed("honeydew"))
        chosen_card:set_edition("e_phanta_waxed")
        card:juice_up()
        return { message = localize("phanta_waxed", "labels"), colour = G.C.FILTER }
      end
    end
  end,
  set_badges = function(self, card, badges)
    badges[#badges + 1] = create_badge(localize('credit_goat3730'), G.C.PHANTA.MISC_COLOURS.PHANTA, G.C.WHITE, 1)
  end
}

G.Phanta.centers["candle"] = {
  config = { extra = { added_xmult = 0.25, current_xmult = 1, is_contestant = true } },
  rarity = 2,
  atlas = 'PhantaMiscAnims3',
  pos = { x = 7, y = 7 },
  pos_extra = { x = 11, y = 7 },
  phanta_anim = {
    { xrange = { first = 7, last = 10 }, y = 7, t = 0.1 }
  },
  phanta_anim_extra = { -- The timing here is weird, so that the background and foreground don't synchronise.
    { x = 11, y = 7, t = 0.098765321 },
    { x = 3,  y = 8, t = 0.098765321 },
    { x = 7,  y = 8, t = 0.098765321 },
    { x = 5,  y = 8, t = 0.098765321 },
    { x = 6,  y = 8, t = 0.098765321 },
    { x = 7,  y = 8, t = 0.098765321 },
    { x = 5,  y = 8, t = 0.098765321 },
    { x = 6,  y = 8, t = 0.098765321 },
    { x = 7,  y = 8, t = 0.098765321 },
    { x = 2,  y = 8, t = 0.098765321 },
    { x = 0,  y = 8, t = 0.098765321 },
    { x = 10, y = 8, t = 0.098765321 },
    { x = 11, y = 8, t = 0.098765321 },
    { x = 0,  y = 9, t = 0.098765321 },
    { x = 1,  y = 9, t = 0.098765321 },
    { x = 11, y = 8, t = 0.098765321 },
    { x = 0,  y = 9, t = 0.098765321 },
    { x = 1,  y = 9, t = 0.098765321 },
    { x = 11, y = 8, t = 0.098765321 },
    { x = 9,  y = 8, t = 0.098765321 },

    { x = 1,  y = 8, t = 0.098765321 },
    { x = 2,  y = 8, t = 0.098765321 },
    { x = 6,  y = 8, t = 0.098765321 },
    { x = 7,  y = 8, t = 0.098765321 },
    { x = 5,  y = 8, t = 0.098765321 },
    { x = 6,  y = 8, t = 0.098765321 },
    { x = 7,  y = 8, t = 0.098765321 },
    { x = 5,  y = 8, t = 0.098765321 },
    { x = 6,  y = 8, t = 0.098765321 },
    { x = 4,  y = 8, t = 0.098765321 },
    { x = 11, y = 7, t = 0.098765321 },
    { x = 9,  y = 8, t = 0.098765321 },
    { x = 1,  y = 9, t = 0.098765321 },
    { x = 11, y = 8, t = 0.098765321 },
    { x = 0,  y = 9, t = 0.098765321 },
    { x = 1,  y = 9, t = 0.098765321 },
    { x = 11, y = 8, t = 0.098765321 },
    { x = 0,  y = 9, t = 0.098765321 },
    { x = 1,  y = 9, t = 0.098765321 },
    { x = 8,  y = 8, t = 0.098765321 },

    { x = 0,  y = 8, t = 0.098765321 },
    { x = 4,  y = 8, t = 0.098765321 },
    { x = 5,  y = 8, t = 0.098765321 },
    { x = 6,  y = 8, t = 0.098765321 },
    { x = 7,  y = 8, t = 0.098765321 },
    { x = 5,  y = 8, t = 0.098765321 },
    { x = 6,  y = 8, t = 0.098765321 },
    { x = 7,  y = 8, t = 0.098765321 },
    { x = 5,  y = 8, t = 0.098765321 },
    { x = 3,  y = 8, t = 0.098765321 },
    { x = 1,  y = 8, t = 0.098765321 },
    { x = 8,  y = 8, t = 0.098765321 },
    { x = 0,  y = 9, t = 0.098765321 },
    { x = 1,  y = 9, t = 0.098765321 },
    { x = 11, y = 8, t = 0.098765321 },
    { x = 0,  y = 9, t = 0.098765321 },
    { x = 1,  y = 9, t = 0.098765321 },
    { x = 11, y = 8, t = 0.098765321 },
    { x = 0,  y = 9, t = 0.098765321 },
    { x = 10, y = 8, t = 0.098765321 }
  },
  cost = 6,
  blueprint_compat = true,
  eternal_compat = true,
  perishable_compat = false,
  loc_vars = function(self, info_queue, card)
    return { vars = { card.ability.extra.added_xmult, card.ability.extra.current_xmult } }
  end,
  calculate = function(self, card, context)
    if context.joker_main then return { xmult = card.ability.extra.current_xmult } end

    if context.setting_blind and not (context.blueprint_card or card).getting_sliced then
      local destructable_tarot = {}
      for i = 1, count_consumables() do
        if G.consumeables.cards[i].ability.set == "Tarot" and not G.consumeables.cards[i].getting_sliced and not G.consumeables.cards[i].ability.eternal then
          destructable_tarot[#destructable_tarot + 1] = G.consumeables.cards[i]
        end
      end
      local tarot_to_destroy = #destructable_tarot > 0 and pseudorandom_element(destructable_tarot, pseudoseed("candle")) or
          nil

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
            message = localize { type = 'variable', key = 'a_xmult', vars = { card.ability.extra.current_xmult } },
            colour = G.C.RED,
            card = card
          })
        end
        return nil, true
      end
    end
  end,
  set_badges = function(self, card, badges)
    if next(SMODS.find_mod("GSBFDI")) then
      badges[#badges + 1] = create_badge(localize('contestant_joker_badge'), G.C.BFDI.MISC_COLOURS.BFDI_GREEN, G.C.WHITE,
        1)
    end
  end
}

G.Phanta.centers["goo"] = {
  config = { extra = { is_contestant = true } },
  rarity = 2,
  atlas = 'PhantaMiscAnims3',
  pos = { x = 2, y = 9 },
  pos_extra = { x = 1, y = 10 },
  phanta_anim = {
    { x = 2,                             y = 9,  t = 3 },
    { xrange = { first = 3, last = 11 }, y = 9,  t = 0.1 },
    { x = 0,                             y = 10, t = 3 },
    { xrange = { first = 11, last = 3 }, y = 9,  t = 0.1 },
  },
  phanta_anim_extra = {
    { x = 1, y = 10, t = 1.6 }, { x = 2, y = 10, t = 0.1 },
    { x = 1, y = 10, t = 2.3 }, { x = 2, y = 10, t = 0.1 }, { x = 1, y = 10, t = 0.1 }, { x = 2, y = 10, t = 0.1 },
    { x = 1, y = 10, t = 2.6 }, { x = 2, y = 10, t = 0.1 },
    { x = 1, y = 10, t = 1.3 }, { x = 2, y = 10, t = 0.1 },
    { x = 1,                             y = 10, t = 1.6 }, { x = 2, y = 10, t = 0.1 },

    { x = 3,                             y = 10, t = 0.12 },
    { xrange = { first = 4, last = 11 }, y = 10, t = 0.06 },
    { xrange = { first = 0, last = 1 },  y = 11, t = 0.06 },

    { x = 3,                             y = 10, t = 0.2 },
    { xrange = { first = 4, last = 11 }, y = 10, t = 0.06 },
    { xrange = { first = 0, last = 1 },  y = 11, t = 0.06 },

    { x = 3,                             y = 10, t = 0.2 },
    { xrange = { first = 4, last = 11 }, y = 10, t = 0.06 },
    { xrange = { first = 0, last = 1 },  y = 11, t = 0.06 },

    { x = 3,                             y = 10, t = 0.2 }
  },
  cost = 6,
  loc_vars = function(self, info_queue, card)
    info_queue[#info_queue + 1] = G.P_SEALS["Blue"]
    return {}
  end,
  blueprint_compat = false,
  eternal_compat = true,
  perishable_compat = true,
  calculate = function(self, card, context)
    if context.cardarea == G.jokers and context.before and G.GAME.current_round.hands_left == 0 then
      G.E_MANAGER:add_event(Event({
        func = function()
          context.full_hand[1]:set_seal('Blue', true, true)
          context.full_hand[1]:juice_up()
          return true
        end
      }))
      return { message = localize("phanta_created_blue_seal"), colour = G.C.BLUE, card = card }
    end
  end,
  set_badges = function(self, card, badges)
    if next(SMODS.find_mod("GSBFDI")) then
      badges[#badges + 1] = create_badge(localize('contestant_joker_badge'), G.C.BFDI.MISC_COLOURS.BFDI_GREEN, G.C.WHITE,
        1)
    end
  end
}

G.Phanta.centers["web"] = {
  config = { extra = { given_mult = 15, counted_spades = 0, required_spades = 2 } },
  rarity = 1,
  atlas = 'Phanta',
  pos = { x = 4, y = 11 },
  cost = 4,
  loc_vars = function(self, info_queue, card)
    return { vars = { card.ability.extra.given_mult, card.ability.extra.required_spades } }
  end,
  blueprint_compat = true,
  eternal_compat = true,
  perishable_compat = true,
  calculate = function(self, card, context)
    if context.joker_main and card.ability.extra.counted_spades >= card.ability.extra.required_spades then
      return { mult = card.ability.extra.given_mult }
    end

    if context.cardarea == G.jokers and context.before and not context.blueprint then
      card.ability.extra.counted_spades = 0
    end

    if context.cardarea == G.hand and not context.blueprint and context.other_card and context.other_card:is_suit("Spades") then
      card.ability.extra.counted_spades = card.ability.extra.counted_spades + 1
    end
  end
}

G.Phanta.centers["cutcorners"] = {
  config = { extra = { added_mult = 1, current_mult = 0, no_of_cards = 3 } },
  rarity = 1,
  atlas = 'Phanta',
  pos = { x = 6, y = 0 },
  cost = 4,
  loc_vars = function(self, info_queue, card)
    return { vars = { card.ability.extra.added_mult, card.ability.extra.no_of_cards, card.ability.extra.current_mult } }
  end,
  blueprint_compat = true,
  eternal_compat = true,
  perishable_compat = false,
  calculate = function(self, card, context)
    if context.joker_main and card.ability.extra.current_mult > 0 then
      return { mult = card.ability.extra.current_mult }
    end

    if context.cardarea == G.jokers and context.before and not context.blueprint and #G.play.cards <= card.ability.extra.no_of_cards then
      card.ability.extra.current_mult = card.ability.extra.current_mult + card.ability.extra.added_mult
      return {
        message = localize('k_upgrade_ex'),
        colour = G.C.FILTER,
        card = card
      }
    end
  end
}

G.Phanta.centers["blottedjoker"] = {
  config = { extra = { added_chips = 30, current_chips = 0 } },
  rarity = 2,
  atlas = 'Phanta',
  pos = { x = 11, y = 0 },
  cost = 6,
  loc_vars = function(self, info_queue, card)
    info_queue[#info_queue + 1] = G.P_CENTERS.m_bonus
    return {}
  end,
  blueprint_compat = false,
  eternal_compat = true,
  perishable_compat = true,
  calculate = function(self, card, context)
    if context.cardarea == G.play and context.individual and (context.other_card:get_id() == 2 or context.other_card:get_id() == 3 or context.other_card:get_id() == 4 or context.other_card:get_id() == 5) then
      local _card = context.other_card
      _card:set_ability("m_bonus", nil, true)
      G.E_MANAGER:add_event(Event({
        func = function()
          _card:juice_up()
          return true
        end
      }))
      return { message = localize("k_bonus"), colour = G.C.FILTER }
    end
  end
}

G.Phanta.centers["bloodpact"] = {
  config = { extra = { xmult = 2 } },
  rarity = 2,
  atlas = 'Phanta',
  pos = { x = 3, y = 5 },
  cost = 4,
  loc_vars = function(self, info_queue, card)
    return { vars = { card.ability.extra.xmult } }
  end,
  blueprint_compat = true,
  eternal_compat = true,
  perishable_compat = true,
  calculate = function(self, card, context)
    if context.joker_main then
      return { xmult = card.ability.extra.xmult }
    end
    if context.modify_scoring_hand and not context.blueprint then
      return { remove_from_hand = true }
    end
  end
}

G.Phanta.centers["tnetennba"] = {
  config = { extra = { added_mult = 3, current_mult = 0 } },
  rarity = 2,
  atlas = 'PhantaMiscAnims2',
  pos = { x = 3, y = 12 },
  phanta_anim = {
    { x = 3, y = 12, t = 1.1 }, { x = 4, y = 12, t = 0.1 },
    { x = 3, y = 12, t = 0.6 }, { x = 4, y = 12, t = 0.1 },
    { x = 5, y = 12, t = 1.6 }, { x = 4, y = 12, t = 0.05 }, { x = 7, y = 12, t = 0.05 },
    { x = 8, y = 12, t = 0.8 }, { x = 7, y = 12, t = 0.1 },
    { x = 8, y = 12, t = 1.7 }, { x = 7, y = 12, t = 0.1 },
    { x = 6, y = 12, t = 0.3 }, { x = 7, y = 12, t = 0.1 },
    { x = 6, y = 12, t = 1.4 }, { x = 7, y = 12, t = 0.1 }, { x = 4, y = 12, t = 0.05 },
    { x = 9, y = 12, t = 0.9 }, { x = 10, y = 12, t = 0.1 },
    { x = 11, y = 12, t = 1.3 }, { x = 4, y = 12, t = 0.1 },
    { x = 11, y = 12, t = 0.7 }, { x = 4, y = 12, t = 0.1 },
  },
  cost = 6,
  loc_vars = function(self, info_queue, card)
    return { vars = { card.ability.extra.added_mult, card.ability.extra.current_mult } }
  end,
  blueprint_compat = true,
  eternal_compat = true,
  perishable_compat = false,
  calculate = function(self, card, context)
    if context.joker_main and card.ability.extra.current_mult > 0 then
      return { mult = card.ability.extra.current_mult }
    end

    if context.cardarea == G.jokers and context.before and not context.blueprint then
      if next(get_straight(G.hand.cards)) then
        card.ability.extra.current_mult = card.ability.extra.current_mult + card.ability.extra.added_mult
        return {
          message = localize('k_upgrade_ex'),
          colour = G.C.FILTER,
          card = card
        }
      end
    end
  end
}

G.Phanta.centers["technicolourjoker"] = {
  config = { extra = { given_mult = 7 } },
  rarity = 1,
  atlas = 'Phanta',
  pos = { x = 9, y = 1 },
  cost = 4,
  loc_vars = function(self, info_queue, card)
    return { vars = { card.ability.extra.given_mult } }
  end,
  blueprint_compat = true,
  eternal_compat = true,
  perishable_compat = true,
  calculate = function(self, card, context)
    if context.individual and context.cardarea == G.play and SMODS.has_enhancement(context.other_card, "m_wild") then
      return { mult = card.ability.extra.given_mult }
    end
  end,
  enhancement_gate = "m_wild"
}

G.Phanta.centers["identity"] = {
  config = { extra = { no_of_cards = 2 } },
  rarity = 2,
  atlas = 'Phanta',
  pos = { x = 1, y = 0 },
  cost = 8,
  loc_vars = function(self, info_queue, card)
    return { vars = { card.ability.extra.no_of_cards } }
  end,
  draw = function(self, card, layer)
    if self.discovered or card.params.bypass_discovery_center then
      card.children.center:draw_shader('voucher', nil, card.ARGS.send_to_shader)
    end
  end,
  blueprint_compat = false,
  eternal_compat = false,
  perishable_compat = false,
  phanta_shatters = true,
  calculate = function(self, card, context)
    if context.ending_shop and not context.repetition and not context.blueprint then
      local _card = card
      G.E_MANAGER:add_event(Event({
        func = function()
          play_sound('timpani')
          local creation_event = Event({
            delay = 0.3,
            blockable = false,
            func = function()
              local new_card = create_card("Spectral", G.consumables, nil, nil, nil, nil)
              new_card:set_edition({ negative = true })
              new_card:add_to_deck()
              G.consumeables:emplace(new_card)
              return true
            end
          })
          for i = 1, card.ability.extra.no_of_cards, 1 do G.E_MANAGER:add_event(creation_event) end

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
              return true
            end
          }))
          return true
        end
      }))
      card_eval_status_text(_card, 'extra', nil, nil, nil, { message = "Shattered!", card = _card })
      return true
    end
  end
}

G.Phanta.centers["tricolour"] = {
  config = { extra = { mult = 17 } },
  rarity = 1,
  atlas = 'PhantaMiscAnims2',
  pos = { x = 2, y = 8 },
  phanta_anim = {
    { xrange = { first = 2, last = 11 }, y = 8,  t = 0.05 },
    { xrange = { first = 0, last = 11 }, y = 9,  t = 0.05 },
    { xrange = { first = 0, last = 9 },  y = 10, t = 0.05 },
  },
  cost = 5,
  loc_vars = function(self, info_queue, card)
    return { vars = { card.ability.extra.mult } }
  end,
  blueprint_compat = true,
  eternal_compat = true,
  perishable_compat = true,
  calculate = function(self, card, context)
    if context.joker_main then
      local wilds = 0
      local counted_suits = {}
      for i = 1, #context.scoring_hand do
        if not SMODS.has_any_suit(context.scoring_hand[i]) then
          local is_new = true
          for j = 1, #counted_suits do
            if context.scoring_hand[i].base.suit == counted_suits[j] then is_new = false end
          end
          if is_new then counted_suits[#counted_suits + 1] = context.scoring_hand[i].base.suit end
        else
          wilds = wilds + 1
        end
      end

      if #counted_suits <= 3 and #counted_suits + wilds >= 3 then
        return { mult = card.ability.extra.mult }
      end
    end
  end
}

G.Phanta.centers["beadnecklace"] = {
  config = { extra = { added_mult = 1, current_mult = 0 } },
  rarity = 2,
  atlas = 'Phanta',
  pos = { x = 2, y = 9 },
  cost = 5,
  loc_vars = function(self, info_queue, card)
    return { vars = { card.ability.extra.added_mult, card.ability.extra.current_mult } }
  end,
  blueprint_compat = true,
  eternal_compat = true,
  perishable_compat = false,
  calculate = function(self, card, context)
    if context.joker_main and card.ability.extra.current_mult > 0 then return { mult = card.ability.extra.current_mult } end

    if context.before and not context.blueprint and (next(context.poker_hands['Straight']) or next(context.poker_hands['Straight Flush'])) then
      local suits = {
        ['Hearts'] = 0,
        ['Diamonds'] = 0,
        ['Spades'] = 0,
        ['Clubs'] = 0
      }
      for i = 1, #context.scoring_hand do
        if not SMODS.has_any_suit(context.scoring_hand[i]) then
          if context.scoring_hand[i]:is_suit('Hearts', true) and suits["Hearts"] == 0 then
            suits["Hearts"] = suits["Hearts"] + 1
          elseif context.scoring_hand[i]:is_suit('Diamonds', true) and suits["Diamonds"] == 0 then
            suits["Diamonds"] = suits["Diamonds"] + 1
          elseif context.scoring_hand[i]:is_suit('Spades', true) and suits["Spades"] == 0 then
            suits["Spades"] = suits["Spades"] + 1
          elseif context.scoring_hand[i]:is_suit('Clubs', true) and suits["Clubs"] == 0 then
            suits["Clubs"] = suits["Clubs"] + 1
          end
        end
      end
      for i = 1, #context.scoring_hand do
        if SMODS.has_any_suit(context.scoring_hand[i]) then
          if suits["Hearts"] == 0 then
            suits["Hearts"] = suits["Hearts"] + 1
          elseif suits["Diamonds"] == 0 then
            suits["Diamonds"] = suits["Diamonds"] + 1
          elseif suits["Spades"] == 0 then
            suits["Spades"] = suits["Spades"] + 1
          elseif suits["Clubs"] == 0 then
            suits["Clubs"] = suits["Clubs"] + 1
          end
        end
      end
      if suits["Hearts"] > 0 or suits["Diamonds"] > 0 or suits["Spades"] > 0 or suits["Clubs"] > 0 then
        card.ability.extra.current_mult = card.ability.extra.current_mult +
            ((suits["Hearts"] + suits["Diamonds"] + suits["Spades"] + suits["Clubs"]) * card.ability.extra.added_mult)
        return {
          message = localize('k_upgrade_ex'),
          colour = G.C.FILTER,
          card = card
        }
      end
    end
  end
}

G.Phanta.centers["p5joker"] = {
  config = { extra = { mult_per_hand = 2, current_mult = 0 } },
  rarity = 2,
  atlas = 'Phanta',
  pos = { x = 2, y = 0 },
  cost = 5,
  loc_vars = function(self, info_queue, card)
    return { vars = { card.ability.extra.mult_per_hand, card.ability.extra.current_mult } }
  end,
  blueprint_compat = true,
  eternal_compat = true,
  perishable_compat = false,
  calculate = function(self, card, context)
    if context.joker_main and card.ability.extra.current_mult > 0 then return { mult = card.ability.extra.current_mult } end

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

G.Phanta.centers["crescent"] = {
  rarity = 1,
  atlas = 'Phanta',
  pos = { x = 3, y = 0 },
  cost = 4,
  blueprint_compat = true,
  eternal_compat = true,
  perishable_compat = true,
  calculate = function(self, card, context)
    if context.selling_card and context.card.config.center.set == "Planet" and count_consumables() <= G.consumeables.config.card_limit then
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
    end
  end
}

G.Phanta.centers["shoppinglist"] = {
  config = { extra = { added_mult = 1, current_mult = 0 } },
  rarity = 1,
  atlas = 'Phanta',
  pos = { x = 7, y = 4 },
  cost = 4,
  loc_vars = function(self, info_queue, card)
    return { vars = { card.ability.extra.added_mult, card.ability.extra.current_mult } }
  end,
  blueprint_compat = true,
  eternal_compat = true,
  perishable_compat = false,
  calculate = function(self, card, context)
    if context.joker_main and card.ability.extra.current_mult > 0 then
      return { mult = card.ability.extra.current_mult }
    end

    if context.buying_card and context.card ~= card and not context.blueprint then
      card.ability.extra.current_mult = card.ability.extra.current_mult + card.ability.extra.added_mult
      return {
        message = localize('k_upgrade_ex'),
        card = card
      }
    end
  end
}

G.Phanta.centers["ransomnote"] = {
  config = { extra = { money = 5 } },
  rarity = 2,
  atlas = 'Phanta',
  pos = { x = 3, y = 10 },
  cost = 4,
  loc_vars = function(self, info_queue, card)
    return { vars = { card.ability.extra.money } }
  end,
  blueprint_compat = true,
  eternal_compat = true,
  perishable_compat = true,
  calculate = function(self, card, context)
    if context.selling_card and context.card.config.center.set == "Joker" and not card.getting_sliced then
      return { dollars = card.ability.extra.money }
    end
  end
}

G.Phanta.centers["purplejoker"] = {
  config = { extra = { mult_per_hand = 1, current_mult = 0 } },
  rarity = 1,
  atlas = 'Phanta',
  pos = { x = 3, y = 9 },
  cost = 4,
  loc_vars = function(self, info_queue, card)
    return { vars = { card.ability.extra.mult_per_hand, card.ability.extra.current_mult } }
  end,
  blueprint_compat = true,
  eternal_compat = true,
  perishable_compat = false,
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

G.Phanta.centers["monetjoker"] = {
  rarity = 3,
  atlas = 'Phanta',
  pos = { x = 4, y = 9 },
  cost = 8,
  blueprint_compat = true,
  eternal_compat = true,
  perishable_compat = true,
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
        end)
      }))
      return {
        message = localize('k_plus_tarot'),
        card = card
      }
    end
  end
}

G.Phanta.centers["charcoaljoker"] = {
  config = { extra = { added_chips = 15, current_chips = 0 } },
  rarity = 2,
  atlas = 'Phanta',
  pos = { x = 4, y = 5 },
  cost = 6,
  loc_vars = function(self, info_queue, card)
    return { vars = { card.ability.extra.added_chips, card.ability.extra.current_chips } }
  end,
  blueprint_compat = true,
  eternal_compat = true,
  perishable_compat = false,
  calculate = function(self, card, context)
    if context.joker_main and card.ability.extra.current_chips > 0 then return { chips = card.ability.extra.current_chips } end

    if context.discard and context.other_card == context.full_hand[#context.full_hand] and not context.blueprint then
      local non_spades_present = false
      for k, v in ipairs(context.full_hand) do
        if not v:is_suit("Spades") then non_spades_present = true end
      end
      if not non_spades_present then
        card.ability.extra.current_chips = card.ability.extra.current_chips + card.ability.extra.added_chips
        return {
          message = localize('k_upgrade_ex'),
          card = card
        }
      end
    end
  end
}

G.Phanta.centers["goldenfiddle"] = {
  rarity = 2,
  atlas = 'Phanta',
  pos = { x = 4, y = 0 },
  cost = 6,
  loc_vars = function(self, info_queue, card)
    info_queue[#info_queue + 1] = G.P_CENTERS.c_devil
    info_queue[#info_queue + 1] = G.P_CENTERS.c_chariot
    return {}
  end,
  blueprint_compat = true,
  eternal_compat = true,
  perishable_compat = true,
  calculate = function(self, card, context)
    if context.setting_blind and not (context.blueprint_card or self).getting_sliced and count_consumables() < G.consumeables.config.card_limit then
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
            end
          }))
          card_eval_status_text(context.blueprint_card or card, 'extra', nil, nil, nil,
            { message = chosen_message, colour = G.C.PURPLE })
          return true
        end
      }))
    end
  end
}

G.Phanta.centers["reverie"] = {
  rarity = 2,
  atlas = 'PhantaMiscAnims1',
  pos = { x = 6, y = 6 },
  phanta_anim = {
    { xrange = { first = 6, last = 9 }, y = 6, t = 0.1 }
  },
  cost = 6,
  loc_vars = function(self, info_queue, card)
    info_queue[#info_queue + 1] = G.P_CENTERS.c_temperance
    info_queue[#info_queue + 1] = G.P_CENTERS.c_tower
    return {}
  end,
  blueprint_compat = true,
  eternal_compat = true,
  perishable_compat = true,
  calculate = function(self, card, context)
    if context.setting_blind and not (context.blueprint_card or self).getting_sliced and count_consumables() < G.consumeables.config.card_limit then
      G.GAME.consumeable_buffer = G.GAME.consumeable_buffer + 1
      G.E_MANAGER:add_event(Event({
        func = function()
          local chosen_message = '+1 Temperance'
          G.E_MANAGER:add_event(Event({
            func = function()
              local chosen_card = 'c_temperance'
              if pseudorandom('reverie', 1, 2) == 1 then
                chosen_card = 'c_tower'
                chosen_message = '+1 Tower'
              end
              local new_card = create_card("Tarot", G.consumables, nil, nil, nil, nil, chosen_card, 'reverie')
              new_card:add_to_deck()
              G.consumeables:emplace(new_card)
              G.GAME.consumeable_buffer = 0
              new_card:juice_up(0.3, 0.5)
              return true
            end
          }))
          card_eval_status_text(context.blueprint_card or card, 'extra', nil, nil, nil,
            { message = chosen_message, colour = G.C.PURPLE })
          return true
        end
      }))
    end
  end
}

G.Phanta.centers["sees"] = {
  rarity = 2,
  atlas = 'Phanta',
  pos = { x = 2, y = 4 },
  cost = 6,
  loc_vars = function(self, info_queue, card)
    info_queue[#info_queue + 1] = G.P_CENTERS.c_moon
    info_queue[#info_queue + 1] = G.P_CENTERS.c_justice
    return {}
  end,
  blueprint_compat = true,
  eternal_compat = true,
  perishable_compat = true,
  calculate = function(self, card, context)
    if context.setting_blind and not (context.blueprint_card or self).getting_sliced and count_consumables() < G.consumeables.config.card_limit then
      G.GAME.consumeable_buffer = G.GAME.consumeable_buffer + 1
      G.E_MANAGER:add_event(Event({
        func = function()
          local chosen_message = '+1 Moon'
          G.E_MANAGER:add_event(Event({
            func = function()
              local chosen_card = 'c_moon'
              if pseudorandom('sees', 1, 2) == 1 then
                chosen_card = 'c_justice'
                chosen_message = '+1 Justice'
              end
              local new_card = create_card("Tarot", G.consumables, nil, nil, nil, nil, chosen_card, 'sees')
              new_card:add_to_deck()
              G.consumeables:emplace(new_card)
              G.GAME.consumeable_buffer = 0
              new_card:juice_up(0.3, 0.5)
              return true
            end
          }))
          card_eval_status_text(context.blueprint_card or card, 'extra', nil, nil, nil,
            { message = chosen_message, colour = G.C.PURPLE })
          return true
        end
      }))
    end
  end
}

G.Phanta.centers["scissorsaresharp"] = {
  rarity = 2,
  atlas = 'Phanta',
  pos = { x = 4, y = 7 },
  cost = 7,
  loc_vars = function(self, info_queue, card)
    info_queue[#info_queue + 1] = G.P_CENTERS.c_judgement
    return {}
  end,
  blueprint_compat = true,
  eternal_compat = true,
  perishable_compat = true,
  calculate = function(self, card, context)
    if context.setting_blind and not (context.blueprint_card or self).getting_sliced and count_consumables() < G.consumeables.config.card_limit then
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
            end
          }))
          card_eval_status_text(context.blueprint_card or card, 'extra', nil, nil, nil,
            { message = "+1 Judgement", colour = G.C.PURPLE })
          return true
        end
      }))
    end
  end
}

G.Phanta.centers["caesarcipher"] = {
  rarity = 2,
  atlas = 'Phanta',
  pos = { x = 5, y = 4 },
  cost = 6,
  loc_vars = function(self, info_queue, card)
    info_queue[#info_queue + 1] = G.P_CENTERS.c_strength
    return {}
  end,
  blueprint_compat = true,
  eternal_compat = true,
  perishable_compat = true,
  calculate = function(self, card, context)
    if context.setting_blind and not (context.blueprint_card or self).getting_sliced and count_consumables() < G.consumeables.config.card_limit then
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
            end
          }))
          if random_card == 1 then
            card_eval_status_text(context.blueprint_card or card, 'extra', nil, nil, nil,
              { message = "+1 Planet", colour = G.C.BLUE })
          else
            card_eval_status_text(context.blueprint_card or card, 'extra', nil, nil, nil,
              { message = "+1 Strength", colour = G.C.PURPLE })
          end
          return true
        end
      }))
    end
  end
}

G.Phanta.centers["timepiece"] = {
  rarity = 2,
  atlas = 'Phanta',
  pos = { x = 3, y = 4 },
  cost = 6,
  loc_vars = function(self, info_queue, card)
    info_queue[#info_queue + 1] = G.P_CENTERS.c_death
    return {}
  end,
  blueprint_compat = true,
  eternal_compat = true,
  perishable_compat = true,
  calculate = function(self, card, context)
    if context.cardarea == G.jokers and context.before and G.GAME.current_round.hands_left == 0 and not (context.blueprint_card or card).getting_sliced and count_consumables() < G.consumeables.config.card_limit then
      G.GAME.consumeable_buffer = G.GAME.consumeable_buffer + 1
      G.E_MANAGER:add_event(Event({
        func = function()
          local new_card = create_card("Tarot", G.consumables, nil, nil, nil, nil, "c_death", 'timepiece')
          new_card:add_to_deck()
          G.consumeables:emplace(new_card)
          G.GAME.consumeable_buffer = 0
          new_card:juice_up(0.3, 0.5)
          return true
        end
      }))
      return { message = "+1 Death", colour = G.C.PURPLE }
    end
  end
}

G.Phanta.centers["introspection"] = {
  config = { extra = { chosen_type = 0 } },
  rarity = 2,
  atlas = 'Phanta',
  pos = { x = 0, y = 1 },
  cost = 6,
  loc_vars = function(self, info_queue, card)
    return {
      vars = {
        ({ 'Tarot', 'Planet' })[card.ability.extra.chosen_type + 1],
        ({ 'Planets', 'Tarots' })[card.ability.extra.chosen_type + 1],
        colours = { ({ G.C.SECONDARY_SET.Tarot, G.C.SECONDARY_SET.Planet })[card.ability.extra.chosen_type + 1], ({ G.C.SECONDARY_SET.Planet, G.C.SECONDARY_SET.Tarot })[card.ability.extra.chosen_type + 1] }
      }
    }
  end,
  blueprint_compat = true,
  eternal_compat = true,
  perishable_compat = true,
  calculate = function(self, card, context)
    if context.setting_blind and not (context.blueprint_card or card).getting_sliced and count_consumables() < G.consumeables.config.card_limit then
      G.GAME.consumeable_buffer = G.GAME.consumeable_buffer + 1
      G.E_MANAGER:add_event(Event({
        func = (function()
          G.E_MANAGER:add_event(Event({
            func = function()
              local new_card = create_card(({ 'Tarot', 'Planet' })[card.ability.extra.chosen_type + 1], G.consumeables,
                nil, nil, nil, nil, nil, 'introspection')
              new_card:add_to_deck()
              G.consumeables:emplace(new_card)
              G.GAME.consumeable_buffer = 0
              card.ability.extra.chosen_type = 1 - card.ability.extra.chosen_type
              return true
            end
          }))
          card_eval_status_text(context.blueprint_card or card, 'extra', nil, nil, nil,
            {
              message = localize(({ 'k_plus_tarot', 'k_plus_planet' })[card.ability.extra.chosen_type + 1]),
              colour = ({ G.C.PURPLE, G.C.BLUE })
                  [card.ability.extra.chosen_type + 1]
            })
          return true
        end)
      }))
    end
  end
}

G.Phanta.centers["blindjoker"] = {
  config = { extra = { no_of_aces = 2 } },
  rarity = 2,
  atlas = 'PhantaMiscAnims4',
  pos = { x = 4, y = 3 },
  phanta_anim = {
    { x = 4,  y = 3, t = 3 },
    { x = 5,  y = 3, t = 0.1 },
    { x = 6,  y = 3, t = 0.05 },
    { x = 7,  y = 3, t = 0.025 },
    { x = 8,  y = 3, t = 0.025 },
    { x = 9,  y = 3, t = 0.05 },
    { x = 10, y = 3, t = 0.1 },
  },
  cost = 6,
  loc_vars = function(self, info_queue, card)
    return { vars = { card.ability.extra.no_of_aces } }
  end,
  blueprint_compat = true,
  eternal_compat = true,
  perishable_compat = true,
  calculate = function(self, card, context)
    if context.joker_main and count_consumables() < G.consumeables.config.card_limit then
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
          end
        }))
        return {
          message = localize('k_plus_planet'),
          colour = G.C.SECONDARY_SET.Planet,
          card = card
        }
      end
    end
  end
}

G.Phanta.centers["spaceinvader"] = {
  config = { extra = { no_of_planets = 2 } },
  rarity = 2,
  atlas = 'PhantaMiscAnims3',
  pos = { x = 6, y = 2 },
  phanta_anim = {
    { xrange = { first = 5, last = 5 }, y = 4, t = 1 }
  },
  pos_extra = { x = 0, y = 5 },
  phanta_anim_extra_states = {
    ["crab"] = {
      anim = {
        { xrange = { first = 0, last = 1 }, y = 5, t = 0.5 }
      },
      loop = true
    },
    ["squid"] = {
      anim = {
        { xrange = { first = 2, last = 3 }, y = 5, t = 0.5 }
      },
      loop = true
    },
    ["octopus"] = {
      anim = {
        { xrange = { first = 4, last = 5 }, y = 5, t = 0.5 }
      },
      loop = true
    },
  },
  phanta_anim_extra_current_state = nil,
  cost = 6,
  loc_vars = function(self, info_queue, card)
    return { vars = { card.ability.extra.no_of_planets } }
  end,
  blueprint_compat = true,
  eternal_compat = true,
  perishable_compat = true,
  calculate = function(self, card, context)
    if context.setting_blind and count_consumables() == 0 then
      G.E_MANAGER:add_event(Event({
        func = function()
          card_eval_status_text(context.blueprint_card or card, 'extra', nil, nil, nil,
            {
              message = localize { type = 'variable', key = 'a_planets', vars = { card.ability.extra.no_of_planets } },
              colour =
                  G.C.Planet
            })
          play_sound("timpani")

          for i = 1, card.ability.extra.no_of_planets do
            if count_consumables() < G.consumeables.config.card_limit then
              local new_card = create_card("Planet", G.consumables, nil, nil, nil, nil)
              new_card:add_to_deck()
              G.consumeables:emplace(new_card)
              new_card:juice_up(0.3, 0.5)
            end
          end
          return true
        end
      }))
    end
  end,
  set_sprites = function(self, card, front)
    if not self.discovered and not card.params.bypass_discovery_center then
      return
    end
    local c = card or {}
    local choices = { "crab", "squid", "octopus" }
    if not c.phanta_anim_extra_current_state then
      local choice = pseudorandom_element(choices, pseudoseed("spaceinvaderchoice"))
      card:phanta_set_anim_extra_state(choice)
    end
  end
}

G.Phanta.centers["witchsmark"] = {
  rarity = 3,
  atlas = 'PhantaMiscAnims3', -- This should've gone in the Layton sheet, but mehhhhh too late
  pos = { x = 2, y = 11 },
  phanta_anim = {
    { x = 2,                              y = 11, t = 3 },
    { xrange = { first = 3, last = 5 },   y = 11, t = 0.075 },
    { x = 6,                              y = 11, t = 0.5 },
    { xrange = { first = 7, last = 8 },   y = 11, t = 0.08 },
    { x = 9,                              y = 11, t = 0.2 },
    { xrange = { first = 10, last = 11 }, y = 11, t = 0.08 },
    { x = 0,                              y = 12, t = 0.08 },
    { x = 1,                              y = 12, t = 0.25 },
    { xrange = { first = 2, last = 3 },   y = 12, t = 0.08 },
    { x = 4,                              y = 12, t = 0.275 },
    { xrange = { first = 5, last = 7 },   y = 12, t = 0.08 },
    { x = 8,                              y = 12, t = 0.225 },
    { xrange = { first = 9, last = 11 },  y = 12, t = 0.08 },

  },
  cost = 8,
  blueprint_compat = true,
  eternal_compat = true,
  perishable_compat = true,
  calculate = function(self, card, context)
    if context.joker_main and count_consumables() < G.consumeables.config.card_limit then
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
          end)
        }))
        return {
          message = localize('k_plus_tarot'),
          card = card
        }
      end
    end
  end
}

G.Phanta.centers["modernart"] = {
  config = { extra = { bonus_cash = 3 } },
  rarity = 1,
  atlas = 'Phanta',
  pos = { x = 4, y = 3 },
  cost = 4,
  loc_vars = function(self, info_queue, card)
    return { vars = { card.ability.extra.bonus_cash } }
  end,
  blueprint_compat = false,
  eternal_compat = true,
  perishable_compat = true,
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

G.Phanta.centers["sketch"] = {
  config = { extra = { xmult = 0.5 } },
  rarity = 3,
  atlas = 'Phanta',
  pos = { x = 5, y = 3 },
  cost = 8,
  loc_vars = function(self, info_queue, card)
    return { vars = { card.ability.extra.xmult } }
  end,
  blueprint_compat = true,
  eternal_compat = true,
  perishable_compat = true,
  calculate = function(self, card, context)
    if context.joker_main and #G.play.cards > #context.scoring_hand then
      return {
        xmult = 1 +
            (card.ability.extra.xmult * (#G.play.cards - #context.scoring_hand))
      }
    end
  end
}

G.Phanta.centers["conspiracist"] = {
  config = { extra = { odds = 2 } },
  rarity = 1,
  atlas = 'Phanta',
  pos = { x = 0, y = 5 },
  cost = 5,
  loc_vars = function(self, info_queue, card)
    info_queue[#info_queue + 1] = G.P_CENTERS.c_earth
    local num, denom = SMODS.get_probability_vars(card, 1, card.ability.extra.odds, "conspiracist")
    return { vars = { num, denom } }
  end,
  blueprint_compat = true,
  eternal_compat = true,
  perishable_compat = true,
  calculate = function(self, card, context)
    if context.before and not (context.blueprint_card or card).getting_sliced and count_consumables() < G.consumeables.config.card_limit
        and SMODS.pseudorandom_probability(card, "conspiracist", 1, card.ability.extra.odds) and next(context.poker_hands['Full House']) then
      G.GAME.consumeable_buffer = G.GAME.consumeable_buffer + 1
      G.E_MANAGER:add_event(Event({
        func = function()
          local new_card = create_card("Planet", G.consumables, nil, nil, nil, nil, "c_earth", 'conspiracist')
          new_card:add_to_deck()
          G.consumeables:emplace(new_card)
          G.GAME.consumeable_buffer = 0
          new_card:juice_up(0.3, 0.5)
          return true
        end
      }))
      return { message = "+1 Earth", colour = G.C.BLUE }
    end
  end
}

G.Phanta.centers["wavyjoker"] = {
  config = { extra = { no_of_tarots = 2 } },
  rarity = 1,
  atlas = 'Phanta',
  pos = { x = 8, y = 8 },
  cost = 4,
  loc_vars = function(self, info_queue, card)
    return { vars = { card.ability.extra.no_of_tarots } }
  end,
  blueprint_compat = true,
  eternal_compat = true,
  perishable_compat = true,
  calculate = function(self, card, context)
    if context.skip_blind then
      G.E_MANAGER:add_event(Event({
        func = function()
          card_eval_status_text(context.blueprint_card or card, 'extra', nil, nil, nil,
            {
              message = localize { type = 'variable', key = 'a_tarots', vars = { card.ability.extra.no_of_tarots } },
              colour =
                  G.C.Tarot
            })
          play_sound("timpani")
          for i = 1, card.ability.extra.no_of_tarots do
            if count_consumables() < G.consumeables.config.card_limit then
              local new_card = create_card("Tarot", G.consumables, nil, nil, nil, nil)
              new_card:add_to_deck()
              G.consumeables:emplace(new_card)
              new_card:juice_up(0.3, 0.5)
            end
          end
          return true
        end
      }))
    end
  end
}

G.Phanta.centers["slidingpuzzle"] = {
  rarity = 2,
  atlas = 'PhantaMiscAnims4',
  pos = { x = 10, y = 6 },
  phanta_anim = {
    { x = 10, y = 6, t = 3 }, { x = 11, y = 6, t = 0.1 },
    { x = 0,  y = 7, t = 0.25 }, { x = 1, y = 7, t = 0.1 },
    { x = 2, y = 7, t = 0.25 }, { x = 3, y = 7, t = 0.1 },
    { x = 4, y = 7, t = 0.25 }, { x = 5, y = 7, t = 0.1 },
    { x = 6, y = 7, t = 0.25 }, { x = 7, y = 7, t = 0.1 },
    { x = 8, y = 7, t = 0.25 }, { x = 9, y = 7, t = 0.1 },
    { x = 10, y = 7, t = 0.25 }, { x = 11, y = 7, t = 0.1 },
    { x = 0,  y = 8, t = 0.25 }, { x = 1, y = 8, t = 0.1 },
    { x = 2, y = 8, t = 0.25 }, { x = 3, y = 8, t = 0.1 },
    { x = 4, y = 8, t = 0.25 }, { x = 5, y = 8, t = 0.1 },
    { x = 6, y = 8, t = 0.25 }, { x = 7, y = 8, t = 0.1 },
    { x = 8, y = 8, t = 0.25 }, { x = 9, y = 8, t = 0.1 },
    { x = 10, y = 8, t = 0.25 }, { x = 11, y = 8, t = 0.1 },
    { x = 0,  y = 9, t = 0.25 }, { x = 1, y = 9, t = 0.1 },
    { x = 2, y = 9, t = 0.25 }, { x = 3, y = 9, t = 0.1 },
    { x = 4, y = 9, t = 0.25 }, { x = 5, y = 9, t = 0.1 },
    { x = 6, y = 9, t = 0.25 }, { x = 7, y = 9, t = 0.1 },
    { x = 8, y = 9, t = 0.25 }, { x = 9, y = 9, t = 0.1 },
    { x = 10, y = 9,  t = 0.25 }, { x = 11, y = 9, t = 0.1 },
    { x = 0,  y = 10, t = 0.25 }, { x = 1, y = 10, t = 0.1 },
    { x = 2, y = 10, t = 0.25 }, { x = 3, y = 10, t = 0.1 },
    { x = 4, y = 10, t = 0.25 }, { x = 5, y = 10, t = 0.1 },
    { x = 6,                             y = 10,                           t = 2 },
    { xrange = { first = 5, last = 0 },  y = 10,                           t = 0.05 },
    { xrange = { first = 11, last = 0 }, yrange = { first = 9, last = 7 }, t = 0.05 },
    { x = 11,                            y = 6,                            t = 0.05 }
  },
  cost = 5,
  blueprint_compat = true,
  eternal_compat = true,
  perishable_compat = true,
  calculate = function(self, card, context)
    if context.first_hand_drawn then
      G.E_MANAGER:add_event(Event({
        func = function()
          SMODS.add_card { set = "Playing Card", seal = SMODS.poll_seal { key = 'slidingpuzzle_seal' .. G.GAME.round_resets.ante, mod = 10 }, edition = poll_edition('slidingpuzzle_edition' .. G.GAME.round_resets.ante, 2, true) }
          G.hand:sort()
          if context.blueprint_card then context.blueprint_card:juice_up() else card:juice_up() end
          return true
        end
      }))

      playing_card_joker_effects({ true })
    end
  end
}

-- This code is so jank, sorry :sob:
G.Phanta.centers["sudoku"] = {
  config = { extra = { ranks = { ["2"] = 0, ["3"] = 0, ["4"] = 0, ["5"] = 0, ["6"] = 0, ["7"] = 0, ["8"] = 0, ["9"] = 0, ["14"] = 0 }, no_of_upgrades = 2 } },
  rarity = 2,
  atlas = 'Phanta',
  pos = { x = 9, y = 2 },
  cost = 5,
  loc_vars = function(self, info_queue, card)
    return {
      vars = {
        (function()
          local rank_list = ""
          if card.ability.extra.ranks["14"] == 0 then rank_list = rank_list .. "A" end
          if card.ability.extra.ranks["2"] == 0 then rank_list = rank_list .. "2" end
          if card.ability.extra.ranks["3"] == 0 then rank_list = rank_list .. "3" end
          if card.ability.extra.ranks["4"] == 0 then rank_list = rank_list .. "4" end
          if card.ability.extra.ranks["5"] == 0 then rank_list = rank_list .. "5" end
          if card.ability.extra.ranks["6"] == 0 then rank_list = rank_list .. "6" end
          if card.ability.extra.ranks["7"] == 0 then rank_list = rank_list .. "7" end
          if card.ability.extra.ranks["8"] == 0 then rank_list = rank_list .. "8" end
          if card.ability.extra.ranks["9"] == 0 then rank_list = rank_list .. "9" end
          return rank_list
        end)(),
        card.ability.extra.no_of_upgrades
      }
    }
  end,
  blueprint_compat = true,
  eternal_compat = true,
  perishable_compat = true,
  calculate = function(self, card, context)
    if context.cardarea == G.jokers and context.before then
      for i = 1, #context.scoring_hand do
        if card.ability.extra.ranks[context.scoring_hand[i]:get_id() .. ""] and card.ability.extra.ranks[context.scoring_hand[i]:get_id() .. ""] == 0 then
          card.ability.extra.ranks[context.scoring_hand[i]:get_id() .. ""] = 1

          local ranks_to_string = {
            ["2"] = "2",
            ["3"] = "3",
            ["4"] = "4",
            ["5"] = "5",
            ["6"] = "6",
            ["7"] = "7",
            ["8"] =
            "8",
            ["9"] = "9",
            ["14"] = "Ace"
          }
          card_eval_status_text(context.blueprint_card or card, 'extra', nil, nil, nil,
            { message = ranks_to_string[context.scoring_hand[i]:get_id() .. ""], colour = G.C.FILTER })

          if card.ability.extra.ranks["14"] == 1
              and card.ability.extra.ranks["2"] == 1
              and card.ability.extra.ranks["3"] == 1
              and card.ability.extra.ranks["4"] == 1
              and card.ability.extra.ranks["5"] == 1
              and card.ability.extra.ranks["6"] == 1
              and card.ability.extra.ranks["7"] == 1
              and card.ability.extra.ranks["8"] == 1
              and card.ability.extra.ranks["9"] == 1 then
            card.ability.extra.ranks = {
              ["2"] = 0,
              ["3"] = 0,
              ["4"] = 0,
              ["5"] = 0,
              ["6"] = 0,
              ["7"] = 0,
              ["8"] = 0,
              ["9"] = 0,
              ["14"] = 0
            }
            card_eval_status_text(context.blueprint_card or card, 'extra', nil, nil, nil,
              { message = localize('k_upgrade_ex') })
            update_hand_text({ sound = 'button', volume = 0.7, pitch = 0.8, delay = 0.3 },
              {
                handname = "Straight",
                chips = G.GAME.hands["Straight"].chips,
                mult = G.GAME.hands["Straight"].mult,
                level =
                    G.GAME.hands["Straight"].level
              })
            level_up_hand(card, "Straight", nil, card.ability.extra.no_of_upgrades)
            update_hand_text({ sound = 'button', volume = 0.7, pitch = 0.8, delay = 0.3 },
              {
                handname = context.scoring_name,
                chips = G.GAME.hands[context.scoring_name].chips,
                mult = G.GAME.hands
                    [context.scoring_name].mult,
                level = G.GAME.hands[context.scoring_name].level
              })
          end
        end
      end
    end
  end
}

G.Phanta.centers["ceaseanddesist"] = {
  config = { extra = { no_of_upgrades = 1 } },
  rarity = 1,
  atlas = 'Phanta',
  pos = { x = 5, y = 9 },
  cost = 4,
  loc_vars = function(self, info_queue, card)
    return { vars = { card.ability.extra.no_of_upgrades } }
  end,
  blueprint_compat = true,
  eternal_compat = true,
  perishable_compat = true,
  calculate = function(self, card, context)
    if context.skipping_booster then
      G.E_MANAGER:add_event(Event({
        func = function()
          card_eval_status_text(context.blueprint_card or card, 'extra', nil, nil, nil,
            { message = localize('k_upgrade_ex') })
          update_hand_text({ sound = 'button', volume = 0.7, pitch = 0.8, delay = 0.3 },
            {
              handname = "Straight",
              chips = G.GAME.hands["Straight"].chips,
              mult = G.GAME.hands["Straight"].mult,
              level =
                  G.GAME.hands["Straight"].level
            })
          level_up_hand(card, "Straight", nil, card.ability.extra.no_of_upgrades)
          update_hand_text({ sound = 'button', volume = 0.7, pitch = 0.8, delay = 0.3 },
            { mult = 0, chips = 0, handname = '', level = '' })
          return true
        end
      }))
    end
  end
}

G.Phanta.centers["thepolicemun"] = {
  config = { extra = { no_of_upgrades = 3 } },
  rarity = 2,
  atlas = 'PhantaMiscAnims2',
  pos = { x = 0, y = 0 },
  phanta_anim = {
    { x = 0, y = 0, t = 0.125 }, { x = 1, y = 0, t = 0.125 }, { x = 2, y = 0, t = 0.125 },
    { x = 0, y = 0, t = 0.125 }, { x = 1, y = 0, t = 0.125 }, { x = 2, y = 0, t = 0.125 },
    { x = 0, y = 0, t = 0.125 }, { x = 1, y = 0, t = 0.125 }, { x = 2, y = 0, t = 0.125 },
    { x = 0, y = 0, t = 0.125 }, { x = 1, y = 0, t = 0.125 }, { x = 2, y = 0, t = 0.125 },
    { x = 0, y = 0, t = 0.0125 }, { x = 3, y = 0, t = 0.1 }, { x = 0, y = 0, t = 0.0125 }, { x = 1, y = 0, t = 0.125 }, { x = 2, y = 0, t = 0.125 },
    { x = 0, y = 0, t = 0.125 }, { x = 1, y = 0, t = 0.125 }, { x = 2, y = 0, t = 0.125 },
    { x = 0, y = 0, t = 0.125 }, { x = 1, y = 0, t = 0.125 }, { x = 2, y = 0, t = 0.125 },
    { x = 0, y = 0, t = 0.025 }, { x = 3, y = 0, t = 0.1 }, { x = 1, y = 0, t = 0.125 }, { x = 2, y = 0, t = 0.125 },
    { x = 3, y = 0, t = 0.1 }, { x = 0, y = 0, t = 0.025 }, { x = 1, y = 0, t = 0.125 }, { x = 2, y = 0, t = 0.125 },
    { x = 0, y = 0, t = 0.125 }, { x = 1, y = 0, t = 0.125 }, { x = 2, y = 0, t = 0.125 },
    { x = 0, y = 0, t = 0.125 }, { x = 1, y = 0, t = 0.125 }, { x = 2, y = 0, t = 0.125 },
    { x = 0, y = 0, t = 0.125 }, { x = 1, y = 0, t = 0.125 }, { x = 2, y = 0, t = 0.125 },
    { x = 0, y = 0, t = 0.125 }, { x = 1, y = 0, t = 0.125 }, { x = 2, y = 0, t = 0.125 },
  },
  cost = 6,
  loc_vars = function(self, info_queue, card)
    return { vars = { card.ability.extra.no_of_upgrades } }
  end,
  blueprint_compat = true,
  eternal_compat = true,
  perishable_compat = true,
  calculate = function(self, card, context)
    if context.skip_blind then
      G.E_MANAGER:add_event(Event({
        func = function()
          card_eval_status_text(context.blueprint_card or card, 'extra', nil, nil, nil,
            { message = localize('k_upgrade_ex') })
          update_hand_text({ sound = 'button', volume = 0.7, pitch = 0.8, delay = 0.3 },
            {
              handname = "Straight",
              chips = G.GAME.hands["Straight"].chips,
              mult = G.GAME.hands["Straight"].mult,
              level =
                  G.GAME.hands["Straight"].level
            })
          level_up_hand(card, "Straight", nil, card.ability.extra.no_of_upgrades)
          update_hand_text({ sound = 'button', volume = 0.7, pitch = 0.8, delay = 0.3 },
            { mult = 0, chips = 0, handname = '', level = '' })
          return true
        end
      }))
    end
  end
}

G.Phanta.centers["nojoke"] = {
  config = { extra = { mult_per_straight = 3 } },
  rarity = 1,
  atlas = 'PhantaMiscAnims4',
  pos = { x = 7, y = 2 },
  phanta_anim = {
    { x = 7, y = 2, t = 1.4 }, { x = 8, y = 2, t = 0.1 },
    { x = 7, y = 2, t = 0.1 }, { x = 8, y = 2, t = 0.1 },
    { x = 7, y = 2, t = 2.2 }, { x = 8, y = 2, t = 0.1 },
    { x = 7, y = 2, t = 1.3 }, { x = 8, y = 2, t = 0.1 },
    { x = 7, y = 2, t = 0.6 }, { xrange = { first = 8, last = 11 }, y = 2, t = 0.1 },
    { x = 0, y = 3, t = 0.3 }, { x = 1, y = 3, t = 0.1 },
    { x = 0, y = 3, t = 0.1 }, { x = 2, y = 3, t = 0.1 },
    { x = 0, y = 3, t = 0.1 }, { x = 1, y = 3, t = 0.1 },
    { x = 0, y = 3, t = 0.1 }, { x = 2, y = 3, t = 0.5 },
    { x = 0, y = 3, t = 0.1 }, { x = 1, y = 3, t = 0.5 },
    { x = 0, y = 3, t = 0.3 }, { x = 3, y = 3, t = 0.1 }, { xrange = { first = 10, last = 8 }, y = 2, t = 0.1 },
  },
  cost = 4,
  loc_vars = function(self, info_queue, card)
    return { vars = { card.ability.extra.mult_per_straight, G.GAME.hands["Straight"].level * card.ability.extra.mult_per_straight } }
  end,
  blueprint_compat = true,
  eternal_compat = true,
  perishable_compat = true,
  calculate = function(self, card, context)
    if context.joker_main then
      return { mult = to_number(G.GAME.hands["Straight"].level * card.ability.extra.mult_per_straight) }
    end
  end
}

G.Phanta.centers["lotteryticket"] = {
  config = { extra = { no_of_upgrades = 1 } },
  rarity = 2,
  atlas = 'Phanta',
  pos = { x = 7, y = 10 },
  cost = 5,
  loc_vars = function(self, info_queue, card)
    return { vars = { card.ability.extra.no_of_upgrades, card.ability.extra.no_of_upgrades == 1 and "" or localize("phanta_plural") } }
  end,
  blueprint_compat = true,
  eternal_compat = true,
  perishable_compat = true,
  calculate = function(self, card, context)
    if context.first_hand_drawn then
      local eval = function() return G.GAME.current_round.hands_played == 0 end
      juice_card_until(card, eval, true)
    end

    if G.GAME.current_round.hands_played == 0 and context.before and context.scoring_name == "Straight" then
      G.E_MANAGER:add_event(Event({
        func = function()
          card_eval_status_text(context.blueprint_card or card, 'extra', nil, nil, nil,
            { message = localize('k_upgrade_ex') })
          update_hand_text({ sound = 'button', volume = 0.7, pitch = 0.8, delay = 0.3 },
            {
              handname = "Straight Flush",
              chips = G.GAME.hands["Straight Flush"].chips,
              mult = G.GAME.hands["Straight Flush"].mult,
              level =
                  G.GAME.hands["Straight Flush"].level
            })
          level_up_hand(card, "Straight Flush", nil, card.ability.extra.no_of_upgrades)
          update_hand_text({ sound = 'button', volume = 0.7, pitch = 0.8, delay = 0.3 },
            { mult = 0, chips = 0, handname = '', level = '' })
          return true
        end
      }))
    end
  end
}

G.Phanta.centers["dottodot"] = {
  config = { extra = { xmult = 3, active = false } },
  rarity = 2,
  atlas = 'PhantaMiscAnims2',
  pos = { x = 4, y = 0 },
  phanta_anim_states = {
    ["drawing"] = {
      anim = {
        { xrange = { first = 5, last = 11 }, y = 0, t = 0.025 }, { xrange = { first = 0, last = 4 }, y = 1, t = 0.025 }, { x = 4, y = 1, t = 0.2 },
        { xrange = { first = 5, last = 11 }, y = 1, t = 0.025 }, { xrange = { first = 0, last = 6 }, y = 2, t = 0.025 }, { x = 6, y = 2, t = 0.2 },
        { xrange = { first = 7, last = 11 }, y = 2, t = 0.025 }, { x = 0, y = 3, t = 0.025 }, { x = 0, y = 3, t = 0.2 },
        { xrange = { first = 1, last = 11 }, y = 3, t = 0.025 }, { xrange = { first = 0, last = 11 }, y = 4, t = 0.025 }, { xrange = { first = 0, last = 10 }, y = 5, t = 0.025 }, { x = 10, y = 5, t = 0.2 },
        { x = 11,                            y = 5, t = 0.025 }, { xrange = { first = 0, last = 4 }, y = 6, t = 0.025 }, { x = 4, y = 6, t = 0.2 },
        { xrange = { first = 5, last = 11 }, y = 6, t = 0.025 }, { xrange = { first = 0, last = 6 }, y = 7, t = 0.025 }, { x = 6, y = 7, t = 0.2 },
        { xrange = { first = 7, last = 9 }, y = 7, t = 0.025 }, { x = 9, y = 7, t = 1 }
      },
      loop = false
    },
    ["fading"] = {
      anim = {
        { xrange = { first = 10, last = 11 }, y = 7, t = 0.025 }, { xrange = { first = 0, last = 1 }, y = 8, t = 0.025 }, { x = 4, y = 0, t = 1 }
      },
      loop = false
    }
  },
  phanta_anim_current_state = nil,
  cost = 6,
  loc_vars = function(self, info_queue, card)
    return { vars = { card.ability.extra.xmult, (G.GAME and G.GAME.current_round and G.GAME.current_round.hands_played ~= 0 and G.GAME.last_hand_played) and localize(G.GAME.last_hand_played, 'poker_hands') or localize('phanta_unknown') } }
  end,
  blueprint_compat = true,
  eternal_compat = true,
  perishable_compat = true,
  calculate = function(self, card, context)
    if context.joker_main and card.ability.extra.active then
      return { xmult = card.ability.extra.xmult }
    end

    if context.after then
      local was_straight = next(context.poker_hands['Straight'])
      if card.ability.extra.active and not was_straight then
        card:phanta_set_anim_state("fading")
      elseif not card.ability.extra.active and was_straight then
        card:phanta_set_anim_state("drawing")
      end
      card.ability.extra.active = was_straight
    end
  end
}

G.Phanta.centers["diningtable"] = {
  rarity = 3,
  atlas = 'Phanta',
  pos = { x = 1, y = 10 },
  cost = 8,
  loc_vars = function(self, info_queue, card)
    info_queue[#info_queue + 1] = G.P_CENTERS.m_glass
    return {}
  end,
  blueprint_compat = false,
  eternal_compat = true,
  perishable_compat = true,
  calculate = function(self, card, context)
    if context.cardarea == G.jokers and context.before and not card.getting_sliced and next(context.poker_hands['Full House']) then
      local rank_tallies = {}
      for k, v in ipairs(context.scoring_hand) do
        if not rank_tallies[v:get_id()] then
          rank_tallies[v:get_id()] = 0
        end
        rank_tallies[v:get_id()] = rank_tallies[v:get_id()] + 1
      end

      local candidates = {}
      for k, v in ipairs(context.scoring_hand) do
        if rank_tallies[v:get_id()] == 2 then
          candidates[#candidates + 1] = v
        end
      end

      if #candidates > 0 then
        for c = 1, #candidates do
          candidates[c]:set_ability(G.P_CENTERS.m_glass, nil, true)
          G.E_MANAGER:add_event(Event({
            func = function()
              candidates[c]:juice_up()
              return true
            end
          }))
        end
        return { message = localize("phanta_become_glass"), colour = G.C.FILTER, card = card }
      end
    end
  end
}

G.Phanta.centers["eyeofprovidence"] = {
  config = { extra = { xmult = 2 } },
  rarity = 3,
  atlas = 'Phanta',
  pos = { x = 1, y = 5 },
  cost = 8,
  loc_vars = function(self, info_queue, card)
    return { vars = { card.ability.extra.xmult } }
  end,
  blueprint_compat = true,
  eternal_compat = true,
  perishable_compat = true,
  calculate = function(self, card, context)
    if context.individual and context.cardarea == G.play and context.other_card:get_id() == 14 and context.other_card:is_suit("Spades") then
      return { xmult = card.ability.extra.xmult }
    end
  end
}

G.Phanta.centers["plumber"] = {
  config = { extra = { added_xmult = 0.2, current_xmult = 1 } },
  rarity = 3,
  atlas = 'Phanta',
  pos = { x = 1, y = 4 },
  cost = 8,
  loc_vars = function(self, info_queue, card)
    return { vars = { card.ability.extra.added_xmult, card.ability.extra.current_xmult } }
  end,
  blueprint_compat = true,
  eternal_compat = true,
  perishable_compat = false,
  calculate = function(self, card, context)
    if context.joker_main and card.ability.extra.current_xmult > 1 then
      return {
        xmult = card.ability.extra
            .current_xmult
      }
    end

    if context.pre_discard and not context.blueprint then
      local text, disp_text = G.FUNCS.get_poker_hand_info(G.hand.highlighted)
      if text == "Flush" then
        card.ability.extra.current_xmult = card.ability.extra.current_xmult + card.ability.extra.added_xmult
        card_eval_status_text(context.blueprint_card or card, 'extra', nil, nil, nil,
          { message = localize('k_upgrade_ex') })
      end
    end
  end
}

G.Phanta.centers["thespear"] = {
  rarity = 3,
  atlas = 'Phanta',
  pos = { x = 0, y = 6 },
  cost = 8,
  blueprint_compat = true,
  eternal_compat = true,
  perishable_compat = true,
  calculate = function(self, card, context)
    if context.cardarea == G.jokers and context.before then
      local spade_cards = {}
      for k, v in ipairs(context.scoring_hand) do
        if v:is_suit("Spades") and not v.phanta_weapon_marked_for_death then
          spade_cards[#spade_cards + 1] = v
        end
      end
      if #spade_cards > 0 then
        pseudorandom_element(spade_cards, pseudoseed("thespear")).phanta_weapon_marked_for_death = true
        card_eval_status_text(context.blueprint_card or card, 'extra', nil, nil, nil,
          { message = localize('k_upgrade_ex') })
        update_hand_text({ sound = 'button', volume = 0.7, pitch = 0.8, delay = 0.3 },
          {
            handname = "Straight",
            chips = G.GAME.hands["Straight"].chips,
            mult = G.GAME.hands["Straight"].mult,
            level =
                G.GAME.hands["Straight"].level
          })
        level_up_hand(card, "Straight", nil, 1)
        update_hand_text({ sound = 'button', volume = 0.7, pitch = 0.8, delay = 0.3 },
          {
            handname = context.scoring_name,
            chips = G.GAME.hands[context.scoring_name].chips,
            mult = G.GAME.hands
                [context.scoring_name].mult,
            level = G.GAME.hands[context.scoring_name].level
          })
      end
    end

    if context.destroy_card and context.cardarea == G.play and context.destroy_card.phanta_weapon_marked_for_death then
      context.destroy_card.phanta_weapon_marked_for_death = nil
      return { remove = true }
    end
  end
}

G.Phanta.centers["thefuse"] = {
  config = { extra = { added_xmult = 0.1, current_xmult = 1 } },
  rarity = 3,
  atlas = 'Phanta',
  pos = { x = 1, y = 6 },
  cost = 8,
  blueprint_compat = true,
  eternal_compat = true,
  perishable_compat = true,
  loc_vars = function(self, info_queue, card)
    return { vars = { card.ability.extra.added_xmult, card.ability.extra.current_xmult } }
  end,
  calculate = function(self, card, context)
    if context.before then
      local heart_cards = {}
      for k, v in ipairs(context.scoring_hand) do
        if v:is_suit("Hearts") and not v.phanta_weapon_marked_for_death then
          heart_cards[#heart_cards + 1] = v
        end
      end
      if #heart_cards > 0 then
        pseudorandom_element(heart_cards, pseudoseed("thefuse")).phanta_weapon_marked_for_death = true
        if not context.blueprint then
          card.ability.extra.current_xmult = card.ability.extra.current_xmult + card.ability.extra.added_xmult
          return { message = localize('k_upgrade_ex'), colour = G.C.FILTER }
        end
      end
    end

    if context.joker_main and card.ability.extra.current_xmult > 1 then
      return { xmult = card.ability.extra.current_xmult }
    end

    if context.destroy_card and context.cardarea == G.play and context.destroy_card.phanta_weapon_marked_for_death then
      context.destroy_card.phanta_weapon_marked_for_death = nil
      return { remove = true }
    end
  end
}

G.Phanta.centers["themace"] = {
  config = { extra = { money = 5 } },
  rarity = 3,
  atlas = 'Phanta',
  pos = { x = 2, y = 6 },
  cost = 8,
  blueprint_compat = true,
  eternal_compat = true,
  perishable_compat = true,
  loc_vars = function(self, info_queue, card)
    return { vars = { card.ability.extra.money } }
  end,
  calculate = function(self, card, context)
    if context.joker_main then
      local club_cards = {}
      for k, v in ipairs(context.scoring_hand) do
        if v:is_suit("Clubs") and not v.phanta_weapon_marked_for_death then
          club_cards[#club_cards + 1] = v
        end
      end
      if #club_cards > 0 then
        pseudorandom_element(club_cards, pseudoseed("themace")).phanta_weapon_marked_for_death = true
        return { dollars = card.ability.extra.money }
      end
    end

    if context.destroy_card and context.cardarea == G.play and context.destroy_card.phanta_weapon_marked_for_death then
      context.destroy_card.phanta_weapon_marked_for_death = nil
      return { remove = true }
    end
  end
}

G.Phanta.centers["thedagger"] = {
  config = { extra = { added_mult = 5, current_mult = 0 } },
  rarity = 3,
  atlas = 'Phanta',
  pos = { x = 3, y = 6 },
  cost = 8,
  blueprint_compat = true,
  eternal_compat = true,
  perishable_compat = true,
  loc_vars = function(self, info_queue, card)
    return { vars = { card.ability.extra.added_mult, card.ability.extra.current_mult } }
  end,
  calculate = function(self, card, context)
    if context.before then
      local diamond_cards = {}
      for k, v in ipairs(context.scoring_hand) do
        if v:is_suit("Diamonds") and not v.phanta_weapon_marked_for_death then
          diamond_cards[#diamond_cards + 1] = v
        end
      end
      if #diamond_cards > 0 then
        pseudorandom_element(diamond_cards, pseudoseed("thedagger")).phanta_weapon_marked_for_death = true
        if not context.blueprint then
          card.ability.extra.current_mult = card.ability.extra.current_mult + card.ability.extra.added_mult
          return { message = localize('k_upgrade_ex'), colour = G.C.FILTER }
        end
      end
    end

    if context.joker_main and card.ability.extra.current_mult > 0 then return { mult = card.ability.extra.current_mult } end

    if context.destroy_card and context.cardarea == G.play and context.destroy_card.phanta_weapon_marked_for_death then
      context.destroy_card.phanta_weapon_marked_for_death = nil
      return { remove = true }
    end
  end
}

G.Phanta.centers["corkboard"] = {
  rarity = 2,
  atlas = 'Phanta',
  pos = { x = 8, y = 5 },
  cost = 6,
  blueprint_compat = true,
  eternal_compat = true,
  perishable_compat = true,
  calculate = function(self, card, context)
    if (context.blueprint or context.cardarea == G.jokers) and context.before and next(context.poker_hands["Straight"]) then
      local candidates = {}
      for k, v in ipairs(G.hand.cards) do
        if not v.phanta_corkboard_marked_for_death then
          candidates[#candidates + 1] = v
        end
      end
      if #candidates > 0 then
        pseudorandom_element(candidates, pseudoseed("corkboard")).phanta_corkboard_marked_for_death = true
      end
    end

    if context.destroy_card and context.cardarea == G.hand and context.destroy_card.phanta_corkboard_marked_for_death then
      context.destroy_card.phanta_corkboard_marked_for_death = nil
      return { remove = true }
    end
  end
}

G.Phanta.centers["evidence"] = {
  config = { extra = { added_xmult = 1, current_xmult = 1 } },
  rarity = 3,
  atlas = 'Phanta',
  pos = { x = 8, y = 3 },
  cost = 8,
  blueprint_compat = true,
  eternal_compat = true,
  perishable_compat = true,
  loc_vars = function(self, info_queue, card)
    return { vars = { card.ability.extra.added_xmult, card.ability.extra.current_xmult } }
  end,
  calculate = function(self, card, context)
    if context.joker_main and card.ability.extra.current_xmult > 1 then
      return {
        xmult = card.ability.extra
            .current_xmult
      }
    end

    if context.remove_playing_cards and not context.blueprint then
      local upgrade = 0
      for k, v in ipairs(context.removed) do
        if SMODS.has_enhancement(v, "m_stone") then
          upgrade = upgrade + card.ability.extra.added_xmult
        end
      end
      if upgrade > 0 then
        card.ability.extra.current_xmult = card.ability.extra.current_xmult + upgrade
        return { message = localize("k_upgrade_ex"), colour = G.C.FILTER }
      end
    end
  end,
  enhancement_gate = "m_stone"
}

G.Phanta.centers["lily"] = {
  config = { extra = { given_chips = 250 } },
  rarity = 3,
  atlas = 'Phanta',
  pos = { x = 0, y = 9 },
  cost = 8,
  blueprint_compat = true,
  eternal_compat = true,
  perishable_compat = true,
  loc_vars = function(self, info_queue, card)
    return { vars = { card.ability.extra.given_chips } }
  end,
  calculate = function(self, card, context)
    if context.joker_main then
      local diamond_cards = {}
      for k, v in ipairs(context.scoring_hand) do
        if v:is_suit("Diamonds") then
          diamond_cards[#diamond_cards + 1] = v
        end
      end
      if #diamond_cards == 1 then return { chips = card.ability.extra.given_chips } end
    end
  end
}

G.Phanta.centers["selfportrait"] = {
  config = { extra = { current_rounds = 0, rounds_required = 2 } },
  rarity = 3,
  atlas = 'Phanta',
  pos = { x = 1, y = 11 },
  cost = 8,
  blueprint_compat = false,
  eternal_compat = false,
  perishable_compat = true,
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
        message = (card.ability.extra.current_rounds < card.ability.extra.rounds_required) and
            (card.ability.extra.current_rounds .. '/' .. card.ability.extra.rounds_required) or localize('k_active_ex'),
        colour = G.C.FILTER
      }
    end

    if context.buying_card and context.card.config.center.set == "Joker" and card.ability.extra.current_rounds >= card.ability.extra.rounds_required then
      --[[ocal eval = function(card)
        return (card.ability.extra.current_rounds == card.ability.extra.rounds_required) and
            not G.RESET_JIGGLES
      end
      juice_card_until(card, eval, true)]] --
      if #G.jokers.cards <= G.jokers.config.card_limit then
        card_eval_status_text(context.blueprint_card or card, 'extra', nil, nil, nil,
          { message = localize('k_duplicated_ex') })
        local new_card = copy_card(context.card, nil, nil, nil, context.card.edition and context.card.edition.negative)
        card.ability.extra.current_rounds = 0
        G.E_MANAGER:add_event(Event({
          func = function()
            play_sound('tarot1')
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
                return true
              end
            }))
            return true
          end
        }))
        new_card:add_to_deck()
        G.jokers:emplace(new_card)
      else
        card_eval_status_text(context.blueprint_card or card, 'extra', nil, nil, nil,
          { message = localize('k_no_room_ex') })
      end
    end
  end,
  set_ability = function(self, card, initial, delay_sprites)
    card.ability.extra.current_rounds = 0
  end
}

G.Phanta.centers["caniossoul"] = {
  config = { extra = { lost_xmult = 0.5, current_xmult = 3 } },
  rarity = 3,
  atlas = 'Phanta',
  pos = { x = 4, y = 6 },
  cost = 8,
  blueprint_compat = true,
  eternal_compat = false,
  perishable_compat = true,
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
              G.E_MANAGER:add_event(Event({
                trigger = 'after',
                delay = 0.3,
                blockable = false,
                func = function()
                  G.jokers:remove_card(card)
                  card:remove()
                  card = nil
                  return true
                end
              }))
              return true
            end
          }))
          return {
            message = "Drained!",
            colour = G.C.FILTER
          }
        else
          return {
            message = localize { type = 'variable', key = 'a_xmult_minus', vars = { card.ability.extra.lost_xmult } },
            colour = G.C.MULT
          }
        end
      end
    end
  end
}

G.Phanta.centers["tribouletssoul"] = {
  config = { extra = { given_xmult = 3, remaining_hands = 2, added_hands = 2 } },
  rarity = 3,
  atlas = 'Phanta',
  pos = { x = 5, y = 6 },
  cost = 8,
  blueprint_compat = true,
  eternal_compat = false,
  perishable_compat = true,
  loc_vars = function(self, info_queue, card)
    return {
      vars = { card.ability.extra.given_xmult, card.ability.extra.remaining_hands, (function()
        if card.ability.extra.remaining_hands == 1 then
          return
          ""
        else
          return "s"
        end
      end)(), card.ability.extra.added_hands }
    }
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
          message = "+" .. card.ability.extra.added_hands .. " Hands",
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
            G.E_MANAGER:add_event(Event({
              trigger = 'after',
              delay = 0.3,
              blockable = false,
              func = function()
                G.jokers:remove_card(card)
                card:remove()
                card = nil
                return true
              end
            }))
            return true
          end
        }))
        return {
          message = "Drained!",
          colour = G.C.FILTER
        }
      else
        return {
          message = card.ability.extra.remaining_hands .. "",
          colour = G.C.FILTER
        }
      end
    end
  end
}

G.Phanta.centers["yorickssoul"] = {
  config = { extra = { lost_xmult = 1, current_xmult = 3 } },
  rarity = 3,
  atlas = 'Phanta',
  pos = { x = 0, y = 7 },
  cost = 8,
  blueprint_compat = true,
  eternal_compat = false,
  perishable_compat = true,
  loc_vars = function(self, info_queue, card)
    return { vars = { card.ability.extra.lost_xmult, card.ability.extra.current_xmult } }
  end,
  calculate = function(self, card, context)
    if context.joker_main and card.ability.extra.current_xmult > 1 then
      return { xmult = card.ability.extra.current_xmult }
    end

    if context.end_of_round and not context.individual and not context.repetition and G.GAME.current_round.discards_left > 0 then
      card.ability.extra.current_xmult = card.ability.extra.current_xmult - card.ability.extra.lost_xmult
      if card.ability.extra.current_xmult <= 1 then
        G.E_MANAGER:add_event(Event({
          func = function()
            play_sound('tarot1')
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
                return true
              end
            }))
            return true
          end
        }))
        return {
          message = "Drained!",
          colour = G.C.FILTER
        }
      else
        return {
          message = localize { type = 'variable', key = 'a_xmult_minus', vars = { card.ability.extra.lost_xmult } },
          colour = G.C.MULT
        }
      end
    end
  end
}

G.Phanta.centers["chicotssoul"] = {
  config = { extra = { lost_xmult = 0.5, current_xmult = 3 } },
  rarity = 3,
  atlas = 'Phanta',
  pos = { x = 1, y = 7 },
  cost = 8,
  blueprint_compat = true,
  eternal_compat = false,
  perishable_compat = true,
  loc_vars = function(self, info_queue, card)
    return { vars = { card.ability.extra.lost_xmult, card.ability.extra.current_xmult } }
  end,
  calculate = function(self, card, context)
    if context.joker_main and card.ability.extra.current_xmult > 1 then
      return { xmult = card.ability.extra.current_xmult }
    end

    if context.before and G.GAME.current_round.hands_played == 1 then
      card.ability.extra.current_xmult = card.ability.extra.current_xmult - card.ability.extra.lost_xmult
      if card.ability.extra.current_xmult <= 1 then
        G.E_MANAGER:add_event(Event({
          func = function()
            play_sound('tarot1')
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
                return true
              end
            }))
            return true
          end
        }))
        return {
          message = "Drained!",
          colour = G.C.FILTER
        }
      else
        return {
          message = localize { type = 'variable', key = 'a_xmult_minus', vars = { card.ability.extra.lost_xmult } },
          colour = G.C.MULT
        }
      end
    end
  end
}

G.Phanta.centers["perkeossoul"] = {
  config = { extra = { lost_xmult = 0.5, current_xmult = 3 } },
  rarity = 3,
  atlas = 'Phanta',
  pos = { x = 2, y = 7 },
  cost = 8,
  blueprint_compat = true,
  eternal_compat = false,
  perishable_compat = true,
  loc_vars = function(self, info_queue, card)
    return { vars = { card.ability.extra.lost_xmult, card.ability.extra.current_xmult } }
  end,
  calculate = function(self, card, context)
    if context.joker_main and card.ability.extra.current_xmult > 1 then
      return { xmult = card.ability.extra.current_xmult }
    end

    if context.end_of_round and not context.individual and not context.repetition and count_consumables() < G.consumeables.config.card_limit then
      card.ability.extra.current_xmult = card.ability.extra.current_xmult - card.ability.extra.lost_xmult
      if card.ability.extra.current_xmult <= 1 then
        G.E_MANAGER:add_event(Event({
          func = function()
            play_sound('tarot1')
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
                return true
              end
            }))
            return true
          end
        }))
        return {
          message = "Drained!",
          colour = G.C.FILTER
        }
      else
        return {
          message = localize { type = 'variable', key = 'a_xmult_minus', vars = { card.ability.extra.lost_xmult } },
          colour = G.C.MULT
        }
      end
    end
  end
}

G.Phanta.centers["spectretile"] = {
  config = { extra = { odds = 3 } },
  rarity = 2,
  atlas = 'Phanta',
  pos = { x = 10, y = 5 },
  cost = 6,
  blueprint_compat = true,
  eternal_compat = true,
  perishable_compat = true,
  loc_vars = function(self, info_queue, card)
    local num, denom = SMODS.get_probability_vars(card, 1, card.ability.extra.odds, "spectretile")
    return { vars = { num, denom } }
  end,
  calculate = function(self, card, context)
    if context.buying_card and context.card.config.center.set == "Joker" and SMODS.pseudorandom_probability(card, "spectretile", 1, card.ability.extra.odds) and count_consumables() < G.consumeables.config.card_limit then
      local _card = card
      G.E_MANAGER:add_event(Event({
        func = function()
          play_sound('timpani')
          G.E_MANAGER:add_event(Event({
            delay = 0.3,
            blockable = false,
            func = function()
              local new_card = create_card("Spectral", G.consumables, nil, nil, nil, nil)
              new_card:add_to_deck()
              G.consumeables:emplace(new_card)
              return true
            end
          }))
          return true
        end
      }))
      card_eval_status_text(_card, 'extra', nil, nil, nil,
        { message = localize('k_plus_spectral'), colour = G.C.SECONDARY_SET.Spectral })
      return true
    end
  end
}

G.Phanta.centers["possession"] = {
  config = { extra = { odds = 13 } },
  rarity = 3,
  atlas = 'Phanta',
  pos = { x = 8, y = 0 },
  soul_pos = { x = 9, y = 0 },
  cost = 9,
  blueprint_compat = true,
  eternal_compat = true,
  perishable_compat = true,
  loc_vars = function(self, info_queue, card)
    local num, denom = SMODS.get_probability_vars(card, 1, card.ability.extra.odds, "possession")
    return { vars = { num, denom } }
  end,
  calculate = function(self, card, context)
    if context.buying_card and context.card.config.center.set == "Joker" and not context.card.edition and SMODS.pseudorandom_probability(card, "possession", 1, card.ability.extra.odds) then
      G.E_MANAGER:add_event(Event({
        func = function()
          context.card:set_edition { negative = true }
          card_eval_status_text(card, 'extra', nil, nil, nil, { message = "Possessed!" })
          return true
        end
      }))
    end
  end
}
