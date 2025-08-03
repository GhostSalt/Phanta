SMODS.Atlas {
  key = "Phanta2",
  path = "PhantaJokers2.png",
  px = 71,
  py = 95
}

SMODS.Sound({
  key = "lobotomy_0",
  path = "phanta_lobotomy_0.ogg",
  replace = true
})

SMODS.Sound({
  key = "lobotomy_1",
  path = "phanta_lobotomy_1.ogg",
  replace = true
})

SMODS.Sound({
  key = "lobotomy_2",
  path = "phanta_lobotomy_2.ogg",
  replace = true
})

SMODS.Sound({
  vol = 1,
  pitch = 1,
  key = "polargeist_music",
  path = "phanta_polargeist.ogg",
  select_music_track = function()
    if #SMODS.find_card('j_phanta_normalface') > 0 then
      return 1e6
    end
    return false
  end
})

G.Phanta.centers["normalface"] = {
  config = { extra = { mult = 10 } },
  loc_vars = function(self, info_queue, card)
    return { vars = { card.ability.extra.mult } }
  end,
  rarity = 1,
  atlas = 'Phanta2',
  pos = { x = 0, y = 0 },
  cost = 4,
  blueprint_compat = true,
  eternal_compat = true,
  perishable_compat = true,
  calculate = function(self, card, context)
    if context.joker_main then return { mult = card.ability.extra.mult } end
    if not context.repetition and math.random() > 0.95 then
      local all_pitches = { { 1 }, { 1, 1, 1, 1, 0.5, 2 }, { 1, 1, 2 } }

      local sound = math.floor(math.random() * #all_pitches)
      sound = sound < #all_pitches and sound or 1
      local pitch = all_pitches[sound + 1][math.floor(math.random() * #all_pitches[sound + 1]) + 1]

      G.E_MANAGER:add_event(Event({
        func = function()
          G.E_MANAGER:add_event(Event({
            func = function()
              play_sound("phanta_lobotomy_" .. sound, pitch, 1)
              card_eval_status_text(card, 'extra', nil, nil, nil, { message = ":)", colour = G.C.GREEN })
              return true
            end
          }))
          return true
        end
      }))
    end
  end
}



-- Debug function
function list_peekaboo_abilities()
  local the_list = {}
  for i = 1, #G.jokers.cards do
    if G.jokers.cards[i].config.center.key == "j_phanta_peekaboo" then
      local card = G.jokers.cards[i]
      local abilities = {
        "+1 hand",
        "+1 discard",
        "+1 hand size",
        "+1 shop size",

        "Chosen suit (" .. card.ability.extra.chosen_suit .. ") gives +3 Mult",
        "Face cards give +5 Mult",
        "Chosen rank (ID " .. card.ability.extra.chosen_rank .. ") gives +7 Mult",
        "Unscored cards give +6 Mult",

        "Chosen suit (" .. card.ability.extra.chosen_suit .. ") gives +20 Chips",
        "Face cards give +40 Chips",
        "Chosen rank (ID " .. card.ability.extra.chosen_rank .. ") gives +60 Chips",
        "Unscored cards give +50 Chips",

        "Chosen suit (" .. card.ability.extra.chosen_suit .. ") gives +$1",
        "Face cards give +$2",
        "Chosen rank (ID " .. card.ability.extra.chosen_rank .. ") gives +$3",
        "Unscored cards give +$1",

        "Chosen suit (" .. card.ability.extra.chosen_suit .. ") gives +$2 when discarded",
        "Face cards give +$3 when discarded",
        "Chosen rank (ID " .. card.ability.extra.chosen_rank .. ") gives +$4 when discarded",

        "+100 Chips on second hand",
        "+15 Mult on second hand",
        "X2 Mult on second hand",
        "+$5 Mult on second hand",

        "$4 at end of round",

        "+Tarot when Blind is selected",
        "+Planet when Blind is selected",
        "+Spectral when Blind is selected",

        "+Double Tag when obtained",
        "Becomes Foil when obtained",
        "Becomes Holographic when obtained",
        "Becomes Polychrome when obtained",
        "Becomes Negative when obtained"
      }

      for i = 1, #card.ability.extra.all_abilities do
        if card.ability.extra.all_abilities[i] == card.ability.extra.chosen_ability then
          the_list[#the_list + 1] = abilities[i]
        end
      end
    end
  end

  if #the_list == 0 then return nil else return the_list end
end

G.Phanta.centers["peekaboo"] = {
  config = {
    extra = {
      mult = 4,
      all_abilities = {

        { unconditional = true,        hands = 1 },
        { unconditional = true,        discards = 1 },
        { unconditional = true,        hand_size = 1 },
        { unconditional = true,        shop_size = 1 },

        { area_condition = "Play",     suit_condition = "Random", mult = 3 },
        { area_condition = "Play",     rank_condition = "Face",   mult = 5 },
        { area_condition = "Play",     rank_condition = "Random", mult = 7 },
        { area_condition = "Unscored", unconditional = true,      mult = 6 },

        { area_condition = "Play",     suit_condition = "Random", chips = 20 },
        { area_condition = "Play",     rank_condition = "Face",   chips = 40 },
        { area_condition = "Play",     rank_condition = "Random", chips = 60 },
        { area_condition = "Unscored", unconditional = true,      chips = 50 },

        { area_condition = "Play",     suit_condition = "Random", money = 1 },
        { area_condition = "Play",     rank_condition = "Face",   money = 2 },
        { area_condition = "Play",     rank_condition = "Random", money = 3 },
        { area_condition = "Unscored", unconditional = true,      money = 1 },

        { area_condition = "Discard",  suit_condition = "Random", money = 2 },
        { area_condition = "Discard",  rank_condition = "Face",   money = 3 },
        { area_condition = "Discard",  rank_condition = "Random", money = 4 },

        { hands_played = 2,            chips = 100 },
        { hands_played = 2,            mult = 15 },
        { hands_played = 2,            xmult = 2 },
        { hands_played = 2,            money = 5 },

        { unconditional = true,        eormoney = 4 },

        { unconditional = true,        tarot = true },
        { unconditional = true,        planet = true },
        { unconditional = true,        spectral = true }, --Intentionally busted.

        { unconditional = true,        double_tag = true },
        { unconditional = true,        foil = true },
        { unconditional = true,        holographic = true },
        { unconditional = true,        polychrome = true },
        { unconditional = true,        negative = true },
      }
    }
  },
  loc_vars = function(self, info_queue, card)
    return { vars = { card.ability.extra.mult } }
  end,
  rarity = 1,
  atlas = 'PhantaMiscAnims3',
  pos = { x = 6, y = 5 },
  phanta_anim = {
    { x = 6, y = 5, t = 0.9 }, { x = 5, y = 7, t = 0.1 },
    { x = 6, y = 5, t = 1.7 }, { x = 5, y = 7, t = 0.1 }, { x = 6, y = 5, t = 0.1 }, { x = 5, y = 7, t = 0.1 },
    { x = 6, y = 5, t = 2.6 }, { x = 5, y = 7, t = 0.1 },
    { x = 6, y = 5, t = 1.4 }, { x = 5, y = 7, t = 0.1 },
    { x = 1, y = 7, t = 0.8 }, { x = 6, y = 5, t = 0.1 },
    { x = 2, y = 7, t = 0.3 }, { x = 5, y = 7, t = 0.1 }, { x = 2, y = 7, t = 0.4 },
    { xrange = { first = 6, last = 11 }, y = 5, t = 0.05 },
    { xrange = { first = 0, last = 2 },  y = 6, t = 0.05 },
    { x = 3,                             y = 6, t = 1 },
    { xrange = { first = 4, last = 11 }, y = 6, t = 0.05 },

    { x = 0,                             y = 7, t = 0.9 }, { x = 6, y = 7, t = 0.1 },
    { x = 0, y = 7, t = 1.7 }, { x = 6, y = 7, t = 0.1 }, { x = 0, y = 7, t = 0.1 }, { x = 6, y = 7, t = 0.1 },
    { x = 0, y = 7, t = 2.6 }, { x = 6, y = 7, t = 0.1 },
    { x = 0, y = 7, t = 1.4 }, { x = 6, y = 7, t = 0.1 },
    { x = 3, y = 7, t = 0.8 }, { x = 0, y = 7, t = 0.1 },
    { x = 4,                             y = 7, t = 0.3 }, { x = 6, y = 7, t = 0.1 }, { x = 4, y = 7, t = 0.4 },
    { xrange = { first = 11, last = 4 }, y = 6, t = 0.05 },
    { x = 3,                             y = 6, t = 1 },
    { xrange = { first = 2, last = 0 },  y = 6, t = 0.05 },
    { xrange = { first = 11, last = 6 }, y = 5, t = 0.05 },
  },
  cost = 4,
  blueprint_compat = true,
  eternal_compat = true,
  perishable_compat = true,
  calculate = function(self, card, context)
    if context.joker_main and not (card.ability.extra.chosen_ability.hands_played and G.GAME.current_round.hands_played ~= 1) then
      local bonus = { mult = card.ability.extra.mult }
      bonus.chips = card.ability.extra.chosen_ability.chips
      bonus.mult = bonus.mult + (card.ability.extra.chosen_ability.mult or 0)
      bonus.xmult = card.ability.extra.chosen_ability.xmult
      bonus.dollars = card.ability.extra.chosen_ability.money
      return bonus
    elseif context.joker_main then
      return { mult = card.ability.extra.mult }
    end

    if context.individual and (
          (card.ability.extra.chosen_ability.area_condition == "Unscored" and context.cardarea == "unscored")
          or (card.ability.extra.chosen_ability.area_condition == "Play" and context.cardarea == G.play)) and
        (card.ability.extra.chosen_ability.unconditional or
          (card.ability.extra.chosen_ability.suit_condition and (
            (card.ability.extra.chosen_ability.suit_condition == "Random" and context.other_card:is_suit(card.ability.extra.chosen_suit))
            or (card.ability.extra.chosen_ability.suit_condition ~= "Random" and context.other_card:is_suit(card.ability.extra.chosen_ability.suit_condition))
          ))
          or (card.ability.extra.chosen_ability.rank_condition and (
            (card.ability.extra.chosen_ability.rank_condition == "Face" and context.other_card:is_face())
            or (card.ability.extra.chosen_ability.rank_condition ~= "Random" and context.other_card:get_id() == card.ability.extra.chosen_ability.rank_condition)
            or (card.ability.extra.chosen_ability.rank_condition == "Random" and context.other_card:get_id() == card.ability.extra.chosen_rank)
          ))) then
      return {
        chips = card.ability.extra.chosen_ability.chips,
        mult = card.ability.extra.chosen_ability.mult,
        xmult = card.ability.extra.chosen_ability.xmult,
        dollars = card.ability.extra.chosen_ability.money
      }
    end

    if context.discard and card.ability.extra.chosen_ability.area_condition == "Discard" and
        (card.ability.extra.chosen_ability.unconditional or
          (card.ability.extra.chosen_ability.suit_condition and (
            (card.ability.extra.chosen_ability.suit_condition == "Random" and context.other_card:is_suit(card.ability.extra.chosen_suit))
            or (card.ability.extra.chosen_ability.suit_condition ~= "Random" and context.other_card:is_suit(card.ability.extra.chosen_ability.suit_condition))
          ))
          or (card.ability.extra.chosen_ability.rank_condition and (
            (card.ability.extra.chosen_ability.rank_condition == "Face" and context.other_card:is_face())
            or (card.ability.extra.chosen_ability.rank_condition ~= "Random" and context.other_card:get_id() == card.ability.extra.chosen_ability.rank_condition)
            or (card.ability.extra.chosen_ability.rank_condition == "Random" and context.other_card:get_id() == card.ability.extra.chosen_rank)
          ))
        ) then
      return {
        dollars = card.ability.extra.chosen_ability.money
      }
    end

    if context.setting_blind and not (context.blueprint_card or self).getting_sliced and count_consumables() < G.consumeables.config.card_limit
        and (card.ability.extra.chosen_ability.tarot or card.ability.extra.chosen_ability.planet or card.ability.extra.chosen_ability.spectral) then
      G.GAME.consumeable_buffer = G.GAME.consumeable_buffer + 1
      G.E_MANAGER:add_event(Event({
        func = (function()
          G.E_MANAGER:add_event(Event({
            func = function()
              local set = card.ability.extra.chosen_ability.tarot and "Tarot" or
                  card.ability.extra.chosen_ability.planet and "Planet" or
                  card.ability.extra.chosen_ability.spectral and "Spectral"
              local card = create_card(set, G.consumeables, nil, nil, nil, nil, nil, 'peekabooconsumable')
              card:add_to_deck()
              G.consumeables:emplace(card)
              G.GAME.consumeable_buffer = 0
              return true
            end
          }))
          local loc = card.ability.extra.chosen_ability.tarot and "k_plus_tarot" or
              card.ability.extra.chosen_ability.planet and "k_plus_planet" or
              card.ability.extra.chosen_ability.spectral and "k_plus_spectral"
          local colour = card.ability.extra.chosen_ability.tarot and G.C.PURPLE or
              card.ability.extra.chosen_ability.planet and G.C.BLUE or
              card.ability.extra.chosen_ability.spectral and G.C.SECONDARY_SET.Spectral
          card_eval_status_text(context.blueprint_card or card, 'extra', nil, nil, nil,
            { message = localize(loc), colour = colour })
          return true
        end)
      }))
    end
  end,
  add_to_deck = function(self, card, from_debuff)
    card.ability.extra.chosen_ability = pseudorandom_element(card.ability.extra.all_abilities,
      pseudoseed('peekabooability'))
    local ranks = { 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14 }
    card.ability.extra.chosen_rank = pseudorandom_element(ranks, pseudoseed('peekaboorank'))
    local suits = { "Diamonds", "Hearts", "Spades", "Clubs" }
    card.ability.extra.chosen_suit = pseudorandom_element(suits, pseudoseed('peekaboosuit'))
    if card.ability.extra.chosen_ability.hands then
      ease_hands_played(card.ability.extra.chosen_ability.hands)
      G.GAME.round_resets.hands = G.GAME.round_resets.hands + card.ability.extra.chosen_ability.hands
    end
    if card.ability.extra.chosen_ability.discards then
      ease_discard(card.ability.extra.chosen_ability.discards)
      G.GAME.round_resets.discards = G.GAME.round_resets.discards + card.ability.extra.chosen_ability.discards
    end
    if card.ability.extra.chosen_ability.hand_size then G.hand:change_size(card.ability.extra.chosen_ability.hand_size) end
    if card.ability.extra.chosen_ability.shop_size then change_shop_size(card.ability.extra.chosen_ability.shop_size) end

    if card.ability.extra.chosen_ability.double_tag then
      G.E_MANAGER:add_event(Event({
        func = (function()
          add_tag(Tag('tag_double'))
          play_sound('generic1', 0.9 + math.random() * 0.1, 0.8)
          play_sound('holo1', 1.2 + math.random() * 0.1, 0.4)
          return true
        end)
      }))
    end

    if card.ability.extra.chosen_ability.foil then
      G.E_MANAGER:add_event(Event({
        func = (function()
          card:set_edition("e_foil")
          return true
        end)
      }))
    end
    if card.ability.extra.chosen_ability.holographic then
      G.E_MANAGER:add_event(Event({
        func = (function()
          card:set_edition("e_holo")
          return true
        end)
      }))
    end
    if card.ability.extra.chosen_ability.polychrome then
      G.E_MANAGER:add_event(Event({
        func = (function()
          card:set_edition("e_polychrome")
          return true
        end)
      }))
    end
    if card.ability.extra.chosen_ability.negative then
      G.E_MANAGER:add_event(Event({
        func = (function()
          card:set_edition("e_negative")
          return true
        end)
      }))
    end
  end,
  remove_from_deck = function(self, card, from_debuff)
    if card.ability.extra.chosen_ability.hands then
      ease_hands_played(-card.ability.extra.chosen_ability.hands)
      G.GAME.round_resets.hands = G.GAME.round_resets.hands - card.ability.extra.chosen_ability.hands
    end
    if card.ability.extra.chosen_ability.discards then
      ease_discard(-card.ability.extra.chosen_ability.discards)
      G.GAME.round_resets.discards = G.GAME.round_resets.discards - card.ability.extra.chosen_ability.discards
    end
    if card.ability.extra.chosen_ability.hand_size then G.hand:change_size(-card.ability.extra.chosen_ability.hand_size) end
    if card.ability.extra.chosen_ability.shop_size then change_shop_size(-card.ability.extra.chosen_ability.shop_size) end
  end,
  calc_dollar_bonus = function(self, card)
    if card.ability.extra.chosen_ability.eormoney then return card.ability.extra.chosen_ability.eormoney end
  end
}

G.Phanta.centers["absentjoker"] = {
  config = { extra = { mult = 15 } },
  loc_vars = function(self, info_queue, card)
    return { vars = { card.ability.extra.mult } }
  end,
  rarity = 1,
  atlas = 'Phanta2',
  pos = { x = 4, y = 1 },
  phanta_anim = { { x = 4, y = 1, t = 2 }, { x = 5, y = 1, t = 0.15 }, { x = 4, y = 1, t = 0.25 }, { x = 5, y = 1, t = 0.15 }, { x = 4, y = 1, t = 0.25 }, { x = 5, y = 1, t = 0.15 } },
  cost = 4,
  blueprint_compat = true,
  eternal_compat = true,
  perishable_compat = true,
  calculate = function(self, card, context)
    if context.joker_main and G.jokers.config.card_limit - #G.jokers.cards == 1 then
      return {
        mult = card.ability.extra
            .mult
      }
    end
  end
}

G.Phanta.centers["fanta"] = {
  rarity = 1,
  atlas = 'Phanta2',
  pos = { x = 3, y = 1 },
  cost = 4,
  loc_vars = function(self, info_queue, card)
    info_queue[#info_queue + 1] = G.P_SEALS["Gold"]
    return {
      main_end = { {
        n = G.UIT.C,
        config = { align = "bm", minh = 0.4 },
        nodes =
        { {
          n = G.UIT.C,
          config = { ref_table = self, align = "m", colour = G.hand and G.hand.cards and #G.hand.cards > 0 and G.C.GREEN or G.C.RED, r = 0.05, padding = 0.06 },
          nodes = { { n = G.UIT.T, config = { text = ' ' .. localize(G.hand and G.hand.cards and #G.hand.cards > 0 and 'phanta_active' or 'phanta_inactive') .. ' ', colour = G.C.UI.TEXT_LIGHT, scale = 0.32 * 0.9 } } }
        } }
      } }
    }
  end,
  blueprint_compat = true,
  eternal_compat = false,
  perishable_compat = true,
  calculate = function(self, card, context)
    if context.selling_self and G.hand and G.hand.cards and #G.hand.cards > 0 then
      local conv_card = pseudorandom_element(G.hand.cards, pseudoseed('fantacard'))
      G.E_MANAGER:add_event(Event({
        func = function()
          play_sound('tarot1')
          card:juice_up(0.3, 0.5)
          card_eval_status_text(context.blueprint_card or card, 'extra', nil, nil, nil,
            { message = localize("phanta_created_gold_seal"), colour = G.C.GOLD, card = card })
          return true
        end
      }))

      G.E_MANAGER:add_event(Event({
        trigger = 'after',
        delay = 0.1,
        func = function()
          conv_card:set_seal("Gold", nil, true)
          return true
        end
      }))
    end
  end
}

G.Phanta.centers["heartbreak"] = {
  config = { extra = { xmult = 1.5, odds = 2 } },
  rarity = 2,
  atlas = 'PhantaMiscAnims1',
  pos = { x = 0, y = 9 },
  phanta_anim = {
    { xrange = { first = 0, last = 11 }, yrange = { first = 9, last = 10 }, t = 0.1 },
    { xrange = { first = 0, last = 3 },  y = 11,                            t = 0.1 }
  },
  cost = 6,
  loc_vars = function(self, info_queue, card)
    return { vars = { card.ability.extra.xmult, (G.GAME.probabilities.normal or 1), card.ability.extra.odds } }
  end,
  blueprint_compat = true,
  eternal_compat = true,
  perishable_compat = true,
  calculate = function(self, card, context)
    if context.individual and context.cardarea == G.play and context.other_card:is_suit("Hearts") then
      return { xmult = card.ability.extra.xmult }
    end

    if context.destroy_card and context.cardarea == G.play and context.destroy_card:is_suit("Hearts")
        and pseudorandom('heartbreak') < G.GAME.probabilities.normal / card.ability.extra.odds then
      return { remove = true }
    end
  end
}

G.Phanta.centers["distance"] = {
  config = { extra = { chips = 250 } },
  rarity = 3,
  atlas = 'Phanta2',
  pos = { x = 2, y = 1 },
  cost = 7,
  loc_vars = function(self, info_queue, card)
    return { vars = { card.ability.extra.chips } }
  end,
  blueprint_compat = true,
  eternal_compat = true,
  perishable_compat = true,
  add_to_deck = function(self, card, from_debuff)
    change_shop_size(-1)
  end,
  remove_from_deck = function(self, card, from_debuff)
    change_shop_size(1)
  end,
  calculate = function(self, card, context)
    if context.joker_main then return { chips = card.ability.extra.chips } end
  end
}

G.Phanta.centers["donpaolo"] = {
  rarity = 2,
  atlas = 'PhantaLaytonAnims',
  pos = { x = 0, y = 2 },
  phanta_anim = {
    { x = 0, y = 2, t = 1.3 }, { x = 1, y = 2, t = 0.1 },
    { x = 0, y = 2, t = 2.7 }, { x = 1, y = 2, t = 0.1 },
    { x = 0, y = 2, t = 0.1 }, { x = 1, y = 2, t = 0.1 },
    { x = 0, y = 2, t = 2.1 }, { x = 1, y = 2, t = 0.1 },
    { x = 0, y = 2, t = 2.9 }, { x = 1, y = 2, t = 0.1 },
    { x = 2, y = 2, t = 0.1 }, { x = 3, y = 2, t = 0.1 }, { x = 4, y = 2, t = 0.8 },
    { x = 3, y = 2, t = 0.1 }, { x = 4, y = 2, t = 0.4 }, { x = 3, y = 2, t = 0.1 }, { x = 4, y = 2, t = 0.4 },
    { x = 3, y = 2, t = 0.1 }, { x = 2, y = 2, t = 0.1 }, { x = 1, y = 2, t = 0.1 },
  },
  cost = 6,
  blueprint_compat = false,
  eternal_compat = true,
  perishable_compat = true,
  calculate = function(self, card, context)
    if context.selling_card and context.card.config.center.set == "Tarot" and #G.hand.highlighted == 1 then
      G.E_MANAGER:add_event(Event({
        trigger = 'after',
        delay = 0.2,
        func = function()
          card:juice_up()
          SMODS.destroy_cards(G.hand.highlighted)
          return true
        end
      }))
    end
  end
}

G.Phanta.centers["futureluke"] = {
  rarity = 2,
  atlas = 'PhantaLaytonAnims',
  pos = { x = 0, y = 3 },
  phanta_anim = {
    { x = 0, y = 3, t = 1.5 }, { x = 1, y = 3, t = 0.1 },
    { x = 0, y = 3, t = 2.2 }, { x = 1, y = 3, t = 0.1 },
    { x = 0, y = 3, t = 0.4 }, { x = 1, y = 3, t = 0.1 },
    { x = 0, y = 3, t = 1.6 }, { x = 1, y = 3, t = 0.1 },
    { x = 0, y = 3, t = 2.5 },
    { x = 1, y = 3, t = 0.4 },
    { x = 2, y = 3, t = 0.1 }, { x = 1, y = 3, t = 0.2 },
    { x = 2, y = 3, t = 0.1 }, { x = 1, y = 3, t = 0.2 },
    { x = 2, y = 3, t = 0.1 }, { x = 1, y = 3, t = 0.3 },
  },
  cost = 6,
  blueprint_compat = false,
  eternal_compat = true,
  perishable_compat = true,
  calculate = function(self, card, context)
    if context.selling_card and context.card.config.center.set == "Planet" and #G.hand.highlighted == 1 then
      G.E_MANAGER:add_event(Event({
        trigger = 'after',
        delay = 0.2,
        func = function()
          card:juice_up()
          SMODS.destroy_cards(G.hand.highlighted)
          return true
        end
      }))
    end
  end
}

G.Phanta.centers["barton"] = {
  config = { extra = { mult = 50, requirement = 15 } },
  rarity = 2,
  atlas = 'PhantaLaytonAnims',
  pos = { x = 0, y = 4 },
  phanta_anim = {
    { x = 0, y = 4, t = 1.7 }, { x = 1, y = 4, t = 0.1 },
    { x = 0, y = 4, t = 0.1 }, { x = 1, y = 4, t = 0.1 },
    { x = 0, y = 4, t = 0.1 }, { x = 1, y = 4, t = 0.1 },
    { x = 0, y = 4, t = 1.9 }, { x = 1, y = 4, t = 0.1 },
    { x = 0, y = 4, t = 0.9 }, { x = 1, y = 4, t = 0.1 },
    { x = 0, y = 4, t = 0.3 }, { x = 2, y = 4, t = 0.1 }, { x = 0, y = 4, t = 0.1 }, { x = 2, y = 4, t = 0.1 }, { x = 0, y = 4, t = 0.3 }, { x = 1, y = 4, t = 0.1 }, { x = 0, y = 4, t = 0.4 },
    { x = 3, y = 4, t = 0.2 }, { x = 0, y = 4, t = 0.2 }, { x = 4, y = 4, t = 0.2 }, { x = 0, y = 4, t = 0.05 },
    { x = 3, y = 4, t = 0.2 }, { x = 0, y = 4, t = 0.2 }, { x = 4, y = 4, t = 0.2 }, { x = 0, y = 4, t = 0.05 },
    { x = 3, y = 4, t = 0.2 }, { x = 0, y = 4, t = 0.2 }, { x = 4, y = 4, t = 0.2 }, { x = 0, y = 4, t = 0.05 }
  },
  cost = 6,
  blueprint_compat = true,
  eternal_compat = true,
  perishable_compat = true,
  loc_vars = function(self, info_queue, card)
    return {
      vars = { card.ability.extra.mult, card.ability.extra.requirement, count_unique_tarots(),
        (next(SMODS.find_card("j_phanta_inspectorchelmey")) or count_unique_tarots() >= card.ability.extra.requirement) and
        localize("phanta_active") or localize("phanta_inactive") }
    }
  end,
  calculate = function(self, card, context)
    if context.joker_main then
      if next(SMODS.find_card("j_phanta_inspectorchelmey")) or count_unique_tarots() >= card.ability.extra.requirement then
        return { mult = card.ability.extra.mult }
      end
    end
  end
}

G.Phanta.centers["inspectorchelmey"] = {
  config = { extra = { xmult = 3, requirement = 9 } },
  rarity = 2,
  atlas = 'PhantaLaytonAnims',
  pos = { x = 0, y = 5 },
  phanta_anim = {
    { x = 0, y = 5, t = 1.2 }, { x = 1, y = 5, t = 0.1 },
    { x = 0, y = 5, t = 2.5 }, { x = 1, y = 5, t = 0.1 },
    { x = 0, y = 5, t = 0.1 }, { x = 1, y = 5, t = 0.1 },
    { x = 0, y = 5, t = 1.6 }, { x = 1, y = 5, t = 0.1 },
    { x = 2, y = 5, t = 2.1 }, { x = 3, y = 5, t = 0.1 },
    { x = 4, y = 5, t = 2.7 }, { x = 5, y = 5, t = 0.1 },
    { x = 4, y = 5, t = 0.9 }, { x = 5, y = 5, t = 0.1 },
    { x = 4, y = 5, t = 1.8 }, { x = 5, y = 5, t = 0.1 }, { x = 4, y = 5, t = 0.4 },
    { x = 3, y = 5, t = 0.1 }, { x = 1, y = 5, t = 0.3 },
  },
  cost = 6,
  blueprint_compat = true,
  eternal_compat = true,
  perishable_compat = true,
  loc_vars = function(self, info_queue, card)
    return {
      vars = { card.ability.extra.xmult, card.ability.extra.requirement, count_unique_planets(),
        (next(SMODS.find_card("j_phanta_barton")) or count_unique_planets() >= card.ability.extra.requirement) and
        localize("phanta_active") or localize("phanta_inactive") }
    }
  end,
  calculate = function(self, card, context)
    if context.joker_main then
      if next(SMODS.find_card("j_phanta_barton")) or count_unique_planets() >= card.ability.extra.requirement then
        return { xmult = card.ability.extra.xmult }
      end
    end
  end
}

G.Phanta.centers["zeroii"] = {
  config = { extra = { odds = 3 } },
  rarity = 2,
  atlas = 'Phanta2',
  pos = { x = 1, y = 1 },
  cost = 6,
  blueprint_compat = true,
  eternal_compat = true,
  perishable_compat = true,
  loc_vars = function(self, info_queue, card)
    return { vars = { (G.GAME.probabilities.normal or 1), card.ability.extra.odds } }
  end,
  calculate = function(self, card, context)
    if context.discard and G.GAME.current_round.discards_used <= 0 and pseudorandom('zeroii') < G.GAME.probabilities.normal / card.ability.extra.odds then
      return { remove = true }
    end
  end
}

G.Phanta.centers["valantgramarye"] = {
  rarity = 2,
  atlas = 'Phanta2',
  pos = { x = 8, y = 1 },
  cost = 5,
  blueprint_compat = false,
  eternal_compat = true,
  perishable_compat = true,
  calculate = function(self, card, context)
    if context.evaluate_poker_hand and context.scoring_name == "Straight" then
      return { replace_scoring_name = "Straight Flush" }
    end
    if context.evaluate_poker_hand and context.scoring_name == "Straight Flush" then
      return { replace_scoring_name = "Straight" }
    end
  end
}

--[[G.Phanta.centers["snoinches"] = {
  rarity = 2,
  atlas = 'Phanta2',
  pos = { x = 11, y = 1 },
  cost = 5,
  blueprint_compat = true,
  eternal_compat = true,
  perishable_compat = true,
  calculate = function(self, card, context)
    if context.after and G.play.cards and G.play.cards[1] then
      draw_card(G.play, G.hand, 90, 'up', true, G.play.cards[1])
      return { message = "Mrrrp", colour = G.C.GOLD, card = card }
    end
  end,
  set_badges = function(self, card, badges)
    badges[#badges + 1] = create_badge(localize('credit_bobisnotaperson'), G.C.PHANTA.MISC_COLOURS.PHANTA, G.C.WHITE, 1)
  end
}]] --

G.Phanta.centers["bloodyace"] = {
  rarity = 1,
  atlas = 'Phanta2',
  pos = { x = 7, y = 1 },
  cost = 4,
  blueprint_compat = false,
  eternal_compat = true,
  perishable_compat = true,
  calculate = function(self, card, context)
    if context.evaluate_poker_hand then
      local ace_counter = 0
      for _, card in ipairs(context.scoring_hand) do
        if card:get_id() == 14 then ace_counter = ace_counter + 1 end
      end
      if ace_counter >= 2 then return { replace_scoring_name = "Full House" } end
    end
  end
}

G.Phanta.centers["yatagarasucard"] = {
  config = { extra = { money = 3 } },
  loc_vars = function(self, info_queue, card)
    return { vars = { card.ability.extra.money } }
  end,
  rarity = 1,
  atlas = 'Phanta2',
  pos = { x = 1, y = 2 },
  cost = 4,
  blueprint_compat = true,
  eternal_compat = true,
  perishable_compat = true,
  calculate = function(self, card, context)
    if context.individual and context.cardarea == G.play and context.other_card:get_id() == 3 then
      return { dollars = card.ability.extra.money }
    end
  end
}

G.Phanta.centers["modping"] = {
  config = { extra = { money_needed = 20, money_increase = 10 } },
  loc_vars = function(self, info_queue, card)
    return {
      vars = { card.ability.extra.money_needed, card.ability.extra.money_increase },
      main_end = { { n = G.UIT.C, config = { align = "bm", minh = 0.4 }, nodes = { { n = G.UIT.C, config = { ref_table = self, align = "m", colour = is_boss_active() and G.C.GREEN or G.C.RED, r = 0.05, padding = 0.06 }, nodes = { { n = G.UIT.T, config = { text = ' ' .. localize(is_boss_active() and 'k_active' or 'ph_no_boss_active') .. ' ', colour = G.C.UI.TEXT_LIGHT, scale = 0.32 * 0.9 } } } } } } }
    }
  end,
  rarity = 2,
  atlas = 'Phanta2',
  pos = { x = 2, y = 2 },
  cost = 5,
  blueprint_compat = false,
  eternal_compat = true,
  perishable_compat = true
}

G.Phanta.centers["clapperboard"] = {
  rarity = 2,
  atlas = 'Phanta2',
  pos = { x = 4, y = 0 },
  cost = 6,
  blueprint_compat = false,
  eternal_compat = true,
  perishable_compat = true,
  in_pool = function()
    return #SMODS.find_card('v_retcon') == 0
  end
}

G.Phanta.centers["birthdaycard"] = {
  config = { extra = { added_xmult = 0.2, current_xmult = 1 } },
  loc_vars = function(self, info_queue, card)
    info_queue[#info_queue + 1] = G.P_CENTERS.e_phanta_waxed
    return { vars = { card.ability.extra.added_xmult, card.ability.extra.current_xmult } }
  end,
  rarity = 2,
  atlas = 'Phanta2',
  pos = { x = 5, y = 0 },
  cost = 5,
  blueprint_compat = true,
  eternal_compat = true,
  perishable_compat = true,
  calculate = function(self, card, context)
    if context.joker_main and card.ability.extra.current_xmult > 1 then
      return { xmult = card.ability.extra.current_xmult }
    end

    if context.remove_playing_cards and not context.blueprint then
      local waxed_cards = {}
      for i = 1, #context.removed do
        if context.removed[i].edition and context.removed[i].edition.key == 'e_phanta_waxed' then
          waxed_cards[#waxed_cards + 1] =
              context.removed[i].edition.key
        end
      end

      if #waxed_cards > 0 then
        card.ability.extra.current_xmult = card.ability.extra.current_xmult +
            (#waxed_cards * card.ability.extra.added_xmult)
        return { message = localize("k_upgrade_ex"), colour = G.C.FILTER, card = card }
      end
    end
  end
}

G.Phanta.centers["plugsocket"] = {
  config = { extra = { xmult = 0.25 } },
  loc_vars = function(self, info_queue, card)
    return { vars = { card.ability.extra.xmult, 1 + (#count_base_copper_grates() * card.ability.extra.xmult) } }
  end,
  rarity = 2,
  atlas = 'Phanta2',
  pos = { x = 3, y = 0 },
  cost = 6,
  blueprint_compat = true,
  eternal_compat = true,
  perishable_compat = true,
  calculate = function(self, card, context)
    if context.joker_main then
      local copper_grates = #count_base_copper_grates()
      if copper_grates > 0 then
        return { xmult = 1 + (copper_grates * card.ability.extra.xmult) }
      end
    end
  end
}

G.Phanta.centers["neonjoker"] = {
  config = { extra = { xmult = 3 } },
  rarity = 2,
  atlas = 'Phanta2',
  pos = { x = 10, y = 0 },
  phanta_anim = {
    { x = 10, y = 0, t = 0.9 }, { x = 11, y = 0, t = 0.1 },
    { x = 10, y = 0, t = 0.1 }, { x = 11, y = 0, t = 0.1 },
    { x = 10, y = 0, t = 0.5 }, { x = 11, y = 0, t = 0.1 },
    { x = 10, y = 0, t = 1.6 }, { x = 11, y = 0, t = 0.1 },
    { x = 10, y = 0, t = 0.4 }, { x = 11, y = 0, t = 0.1 },
    { x = 10, y = 0, t = 0.2 }, { x = 11, y = 0, t = 0.1 },
    { x = 10, y = 0, t = 1.1 }, { x = 11, y = 0, t = 0.1 },
    { x = 10, y = 0, t = 1.5 }, { x = 11, y = 0, t = 0.1 },
    { x = 10, y = 0, t = 0.5 }, { x = 11, y = 0, t = 0.1 },
    { x = 10, y = 0, t = 0.8 }, { x = 11, y = 0, t = 0.1 },
    { x = 10, y = 0, t = 0.1 }, { x = 11, y = 0, t = 0.1 },
    { x = 10, y = 0, t = 0.1 }, { x = 11, y = 0, t = 0.1 },
    { x = 10, y = 0, t = 1.4 }, { x = 11, y = 0, t = 0.1 },
    { x = 10, y = 0, t = 0.2 }, { x = 11, y = 0, t = 0.1 },
    { x = 10, y = 0, t = 1.3 }, { x = 11, y = 0, t = 0.1 }
  },
  cost = 6,
  loc_vars = function(self, info_queue, card)
    return { vars = { card.ability.extra.xmult } }
  end,
  blueprint_compat = true,
  eternal_compat = true,
  perishable_compat = true,
  calculate = function(self, card, context)
    if context.joker_main then
      local wilds = 0
      local counted_suits = {}
      for i = 1, #G.hand.cards do
        if not SMODS.has_any_suit(G.hand.cards[i]) then
          local is_new = true
          for j = 1, #counted_suits do
            if G.hand.cards[i].base.suit == counted_suits[j] then is_new = false end
          end
          if is_new then counted_suits[#counted_suits + 1] = G.hand.cards[i].base.suit end
        else
          wilds = wilds + 1
        end
      end

      if #counted_suits + wilds >= 4 then
        return { xmult = card.ability.extra.xmult }
      end
    end
  end
}

G.Phanta.centers["technojoker"] = {
  config = { extra = { xmult = 0.5 } },
  loc_vars = function(self, info_queue, card)
    return { vars = { card.ability.extra.xmult, 1 + (count_missing_ranks() * card.ability.extra.xmult) } }
  end,
  rarity = 3,
  atlas = 'Phanta2',
  pos = { x = 1, y = 0 },
  phanta_anim = { { x = 1, y = 0, t = 0.5 }, { x = 2, y = 0, t = 0.5 } },
  cost = 8,
  blueprint_compat = true,
  eternal_compat = true,
  perishable_compat = true,
  calculate = function(self, card, context)
    if context.joker_main then
      local missing_ranks = count_missing_ranks()
      if missing_ranks > 0 then
        return { xmult = 1 + (missing_ranks * card.ability.extra.xmult) }
      end
    end
  end
}

G.Phanta.centers["profile"] = {
  loc_vars = function(self, info_queue, card)
    info_queue[#info_queue + 1] = G.P_TAGS.tag_charm
    info_queue[#info_queue + 1] = G.P_TAGS.tag_meteor
    info_queue[#info_queue + 1] = G.P_TAGS.tag_ethereal
    return {}
  end,
  rarity = 3,
  atlas = 'Phanta2',
  pos = { x = 10, y = 1 },
  cost = 8,
  blueprint_compat = false,
  eternal_compat = true,
  perishable_compat = true
}
