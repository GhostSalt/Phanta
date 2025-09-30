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
  key = "lobotomy_die",
  path = "phanta_lobotomy_die.ogg",
  replace = true
})

SMODS.Sound({
  vol = 1,
  pitch = 1,
  key = "polargeist_music",
  path = "phanta_polargeist.ogg",
  select_music_track = function()
    if #SMODS.find_card('j_phanta_normalface') > 0 and not Phanta.config["custom_music_disabled"] then
      return 1e6
    end
    return false
  end
})

G.Phanta.centers["normalface"] = {
  config = { extra = { mult = 10, amazing_grace = false } },
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
    if not context.repetition and not card.ability.extra.amazing_grace and math.random() > 0.95 then
      local all_pitches = { { 1 }, { 1, 1, 1, 1, 0.5, 2 }, { 1, 1, 2 } }

      local sound = math.floor(math.random() * #all_pitches)
      sound = sound < #all_pitches and sound or 1
      local pitch = all_pitches[sound + 1][math.floor(math.random() * #all_pitches[sound + 1]) + 1]

      G.E_MANAGER:add_event(Event({
        func = function()
          G.E_MANAGER:add_event(Event({
            func = function()
              if not card.ability.extra.amazing_grace then
                play_sound("phanta_lobotomy_" .. sound, pitch, 1)
                card_eval_status_text(card, 'extra', nil, nil, nil, { message = ":)", colour = G.C.GREEN })
              end
              return true
            end
          }))
          return true
        end
      }))
    end

    if context.selling_self or (context.joker_type_destroyed and context.joker_type_destroyed == card) then
      card.ability.extra.amazing_grace = true
      card.children.center:set_sprite_pos({ x = 0, y = 4 })
      play_sound("phanta_lobotomy_die", 1, 0.5)
      card_eval_status_text(card, 'extra', nil, nil, nil, { message = ">:(", colour = G.C.RED })
      delay(4.5)
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



SMODS.Atlas {
  key = "PhantaDeckJoker",
  path = "PhantaDeckJoker.png",
  px = 71,
  py = 95
}

G.Phanta.centers["deckjoker"] = {
  rarity = 1,
  atlas = "PhantaDeckJoker",
  pos = { x = 0, y = 0 },
  cost = 4,
  in_pool = function()
    return G.GAME.phanta_deck_joker_selected_deck
  end
}

function phanta_assign_deck_joker()
  local deck_key = G.GAME.selected_back and G.GAME.selected_back.effect and G.GAME.selected_back.effect.center and
      G.GAME.selected_back.effect.center.key
  local deck = deck_key and G.phanta_all_deck_joker_decks[deck_key]
  G.GAME.phanta_deck_joker_selected_deck = deck and deck_key

  if deck then
    G.P_CENTERS["j_phanta_deckjoker"].config = deck.config or {}
    G.P_CENTERS["j_phanta_deckjoker"].loc_vars = function(self, info_queue, card)
      for _, v in ipairs(deck.info_queue or {}) do
        info_queue[#info_queue + 1] = v
      end
      return { key = deck.loc_key and self.key .. "_" .. deck.loc_key or self.key, vars = deck.loc_vars }
    end

    G.P_CENTERS["j_phanta_deckjoker"].set_sprites = function(self, card, front)
      if not self.discovered and not card.params.bypass_discovery_center then
        return
      end
      if card and card.children and card.children.center and card.children.center.set_sprite_pos then
        card.children.center.atlas = G.ASSET_ATLAS[deck.atlas or "phanta_PhantaDeckJoker"]
        card.children.center:set_sprite_pos({
          x = deck.pos and deck.pos.x or 0,
          y = deck.pos and deck.pos.y or 0
        })
      end
    end

    G.P_CENTERS["j_phanta_deckjoker"].calculate = deck.calculate
    G.P_CENTERS["j_phanta_deckjoker"].add_to_deck = deck.add_to_deck
    G.P_CENTERS["j_phanta_deckjoker"].remove_from_deck = deck.remove_from_deck
    G.P_CENTERS["j_phanta_deckjoker"].calc_dollar_bonus = deck.calc_dollar_bonus

    G.P_CENTERS["j_phanta_deckjoker"].blueprint_compat = deck.blueprint_compat or false
    G.P_CENTERS["j_phanta_deckjoker"].eternal_compat = deck.eternal_compat or false
    G.P_CENTERS["j_phanta_deckjoker"].perishable_compat = deck.perishable_compat or false

    G.P_CENTERS["j_phanta_deckjoker"].pos = deck.pos or { x = 0, y = 0 }
    G.P_CENTERS["j_phanta_deckjoker"].cost = deck.cost or 4
    G.P_CENTERS["j_phanta_deckjoker"].rarity = deck.rarity or 1
    G.P_CENTERS["j_phanta_deckjoker"].atlas = deck.atlas or "phanta_PhantaDeckJoker"
  else
    G.P_CENTERS["j_phanta_deckjoker"].config = nil
    G.P_CENTERS["j_phanta_deckjoker"].loc_vars = nil

    G.P_CENTERS["j_phanta_deckjoker"].set_sprites = function(self, card, front)
      if not self.discovered and not card.params.bypass_discovery_center then
        return
      end
      if card and card.children and card.children.center and card.children.center.set_sprite_pos then
        card.children.center.atlas = G.ASSET_ATLAS["phanta_PhantaDeckJoker"]
        card.children.center:set_sprite_pos({ x = 0, y = 0 })
      end
    end

    G.P_CENTERS["j_phanta_deckjoker"].calculate = nil
    G.P_CENTERS["j_phanta_deckjoker"].add_to_deck = nil
    G.P_CENTERS["j_phanta_deckjoker"].remove_from_deck = nil
    G.P_CENTERS["j_phanta_deckjoker"].calc_dollar_bonus = nil

    G.P_CENTERS["j_phanta_deckjoker"].blueprint_compat = false
    G.P_CENTERS["j_phanta_deckjoker"].eternal_compat = false
    G.P_CENTERS["j_phanta_deckjoker"].perishable_compat = false

    G.P_CENTERS["j_phanta_deckjoker"].pos = { x = 0, y = 0 }
    G.P_CENTERS["j_phanta_deckjoker"].cost = 4
    G.P_CENTERS["j_phanta_deckjoker"].rarity = 1
    G.P_CENTERS["j_phanta_deckjoker"].atlas = "phanta_PhantaDeckJoker"
  end
end

function phanta_add_deck_joker_deck(deck)
  G.phanta_all_deck_joker_decks = G.phanta_all_deck_joker_decks or {}
  G.phanta_all_deck_joker_decks[deck.key] = deck
end

-- Find the list of decks in DeckJoker.lua.



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
        mult = card.ability.extra.mult
      }
    end
  end
}

G.Phanta.centers["patientjoker"] = {
  config = { extra = { mult = 12 } },
  loc_vars = function(self, info_queue, card)
    return { vars = { card.ability.extra.mult } }
  end,
  rarity = 1,
  atlas = 'Phanta2',
  pos = { x = 3, y = 2 },
  cost = 4,
  blueprint_compat = true,
  eternal_compat = true,
  perishable_compat = true,
  calculate = function(self, card, context)
    if context.joker_main then
      for _, v in ipairs(context.scoring_hand) do
        if v:is_suit("Diamonds") then return { mult = card.ability.extra.mult } end
      end
    end
  end
}

G.Phanta.centers["blissedjoker"] = {
  config = { extra = { mult = 12 } },
  loc_vars = function(self, info_queue, card)
    return { vars = { card.ability.extra.mult } }
  end,
  rarity = 1,
  atlas = 'Phanta2',
  pos = { x = 4, y = 2 },
  cost = 4,
  blueprint_compat = true,
  eternal_compat = true,
  perishable_compat = true,
  calculate = function(self, card, context)
    if context.joker_main then
      for _, v in ipairs(context.scoring_hand) do
        if v:is_suit("Hearts") then return { mult = card.ability.extra.mult } end
      end
    end
  end
}

G.Phanta.centers["forgivingjoker"] = {
  config = { extra = { mult = 12 } },
  loc_vars = function(self, info_queue, card)
    return { vars = { card.ability.extra.mult } }
  end,
  rarity = 1,
  atlas = 'Phanta2',
  pos = { x = 5, y = 2 },
  cost = 4,
  blueprint_compat = true,
  eternal_compat = true,
  perishable_compat = true,
  calculate = function(self, card, context)
    if context.joker_main then
      for _, v in ipairs(context.scoring_hand) do
        if v:is_suit("Spades") then return { mult = card.ability.extra.mult } end
      end
    end
  end
}

G.Phanta.centers["temperedjoker"] = {
  config = { extra = { mult = 12 } },
  loc_vars = function(self, info_queue, card)
    return { vars = { card.ability.extra.mult } }
  end,
  rarity = 1,
  atlas = 'Phanta2',
  pos = { x = 6, y = 2 },
  cost = 4,
  blueprint_compat = true,
  eternal_compat = true,
  perishable_compat = true,
  calculate = function(self, card, context)
    if context.joker_main then
      for _, v in ipairs(context.scoring_hand) do
        if v:is_suit("Clubs") then return { mult = card.ability.extra.mult } end
      end
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

G.Phanta.centers["testpage"] = {
  config = { extra = { added_chips = 20, current_chips = 0 } },
  rarity = 1,
  atlas = 'Phanta2',
  pos = { x = 1, y = 3 },
  cost = 4,
  loc_vars = function(self, info_queue, card)
    return { vars = { card.ability.extra.added_chips, card.ability.extra.current_chips } }
  end,
  blueprint_compat = true,
  eternal_compat = true,
  perishable_compat = false,
  calculate = function(self, card, context)
    if context.joker_main and card.ability.extra.current_chips > 0 then
      return { chips = card.ability.extra.current_chips }
    end
    if context.before and context.scoring_name == "phanta_junk" and not context.blueprint then
      card.ability.extra.current_chips = card.ability.extra.current_chips + card.ability.extra.added_chips
      return { message = localize("k_upgrade_ex"), colour = G.C.FILTER }
    end
  end,
  in_pool = function()
    return G.GAME.hands["phanta_junk"].visible and Phanta.config["junk_enabled"]
  end
}

G.Phanta.centers["flagsignal"] = {
  config = { extra = { added_mult = 1, current_mult = 0 } },
  rarity = 1,
  atlas = 'PhantaMiscAnims5',
  pos = { x = 10, y = 2 },
  phanta_anim = {
    { x = 10, y = 2, t = 0.3 },
    { x = 11, y = 2, t = 0.3 },
    { x = 0,  y = 3, t = 0.3 }
  },
  pos_extra = { x = 1, y = 3 },
  phanta_anim_extra = {
    { x = 1, y = 3, t = 0.2 }, { x = 2, y = 3, t = 0.1 }, -- LETTERS
    { x = 3, y = 3, t = 0.1 },

    { x = 4, y = 3, t = 0.3 }, -- REST
    { x = 3, y = 3, t = 0.1 },

    { x = 1, y = 3, t = 0.2 }, { x = 2, y = 3, t = 0.1 }, -- J
    { x = 5, y = 3, t = 0.1 },

    { x = 6, y = 3, t = 0.2 }, { x = 7, y = 3, t = 0.1 }, -- O
    { x = 8, y = 3, t = 0.1 },

    { x = 9, y = 3, t = 0.2 }, { x = 10, y = 3, t = 0.1 }, -- K
    { x = 11, y = 3, t = 0.1 },

    { x = 0,  y = 4, t = 0.2 }, { x = 1, y = 4, t = 0.1 }, -- E
    { x = 2, y = 4, t = 0.1 },

    { x = 3, y = 4, t = 0.2 }, { x = 4, y = 4, t = 0.1 }, -- R
    { x = 5, y = 4, t = 0.1 },

    { x = 4, y = 3, t = 4 },   -- REST

    { x = 5, y = 4, t = 0.1 }, -- ATTENTION
    { x = 3, y = 4, t = 0.05 },
    { x = 6, y = 4, t = 0.2 },
    { x = 3, y = 4, t = 0.1 },
    { x = 5, y = 4, t = 0.2 },
    { x = 3, y = 4, t = 0.1 },
    { x = 6, y = 4, t = 0.2 },
    { x = 3, y = 4, t = 0.1 },
    { x = 5, y = 4, t = 0.05 },
    { x = 4, y = 3, t = 0.4 },

    { x = 3, y = 3, t = 0.1 },
  },
  cost = 5,
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
    if context.individual and context.cardarea == "unscored" and SMODS.has_enhancement(context.other_card, "m_lucky") and not context.blueprint then
      card.ability.extra.current_mult = card.ability.extra.current_mult + card.ability.extra.added_mult
      return { message = localize("k_upgrade_ex"), colour = G.C.FILTER, card = card }
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
    local num, denom = SMODS.get_probability_vars(card, 1, card.ability.extra.odds, "heartbreak")
    return { vars = { card.ability.extra.xmult, num, denom } }
  end,
  blueprint_compat = true,
  eternal_compat = true,
  perishable_compat = true,
  calculate = function(self, card, context)
    if context.individual and context.cardarea == G.play and context.other_card:is_suit("Hearts") then
      return { xmult = card.ability.extra.xmult }
    end

    if context.destroy_card and context.cardarea == G.play and context.destroy_card:is_suit("Hearts")
        and SMODS.pseudorandom_probability(card, "heartbreak", 1, card.ability.extra.odds) then
      return { remove = true }
    end
  end
}

G.Phanta.centers["distance"] = {
  config = { extra = { chips = 250 } },
  rarity = 3,
  atlas = 'PhantaMiscAnims4',
  pos = { x = 0, y = 0 },
  phanta_anim = {
    { xrange = { first = 0, last = 4 },  y = 0, t = 0.05 },
    { x = 5,                             y = 0, t = 0.45 },
    { xrange = { first = 0, last = 4 },  y = 0, t = 0.05 },
    { xrange = { first = 6, last = 11 }, y = 0, t = 0.05 },
  },
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

G.Phanta.centers["theblackraven"] = {
  config = { extra = { no_of_cards = 2 } },
  rarity = 2,
  atlas = 'Phanta2',
  pos = { x = 3, y = 3 },
  cost = 6,
  blueprint_compat = false,
  eternal_compat = true,
  perishable_compat = true,
  loc_vars = function(self, info_queue, card)
    return {
      vars = { card.ability.extra.no_of_cards, card.ability.extra.no_of_cards == 1 and "" or localize("phanta_plural") }
    }
  end,
  add_to_deck = function(self, card, from_debuff)
    G.GAME.phanta_black_raven_cards = G.GAME.phanta_black_raven_cards or 0
    G.GAME.phanta_black_raven_cards = G.GAME.phanta_black_raven_cards + card.ability.extra.no_of_cards
    if G.STATE == G.STATES["SHOP"] then phanta_black_raven_add_to_shop(card.ability.extra.no_of_cards) end
  end,
  remove_from_deck = function(self, card, from_debuff)
    G.GAME.phanta_black_raven_cards = G.GAME.phanta_black_raven_cards - card.ability.extra.no_of_cards
  end
}

function phanta_black_raven_add_to_shop(no_of_cards)
  for i = 1, no_of_cards do
    local new_card = create_card("Tarot", G.shop_vouchers, nil, nil, nil, nil, nil, 'blackraven')
    G.shop_vouchers:emplace(new_card)
    create_shop_card_ui(new_card)
    G.shop_vouchers.config.card_limit = G.shop_vouchers.config.card_limit + 1
  end
end

local context_ref = SMODS.calculate_context
function SMODS.calculate_context(context, return_table)
  if context and context.starting_shop then phanta_black_raven_add_to_shop(G.GAME.phanta_black_raven_cards or 0) end
  return context_ref(context, return_table)
end

G.Phanta.centers["zero"] = {
  config = { extra = { sum = 9 } },
  rarity = 2,
  atlas = 'Phanta2',
  pos = { x = 9, y = 2 },
  cost = 6,
  blueprint_compat = false,
  eternal_compat = true,
  perishable_compat = true,
  loc_vars = function(self, info_queue, card)
    return { vars = { card.ability.extra.sum } }
  end,
  calculate = function(self, card, context)
    if context.discard and context.cardarea == G.jokers and #context.full_hand > 1 then
      local total = 0
      for _, v in ipairs(context.full_hand) do
        total = total + v:get_chip_bonus()
      end

      if total == 9 then return { remove = true } end
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
    local num, denom = SMODS.get_probability_vars(card, 1, card.ability.extra.odds, "zeroii")
    return { vars = { num, denom } }
  end,
  calculate = function(self, card, context)
    if context.discard and G.GAME.current_round.discards_used <= 0 and SMODS.pseudorandom_probability(card, "zeroii", 1, card.ability.extra.odds) then
      return { remove = true }
    end
  end
}

G.Phanta.centers["zeroiii"] = {
  config = { extra = { cards = 3 } },
  rarity = 2,
  atlas = 'Phanta2',
  pos = { x = 9, y = 3 },
  cost = 6,
  blueprint_compat = false,
  eternal_compat = true,
  perishable_compat = true,
  loc_vars = function(self, info_queue, card)
    return { vars = { card.ability.extra.cards } }
  end,
  calculate = function(self, card, context)
    if context.before and context.scoring_name == "Pair" and #context.full_hand == card.ability.extra.cards then
      for k, v in pairs(context.full_hand) do
        if not SMODS.in_scoring(v, context.scoring_hand) then
          v.phanta_zeroiii_marked_for_death = true
        end
      end
    end

    if context.destroy_card and context.destroy_card.phanta_zeroiii_marked_for_death then return { remove = true } end
  end
}

G.Phanta.centers["theriddler"] = {
  config = { extra = { chips = 250 } },
  rarity = 3,
  atlas = 'PhantaMiscAnims5',
  pos = { x = 8, y = 0 },
  phanta_anim = {
    { xrange = { first = 8, last = 11 }, y = 0, t = 0.1 },
    { xrange = { first = 0, last = 7 },  y = 1, t = 0.1 }
  },
  pos_extra = { x = 8, y = 1 },
  phanta_anim_extra = {
    { x = 8, y = 1, t = 1.3 }, { x = 9, y = 1, t = 0.1 },
    { x = 8, y = 1, t = 0.3 }, { x = 9, y = 1, t = 0.1 },
    { x = 8, y = 1, t = 2.1 }, { x = 9, y = 1, t = 0.1 },
    { x = 8, y = 1, t = 1.6 }, { x = 9, y = 1, t = 0.1 },
    { x = 8,  y = 1, t = 2.3 }, { x = 9, y = 1, t = 0.1 },
    { x = 8,  y = 1, t = 0.9 },

    { x = 10, y = 1, t = 0.1 },
    { x = 11, y = 1, t = 0.07 }, { xrange = { first = 0, last = 2 }, y = 2, t = 0.07 },
    { x = 11, y = 1, t = 0.07 }, { xrange = { first = 0, last = 2 }, y = 2, t = 0.07 },
    { x = 11, y = 1, t = 0.07 }, { xrange = { first = 0, last = 2 }, y = 2, t = 0.07 },
    { x = 11, y = 1, t = 0.07 }, { xrange = { first = 0, last = 1 }, y = 2, t = 0.07 },
    { x = 10, y = 1, t = 0.1 }
  },
  cost = 8,
  blueprint_compat = true,
  eternal_compat = true,
  perishable_compat = true,
  loc_vars = function(self, info_queue, card)
    return { vars = { card.ability.extra.chips } }
  end,
  calculate = function(self, card, context)
    if context.joker_main then
      return { chips = card.ability.extra.chips }
    end
  end,
  add_to_deck = function(self, card, from_debuff)
    if G.playing_cards then
      for _, v in ipairs(G.playing_cards) do
        v:become_unknown("phanta_theriddler")
      end
    end
  end,
  remove_from_deck = function(self, card, from_debuff)
    if G.playing_cards and #SMODS.find_card("j_phanta_theriddler") <= 1 then
      for _, v in ipairs(G.playing_cards) do
        v:release_unknown("phanta_theriddler")
      end
    end
  end
}

local add_to_deck_ref = Card.add_to_deck
function Card:add_to_deck(card, from_debuff)
  local ref_return = add_to_deck_ref(self, card, from_debuff)
  if next(SMODS.find_card("j_phanta_theriddler")) and self.config and self.config.center and (self.config.center.set == "Default" or self.config.center.set == "Enhanced") then
    self:become_unknown("phanta_theriddler")
  end
  return ref_return
end

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
  rarity = 1,
  atlas = 'Phanta2',
  pos = { x = 11, y = 1 },
  cost = 4,
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
  atlas = 'PhantaMiscAnims4',
  pos = { x = 11, y = 3 },
  phanta_anim = {
    { x = 11,                           y = 3, t = 3 },
    { xrange = { first = 0, last = 2 }, y = 4, t = 0.05 },
    { x = 3,                            y = 4, t = 0.5 },
    { x = 4,                            y = 4, t = 0.5 },
    { x = 5,                            y = 4, t = 0.6 },
    { x = 6,                            y = 4, t = 0.7 },
    { xrange = { first = 7, last = 9 }, y = 4, t = 0.01 },
  },
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

G.Phanta.centers["glassjoe"] = {
  loc_vars = function(self, info_queue, card)
    info_queue[#info_queue + 1] = G.P_CENTERS.m_glass
    return {}
  end,
  rarity = 1,
  atlas = 'PhantaMiscAnims4',
  pos = { x = 0, y = 5 },
  phanta_anim = {
    { x = 0, y = 5, t = 0.5 },
    { x = 1, y = 5, t = 0.3 },
    { x = 2, y = 5, t = 0.2 },
    { x = 3, y = 5, t = 0.9 },
    { x = 4, y = 5, t = 0.4 },
    { x = 5, y = 5, t = 0.2 },
    { x = 6, y = 5, t = 0.8 },
    { x = 7, y = 5, t = 0.1 },
    { x = 8, y = 5, t = 0.2 },
    { x = 9, y = 5, t = 0.7 },
    { x = 0, y = 6, t = 0.3 },
    { x = 1, y = 6, t = 0.6 },
    { x = 2, y = 6, t = 0.3 },
    { x = 3, y = 6, t = 0.5 }
  },
  pos_extra = { x = 4, y = 6 },
  phanta_anim_extra = {
    { x = 4, y = 6, t = 8 / 30 },
    { x = 5, y = 6, t = 0.1 },
    { x = 6, y = 6, t = 1 / 30 },
    { x = 7, y = 6, t = 8 / 30 },
    { x = 8, y = 6, t = 0.1 },
    { x = 9, y = 6, t = 1 / 30 }
  },
  cost = 4,
  blueprint_compat = false,
  eternal_compat = true,
  perishable_compat = true,
  calculate = function(self, card, context)
    if context.individual and context.cardarea == G.play and context.other_card:is_face() and context.other_card:is_suit("Diamonds") and not SMODS.has_enhancement(context.other_card, "m_glass") then
      local _card = context.other_card
      _card:set_ability("m_glass", nil, true)
      G.E_MANAGER:add_event(Event({
        func = function()
          _card:juice_up()
          return true
        end
      }))
      return { message = localize("k_glass"), colour = G.C.FILTER }
    end
  end
}



SMODS.Sound({
  key = "dougdimmadome_0",
  path = "phanta_dougdimmadome_0.ogg",
  replace = true
})

SMODS.Sound({
  key = "dougdimmadome_1",
  path = "phanta_dougdimmadome_1.ogg",
  replace = true
})

SMODS.Sound({
  key = "dougdimmadome_2",
  path = "phanta_dougdimmadome_2.ogg",
  replace = true
})

G.Phanta.centers["dougdimmadome"] = {
  config = { extra = { added_xmult = 0.25 } },
  loc_vars = function(self, info_queue, card)
    return { vars = { card.ability.extra.added_xmult, 1 + (card.ability.extra.added_xmult * phanta_dougdimmadome_count_duplicates()) } }
  end,
  rarity = 3,
  atlas = 'Phanta2',
  pos = { x = 10, y = 3 },
  cost = 8,
  blueprint_compat = true,
  eternal_compat = true,
  perishable_compat = true,
  add_to_deck = function(self, card, from_debuff)
    if not G.PROFILES[G.SETTINGS.profile].phanta_dougdimmadomes_taken then G.PROFILES[G.SETTINGS.profile].phanta_dougdimmadomes_taken = 0 end
    if G.PROFILES[G.SETTINGS.profile].phanta_dougdimmadomes_taken < 3 then
      play_sound("phanta_dougdimmadome_" .. G.PROFILES[G.SETTINGS.profile].phanta_dougdimmadomes_taken, 1, 0.5)
      G.PROFILES[G.SETTINGS.profile].phanta_dougdimmadomes_taken =
          G.PROFILES[G.SETTINGS.profile].phanta_dougdimmadomes_taken + 1
    end
    G:save_settings()
  end,
  calculate = function(self, card, context)
    if context.joker_main then
      local xmult = 1 + (card.ability.extra.added_xmult * phanta_dougdimmadome_count_duplicates())
      if xmult > 1 then return { xmult = xmult } end
    end
  end
}

G.Phanta.centers["magiceggcup"] = {
  config = { extra = { is_first = true } },
  rarity = 1,
  atlas = 'PhantaMiscAnims4',
  pos = { x = 7, y = 10 },
  pos_extra = { x = 0, y = 11 },
  phanta_anim_states = {
    ["unknown"] = { anim = { { x = 7, y = 10, t = 1 } }, loop = false },

    ["diamonds"] = { anim = { { x = 8, y = 10, t = 1 } }, loop = false },
    ["hearts"] = { anim = { { x = 9, y = 10, t = 1 } }, loop = false },
    ["spades"] = { anim = { { x = 10, y = 10, t = 1 } }, loop = false },
    ["clubs"] = { anim = { { x = 11, y = 10, t = 1 } }, loop = false },

    ["inks"] = { anim = { { x = 8, y = 11, t = 1 } }, loop = false },
    ["colors"] = { anim = { { x = 9, y = 11, t = 1 } }, loop = false },

    ["clovers"] = { anim = { { x = 10, y = 11, t = 1 } }, loop = false },
    ["suitless"] = { anim = { { x = 11, y = 11, t = 1 } }, loop = false },

    ["3s"] = { anim = { { x = 0, y = 12, t = 1 } }, loop = false },

    ["notes"] = { anim = { { x = 1, y = 12, t = 1 } }, loop = false },

    ["stars1"] = { anim = { { x = 2, y = 12, t = 1 } }, loop = false },
    ["moons"] = { anim = { { x = 3, y = 12, t = 1 } }, loop = false },

    ["fleurons"] = { anim = { { x = 4, y = 12, t = 1 } }, loop = false },
    ["halberds"] = { anim = { { x = 5, y = 12, t = 1 } }, loop = false },

    ["goblets"] = { anim = { { x = 6, y = 12, t = 1 } }, loop = false },
    ["towers"] = { anim = { { x = 7, y = 12, t = 1 } }, loop = false },
    ["blooms"] = { anim = { { x = 8, y = 12, t = 1 } }, loop = false },
    ["daggers"] = { anim = { { x = 9, y = 12, t = 1 } }, loop = false },
    ["voids"] = { anim = { { x = 10, y = 12, t = 1 } }, loop = false },
    ["lanterns"] = { anim = { { x = 11, y = 12, t = 1 } }, loop = false },

    ["crowns"] = { anim = { { x = 0, y = 13, t = 1 } }, loop = false },
    ["stars2"] = { anim = { { x = 1, y = 13, t = 1 } }, loop = false },

    ["thunders"] = { anim = { { x = 2, y = 13, t = 1 } }, loop = false },
    ["waters"] = { anim = { { x = 3, y = 13, t = 1 } }, loop = false },

    ["eyes"] = { anim = { { x = 4, y = 13, t = 1 } }, loop = false }
  },
  phanta_anim_extra_states = {
    ["lifting first"] = {
      anim = {
        { xrange = { first = 0, last = 7 }, y = 11, t = 0.05 },
        { xrange = { first = 7, last = 2 }, y = 11, t = 0.06 },
      },
      loop = false
    },
    ["lifting middle"] = {
      anim = {
        { xrange = { first = 2, last = 7 }, y = 11, t = 0.05 },
        { xrange = { first = 7, last = 2 }, y = 11, t = 0.06 },
      },
      loop = false
    },
    ["lifting end"] = {
      anim = {
        { xrange = { first = 2, last = 0 }, y = 11, t = 0.1 }
      },
      loop = false
    },
    ["resting"] = { anim = { { x = 0, y = 11, t = 1 } }, loop = false }
  },
  phanta_anim_current_state = "unknown",
  phanta_anim_extra_current_state = "resting",
  cost = 4,
  blueprint_compat = false,
  eternal_compat = true,
  perishable_compat = true,
  calculate = function(self, card, context)
    if context.individual and context.cardarea == "unscored" then
      local _card = context.other_card
      local selectable_suits = {}
      for k, v in pairs(SMODS.Suits) do
        if k ~= _card.base.suit then
          selectable_suits[k] = v
        end
      end
      selectable_suits[_card.base.suit] = nil
      local chosen_suit = (pseudorandom_element(selectable_suits, pseudoseed('magiceggcup')) or { key = "Spades" }).key

      local supported_suits = {
        ["Diamonds"] = "diamonds",
        ["Hearts"] = "hearts",
        ["Spades"] = "spades",
        ["Clubs"] = "clubs",

        ["ink_Inks"] = "inks",
        ["ink_Colors"] = "colors",

        ["mtg_Clovers"] = "clovers",
        ["mtg_Suitless"] = "suitless",

        ["minty_3s"] = "3s",

        ["Notes"] = "notes",

        ["six_Stars"] = "stars1",
        ["six_Moons"] = "moons",

        ["bunc_Fleurons"] = "fleurons",
        ["bunc_Halberds"] = "halberds",

        ["rgmc_goblets"] = "goblets",
        ["rgmc_towers"] = "towers",
        ["rgmc_blooms"] = "blooms",
        ["rgmc_daggers"] = "daggers",
        ["rgmc_voids"] = "voids",
        ["rgmc_lanterns"] = "lanterns",

        ["paperback_Crowns"] = "crowns",
        ["paperback_Stars"] = "stars2",

        ["rcb_thunders"] = "thunders",
        ["rcb_waters"] = "waters",

        ["gb_Eyes"] = "eyes"
      }
      local displayed_suit = supported_suits[chosen_suit] or "unknown"

      G.E_MANAGER:add_event(Event({
        func = function()
          play_sound('tarot1')
          card:juice_up()
          card:phanta_set_anim_state(displayed_suit)
          card:phanta_set_anim_extra_state(card.ability.extra.is_first and "lifting first" or "lifting middle")
          card.ability.extra.is_first = false
          return true
        end
      }))
      G.E_MANAGER:add_event(Event({
        trigger = 'after',
        delay = 0.15,
        func = function()
          _card:flip()
          play_sound('card1', 1)
          _card:juice_up(0.3, 0.3)
          delay(0.2)
          return true
        end
      }))
      G.E_MANAGER:add_event(Event({
        trigger = 'after',
        delay = 0.1,
        func = function()
          _card:change_suit(chosen_suit)
          return true
        end
      }))
      G.E_MANAGER:add_event(Event({
        delay = 0.1,
        func = function()
          _card:flip()
          play_sound('tarot2', 1)
          _card:juice_up(0.3, 0.3)
          return true
        end
      }))
      delay(0.2)
      return { message = localize(chosen_suit, "suits_plural"), colour = G.C.SUITS[chosen_suit] }
    end

    if context.after and not card.ability.extra.is_first then
      G.E_MANAGER:add_event(Event({
        func = function()
          card.ability.extra.is_first = true
          card:phanta_set_anim_state("unknown")
          card:phanta_set_anim_extra_state("lifting end")
          return true
        end
      }))
    end
  end
}

G.Phanta.centers["doublelift"] = {
  config = { extra = { cards_to_draw = 2 } },
  loc_vars = function(self, info_queue, card)
    return {
      vars = { card.ability.extra.cards_to_draw },
    }
  end,
  rarity = 1,
  atlas = 'Phanta2',
  pos = { x = 5, y = 3 },
  cost = 4,
  blueprint_compat = false,
  eternal_compat = true,
  perishable_compat = true,
  calculate = function(self, card, context)
    if context.pre_discard then
      card.ability.extra.primed = true
    end

    if context.drawing_cards and card.ability.extra.primed then
      card.ability.extra.primed = nil
      if G.hand.config.card_limit - #G.hand.cards <= card.ability.extra.cards_to_draw then
        return { cards_to_draw = card.ability.extra.cards_to_draw }
      end
    end
  end
}

G.Phanta.centers["modping"] = {
  config = { extra = { money_needed = 5, money_increase = 10 } },
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

G.FUNCS.phanta_can_modping_use = function(e)
  local card = e.config.ref_table

  if G.GAME.dollars - card.ability.extra.money_needed < to_big(G.GAME.bankrupt_at) or not is_boss_active() then
    e.config.colour = G.C.UI.BACKGROUND_INACTIVE
    e.config.button = nil
  end
end

G.FUNCS.phanta_modping_use = function(e)
  local card = e.config.ref_table

  G.E_MANAGER:add_event(Event({
    func = function()
      if is_boss_active() then
        ease_dollars(-card.ability.extra.money_needed)
        card.ability.extra.money_needed = card.ability.extra.money_needed + card.ability.extra.money_increase
        play_sound("timpani")
        card:juice_up()
        G.GAME.blind:disable()
      end
      return true
    end
  }))
end



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
  config = { extra = { added_xmult = 0.25, current_xmult = 1 } },
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

G.Phanta.centers["leprechaun"] = {
  config = { extra = { mult = 17 } },
  loc_vars = function(self, info_queue, card)
    return { vars = { card.ability.extra.mult } }
  end,
  rarity = 1,
  atlas = 'Phanta2',
  pos = { x = 8, y = 3 },
  cost = 6,
  blueprint_compat = true,
  eternal_compat = true,
  perishable_compat = true,
  calculate = function(self, card, context)
    if context.joker_main and G.hand.cards[#G.hand.cards]:get_id() == 7 then
      return { mult = card.ability.extra.mult }
    end
  end
}

G.Phanta.centers["shamrock"] = {
  loc_vars = function(self, info_queue, card)
    info_queue[#info_queue + 1] = G.P_CENTERS.m_lucky
    return {}
  end,
  rarity = 2,
  atlas = 'Phanta2',
  pos = { x = 7, y = 3 },
  cost = 6,
  blueprint_compat = false,
  eternal_compat = true,
  perishable_compat = true,
  calculate = function(self, card, context)
    if context.individual and context.cardarea == G.play and SMODS.has_enhancement(context.other_card, "m_lucky")
        and not (context.other_card:is_suit("Clubs") and context.other_card:get_id() == 7) then
      local _card = context.other_card
      G.E_MANAGER:add_event(Event({
        func = function()
          assert(SMODS.change_base(_card, "Clubs", "7"))
          _card:juice_up()
          return true
        end
      }))
      return { message = "7 of Clubs", colour = G.C.SUITS.Clubs }
    end
  end
}

G.Phanta.centers["metalhead"] = {
  loc_vars = function(self, info_queue, card)
    info_queue[#info_queue + 1] = G.P_CENTERS.m_steel
    return {}
  end,
  rarity = 2,
  atlas = 'Phanta2',
  pos = { x = 4, y = 3 },
  cost = 6,
  blueprint_compat = false,
  eternal_compat = true,
  perishable_compat = true,
  calculate = function(self, card, context)
    if context.first_hand_drawn then
      local eval = function() return G.GAME.current_round.hands_played == 0 end
      juice_card_until(card, eval, true)
    end

    if context.before and G.GAME.current_round.hands_played == 0 then
      if #context.full_hand == 1 then
        G.E_MANAGER:add_event(Event({
          func = function()
            context.full_hand[1]:set_ability("m_steel")
            context.full_hand[1]:juice_up()
            return true
          end
        }))
        return { message = localize { key = "m_steel", type = "name_text", set = "Enhanced" }, colour = G.C.FILTER }
      end
    end
  end
}

G.Phanta.centers["plugsocket"] = {
  config = { extra = { xmult = 0.25 } },
  loc_vars = function(self, info_queue, card)
    info_queue[#info_queue + 1] = G.P_CENTERS.m_phanta_coppergratefresh
    return { vars = { card.ability.extra.xmult, 1 + (#count_base_copper_grates() * card.ability.extra.xmult) } }
  end,
  rarity = 2,
  atlas = 'PhantaMiscAnims4',
  pos = { x = 0, y = 1 },
  phanta_anim = {
    { x = 0, y = 1, t = 4 },
    { x = 1, y = 1, t = 0.05 },
    { x = 2, y = 1, t = 0.5 },
    { x = 3, y = 1, t = 0.05 },
    { x = 4, y = 1, t = 2 },
    { x = 5, y = 1, t = 0.05 },
    { x = 6, y = 1, t = 0.5 },
    { x = 7, y = 1, t = 0.05 },
  },
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

G.Phanta.centers["mrbigmoneybags"] = {
  rarity = 1,
  atlas = 'Phanta2',
  pos = { x = 11, y = 2 },
  cost = 5,
  blueprint_compat = false,
  eternal_compat = true,
  perishable_compat = true
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

G.Phanta.centers["crystaljoker"] = {
  loc_vars = function(self, info_queue, card)
    info_queue[#info_queue + 1] = G.P_CENTERS.m_glass
    return {}
  end,
  rarity = 3,
  atlas = 'Phanta2',
  pos = { x = 0, y = 2 },
  draw = function(self, card, layer)
    if self.discovered or card.params.bypass_discovery_center then
      card.children.center:draw_shader('booster', nil, card.ARGS.send_to_shader)
    end
  end,
  cost = 8,
  blueprint_compat = true,
  eternal_compat = true,
  perishable_compat = true,
  calculate = function(self, card, context)
    if context.individual and not context.end_of_round and context.cardarea == G.hand and SMODS.has_enhancement(context.other_card, "m_glass") then
      return { xmult = context.other_card.ability.Xmult }
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

G.FUNCS.run_profile_menu = function(e)
  G.SETTINGS.paused = true
  G.FUNCS.overlay_menu {
    definition = create_profile_more_menu()
  }
end

G.FUNCS.phanta_can_profile_more = function(e)

end

function create_profile_more_menu()
  local charm = UIBox_button({ button = 'phanta_purchase_charm_tag', func = 'phanta_can_purchase_charm_tag', label = { localize({ type = 'name_text', set = 'Tag', key = 'tag_charm' }) }, minw = 5, focus_args = { snap_to = true } })
  local meteor = UIBox_button({ button = 'phanta_purchase_meteor_tag', func = 'phanta_can_purchase_meteor_tag', label = { localize({ type = 'name_text', set = 'Tag', key = 'tag_meteor' }) }, minw = 5, focus_args = { snap_to = true } })
  local ethereal = UIBox_button({ button = 'phanta_purchase_ethereal_tag', func = 'phanta_can_purchase_ethereal_tag', label = { localize({ type = 'name_text', set = 'Tag', key = 'tag_ethereal' }) }, minw = 5, focus_args = { snap_to = true } })

  local t = create_UIBox_generic_options({
    infotip = localize("phanta_profile_more_tooltip"),
    contents = {
      charm,
      meteor,
      ethereal
    }
  })
  return t
end

G.FUNCS.phanta_purchase_charm_tag = function(e)
  G.E_MANAGER:add_event(Event({
    func = (function()
      add_tag(Tag('tag_charm'))
      play_sound('generic1', 0.9 + math.random() * 0.1, 0.8)
      play_sound('holo1', 1.2 + math.random() * 0.1, 0.4)
      return true
    end)
  }))

  ease_dollars(-16)

  if G.OVERLAY_MENU then G.FUNCS.exit_overlay_menu() end
  G.SETTINGS.paused = true
  G.FUNCS.overlay_menu {
    definition = create_profile_more_menu()
  }
end

G.FUNCS.phanta_purchase_meteor_tag = function(e)
  G.E_MANAGER:add_event(Event({
    func = (function()
      add_tag(Tag('tag_meteor'))
      play_sound('generic1', 0.9 + math.random() * 0.1, 0.8)
      play_sound('holo1', 1.2 + math.random() * 0.1, 0.4)
      return true
    end)
  }))

  ease_dollars(-16)

  if G.OVERLAY_MENU then G.FUNCS.exit_overlay_menu() end
  G.SETTINGS.paused = true
  G.FUNCS.overlay_menu {
    definition = create_profile_more_menu()
  }
end

G.FUNCS.phanta_purchase_ethereal_tag = function(e)
  G.E_MANAGER:add_event(Event({
    func = (function()
      add_tag(Tag('tag_ethereal'))
      play_sound('generic1', 0.9 + math.random() * 0.1, 0.8)
      play_sound('holo1', 1.2 + math.random() * 0.1, 0.4)
      return true
    end)
  }))

  ease_dollars(-16)

  if G.OVERLAY_MENU then G.FUNCS.exit_overlay_menu() end
  G.SETTINGS.paused = true
  G.FUNCS.overlay_menu {
    definition = create_profile_more_menu()
  }
end

G.FUNCS.phanta_can_purchase_charm_tag = function(e)
  if G.GAME.dollars - 16 < to_big(G.GAME.bankrupt_at) then
    e.config.colour = G.C.UI.BACKGROUND_INACTIVE
    e.config.button = nil
  end
end

G.FUNCS.phanta_can_purchase_meteor_tag = function(e)
  if G.GAME.dollars - 16 < to_big(G.GAME.bankrupt_at) then
    e.config.colour = G.C.UI.BACKGROUND_INACTIVE
    e.config.button = nil
  end
end

G.FUNCS.phanta_can_purchase_ethereal_tag = function(e)
  if G.GAME.dollars - 16 < to_big(G.GAME.bankrupt_at) then
    e.config.colour = G.C.UI.BACKGROUND_INACTIVE
    e.config.button = nil
  end
end

G.Phanta.centers["deathnote"] = {
  loc_vars = function(self, info_queue, card)
    info_queue[#info_queue + 1] = G.P_CENTERS.e_negative
    local name = card.ability and card.ability.extra and card.ability.extra.card_name and
        card.ability.extra.card_name ~= "" and card.ability.extra.card_name
    return { vars = { name and localize("phanta_deathnote_name_present") or localize("phanta_deathnote_no_name"), name and name or "" } }
  end,
  rarity = 3,
  atlas = 'Phanta2',
  pos = { x = 0, y = 3 },
  cost = 4,
  blueprint_compat = false,
  eternal_compat = true,
  perishable_compat = true
}

G.FUNCS.run_deathnote_menu = function(e)
  G.SETTINGS.paused = true
  e.config.ref_table.ability = e.config.ref_table.ability or {}
  e.config.ref_table.ability.extra = e.config.ref_table.ability.extra or {}
  G.GAME.phanta_deathnote_name = e.config.ref_table.ability.extra.card_name or ""
  G.FUNCS.overlay_menu {
    definition = create_deathnote_more_menu(e)
  }
end

G.FUNCS.phanta_can_deathnote_more = function(e)

end

function create_deathnote_more_menu(e)
  local t = create_UIBox_generic_options({
    infotip = localize("phanta_deathnote_more_tooltip"),
    contents = {
      {
        n = G.UIT.R,
        nodes = {
          create_text_input({
            w = 5,
            h = 1,
            max_length = 100,
            extended_corpus = true,
            prompt_text = localize("phanta_deathnote_more_text"),
            ref_table = G.GAME,
            ref_value = "phanta_deathnote_name",
            keyboard_offset = 1
          })
        }
      },
      {
        n = G.UIT.R,
        config = { align = "cm" },
        nodes = {
          UIBox_button({
            ref_table = e.config.ref_table,
            button = "phanta_set_deathnote_card",
            func = "phanta_can_set_deathnote_card",
            label = { localize("phanta_set") },
            minw = 2,
            focus_args = { snap_to = true }
          })
        }
      }
    },
  })
  return t
end

G.FUNCS.phanta_set_deathnote_card = function(e)
  if not phanta_deathnote_is_existing_card() then
    if G.GAME.phanta_deathnote_name:lower() == G.PROFILES[G.SETTINGS.profile].name:lower() then
      G.STATE = G.STATES.GAME_OVER
      if not G.GAME.won and not G.GAME.seeded and not G.GAME.challenge then
        G.PROFILES[G.SETTINGS.profile].high_scores.current_streak.amt = 0
      end
      G:save_settings()
      G.FILE_HANDLER.force = true
      G.STATE_COMPLETE = false
      G.SETTINGS.paused = false
      return
    end
    if G.GAME.phanta_deathnote_name:lower() == "balatro" then
      G:save_settings()
      G:save_progress()
      love.event.quit(0)
      return
    end
  end

  e.config.ref_table.ability.extra.card_name = G.GAME.phanta_deathnote_name

  if G.OVERLAY_MENU then G.FUNCS.exit_overlay_menu() end
  G.SETTINGS.paused = true
  G.FUNCS.overlay_menu {
    definition = create_deathnote_more_menu(e)
  }
end

G.FUNCS.phanta_can_set_deathnote_card = function(e)
  if G.GAME.phanta_deathnote_name:lower() == G.PROFILES[G.SETTINGS.profile].name:lower()
      or G.GAME.phanta_deathnote_name:lower() == "balatro" then
    e.config.colour = G.C.RED
    e.config.button = "phanta_set_deathnote_card"
    return
  end

  if not phanta_deathnote_is_existing_card() then
    e.config.colour = G.C.UI.BACKGROUND_INACTIVE
    e.config.button = nil
  else
    e.config.colour = G.C.RED
    e.config.button = "phanta_set_deathnote_card"
  end
end

function phanta_deathnote_is_existing_card()
  local banned = { "Voucher", "Back", "Enhanced", "Edition", "Booster" }
  local valid = false
  for k, v in pairs(G.P_CENTERS) do
    if localize { key = k, type = "name_text", set = v.set }:lower() == G.GAME.phanta_deathnote_name:lower() then
      local is_banned = false
      for i, banned_key in ipairs(banned) do
        if v.set == banned_key then is_banned = true end
      end
      if not is_banned then
        valid = true
        break
      end
    end
  end
  return valid
end

local create_card_ref = create_card
function create_card(_type, area, legendary, _rarity, skip_materialize, soulable, forced_key, key_append)
  local card = create_card_ref(_type, area, legendary, _rarity, skip_materialize, soulable, forced_key, key_append)
  local notes = SMODS.find_card("j_phanta_deathnote")
  if next(notes) then
    for i, v in ipairs(notes) do
      if v and v.ability and v.ability.extra and v.ability.extra.card_name
          and localize { key = card.config.center.key, type = "name_text", set = card.config.center.set }:lower() == v.ability.extra.card_name:lower() then
        card:set_edition("e_negative")
      end
    end
  end
  return card
end

local smods_create_card_ref = SMODS.create_card
function SMODS:create_card(t)
  local card = smods_create_card_ref(self, t)
  local notes = SMODS.find_card("j_phanta_deathnote")
  if next(notes) then
    for i, v in ipairs(notes) do
      if v and v.ability and v.ability.extra and v.ability.extra.card_name
          and localize { key = card.config.center.key, type = "name_text", set = card.config.center.set }:lower() == v.ability.extra.card_name:lower() then
        card:set_edition("e_negative")
      end
    end
  end
  return card
end
