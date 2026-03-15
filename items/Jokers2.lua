G.Phanta.centers["normalface"] = {
  config = { extra = { mult = 10, amazing_grace = false } },
  loc_vars = function(self, info_queue, card)
    return { vars = { card.ability.extra.mult } }
  end,
  rarity = 1,
  atlas = 'PhantaMiscAnims6',
  pos = { x = 4, y = 10 },
  flipbook_anim_states = {
    normal = {
      anim = {
        { x = 4, y = 10, t = 1.4 },

        { x = 5, y = 10, t = 0.05 }, { x = 6, y = 10, t = 0.2 },
        { x = 5, y = 10, t = 0.05 }, { x = 4, y = 10, t = 0.05 },
        { x = 7, y = 10, t = 0.05 }, { x = 8, y = 10, t = 0.2 },
        { x = 7, y = 10, t = 0.05 }, { x = 4, y = 10, t = 0.05 },

        { x = 5, y = 10, t = 0.05 }, { x = 6, y = 10, t = 0.2 },
        { x = 5, y = 10, t = 0.05 }, { x = 4, y = 10, t = 0.05 },
        { x = 7, y = 10, t = 0.05 }, { x = 8, y = 10, t = 0.2 },
        { x = 7, y = 10, t = 0.05 }, { x = 4, y = 10, t = 0.05 },

        { x = 5, y = 10, t = 0.05 }, { x = 6, y = 10, t = 0.2 },
        { x = 5, y = 10, t = 0.05 }, { x = 4, y = 10, t = 0.05 },
        { x = 7, y = 10, t = 0.05 }, { x = 8, y = 10, t = 0.2 },
        { x = 7, y = 10, t = 0.05 }, { x = 4, y = 10, t = 0.05 },

        { x = 5, y = 10, t = 0.05 }, { x = 6, y = 10, t = 0.2 },
        { x = 5, y = 10, t = 0.05 }, { x = 4, y = 10, t = 0.05 },
        { x = 7, y = 10, t = 0.05 }, { x = 8, y = 10, t = 0.2 },
        { x = 7, y = 10, t = 0.05 }, { x = 4, y = 10, t = 0.05 },

        { x = 9, y = 10, t = 0.05 }, { x = 10, y = 10, t = 1 },

        { x = 11, y = 10, t = 0.05 }, { x = 0, y = 11, t = 0.2 },
        { x = 1,  y = 11, t = 0.05 }, { x = 2, y = 11, t = 0.05 },
      }
    },
    angry = { anim = { { xrange = { first = 3, last = 11 }, y = 11, t = 0.05 } } }
  },
  flipbook_anim_initial_state = "normal",
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
          if not card.ability.extra.amazing_grace then
            play_sound("phanta_lobotomy_" .. sound, pitch, 1)
            card_eval_status_text(card, 'extra', nil, nil, nil, { message = ":)", colour = G.C.GREEN })
          end
          return true
        end
      }))
    end

    if context.selling_self or (context.joker_type_destroyed and context.joker_type_destroyed == card) and not context.blueprint then
      card.ability.extra.amazing_grace = true
      card:flipbook_set_anim_state("angry")
      play_sound("phanta_lobotomy_die", 1, 0.5)
      card_eval_status_text(card, 'extra', nil, nil, nil, { message = ">:(", colour = G.C.RED })
      delay(4.5)
    end
  end,
  pronouns = "any_all"
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
  flipbook_anim = {
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
    if context.joker_main and card.ability.extra.chosen_ability.hands_played and G.GAME.current_round.hands_played == card.ability.extra.chosen_ability.hands_played - 1 and not context.blueprint then
      local bonus = { mult = card.ability.extra.mult }
      bonus.chips = card.ability.extra.chosen_ability.chips
      bonus.mult = bonus.mult + (card.ability.extra.chosen_ability.mult or 0)
      bonus.xmult = card.ability.extra.chosen_ability.xmult
      bonus.dollars = card.ability.extra.chosen_ability.money
      return bonus
    elseif context.joker_main then
      return { mult = card.ability.extra.mult }
    end

    if not context.blueprint then
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

      if context.setting_blind and not card.getting_sliced and count_consumables() < G.consumeables.config.card_limit
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
            card_eval_status_text(card, 'extra', nil, nil, nil,
              { message = localize(loc), colour = colour })
            return true
          end)
        }))
      end
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
  end,
  pronouns = "any_all"
}

G.Phanta.centers["topsyturvy"] = {
  config = { extra = { three_given_chips = 20, two_given_chips = 40 } },
  loc_vars = function(self, info_queue, card)
    return { vars = { card.ability.extra.three_given_chips, card.ability.extra.two_given_chips } }
  end,
  rarity = 1,
  atlas = 'Phanta2',
  pos = { x = 7, y = 6 },
  cost = 4,
  blueprint_compat = true,
  eternal_compat = true,
  perishable_compat = true,

  calculate = function(self, card, context)
    if context.individual and context.cardarea == G.play and context.other_card:get_id() == 3 then
      return { chips = card.ability.extra.three_given_chips }
    end
    if context.individual and context.cardarea == G.play and context.other_card:get_id() == 2 then
      return { chips = card.ability.extra.two_given_chips }
    end
  end,
  pronouns = "she_her",
  phanta_yield_to_cbean = true
}






G.Phanta.centers["stachenscarfen"] = {
  rarity = 3,
  atlas = "PhantaLaytonAnims",
  pos = { x = 0, y = 8 },
  cost = 9,
  blueprint_compat = false,
  eternal_compat = true,
  perishable_compat = true,
  pronouns = "he_him",
  phanta_yield_to_cbean = true
}

local create_card_ref = create_card
function create_card(_type, area, legendary, _rarity, skip_materialize, soulable, forced_key, key_append)
  local staches = SMODS.find_card("j_phanta_stachenscarfen")
  if next(staches) and not (forced_key and G.P_CENTERS[forced_key] and G.P_CENTERS[forced_key].rarity == 2) then
    legendary = nil
    _rarity = 0.71
    forced_key = nil
  end
  return create_card_ref(_type, area, legendary, _rarity, skip_materialize, soulable, forced_key, key_append)
end

local smods_create_card_ref = SMODS.create_card
function SMODS:create_card(t)
  local staches = SMODS.find_card("j_phanta_stachenscarfen")
  if next(staches)
      and not (t and t.forced_key and G.P_CENTERS[t.forced_key] and G.P_CENTERS[t.forced_key].rarity == 2)
  then
    if not t then
      t = {}
    end
    t.legendary = nil
    t.rarity = 0.71
    t.forced_key = nil
  end
  return smods_create_card_ref(self, t)
end

G.Phanta.centers["aldus"] = {
  rarity = 3,
  atlas = "PhantaLaytonAnims",
  pos = { x = 0, y = 9 },
  cost = 9,
  blueprint_compat = false,
  eternal_compat = true,
  perishable_compat = true,
  pronouns = "he_him",
  phanta_yield_to_cbean = true
}

local main_menu_ref = Game.main_menu
Game.main_menu = function(change_context)
  local ret = main_menu_ref(change_context)

  for k, v in pairs(G.P_CENTERS) do
    if
        v.set == "Tarot"
        and v.config
        and ((v.config.mod_conv and v.config.mod_conv ~= "card") or v.config.phanta_banned_by_aldus)
        and not v.config.phanta_whitelisted_by_aldus
    then
      v.in_pool = v.in_pool or function()
        return true
      end

      local in_pool_ref = v.in_pool
      v.in_pool = function()
        return in_pool_ref() and not next(SMODS.find_card("j_phanta_aldus"))
      end
    end
  end

  return ret
end

G.Phanta.centers["alecwatson"] = {
  loc_vars = function(self, info_queue, card)
    local main_end = {}
    if G.consumeables and G.consumeables.cards then
      for _, consumable in ipairs(G.consumeables.cards) do
        if consumable.edition and consumable.edition.negative then
          localize { type = "other", key = "remove_negative", nodes = main_end, vars = {} }
          break
        end
      end
    end
    return { main_end = main_end[1] }
  end,
  rarity = 2,
  atlas = "PhantaMiscAnims7",
  pos = { x = 0, y = 0 },
  flipbook_anim = {
    { xrange = { first = 0, last = 2 }, y = 0, t = 0.1 },
    { x = 1,                            y = 0, t = 0.1 }
  },
  cost = 7,
  blueprint_compat = true,
  eternal_compat = true,
  perishable_compat = true,
  hpot_unbreedable = true,

  calculate = function(self, card, context)
    if context.buying_card and context.card.ability.consumeable
        and (context.card.config.center.set == "Tarot" or context.card.config.center.set == "Planet")
        and count_consumables() < G.consumeables.config.card_limit then
      G.GAME.consumeable_buffer = G.GAME.consumeable_buffer + 1
      local _card = context.card
      return {
        extra = {
          focus = card,
          message = localize("k_copied_ex"),
          func = function()
            G.E_MANAGER:add_event(Event({
              trigger = "before",
              delay = 0.0,
              func = function()
                play_sound("timpani")
                local new_card = SMODS.create_card({
                  set = _card.config.center.set,
                  area = G.consumeables,
                  key = _card.config.center.key,
                })
                new_card:add_to_deck()
                G.consumeables:emplace(new_card)
                G.GAME.consumeable_buffer = 0
                new_card:juice_up(0.3, 0.5)
                return true
              end,
            }))
          end,
          colour = G.C.SECONDARY_SET.Tarot,
          card = card
        }
      }
    end
  end,
  pronouns = "he_him",
  phanta_yield_to_cbean = true
}

G.Phanta.centers["giveway"] = {
  config = { extra = { xmult = 2 } },
  loc_vars = function(self, info_queue, card)
    return { vars = { card.ability.extra.xmult } }
  end,
  rarity = 1,
  atlas = "Phanta2",
  pos = { x = 11, y = 6 },
  flipbook_pos_extra = { x = 0, y = 7 },
  flipbook_draw_extra = function(self, card, layer)
    if self.discovered or card.params.bypass_discovery_center then
      card.flipbook_extra["extra"]:draw_shader("booster", nil, card.ARGS.send_to_shader, nil, card.children.center)
    end
  end,
  cost = 5,
  blueprint_compat = true,
  eternal_compat = true,
  perishable_compat = true,

  calculate = function(self, card, context)
    if context.initial_scoring_step then
      return { xmult = card.ability.extra.xmult }
    end
  end,
  pronouns = "it_its",
  phanta_yield_to_cbean = true
}

G.Phanta.centers["ghostimage"] = {
  config = { extra = { levels = 1 } },
  rarity = 1,
  atlas = "Phanta2",
  pos = { x = 1, y = 7 },
  flipbook_pos_extra = { x = 2, y = 7 },
  flipbook_draw_extra = function(self, card, layer)
    if self.discovered or card.params.bypass_discovery_center then
      card.flipbook_extra["extra"]:draw_shader("negative_shine", nil, card.ARGS.send_to_shader, nil, card.children.center)
    end
  end,
  cost = 6,
  loc_vars = function(self, info_queue, card)
    return { vars = { card.ability.extra.levels } }
  end,
  blueprint_compat = true,
  eternal_compat = true,
  perishable_compat = true,

  calculate = function(self, card, context)
    if context.using_consumeable and context.consumeable.config.center.set == "Planet" then
      local valid_hands = {}
      for k, v in pairs(G.GAME.hands) do
        if SMODS.is_poker_hand_visible(k) then
          valid_hands[#valid_hands + 1] = k
        end
      end
      local chosen_hand = pseudorandom_element(valid_hands, pseudoseed("ghostimage"))

      G.E_MANAGER:add_event(Event({
        func = function()
          SMODS.smart_level_up_hand(card, chosen_hand, nil, card.ability.extra.levels)
          return true
        end,
      }))
      return { message = localize("k_level_up_ex"), colour = G.C.FILTER }
    end
  end,
  pronouns = "they_them",
  phanta_yield_to_cbean = true
}

G.Phanta.centers["tipoftheiceberg"] = {
  config = { extra = { counted_rerolls = 0, added_chips = 10, current_chips = 0 } },
  loc_vars = function(self, info_queue, card)
    return { vars = { card.ability.extra.added_chips, card.ability.extra.current_chips } }
  end,
  rarity = 2,
  atlas = "PhantaMiscAnims7",
  pos = { x = 3, y = 0 },
  flipbook_anim = {
    { xrange = { first = 3, last = 5 }, y = 0, t = 0.3 },
  },
  cost = 6,
  blueprint_compat = true,
  eternal_compat = true,
  perishable_compat = false,

  calculate = function(self, card, context)
    if context.joker_main and card.ability.extra.current_chips > 0 then
      return { chips = card.ability.extra.current_chips }
    end

    if context.reroll_shop and not context.blueprint then
      card.ability.extra.counted_rerolls = card.ability.extra.counted_rerolls + 1
    end
    if context.ending_shop and not context.blueprint then
      card.ability.extra.counted_rerolls = 0
    end

    if context.buying_card and context.card ~= card and context.card.config.center.set ~= "Voucher" and not context.blueprint and card.ability.extra.counted_rerolls == 0 then
      card.ability.extra.current_chips = card.ability.extra.current_chips + card.ability.extra.added_chips
      return { message = localize("k_upgrade_ex"), colour = G.C.FILTER }
    end
  end,
  pronouns = "it_its",
  phanta_yield_to_cbean = true
}

G.Phanta.centers["sailthestyx"] = {
  config = { extra = { joker_slots = 2, target_sold = 13, current_sold = 0, slots_given = false } },
  loc_vars = function(self, info_queue, card)
    return {
      vars = {
        card.ability.extra.joker_slots,
        card.ability.extra.target_sold,
        card.ability.extra.target_sold - card.ability.extra.current_sold,
        card.ability.extra.slots_given and localize("phanta_active") or localize("phanta_inactive"),
      },
    }
  end,
  rarity = 3,
  atlas = "Phanta2",
  pos = { x = 4, y = 7 },
  cost = 10,
  blueprint_compat = false,
  eternal_compat = true,
  perishable_compat = false,

  calculate = function(self, card, context)
    if context.selling_card and context.card.config.center.set == "Joker" and context.card ~= card and not card.ability.extra.slots_given and not context.blueprint then
      card.ability.extra.current_sold = card.ability.extra.current_sold + 1

      if card.ability.extra.current_sold >= card.ability.extra.target_sold then
        card.ability.extra.slots_given = true
        G.jokers.config.card_limit = G.jokers.config.card_limit + card.ability.extra.joker_slots

        return { message = localize("k_active_ex") }
      else
        return { message = card.ability.extra.current_sold .. "/" .. card.ability.extra.target_sold }
      end
    end
  end,
  remove_from_deck = function(self, card, from_debuff)
    if card.ability.extra.slots_given then
      G.jokers.config.card_limit = G.jokers.config.card_limit - card.ability.extra.joker_slots
    end
  end,
  pronouns = "any_all",
  phanta_yield_to_cbean = true
}

G.Phanta.centers["goldenghost"] = {
  config = { extra = { current_money = 1, added_money = 1 } },
  rarity = 1,
  atlas = "Phanta2",
  pos = { x = 5, y = 7 },
  cost = 6,
  loc_vars = function(self, info_queue, card)
    return { vars = { card.ability.extra.current_money, card.ability.extra.added_money } }
  end,
  blueprint_compat = false,
  eternal_compat = true,
  perishable_compat = false,

  calculate = function(self, card, context)
    if context.before and G.GAME.current_round.hands_left <= 0 and not context.blueprint then
      card.ability.extra.current_money = card.ability.extra.current_money + card.ability.extra.added_money
      return { message = localize("k_upgrade_ex"), colour = G.C.FILTER }
    end
  end,
  calc_dollar_bonus = function(self, card)
    return card.ability.extra.current_money
  end,
  pronouns = "she_her",
  phanta_yield_to_cbean = true
}

G.Phanta.centers["liam"] = {
  config = { extra = { xmult = 3 } },
  rarity = 3,
  atlas = "Phanta2",
  pos = { x = 6, y = 7 },
  cost = 8,
  loc_vars = function(self, info_queue, card)
    return { vars = { card.ability.extra.xmult } }
  end,
  blueprint_compat = true,
  eternal_compat = true,
  perishable_compat = true,

  calculate = function(self, card, context)
    if context.joker_main then
      local me = nil
      for i = 1, #G.jokers.cards do
        if G.jokers.cards[i] == card then
          me = i
          break
        end
      end

      if me and me >= 1 and me <= #G.jokers.cards and G.jokers.cards[me + 1] and G.jokers.cards[me + 1]:is_rarity("Rare") then
        return { xmult = card.ability.extra.xmult }
      end
    end
  end,
  pronouns = "he_him",
  phanta_yield_to_cbean = true
}

G.Phanta.centers["bryce"] = {
  config = { extra = { discards = 1 } },
  rarity = 3,
  atlas = "Phanta2",
  pos = { x = 7, y = 7 },
  cost = 8,
  loc_vars = function(self, info_queue, card)
    return { vars = { card.ability.extra.discards } }
  end,
  blueprint_compat = true,
  eternal_compat = true,
  perishable_compat = true,

  calculate = function(self, card, context)
    if context.before then
      ease_discard(card.ability.extra.discards)
      return { message = localize { type = "variable", key = card.ability.extra.discards == 1 and "a_discard" or "a_discards", vars = { card.ability.extra.discards } }, colour = G.C.RED }
    end
  end,
  pronouns = "he_him",
  phanta_yield_to_cbean = true
}

G.Phanta.centers["bountyhunter"] = {
  config = { extra = { money = 10 } },
  rarity = 1,
  atlas = "Phanta2",
  pos = { x = 8, y = 7 },
  cost = 6,
  loc_vars = function(self, info_queue, card)
    return { vars = { card.ability.extra.money } }
  end,
  blueprint_compat = false,
  eternal_compat = true,
  perishable_compat = true,

  calculate = function(self, card, context)
    if context.setting_blind and not context.blueprint then
      local my_pos = nil
      for i = 1, #G.jokers.cards do
        if G.jokers.cards[i] == card then
          my_pos = i
          break
        end
      end
      if my_pos and G.jokers.cards[my_pos + 1] and not SMODS.is_eternal(G.jokers.cards[my_pos + 1], card) and not G.jokers.cards[my_pos + 1].getting_sliced then
        local sliced_card = G.jokers.cards[my_pos + 1]
        sliced_card.getting_sliced = true
        G.GAME.joker_buffer = G.GAME.joker_buffer - 1
        G.E_MANAGER:add_event(Event({
          func = function()
            G.GAME.joker_buffer = 0
            card:juice_up(0.8, 0.8)
            sliced_card:start_dissolve({ HEX("57ecab") }, nil, 1.6)
            play_sound("slice1", 0.96 + math.random() * 0.08)
            return true
          end,
        }))
        return { dollars = card.ability.extra.money }
      end
    end
  end,
  pronouns = "he_they",
  phanta_yield_to_cbean = true
}









G.Phanta.centers["ghostinabucket"] = {
  config = { extra = { odds = 4 } },
  rarity = 1,
  atlas = "Phanta2",
  pos = { x = 10, y = 7 },
  cost = 4,
  loc_vars = function(self, info_queue, card)
    local num, denom = SMODS.get_probability_vars(card, 1, card.ability.extra.odds, "ghostinabucket")
    return { vars = { num, denom } }
  end,
  blueprint_compat = true,
  eternal_compat = true,
  perishable_compat = true,

  calculate = function(self, card, context)
    if context.individual and context.cardarea == G.hand and context.other_card:get_id() == 14 and SMODS.pseudorandom_probability(card, "ghostinabucket", 1, card.ability.extra.odds)
        and count_consumables() < G.consumeables.config.card_limit then
      G.GAME.consumeable_buffer = G.GAME.consumeable_buffer + 1
      local juice_card = context.other_card
      return {
        extra = {
          message = localize('k_plus_tarot'),
          message_card = juice_card,
          func = function()
            G.E_MANAGER:add_event(Event({
              func = (function()
                juice_card:juice_up()
                SMODS.add_card {
                  set = "Tarot",
                  key_append = "ghostinabucket"
                }
                G.GAME.consumeable_buffer = 0
                return true
              end)
            }))
          end
        }
      }
    end
  end,
  pronouns = "she_her"
}

G.Phanta.centers["thescream"] = {
  loc_vars = function(self, info_queue, card)
    local main_end = {}
    if G.consumeables and G.consumeables.cards then
      for _, consumable in ipairs(G.consumeables.cards) do
        if consumable.edition and consumable.edition.negative then
          localize { type = "other", key = "remove_negative", nodes = main_end, vars = {} }
          break
        end
      end
    end
    return { main_end = main_end[1] }
  end,
  rarity = 2,
  atlas = "Phanta2",
  pos = { x = 3, y = 8 },
  cost = 7,
  blueprint_compat = true,
  eternal_compat = true,
  perishable_compat = true,

  calculate = function(self, card, context)
    if context.end_of_round and not context.individual and not context.repetition and count_consumables() > 0 and count_consumables() < G.consumeables.config.card_limit then
      G.GAME.consumeable_buffer = G.GAME.consumeable_buffer + 1
      local _card = pseudorandom_element(G.consumeables.cards, pseudoseed("thescream"))
      return {
        extra = {
          focus = card,
          message = localize("k_copied_ex"),
          func = function()
            G.E_MANAGER:add_event(Event({
              trigger = "before",
              delay = 0.0,
              func = function()
                play_sound("timpani")
                local new_card = SMODS.create_card({
                  set = _card.config.center.set,
                  area = G.consumeables,
                  key = _card.config.center.key,
                })
                new_card:add_to_deck()
                G.consumeables:emplace(new_card)
                G.GAME.consumeable_buffer = 0
                new_card:juice_up(0.3, 0.5)
                return true
              end,
            }))
          end,
        },
        colour = G.C.FILTER,
        card = card
      }
    end
  end,
  pronouns = "he_him"
}

G.Phanta.centers["deckjoker"] = {
  rarity = 1,
  atlas = "PhantaDeckJoker",
  pos = { x = 0, y = 0 },
  cost = 4,
  in_pool = function()
    return G.GAME.phanta_deck_joker_selected_deck
  end,
  pronouns = "any_all"
}

function phanta_assign_deck_joker()
  local deck_key = G.GAME.selected_back and G.GAME.selected_back.effect and G.GAME.selected_back.effect.center and
      G.GAME.selected_back.effect.center.key
  local deck = deck_key and G.phanta_all_deck_joker_decks[deck_key]
  G.GAME.phanta_deck_joker_selected_deck = deck and deck_key

  if deck then
    G.P_CENTERS["j_phanta_deckjoker"].config = deck.config or {}
    G.P_CENTERS["j_phanta_deckjoker"].loc_vars = function(self, info_queue, card)
      print(inspect(deck.info_queue))
      for _, v in ipairs(deck.info_queue or {}) do
        info_queue[#info_queue + 1] = v
      end
      return { key = deck.loc_key and self.key .. "_" .. deck.loc_key or self.key, vars = deck.loc_vars }
    end
    G.P_CENTERS["j_phanta_deckjoker"].enhancement_gate = deck.enhancement_gate

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
    G.P_CENTERS["j_phanta_deckjoker"].enhancement_gate = nil

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




G.Phanta.centers["datacube"] = {
  config = { extra = { money = 4, rank_key = "unknown" } },
  loc_vars = function(self, info_queue, card)
    return { vars = { card.ability.extra.money, localize((G.GAME.current_round.datacube_card.value or 2) .. "", 'ranks') } }
  end,
  rarity = 1,
  atlas = 'PhantaMiscAnims6',
  pos = { x = 0, y = 3 },
  flipbook_pos_extra = { x = 1, y = 3 },
  flipbook_anim_states = {
    ["unknown"] = { anim = { { x = 0, y = 3, t = 1 } }, loop = false },
    ["2"] = { anim = { { x = 0, y = 3, t = 1 } }, loop = false },
    ["3"] = { anim = { { x = 0, y = 3, t = 1 } }, loop = false },
    ["4"] = { anim = { { x = 0, y = 3, t = 1 } }, loop = false },
    ["5"] = { anim = { { x = 0, y = 3, t = 1 } }, loop = false },
    ["6"] = { anim = { { x = 0, y = 3, t = 1 } }, loop = false },
    ["7"] = { anim = { { x = 0, y = 3, t = 1 } }, loop = false },
    ["8"] = { anim = { { x = 0, y = 3, t = 1 } }, loop = false },
    ["9"] = { anim = { { x = 0, y = 3, t = 1 } }, loop = false },
    ["10"] = { anim = { { x = 0, y = 3, t = 1 } }, loop = false },
    ["Jack"] = { anim = { { x = 11, y = 3, t = 1 } }, loop = false },
    ["Queen"] = { anim = { { x = 11, y = 3, t = 1 } }, loop = false },
    ["King"] = { anim = { { x = 11, y = 3, t = 1 } }, loop = false },
    ["Ace"] = { anim = { { x = 11, y = 3, t = 1 } }, loop = false },
    ["paperback_Apostle"] = { anim = { { x = 11, y = 3, t = 1 } }, loop = false },
  },
  flipbook_anim_extra_states = {
    extra = {
      ["unknown"] = { anim = { { x = 1, y = 3, t = 1 } }, loop = false },
      ["2"] = { anim = { { x = 2, y = 3, t = 1 } }, loop = false },
      ["3"] = { anim = { { x = 3, y = 3, t = 1 } }, loop = false },
      ["4"] = { anim = { { x = 4, y = 3, t = 1 } }, loop = false },
      ["5"] = { anim = { { x = 5, y = 3, t = 1 } }, loop = false },
      ["6"] = { anim = { { x = 6, y = 3, t = 1 } }, loop = false },
      ["7"] = { anim = { { x = 7, y = 3, t = 1 } }, loop = false },
      ["8"] = { anim = { { x = 8, y = 3, t = 1 } }, loop = false },
      ["9"] = { anim = { { x = 9, y = 3, t = 1 } }, loop = false },
      ["10"] = { anim = { { x = 10, y = 3, t = 1 } }, loop = false },
      ["Jack"] = { anim = { { x = 0, y = 4, t = 1 } }, loop = false },
      ["Queen"] = { anim = { { x = 1, y = 4, t = 1 } }, loop = false },
      ["King"] = { anim = { { x = 2, y = 4, t = 1 } }, loop = false },
      ["Ace"] = { anim = { { x = 3, y = 4, t = 1 } }, loop = false },
      ["paperback_Apostle"] = { anim = { { x = 3, y = 4, t = 1 } }, loop = false }
    }
  },
  flipbook_anim_initial_state = "unknown",
  flipbook_anim_extra_initial_state = "unknown",
  cost = 5,
  blueprint_compat = true,
  eternal_compat = true,
  perishable_compat = true,
  calculate = function(self, card, context)
    if context.before then
      for _, v in ipairs(context.scoring_hand) do
        if v:get_id() == G.GAME.current_round.datacube_card.id then
          return { dollars = card.ability.extra.money }
        end
      end
    end

    if context.end_of_round and not context.individual and not context.repetition and not context.blueprint then
      return { message = localize("k_reset") }
    end
  end,
  update_datacube_rank = function(self, card)
    local displayed_rank = "unknown"
    if card.config.center.flipbook_anim_extra_states["extra"][G.GAME.current_round.datacube_card.value] then
      displayed_rank = G.GAME.current_round.datacube_card.value
    end

    card:flipbook_set_anim_state(displayed_rank)
    card:flipbook_set_anim_extra_state(displayed_rank)
    card.ability.extra.rank_key = displayed_rank
  end,
  add_to_deck = function(self, card, from_debuff)
    self:update_datacube_rank(card)
  end,
  update = function(self, card, dt)
    if not self.discovered and not card.params.bypass_discovery_center then
      return
    end
    if card.ability.extra.rank_key ~= G.GAME.current_round.datacube_card.value then self:update_datacube_rank(card) end
  end,
  pronouns = "it_its"
}

G.Phanta.centers["longtail"] = {
  config = { extra = { money = 4 } },
  loc_vars = function(self, info_queue, card)
    return { vars = { card.ability.extra.money } }
  end,
  rarity = 1,
  atlas = 'Phanta2',
  pos = { x = 2, y = 8 },
  cost = 5,
  blueprint_compat = true,
  eternal_compat = true,
  perishable_compat = true,
  calculate = function(self, card, context)
    if context.before and next(context.poker_hands["Straight"]) then
      local valid = true
      for _, v in ipairs(context.scoring_hand) do
        if v:is_face() then
          valid = false
        end
      end

      if valid then return { dollars = card.ability.extra.money } end
    end
  end,
  pronouns = "it_its"
}

G.Phanta.centers["luckynumber"] = {
  config = { extra = { odds = 5, money = 8 } },
  rarity = 1,
  atlas = 'Phanta2',
  pos = { x = 6, y = 6 },
  cost = 4,
  loc_vars = function(self, info_queue, card)
    local num, denom = SMODS.get_probability_vars(card, 1, card.ability.extra.odds, "luckynumber")
    return { vars = { num, denom, card.ability.extra.money } }
  end,
  blueprint_compat = true,
  eternal_compat = true,
  perishable_compat = true,
  calculate = function(self, card, context)
    if context.individual and context.cardarea == G.play and
        (context.other_card:get_id() == 3 or context.other_card:get_id() == 4 or context.other_card:get_id() == 9)
        and SMODS.pseudorandom_probability(card, "luckynumber", 1, card.ability.extra.odds) then
      return { dollars = card.ability.extra.money }
    end
  end,
  pronouns = "it_its"
}



G.Phanta.centers["absentjoker"] = {
  config = { extra = { mult = 15 } },
  loc_vars = function(self, info_queue, card)
    return { vars = { card.ability.extra.mult } }
  end,
  rarity = 1,
  atlas = 'Phanta2',
  pos = { x = 4, y = 1 },
  flipbook_anim = { { x = 4, y = 1, t = 2 }, { x = 5, y = 1, t = 0.15 }, { x = 4, y = 1, t = 0.25 }, { x = 5, y = 1, t = 0.15 }, { x = 4, y = 1, t = 0.25 }, { x = 5, y = 1, t = 0.15 } },
  cost = 4,
  blueprint_compat = true,
  eternal_compat = true,
  perishable_compat = true,
  calculate = function(self, card, context)
    if context.joker_main and G.jokers.config.card_limit - #G.jokers.cards >= 1 then
      return { mult = card.ability.extra.mult }
    end
  end,
  pronouns = "they_them"
}

G.Phanta.centers["pottedpeashooter"] = {
  config = { extra = { mult = 15 } },
  loc_vars = function(self, info_queue, card)
    return { vars = { card.ability.extra.mult } }
  end,
  rarity = 1,
  atlas = 'Phanta2',
  pos = { x = 1, y = 4 },
  cost = 4,
  blueprint_compat = true,
  eternal_compat = true,
  perishable_compat = true,
  calculate = function(self, card, context)
    if context.joker_main and G.jokers.cards[#G.jokers.cards] == card then
      return { mult = card.ability.extra.mult }
    end
  end
  -- Pronouns are random
}

G.Phanta.centers["venndiagram"] = {
  config = { extra = { added_chips = 8, current_chips = 0, required_of_suit = 3 } },
  loc_vars = function(self, info_queue, card)
    return { vars = { card.ability.extra.added_chips, card.ability.extra.required_of_suit, card.ability.extra.current_chips } }
  end,
  rarity = 1,
  atlas = 'Phanta2',
  pos = { x = 8, y = 4 },
  cost = 4,
  blueprint_compat = true,
  eternal_compat = true,
  perishable_compat = false,
  calculate = function(self, card, context)
    if context.joker_main and card.ability.extra.current_chips > 0 then return { chips = card.ability.extra.current_chips } end

    if context.before and not context.blueprint then
      local wilds = 0
      local suit_counts = {}
      local triggered = false
      for i = 1, #context.scoring_hand do
        if not SMODS.has_any_suit(context.scoring_hand[i]) then
          suit_counts[context.scoring_hand[i].base.suit] = (suit_counts[context.scoring_hand[i].base.suit] or 0) + 1
        else
          wilds = wilds + 1
        end
        if (suit_counts[context.scoring_hand[i].base.suit] or 0) + wilds >= card.ability.extra.required_of_suit then
          triggered = true; break
        end
      end

      if triggered then
        card.ability.extra.current_chips = card.ability.extra.current_chips + card.ability.extra.added_chips
        return { message = localize("k_upgrade_ex"), colour = G.C.FILTER }
      end
    end
  end,
  pronouns = "it_its"
}

G.Phanta.centers["visionary"] = {
  config = { extra = { added_xmult = 0.1, current_xmult = 1, required_scored = 4 } },
  loc_vars = function(self, info_queue, card)
    return { vars = { card.ability.extra.added_xmult, card.ability.extra.required_scored, card.ability.extra.current_xmult } }
  end,
  rarity = 2,
  atlas = 'PhantaMiscAnims6',
  pos = { x = 6, y = 8 },
  flipbook_anim = {
    { x = 6,  y = 8, t = 0.05 },
    { x = 7,  y = 8, t = 0.1 },
    { x = 8,  y = 8, t = 0.25 },
    { x = 7,  y = 8, t = 0.1 },
    { x = 6,  y = 8, t = 0.05 },
    { x = 9,  y = 8, t = 0.1 },
    { x = 10, y = 8, t = 0.25 },
    { x = 9,  y = 8, t = 0.1 }
  },
  pos = { x = 11, y = 8 },
  flipbook_anim_extra = {
    { x = 11,                           y = 8, t = 0.15 },
    { xrange = { first = 0, last = 1 }, y = 9, t = 0.15 }
  },
  cost = 7,
  blueprint_compat = true,
  eternal_compat = true,
  perishable_compat = false,
  calculate = function(self, card, context)
    if context.joker_main then return { xmult = card.ability.extra.current_xmult } end

    if context.before and not context.blueprint then
      if #context.scoring_hand >= card.ability.extra.required_scored then
        card.ability.extra.current_xmult = card.ability.extra.current_xmult + card.ability.extra.added_xmult
        return { message = localize("k_upgrade_ex"), colour = G.C.FILTER }
      end
    end
  end,
  pronouns = "it_its"
}

G.Phanta.centers["88888888"] = {
  config = { extra = { given_chips = 8, given_mult = 8 } },
  loc_vars = function(self, info_queue, card)
    return { vars = { card.ability.extra.given_chips, card.ability.extra.given_mult } }
  end,
  rarity = 1,
  atlas = 'PhantaMiscAnims6',
  pos = { x = 11, y = 4 },
  flipbook_anim = {
    { xrange = { first = 5, last = 10 }, y = 0, t = 0.1 }
  },
  flipbook_pos_extra = { x = 11, y = 4 },
  flipbook_anim_extra_states = {
    ["normal"] = { anim = { { x = 11, y = 0, t = 1 } }, loop = false },
    ["pressed"] = { anim = { { x = 11, y = 1, t = 1 } }, loop = false },
  },
  flipbook_anim_extra_initial_state = "normal",
  cost = 8,
  blueprint_compat = true,
  eternal_compat = true,
  perishable_compat = true,
  calculate = function(self, card, context)
    if context.individual and context.cardarea == G.play and context.other_card:get_id() == 8 then
      return { chips = card.ability.extra.given_chips, mult = card.ability.extra.given_mult }
    end

    if context.phanta_eight_pressed and not context.blueprint then
      G.E_MANAGER:add_event(Event({
        func = function()
          card:juice_up()
          play_sound("phanta_88888888", 1, 0.75)
          card:flipbook_set_anim_extra_state("pressed")
          return true
        end
      }))
    end

    if context.phanta_eight_released and not context.blueprint then
      G.E_MANAGER:add_event(Event({
        func = function()
          card:flipbook_set_anim_extra_state("normal")
          return true
        end
      }))
    end
  end,
  pronouns = "it_its"
}

local key_press_ref = Controller.key_press
function Controller:key_press(key)
  key_press_ref(self, key)
  if self.pressed_keys["8"] then
    SMODS.calculate_context({ phanta_eight_pressed = true })
  end
end

local key_release_ref = Controller.key_release
function Controller:key_release(key)
  key_release_ref(self, key)
  if self.released_keys["8"] then
    SMODS.calculate_context({ phanta_eight_released = true })
  end
end

G.Phanta.centers["burnerphone"] = {
  loc_vars = function(self, info_queue, card)
    local _vars = -- Brace yourself.

        not (card.area and card.area == G.jokers) and
        { "Unknown", "", "", "(Obtain this Joker", "", "", "to learn this info)", "", "" }
        --or not G.GAME.blind.in_blind and { "Unknown", "", "", "(Not currently in", "", "", "a round)", "", "" }
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

    if not (card.area and card.area == G.jokers) then
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
  atlas = 'PhantaMiscAnims5',
  pos = { x = 0, y = 8 },
  flipbook_anim = {
    { xrange = { first = 0, last = 11 }, yrange = { first = 8, last = 9 }, t = 0.1 },
    { xrange = { first = 0, last = 3 },  y = 10,                           t = 0.1 }
  },
  flipbook_pos_extra = { x = 4, y = 10 },
  flipbook_anim_extra = {
    { x = 4, y = 10, t = 1.1 },
    { x = 5, y = 10, t = 0.075 },
    { x = 4, y = 10, t = 0.6 },
    { x = 5, y = 10, t = 0.075 },
    { x = 6, y = 10, t = 0.075 },
    { x = 5, y = 10, t = 0.075 },
    { x = 4, y = 10, t = 1.4 },
    { x = 5, y = 10, t = 0.075 },
    { x = 4, y = 10, t = 0.4 },
    { x = 5, y = 10, t = 0.075 },
    { x = 6, y = 10, t = 0.075 },
    { x = 7, y = 10, t = 0.075 }, { x = 8, y = 10, t = 0.075 },
    { x = 7, y = 10, t = 0.075 }, { x = 8, y = 10, t = 0.075 },
    { x = 7, y = 10, t = 0.075 }, { x = 8, y = 10, t = 0.075 },
    { x = 7, y = 10, t = 0.075 }, { x = 8, y = 10, t = 0.075 },
    { x = 9, y = 10, t = 0.075 }, { x = 10, y = 10, t = 0.075 },
    { x = 9, y = 10, t = 0.075 }, { x = 10, y = 10, t = 0.075 },
    { x = 9, y = 10, t = 0.075 }, { x = 10, y = 10, t = 0.075 },
    { x = 9,  y = 10, t = 0.075 }, { x = 10, y = 10, t = 0.075 },
    { x = 6,  y = 10, t = 0.075 },
    { x = 5,  y = 10, t = 0.075 },
    { x = 4,  y = 10, t = 1.6 },
    { x = 5,  y = 10, t = 0.075 },
    { x = 4,  y = 10, t = 1.4 },
    { x = 5,  y = 10, t = 0.075 },
    { x = 4,  y = 10, t = 0.5 },
    { x = 5,  y = 10, t = 0.075 },
    { x = 4,  y = 10, t = 1.2 },
    { x = 5,  y = 10, t = 0.075 },
    { x = 6,  y = 10, t = 0.075 },
    { x = 11, y = 10, t = 0.075 }, { x = 10, y = 11, t = 0.075 }, { x = 11, y = 11, t = 0.075 },
    { x = 6,  y = 10, t = 0.075 },
    { x = 11, y = 10, t = 0.075 }, { x = 10, y = 11, t = 0.075 }, { x = 11, y = 11, t = 0.075 },
    { x = 11, y = 10, t = 0.075 }, { x = 10, y = 11, t = 0.075 }, { x = 11, y = 11, t = 0.075 },
    { x = 11, y = 10, t = 0.075 }, { x = 10, y = 11, t = 0.075 }, { x = 11, y = 11, t = 0.075 },
    { x = 11, y = 10, t = 0.075 }, { x = 10, y = 11, t = 0.075 }, { x = 11, y = 11, t = 0.075 },
    { x = 6,  y = 10, t = 0.075 },
    { x = 11, y = 10, t = 0.075 }, { x = 10, y = 11, t = 0.075 }, { x = 11, y = 11, t = 0.075 },
    { x = 6, y = 10, t = 0.075 },
    { x = 5, y = 10, t = 0.075 },
    { x = 4, y = 10, t = 1.9 },
    { x = 5, y = 10, t = 0.075 },
    { x = 4, y = 10, t = 0.5 },
    { x = 5, y = 10, t = 0.075 }
  },
  cost = 4,
  blueprint_compat = false,
  eternal_compat = true,
  perishable_compat = true,
  pronouns = "it_its"
}

G.Phanta.centers["flushed"] = {
  config = { extra = { added_mult = 3, current_mult = 0 } },
  loc_vars = function(self, info_queue, card)
    return { vars = { card.ability.extra.added_mult, card.ability.extra.current_mult } }
  end,
  rarity = 1,
  atlas = 'PhantaMiscAnims6',
  pos = { x = 0, y = 1 },
  flipbook_anim = {
    { xrange = { first = 0, last = 3 }, y = 1, t = 0.1 }
  },
  cost = 4,
  blueprint_compat = true,
  eternal_compat = true,
  perishable_compat = false,
  calculate = function(self, card, context)
    if context.joker_main then return { mult = card.ability.extra.current_mult } end

    if context.before and G.GAME.current_round.hands_played == 1 and next(context.poker_hands['Flush']) and not context.blueprint then
      card.ability.extra.current_mult = card.ability.extra.current_mult + card.ability.extra.added_mult
      return { message = localize("k_upgrade_ex"), colour = G.C.FILTER }
    end
  end,
  pronouns = "she_they"
}

G.Phanta.centers["smilingimp"] = {
  rarity = 2,
  atlas = 'PhantaMiscAnims6',
  pos = { x = 4, y = 1 },
  flipbook_anim = {
    { xrange = { first = 4, last = 7 }, y = 1, t = 0.1 }
  },
  cost = 6,
  blueprint_compat = true,
  eternal_compat = true,
  perishable_compat = false,
  calculate = function(self, card, context)
    if context.individual and context.cardarea == "unscored" and context.other_card:get_id() == 6 and count_consumables() < G.consumeables.config.card_limit then
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
                local new_card = create_card("Tarot", G.consumables, nil, nil, nil, nil, nil, "smilingimp")
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
  pronouns = "he_they"
}

G.Phanta.centers["thumper"] = {
  config = { extra = { odds = 2, money = 3 } },
  loc_vars = function(self, info_queue, card)
    local num, denom = SMODS.get_probability_vars(card, 1, card.ability.extra.odds, "thumper")
    return { vars = { num, denom, card.ability.extra.money } }
  end,
  rarity = 1,
  atlas = 'Phanta2',
  pos = { x = 9, y = 7 },
  cost = 5,
  blueprint_compat = true,
  eternal_compat = true,
  perishable_compat = true,
  calculate = function(self, card, context)
    if context.individual and context.cardarea == "unscored" and context.other_card:is_face() and SMODS.pseudorandom_probability(card, "thumper", 1, card.ability.extra.odds) then
      return { dollars = card.ability.extra.money }
    end
  end,
  pronouns = "it_its"
}

G.Phanta.centers["coldjoker"] = {
  config = { extra = { added_chips = 8, current_chips = 0 } },
  loc_vars = function(self, info_queue, card)
    return { vars = { card.ability.extra.added_chips, card.ability.extra.current_chips } }
  end,
  rarity = 1,
  atlas = 'PhantaMiscAnims6',
  pos = { x = 8, y = 1 },
  flipbook_anim = {
    { x = 8, y = 1, t = 1.1 }, { x = 9, y = 1, t = 0.3 }, { x = 9, y = 2, t = 0.1 },
    { x = 9, y = 1, t = 0.5 }, { x = 9, y = 2, t = 0.1 },
    { x = 9,  y = 1, t = 0.9 }, { x = 9, y = 2, t = 0.1 },
    { x = 10, y = 1, t = 0.2 }, { x = 10, y = 2, t = 0.4 },
    { x = 10, y = 1, t = 0.2 }, { x = 9, y = 2, t = 0.4 },
    { x = 10, y = 1, t = 0.2 }, { x = 10, y = 2, t = 0.4 },
    { x = 10, y = 1, t = 0.2 }, { x = 9, y = 2, t = 0.4 },
    { x = 10, y = 1, t = 0.2 }, { x = 10, y = 2, t = 0.4 },
    { x = 10, y = 1, t = 0.2 }, { x = 9, y = 2, t = 0.3 }, { x = 9, y = 2, t = 0.1 },
    { x = 9,  y = 1, t = 1.2 }, { x = 9, y = 2, t = 0.1 },
    { x = 9, y = 1, t = 0.3 }, { x = 9, y = 2, t = 0.1 },
    { x = 9, y = 1, t = 0.8 }, { x = 9, y = 2, t = 0.3 },
    { x = 0, y = 2, t = 0.1 }, { x = 1, y = 2, t = 0.4 },
    { x = 2, y = 2, t = 1.2 }, { x = 3, y = 2, t = 0.1 }, { x = 4, y = 2, t = 0.1 },
    { x = 5, y = 2, t = 0.1 }, { x = 6, y = 2, t = 0.1 }, { x = 5, y = 2, t = 0.1 }, { x = 7, y = 2, t = 0.1 },
    { x = 5, y = 2, t = 0.1 }, { x = 6, y = 2, t = 0.1 }, { x = 5, y = 2, t = 0.1 }, { x = 7, y = 2, t = 0.1 },
    { x = 5, y = 2, t = 0.1 }, { x = 6, y = 2, t = 0.1 }, { x = 5, y = 2, t = 0.1 }, { x = 7, y = 2, t = 0.1 },
    { x = 5, y = 2, t = 0.1 }, { x = 6, y = 2, t = 0.1 }, { x = 5, y = 2, t = 0.1 }, { x = 7, y = 2, t = 0.1 },
    { x = 5, y = 2, t = 0.3 }, { x = 4, y = 2, t = 0.1 }, { x = 3, y = 2, t = 0.1 }, { x = 1, y = 2, t = 0.1 },
    { x = 2, y = 2, t = 1.2 }, { x = 3, y = 2, t = 0.1 }, { x = 4, y = 2, t = 0.1 },
    { x = 5, y = 2, t = 0.1 }, { x = 6, y = 2, t = 0.1 }, { x = 5, y = 2, t = 0.1 }, { x = 7, y = 2, t = 0.1 },
    { x = 5, y = 2, t = 0.1 }, { x = 6, y = 2, t = 0.1 }, { x = 5, y = 2, t = 0.1 }, { x = 7, y = 2, t = 0.1 },
    { x = 5, y = 2, t = 0.1 }, { x = 6, y = 2, t = 0.1 }, { x = 5, y = 2, t = 0.1 }, { x = 7, y = 2, t = 0.1 },
    { x = 5, y = 2, t = 0.1 }, { x = 6, y = 2, t = 0.1 }, { x = 5, y = 2, t = 0.1 }, { x = 7, y = 2, t = 0.1 },
    { x = 5, y = 2, t = 0.3 }, { x = 11, y = 2, t = 0.1 },
    { x = 9, y = 1, t = 0.9 }, { x = 9, y = 2, t = 0.1 },
    { x = 9, y = 1, t = 1.4 }, { x = 9, y = 2, t = 0.1 },
    { x = 9, y = 1, t = 0.3 }, { x = 9, y = 2, t = 0.1 },
    { x = 10, y = 1, t = 0.2 }, { x = 10, y = 2, t = 0.4 },
    { x = 10, y = 1, t = 0.2 }, { x = 9, y = 2, t = 0.4 },
    { x = 10, y = 1, t = 0.2 }, { x = 10, y = 2, t = 0.4 },
    { x = 10, y = 1, t = 0.2 }, { x = 9, y = 2, t = 0.4 },
    { x = 10, y = 1, t = 0.2 }, { x = 10, y = 2, t = 0.4 },
    { x = 10, y = 1, t = 0.2 }, { x = 9, y = 2, t = 0.3 },
    { x = 9, y = 1, t = 1.5 }, { x = 9, y = 2, t = 0.1 },
    { x = 9, y = 1, t = 0.6 }, { x = 9, y = 2, t = 0.2 }, { x = 10, y = 1, t = 0.5 },
    { x = 8, y = 2, t = 0.2 }, { x = 8, y = 1, t = 0.3 },
  },
  cost = 5,
  blueprint_compat = true,
  eternal_compat = true,
  perishable_compat = false,
  calculate = function(self, card, context)
    if context.joker_main and card.ability.extra.current_chips > 0 then return { chips = card.ability.extra.current_chips } end

    if context.end_of_round and not context.individual and not context.repetition and not context.blueprint and count_consumables({ ignore_catan = true }) > 0 then
      card.ability.extra.current_chips = card.ability.extra.current_chips + (card.ability.extra.added_chips * count_consumables({ ignore_catan = true }))
      return { message = localize("k_upgrade_ex"), colour = G.C.FILTER }
    end
  end,
  pronouns = "they_them"
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
  end,
  pronouns = "they_them"
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
  end,
  pronouns = "they_them"
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
  end,
  pronouns = "they_them"
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
  end,
  pronouns = "they_them"
}

G.Phanta.centers["returnticket"] = {
  config = { extra = { current_rounds = 0, rounds_required = 2 } },
  loc_vars = function(self, info_queue, card)
    info_queue[#info_queue + 1] = G.P_TAGS.tag_polychrome
    return { vars = { card.ability.extra.rounds_required, card.ability.extra.current_rounds } }
  end,
  rarity = 1,
  atlas = 'Phanta2',
  pos = { x = 7, y = 5 },
  pixel_size = { w = 43 },
  cost = 6,
  blueprint_compat = false,
  eternal_compat = false,
  perishable_compat = true,
  calculate = function(self, card, context)
    if context.selling_self and card.ability.extra.current_rounds >= card.ability.extra.rounds_required then
      G.E_MANAGER:add_event(Event({
        func = (function()
          add_tag(Tag('tag_polychrome'))
          play_sound('holo1', 1.2 + math.random() * 0.1, 0.4)
          return true
        end)
      }))

      return { message = localize { key = "tag_polychrome", type = "name_text", set = "Tag" }, colour = G.C.FILTER }
    end

    if context.end_of_round and not context.individual and not context.repetition and not context.blueprint then
      card.ability.extra.current_rounds = card.ability.extra.current_rounds + 1
      if card.ability.extra.current_rounds == card.ability.extra.rounds_required then
        local eval = function(card) return not card.REMOVED end
        juice_card_until(card, eval, true)
      end
      return {
        message = (card.ability.extra.current_rounds < card.ability.extra.rounds_required) and
            (card.ability.extra.current_rounds .. '/' .. card.ability.extra.rounds_required) or localize('k_active_ex')
      }
    end
  end,
  pronouns = "it_its"
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
      local eligible = {}
      for _, v in ipairs(G.hand.cards) do
        if not v.seal then eligible[#eligible + 1] = v end
      end
      local conv_card = pseudorandom_element(eligible, pseudoseed('fantacard'))
      G.E_MANAGER:add_event(Event({
        func = function()
          play_sound('tarot1')
          card:juice_up(0.3, 0.5)
          card_eval_status_text(card, 'extra', nil, nil, nil,
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
  end,
  pronouns = "it_its"
}

G.Phanta.centers["sprinkles"] = {
  rarity = 2,
  atlas = 'PhantaMiscAnims5',
  pos = { x = 1, y = 7 },
  flipbook_anim = {
    { xrange = { first = 0, last = 3 }, y = 7, t = 0.1 }
  },
  flipbook_pos_extra = { x = 4, y = 7 },
  flipbook_anim_extra = {
    { x = 4,  y = 7, t = 0.075 },
    { x = 5,  y = 7, t = 0.125 },
    { x = 6,  y = 7, t = 0.175 },
    { x = 7,  y = 7, t = 0.3 },
    { x = 6,  y = 7, t = 0.175 },
    { x = 5,  y = 7, t = 0.125 },
    { x = 4,  y = 7, t = 0.075 },
    { x = 8,  y = 7, t = 0.125 },
    { x = 9,  y = 7, t = 0.175 },
    { x = 10, y = 7, t = 0.3 },
    { x = 9,  y = 7, t = 0.175 },
    { x = 8,  y = 7, t = 0.125 }
  },
  cost = 6,
  blueprint_compat = true,
  eternal_compat = false,
  perishable_compat = true,
  calculate = function(self, card, context)
    if context.selling_self and G.consumeables then
      G.E_MANAGER:add_event(Event({
        func = function()
          play_sound('tarot1')
          card:juice_up(0.3, 0.5)
          return true
        end
      }))

      G.E_MANAGER:add_event(Event({
        trigger = 'after',
        delay = 0.1,
        func = function()
          for _, v in ipairs(G.consumeables.cards) do
            if not v.edition then
              v:set_edition(poll_edition("sprinklesed", nil, true, true))
            end
          end
          return true
        end
      }))
    end
  end,
  pronouns = "it_its"
}

G.Phanta.centers["testpage"] = {
  unlocked = false,
  unlock_condition = { extra = "phanta_junk" },
  check_for_unlock = function(self, args)
    if args.cards then
      local text, disp_text = G.FUNCS.get_poker_hand_info(args.cards)
      return args.type == "hand_contents" and text == self.unlock_condition.extra
    end
  end,
  config = { extra = { added_chips = 10, current_chips = 0 } },
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
  end,
  pronouns = "it_its"
}

G.Phanta.centers["flagsignal"] = {
  config = { extra = { xmult = 2 } },
  rarity = 2,
  atlas = 'PhantaMiscAnims5',
  pos = { x = 10, y = 2 },
  flipbook_anim = {
    { x = 10, y = 2, t = 0.3 },
    { x = 11, y = 2, t = 0.3 },
    { x = 0,  y = 3, t = 0.3 }
  },
  flipbook_pos_extra = { x = 1, y = 3 },
  flipbook_anim_extra = {
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
  cost = 6,
  loc_vars = function(self, info_queue, card)
    return { vars = { card.ability.extra.xmult } }
  end,
  blueprint_compat = true,
  eternal_compat = true,
  perishable_compat = true,
  calculate = function(self, card, context)
    if context.joker_main and next(G.hand.cards) then
      local ranks = {}
      for _, v in ipairs(G.hand.cards) do
        if ranks[v:get_id()] then return { xmult = card.ability.extra.xmult } end
        ranks[v:get_id()] = true
      end
    end
  end
  -- Pronouns are random
}

G.Phanta.centers["signofthehorns"] = {
  config = { extra = { mult = 13 } },
  rarity = 1,
  atlas = "Phanta2",
  pos = { x = 1, y = 6 },
  cost = 5,
  loc_vars = function(self, info_queue, card)
    return { vars = { card.ability.extra.mult } }
  end,
  blueprint_compat = true,
  eternal_compat = true,
  perishable_compat = true,
  calculate = function(self, card, context)
    if context.individual and not context.end_of_round and context.cardarea == G.hand and context.other_card:get_id() == 3 then
      return { mult = card.ability.extra.mult }
    end
  end,
  pronouns = "they_them"
}

G.Phanta.centers["jackolantern"] = {
  config = { extra = { xmult = 1.5 } },
  rarity = 3,
  atlas = 'PhantaMiscAnims6',
  pos = { x = 0, y = 0 },
  flipbook_anim = {
    { x = 0, y = 0, t = 0.1 },
    { x = 2, y = 0, t = 0.1 },
    { x = 1, y = 0, t = 0.1 },
    { x = 4, y = 0, t = 0.1 },
    { x = 0, y = 0, t = 0.1 },
    { x = 3, y = 0, t = 0.1 },
    { x = 4, y = 0, t = 0.1 },
    { x = 0, y = 0, t = 0.1 },
    { x = 1, y = 0, t = 0.1 },
    { x = 2, y = 0, t = 0.1 },
    { x = 1, y = 0, t = 0.1 },
    { x = 3, y = 0, t = 0.1 },
    { x = 4, y = 0, t = 0.1 },
    { x = 2, y = 0, t = 0.1 },
    { x = 3, y = 0, t = 0.1 },
    { x = 0, y = 0, t = 0.1 },
    { x = 3, y = 0, t = 0.1 },
    { x = 1, y = 0, t = 0.1 },
    { x = 4, y = 0, t = 0.1 },
    { x = 0, y = 0, t = 0.1 },
    { x = 1, y = 0, t = 0.1 },
    { x = 0, y = 0, t = 0.1 },
    { x = 2, y = 0, t = 0.1 },
    { x = 3, y = 0, t = 0.1 },
    { x = 1, y = 0, t = 0.1 },
    { x = 2, y = 0, t = 0.1 },
    { x = 4, y = 0, t = 0.1 },
    { x = 0, y = 0, t = 0.1 },
    { x = 2, y = 0, t = 0.1 },
    { x = 3, y = 0, t = 0.1 },
    { x = 4, y = 0, t = 0.1 },
    { x = 3, y = 0, t = 0.1 },
    { x = 2, y = 0, t = 0.1 },
    { x = 0, y = 0, t = 0.1 },
    { x = 1, y = 0, t = 0.1 },
    { x = 0, y = 0, t = 0.1 },
    { x = 1, y = 0, t = 0.1 },
    { x = 4, y = 0, t = 0.1 },
    { x = 3, y = 0, t = 0.1 },
    { x = 2, y = 0, t = 0.1 },
  },
  cost = 8,
  loc_vars = function(self, info_queue, card)
    return { vars = { card.ability.extra.xmult } }
  end,
  blueprint_compat = true,
  eternal_compat = true,
  perishable_compat = true,
  calculate = function(self, card, context)
    if context.individual and context.cardarea == G.play and context.other_card:is_face() and next(SMODS.get_enhancements(context.other_card)) then
      return { xmult = card.ability.extra.xmult }
    end
  end,
  pronouns = "she_her"
}

G.Phanta.centers["runicjoker"] = {
  config = { extra = { xmult = 1.5 } },
  rarity = 2,
  atlas = 'Phanta2',
  pos = { x = 7, y = 4 },
  cost = 6,
  loc_vars = function(self, info_queue, card)
    info_queue[#info_queue + 1] = G.P_CENTERS.m_stone
    return { vars = { card.ability.extra.xmult } }
  end,
  blueprint_compat = true,
  eternal_compat = true,
  perishable_compat = true,
  calculate = function(self, card, context)
    if context.individual and context.cardarea == G.play and SMODS.has_enhancement(context.other_card, "m_stone") then
      return { xmult = card.ability.extra.xmult }
    end
  end,
  enhancement_gate = "m_stone",
  pronouns = "they_them"
}

G.Phanta.centers["heartbreak"] = {
  config = { extra = { added_xmult = 0.1, current_xmult = 1 } },
  rarity = 3,
  atlas = 'PhantaMiscAnims1',
  pos = { x = 0, y = 9 },
  flipbook_anim = {
    { xrange = { first = 0, last = 11 }, yrange = { first = 9, last = 10 }, t = 0.1 },
    { xrange = { first = 0, last = 3 },  y = 11,                            t = 0.1 }
  },
  cost = 8,
  loc_vars = function(self, info_queue, card)
    return { vars = { card.ability.extra.current_xmult, card.ability.extra.added_xmult } }
  end,
  blueprint_compat = true,
  eternal_compat = true,
  perishable_compat = false,
  calculate = function(self, card, context)
    if context.individual and context.cardarea == G.play and context.other_card:is_suit("Hearts") and card.ability.extra.current_xmult > 1 then
      return { xmult = card.ability.extra.current_xmult }
    end

    if context.remove_playing_cards and not context.blueprint then
      local count = 0
      for _, v in ipairs(context.removed) do
        if v:is_suit("Hearts") then count = count + 1 end
      end
      if count > 0 then
        card.ability.extra.current_xmult = card.ability.extra.current_xmult + (count * card.ability.extra.added_xmult)
        return { message = localize("k_upgrade_ex"), colour = G.C.FILTER, message_card = card }
      end
    end
  end,
  pronouns = "she_her"
}

G.Phanta.centers["distance"] = {
  config = { extra = { chips = 250 } },
  rarity = 3,
  atlas = 'PhantaMiscAnims4',
  pos = { x = 0, y = 0 },
  flipbook_anim = {
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
  end,
  pronouns = "she_her"
}

G.Phanta.centers["thefall"] = {
  config = { extra = { added_xmult = 0.1, current_xmult = 1 } },
  rarity = 2,
  atlas = 'PhantaMiscAnims6',
  pos = { x = 8, y = 6 },
  flipbook_anim = {
    { xrange = { first = 8, last = 11 }, y = 6, t = 0.03 },
    { xrange = { first = 0, last = 2 },  y = 7, t = 0.03 },
  },
  flipbook_pos_extra = { person = { x = 3, y = 7 }, hat = { x = 2, y = 8 } },
  flipbook_anim_extra = {
    person = {
      { x = 3,  y = 7, t = 0.2 },
      { x = 4,  y = 7, t = 0.25 },
      { x = 5,  y = 7, t = 0.3 },
      { x = 6,  y = 7, t = 0.35 },
      { x = 7,  y = 7, t = 0.45 },
      { x = 8,  y = 7, t = 0.6 },
      { x = 7,  y = 7, t = 0.45 },
      { x = 6,  y = 7, t = 0.35 },
      { x = 5,  y = 7, t = 0.3 },
      { x = 4,  y = 7, t = 0.25 },
      { x = 3,  y = 7, t = 0.2 },
      { x = 9,  y = 7, t = 0.25 },
      { x = 10, y = 7, t = 0.3 },
      { x = 11, y = 7, t = 0.35 },
      { x = 0,  y = 8, t = 0.45 },
      { x = 1,  y = 8, t = 0.6 },
      { x = 0,  y = 8, t = 0.45 },
      { x = 11, y = 7, t = 0.35 },
      { x = 10, y = 7, t = 0.3 },
      { x = 9,  y = 7, t = 0.25 }
    },
    hat = { { xrange = { first = 2, last = 5 }, y = 8, t = 0.15 } }
  },
  cost = 7,
  loc_vars = function(self, info_queue, card)
    return {
      vars = { card.ability.extra.added_xmult, card.ability.extra.current_xmult,
        (G.GAME and G.GAME.current_round and G.GAME.last_hand_played) and localize(G.GAME.last_hand_played, 'poker_hands') or localize('phanta_unknown') }
    }
  end,
  blueprint_compat = true,
  eternal_compat = true,
  perishable_compat = false,
  calculate = function(self, card, context)
    if context.joker_main and card.ability.extra.current_xmult > 1 then return { xmult = card.ability.extra.current_xmult } end

    if context.after then
      card.ability.extra.prev_hand = G.GAME.last_hand_played
    end

    if context.before then
      local prev_hand = card.ability.extra.prev_hand
      if prev_hand and G.GAME.hands[prev_hand] and context.scoring_name and G.GAME.hands[context.scoring_name]
          and G.GAME.hands[prev_hand].order < G.GAME.hands[context.scoring_name].order then
        card.ability.extra.current_xmult = card.ability.extra.current_xmult + card.ability.extra.added_xmult
        return { message = localize("k_upgrade_ex") }
      end
    end
  end,
  pronouns = "she_her"
}

G.Phanta.centers["donpaolo"] = {
  config = { extra = { money = 2 } },
  rarity = 2,
  atlas = 'PhantaLaytonAnims',
  pos = { x = 0, y = 2 },
  flipbook_anim = {
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
  loc_vars = function(self, info_queue, card)
    return { vars = { card.ability.extra.money } }
  end,
  blueprint_compat = true,
  eternal_compat = true,
  perishable_compat = true,
  calculate = function(self, card, context)
    if context.using_consumeable and context.consumeable.config.center.set == "Tarot" then
      return { dollars = card.ability.extra.money }
    end
  end,
  pronouns = "he_him"
}

SMODS.Sound({
  key = "future_luke_sold",
  path = "phanta_future_luke_sold.ogg",
  replace = true
})

G.Phanta.centers["futureluke"] = {
  config = { extra = { money = 2 } },
  rarity = 2,
  atlas = 'PhantaLaytonAnims',
  pos = { x = 0, y = 3 },
  flipbook_anim = {
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
  loc_vars = function(self, info_queue, card)
    return { vars = { card.ability.extra.money } }
  end,
  blueprint_compat = false,
  eternal_compat = true,
  perishable_compat = true,
  calculate = function(self, card, context)
    if context.using_consumeable and context.consumeable.config.center.set == "Planet" then
      return { dollars = card.ability.extra.money }
    end

    if context.selling_self and not context.blueprint then
      play_sound("phanta_future_luke_sold", 1, 0.9)
    end
  end,
  pronouns = "he_him"
}

G.Phanta.centers["barton"] = {
  config = { extra = { mult = 30, requirement = 12 } },
  rarity = 2,
  atlas = 'PhantaLaytonAnims',
  pos = { x = 0, y = 4 },
  flipbook_anim = {
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
  end,
  pronouns = "he_him"
}

G.Phanta.centers["inspectorchelmey"] = {
  config = { extra = { xmult = 3, requirement = 8 } },
  rarity = 2,
  atlas = 'PhantaLaytonAnims',
  pos = { x = 0, y = 5 },
  flipbook_anim = {
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
  end,
  pronouns = "he_him"
}

G.Phanta.centers["theblackraven"] = {
  config = { extra = { no_of_cards = 2 } },
  rarity = 2,
  atlas = 'PhantaLaytonAnims',
  pos = { x = 3, y = 3 },
  flipbook_anim = {
    { x = 0, y = 7, t = 5 }, { x = 4, y = 7, t = 0.1 },
    { x = 1, y = 7, t = 0.3 },
    { x = 2, y = 7, t = 0.1 }, { x = 3, y = 7, t = 0.3 },
    { xrange = { first = 2, last = 1 }, y = 7, t = 0.1 },
    { x = 2,                            y = 7, t = 0.1 }, { x = 3, y = 7, t = 0.3 },
    { xrange = { first = 2, last = 1 }, y = 7, t = 0.1 },
    { x = 2,                            y = 7, t = 0.1 }, { x = 3, y = 7, t = 0.3 },
    { x = 2, y = 7, t = 0.1 }, { x = 1, y = 7, t = 0.1 }, { x = 4, y = 7, t = 0.1 }
  },
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
  end,
  hpot_unbreedable = true,
  pronouns = "they_them"
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
  rarity = 3,
  atlas = 'Phanta2',
  pos = { x = 9, y = 2 },
  cost = 9,
  blueprint_compat = false,
  eternal_compat = true,
  perishable_compat = true,
  loc_vars = function(self, info_queue, card)
    return { vars = { card.ability.extra.sum } }
  end,
  calculate = function(self, card, context)
    if context.discard and context.cardarea == G.jokers and #context.full_hand > 1 and not context.blueprint then
      local total = 0
      for _, v in ipairs(context.full_hand) do
        total = total + v:get_chip_bonus()
      end

      if total == 9 then return { remove = true } end
    end
  end,
  pronouns = "they_them"
}

G.Phanta.centers["zeroii"] = {
  config = { extra = { odds = 3 } },
  rarity = 3,
  atlas = 'Phanta2',
  pos = { x = 1, y = 1 },
  cost = 9,
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
  end,
  pronouns = "he_they"
}

G.Phanta.centers["zeroiii"] = {
  config = { extra = { cards = 3 } },
  rarity = 3,
  atlas = 'Phanta2',
  pos = { x = 9, y = 3 },
  cost = 9,
  blueprint_compat = false,
  eternal_compat = true,
  perishable_compat = true,
  loc_vars = function(self, info_queue, card)
    return { vars = { card.ability.extra.cards } }
  end,
  calculate = function(self, card, context)
    if context.before and context.scoring_name == "Pair" and #context.full_hand == card.ability.extra.cards and not context.blueprint then
      for k, v in pairs(context.full_hand) do
        if not SMODS.in_scoring(v, context.scoring_hand) then
          v.phanta_zeroiii_marked_for_death = true
        end
      end
    end

    if context.destroy_card and context.destroy_card.phanta_zeroiii_marked_for_death and not context.blueprint then return { remove = true } end
  end,
  hpot_unbreedable = true,
  pronouns = "it_its"
}

G.Phanta.centers["theriddler"] = {
  config = { extra = { xmult = 3 } },
  rarity = 3,
  atlas = 'PhantaMiscAnims5',
  pos = { x = 8, y = 0 },
  flipbook_anim = {
    { xrange = { first = 8, last = 11 }, y = 0, t = 0.1 },
    { xrange = { first = 0, last = 7 },  y = 1, t = 0.1 }
  },
  flipbook_pos_extra = { x = 8, y = 1 },
  flipbook_anim_extra = {
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
    return { vars = { card.ability.extra.xmult } }
  end,
  calculate = function(self, card, context)
    if context.joker_main then
      return { xmult = card.ability.extra.xmult }
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
  end,
  pronouns = "he_him"
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
    if context.evaluate_poker_hand and context.scoring_name == "Straight" and not context.blueprint then
      return { replace_scoring_name = "Straight Flush" }
    end
    if context.evaluate_poker_hand and context.scoring_name == "Straight Flush" and not context.blueprint then
      return { replace_scoring_name = "Straight" }
    end
  end,
  pronouns = "he_him"
}

G.Phanta.centers["bloodyace"] = {
  rarity = 1,
  atlas = 'PhantaMiscAnims4',
  pos = { x = 11, y = 3 },
  flipbook_anim = {
    { x = 11,                           y = 3, t = 3 },
    { xrange = { first = 0, last = 2 }, y = 4, t = 0.05 },
    { x = 3,                            y = 4, t = 0.5 },
    { x = 4,                            y = 4, t = 0.5 },
    { x = 5,                            y = 4, t = 0.6 },
    { x = 6,                            y = 4, t = 0.7 },
    { xrange = { first = 7, last = 9 }, y = 4, t = 0.01 },
  },
  cost = 5,
  blueprint_compat = false,
  eternal_compat = true,
  perishable_compat = true,
  calculate = function(self, card, context)
    if context.evaluate_poker_hand and not context.blueprint then
      local ace_counter = 0
      for _, card in ipairs(context.scoring_hand) do
        if card:get_id() == 14 then ace_counter = ace_counter + 1 end
      end
      if ace_counter >= 2 then return { replace_scoring_name = "Four of a Kind" } end
    end
  end,
  pronouns = "it_its"
}

G.Phanta.centers["yatagarasucard"] = {
  config = { extra = { money = 2 } },
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
  end,
  pronouns = "it_its"
}

G.Phanta.centers["widget"] = {
  config = { extra = { added_xmult = 0.1, current_xmult = 1 } },
  loc_vars = function(self, info_queue, card)
    return {
      vars = {
        card.ability.extra.added_xmult,
        localize(G.GAME.current_round.phanta_widget_suit, 'suits_singular'),
        card.ability.extra.current_xmult,
        colours = { G.C.SUITS[G.GAME.current_round.phanta_widget_suit] or G.C.JOKER_GREY }
      }
    }
  end,
  rarity = 3,
  atlas = 'PhantaMiscAnims5',
  pos = { x = 7, y = 4 },
  flipbook_anim = {
    { xrange = { first = 7, last = 10 }, y = 4, t = 0.2 },
  },
  flipbook_pos_extra = { x = 11, y = 4 },
  flipbook_anim_extra_states = {
    ["unknown"] = { anim = { { x = 11, y = 4, t = 1 } }, loop = false },

    ["diamonds"] = { anim = { { x = 0, y = 5, t = 1 } }, loop = false },
    ["hearts"] = { anim = { { x = 1, y = 5, t = 1 } }, loop = false },
    ["spades"] = { anim = { { x = 2, y = 5, t = 1 } }, loop = false },
    ["clubs"] = { anim = { { x = 3, y = 5, t = 1 } }, loop = false },

    ["inks"] = { anim = { { x = 4, y = 5, t = 1 } }, loop = false },
    ["colors"] = { anim = { { x = 5, y = 5, t = 1 } }, loop = false },

    ["clovers"] = { anim = { { x = 6, y = 5, t = 1 } }, loop = false },
    ["suitless"] = { anim = { { x = 7, y = 5, t = 1 } }, loop = false },

    ["3s"] = { anim = { { x = 8, y = 5, t = 1 } }, loop = false },

    ["notes"] = { anim = { { x = 9, y = 5, t = 1 } }, loop = false },

    ["stars1"] = { anim = { { x = 10, y = 5, t = 1 } }, loop = false },
    ["moons"] = { anim = { { x = 11, y = 5, t = 1 } }, loop = false },

    ["fleurons"] = { anim = { { x = 0, y = 6, t = 1 } }, loop = false },
    ["halberds"] = { anim = { { x = 1, y = 6, t = 1 } }, loop = false },

    ["goblets"] = { anim = { { x = 2, y = 6, t = 1 } }, loop = false },
    ["towers"] = { anim = { { x = 3, y = 6, t = 1 } }, loop = false },
    ["blooms"] = { anim = { { x = 4, y = 6, t = 1 } }, loop = false },
    ["daggers"] = { anim = { { x = 5, y = 6, t = 1 } }, loop = false },
    ["voids"] = { anim = { { x = 6, y = 6, t = 1 } }, loop = false },
    ["lanterns"] = { anim = { { x = 7, y = 6, t = 1 } }, loop = false },

    ["crowns"] = { anim = { { x = 8, y = 6, t = 1 } }, loop = false },
    ["stars2"] = { anim = { { x = 9, y = 6, t = 1 } }, loop = false },

    ["thunders"] = { anim = { { x = 10, y = 6, t = 1 } }, loop = false },
    ["waters"] = { anim = { { x = 11, y = 6, t = 1 } }, loop = false },

    ["eyes"] = { anim = { { x = 0, y = 7, t = 1 } }, loop = false }
  },
  flipbook_anim_extra_initial_state = "unknown",
  cost = 8,
  blueprint_compat = true,
  eternal_compat = true,
  perishable_compat = true,
  calculate = function(self, card, context)
    if context.joker_main and card.ability.extra.current_xmult > 1 then
      return { xmult = card.ability.extra.current_xmult }
    end

    if context.before and context.scoring_hand[1] and context.scoring_hand[1]:is_suit(G.GAME.current_round.phanta_widget_suit) and not context.blueprint then
      card.ability.extra.current_xmult = card.ability.extra.current_xmult + card.ability.extra.added_xmult
      return { message = localize("k_upgrade_ex"), colour = G.C.FILTER, card = card }
    end

    if context.end_of_round and not context.individual and not context.repetition and not context.blueprint then
      self:update_widget_suit(card)
      return { message = localize("k_reset"), colour = G.FILTER }
    end
  end,
  update_widget_suit = function(self, card)
    local supported_suits = {
      ["Diamonds"] = "diamonds",
      ["Hearts"] = "hearts",
      ["Spades"] = "spades",
      ["Clubs"] = "clubs", --[[

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

        ["gb_Eyes"] = "eyes"]] --
    }
    local displayed_suit = supported_suits[G.GAME.current_round.phanta_widget_suit] or "unknown"

    card:flipbook_set_anim_extra_state(displayed_suit)
    card.ability.extra.suit_key = G.GAME.current_round.phanta_widget_suit
  end,
  add_to_deck = function(self, card, from_debuff)
    self:update_widget_suit(card)
  end,
  update = function(self, card, dt)
    if not self.discovered and not card.params.bypass_discovery_center then
      return
    end
    if card.ability.extra.suit_key ~= G.GAME.current_round.phanta_widget_suit then self:update_widget_suit(card) end
  end,
  pronouns = "it_its"
}

G.Phanta.centers["glassjoe"] = {
  config = { extra = { xmult = 2, odds = 3 } },
  loc_vars = function(self, info_queue, card)
    local num, denom = SMODS.get_probability_vars(card, 1, card.ability.extra.odds, "glassjoe")
    return { vars = { card.ability.extra.xmult, num, denom } }
  end,
  rarity = 1,
  atlas = 'PhantaMiscAnims4',
  pos = { x = 0, y = 5 },
  flipbook_anim_states = {
    first = {
      anim = {
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
      atlas = "phanta_PhantaMiscAnims4"
    },
    rematch = {
      anim = {
        { x = 0,  y = 1, t = 0.5 },
        { x = 1,  y = 1, t = 0.3 },
        { x = 2,  y = 1, t = 0.2 },
        { x = 3,  y = 1, t = 0.9 },
        { x = 4,  y = 1, t = 0.4 },
        { x = 5,  y = 1, t = 0.2 },
        { x = 6,  y = 1, t = 0.8 },
        { x = 7,  y = 1, t = 0.1 },
        { x = 8,  y = 1, t = 0.2 },
        { x = 9,  y = 1, t = 0.7 },
        { x = 10, y = 1, t = 0.3 },
        { x = 11, y = 1, t = 0.6 },
        { x = 0,  y = 2, t = 0.3 },
        { x = 1,  y = 2, t = 0.5 }
      },
      atlas = "phanta_PhantaMiscAnims7"
    }
  },
  flipbook_pos_extra = { x = 4, y = 6 },
  flipbook_anim_extra_states = {
    first = {
      anim = {
        { x = 4, y = 6, t = 8 / 30 },
        { x = 5, y = 6, t = 0.1 },
        { x = 6, y = 6, t = 1 / 30 },
        { x = 7, y = 6, t = 8 / 30 },
        { x = 8, y = 6, t = 0.1 },
        { x = 9, y = 6, t = 1 / 30 }
      },
      atlas = "phanta_PhantaMiscAnims4"
    },
    rematch = {
      anim = {
        { x = 6,  y = 0, t = 8 / 30 },
        { x = 7,  y = 0, t = 0.1 },
        { x = 8,  y = 0, t = 1 / 30 },
        { x = 9,  y = 0, t = 8 / 30 },
        { x = 10, y = 0, t = 0.1 },
        { x = 11, y = 0, t = 1 / 30 }
      },
      atlas = "phanta_PhantaMiscAnims7"
    }
  },
  flipbook_anim_initial_state = "first",
  flipbook_anim_extra_initial_state = "first",
  cost = 4,
  blueprint_compat = true,
  eternal_compat = false,
  perishable_compat = true,
  calculate = function(self, card, context)
    if context.joker_main then return { xmult = card.ability.extra.xmult } end
    if context.end_of_round and context.game_over == false and context.main_eval and not context.blueprint then
      if SMODS.pseudorandom_probability(card, "glassjoe", 1, card.ability.extra.odds) then
        G.GAME.phanta_glassjoe_odds = G.GAME.phanta_glassjoe_odds + 2
        card:shatter()
      else
        return { message = localize("k_safe_ex") }
      end
    end
  end,
  set_ability = function(self, card, initial, delay_sprites)
    if not G.GAME then return end
    if not G.GAME.phanta_glassjoe_odds then G.GAME.phanta_glassjoe_odds = 3 end
    card.ability.extra.odds = G.GAME.phanta_glassjoe_odds
    if G.GAME.phanta_glassjoe_odds > 3 then
      card:flipbook_set_anim_state("rematch")
      card:flipbook_set_anim_extra_state("rematch")
    else
      card:flipbook_set_anim_state("first")
      card:flipbook_set_anim_extra_state("first")
    end
  end,
  pronouns = "he_him"
}

G.Phanta.centers["snoinches"] = {
  rarity = 2,
  atlas = 'Phanta2',
  pos = { x = 11, y = 1 },
  cost = 5,
  blueprint_compat = false,
  eternal_compat = true,
  perishable_compat = true,
  set_badges = function(self, card, badges)
    badges[#badges + 1] = create_badge(localize('credit_bobisnotaperson'), G.C.PHANTA.MISC_COLOURS.PHANTA, G.C.WHITE, 1)
  end,
  pronouns = "it_its",
  hpot_unbreedable = true
}

-- Thanks, Berries and Honey!
local drpd_ref = G.FUNCS.draw_from_play_to_discard
G.FUNCS.draw_from_play_to_discard = function(e)
  if not next(SMODS.find_card("j_phanta_snoinches")) then return drpd_ref(e) end
  local it = 1
  local play_count = #G.play.cards
  local snoinches_handled = 0

  for i = 1, #G.play.cards do
    if not G.play.cards[i].shattered and not G.play.cards[i].destroyed then
      if snoinches_handled < #SMODS.find_card("j_phanta_snoinches") then
        snoinches_handled = snoinches_handled + 1
        draw_card(G.play, G.hand, it * 100 / play_count, "up", true, G.play.cards[i])
      else
        draw_card(G.play, G.discard, it * 100 / play_count, "down", false, v)
      end
      it = it + 1
    end
  end
end

G.Phanta.centers["astro"] = {
  config = { extra = { chips = 125 } },
  loc_vars = function(self, info_queue, card)
    return { vars = { card.ability.extra.chips } }
  end,
  rarity = 2,
  atlas = 'Phanta2',
  pos = { x = 11, y = 7 },
  cost = 7,
  blueprint_compat = true,
  eternal_compat = true,
  perishable_compat = true,
  calculate = function(self, card, context)
    if context.other_consumeable and context.other_consumeable.ability.set == "Planet" then
      return { chips = card.ability.extra.chips, message_card = context.other_consumeable }
    end
  end,
  pronouns = "he_him"
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
      play_sound("phanta_dougdimmadome_" .. G.PROFILES[G.SETTINGS.profile].phanta_dougdimmadomes_taken)
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
  end,
  pronouns = "he_him"
}

G.Phanta.centers["thetrick"] = {
  rarity = 2,
  atlas = 'Phanta2',
  pos = { x = 9, y = 4 },
  cost = 6,
  blueprint_compat = false,
  eternal_compat = true,
  perishable_compat = true,
  pronouns = "he_they"
}

G.Phanta.centers["stampedjoker"] = {
  rarity = 2,
  atlas = 'Phanta2',
  pos = { x = 11, y = 5 },
  cost = 7,
  blueprint_compat = false,
  eternal_compat = true,
  perishable_compat = true,
  pronouns = "she_they"
}

SMODS.Booster:take_ownership_by_kind('Standard', {
  create_card = function(self, card, i)
    local _edition = poll_edition('standard_edition' .. G.GAME.round_resets.ante, 2, true)
    local _seal = SMODS.poll_seal({ mod = 10, guaranteed = next(SMODS.find_card("j_phanta_stampedjoker")) and true })
    return { set = (pseudorandom(pseudoseed('stdset' .. G.GAME.round_resets.ante)) > 0.6) and "Enhanced" or "Base", edition = _edition, seal = _seal, area = G.pack_cards, skip_materialize = true, soulable = true, key_append = "sta" }
  end,
  loc_vars = pack_loc_vars,
})

G.Phanta.centers["doublingcube"] = {
  config = { extra = { xmult = 2 } },
  loc_vars = function(self, info_queue, card)
    return { vars = { card.ability.extra.xmult } }
  end,
  rarity = 2,
  atlas = "PhantaMiscAnims5",
  pos = { x = 0, y = 11 },
  flipbook_anim = {
    { xrange = { first = 0, last = 2 }, y = 11, t = 0.1 }
  },
  flipbook_pos_extra = { x = 3, y = 11 },
  flipbook_anim_extra = {
    { x = 3, y = 11, t = 0.075 },
    { x = 4, y = 11, t = 0.125 },
    { x = 5, y = 11, t = 0.175 },
    { x = 6, y = 11, t = 0.3 },
    { x = 5, y = 11, t = 0.175 },
    { x = 4, y = 11, t = 0.125 },
    { x = 3, y = 11, t = 0.075 },
    { x = 7, y = 11, t = 0.125 },
    { x = 8, y = 11, t = 0.175 },
    { x = 9, y = 11, t = 0.3 },
    { x = 8, y = 11, t = 0.175 },
    { x = 7, y = 11, t = 0.125 }
  },
  cost = 6,
  blueprint_compat = true,
  eternal_compat = true,
  perishable_compat = true,
  calculate = function(self, card, context)
    if context.joker_main then
      local contains_only_numbers = true
      for i = 1, #context.scoring_hand do
        if SMODS.has_no_rank(context.scoring_hand[i]) or context.scoring_hand[i]:is_face() or context.scoring_hand[i]:get_id() == 14 then
          contains_only_numbers = false
        end
      end
      if contains_only_numbers then return { xmult = card.ability.extra.xmult } end
    end
  end,
  pronouns = "it_its"
}

G.Phanta.centers["robojoker"] = {
  config = { extra = { odds = 8 } },
  rarity = 1,
  atlas = "PhantaMiscAnims6",
  pos = { x = 5, y = 4 },
  flipbook_anim = {
    { x = 5,                             y = 4, t = 1.5 },
    { xrange = { first = 6, last = 10 }, y = 4, t = 0.1 },
    { x = 11,                            y = 4, t = 0.3 },
    { xrange = { first = 0, last = 3 },  y = 5, t = 0.1 },
    { xrange = { first = 1, last = 0 },  y = 5, t = 0.2 },
    { xrange = { first = 0, last = 3 },  y = 5, t = 0.1 },
    { xrange = { first = 1, last = 0 },  y = 5, t = 0.2 },
    { xrange = { first = 0, last = 3 },  y = 5, t = 0.1 },
    { xrange = { first = 1, last = 0 },  y = 5, t = 0.2 },
    { xrange = { first = 10, last = 5 }, y = 4, t = 0.1 },
    { xrange = { first = 4, last = 5 },  y = 5, t = 0.1 },
    { x = 6,                             y = 5, t = 0.5 },
    { xrange = { first = 7, last = 11 }, y = 5, t = 0.1 },
    { xrange = { first = 0, last = 3 },  y = 6, t = 0.1 },
    { x = 6,                             y = 5, t = 0.5 },

    { x = 4,                             y = 6, t = 0.3 },
    { x = 6,                             y = 5, t = 0.2 },
    { x = 5,                             y = 6, t = 0.3 },
    { x = 6,                             y = 5, t = 0.2 },

    { x = 4,                             y = 6, t = 0.3 },
    { x = 6,                             y = 5, t = 0.2 },
    { x = 5,                             y = 6, t = 0.3 },
    { x = 6,                             y = 5, t = 0.2 },

    { x = 4,                             y = 6, t = 0.3 },
    { x = 6,                             y = 5, t = 0.2 },
    { x = 5,                             y = 6, t = 0.3 },
    { x = 6,                             y = 5, t = 0.2 },

    { x = 4,                             y = 6, t = 0.3 },
    { x = 6,                             y = 5, t = 0.2 },
    { x = 5,                             y = 6, t = 0.3 },
    { x = 6,                             y = 5, t = 0.2 },

    { x = 4,                             y = 6, t = 0.3 },
    { x = 6,                             y = 5, t = 0.2 },
    { x = 5,                             y = 6, t = 0.3 },
    { x = 6,                             y = 5, t = 0.2 },

    { x = 4,                             y = 6, t = 0.3 },
    { x = 6,                             y = 5, t = 0.2 },
    { x = 5,                             y = 6, t = 0.3 },
    { x = 6,                             y = 5, t = 0.2 },


    { xrange = { first = 6, last = 7 },  y = 6, t = 0.1 },
    { xrange = { first = 6, last = 7 },  y = 6, t = 0.15 },
    { xrange = { first = 5, last = 4 },  y = 5, t = 0.1 },
  },
  cost = 5,
  blueprint_compat = true,
  eternal_compat = true,
  perishable_compat = true,
  loc_vars = function(self, info_queue, card)
    local num, denom = SMODS.get_probability_vars(card, 1, card.ability.extra.odds, "robojoker")
    return { vars = { num, denom } }
  end,
  calculate = function(self, card, context)
    if context.individual and context.cardarea == G.play and context.other_card:get_id() < 10 and SMODS.pseudorandom_probability(card, "robojoker", 1, card.ability.extra.odds) then
      local _card = context.other_card
      G.E_MANAGER:add_event(Event({
        func = function()
          play_sound('tarot1')
          card:juice_up()
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
        delay = 0.1,
        func = function()
          assert(SMODS.modify_rank(_card, 1))
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
    end
  end,
  pronouns = "they_them"
}

G.Phanta.centers["magiceggcup"] = {
  config = { extra = { is_first = true } },
  rarity = 1,
  atlas = "PhantaMiscAnims4",
  pos = { x = 7, y = 10 },
  flipbook_pos_extra = { x = 0, y = 11 },
  flipbook_anim_states = {
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
  flipbook_anim_extra_states = {
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
  flipbook_anim_initial_state = "unknown",
  flipbook_anim_extra_initial_state = "resting",
  cost = 4,
  blueprint_compat = false,
  eternal_compat = true,
  perishable_compat = true,
  calculate = function(self, card, context)
    if context.individual and context.cardarea == "unscored" and not context.blueprint then
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

      local first_local = card.ability.extra.is_first
      card.ability.extra.is_first = false
      G.E_MANAGER:add_event(Event({
        func = function()
          play_sound('tarot1')
          card:juice_up()
          card:flipbook_set_anim_state(displayed_suit)
          card:flipbook_set_anim_extra_state(first_local and "lifting first" or "lifting middle")
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

    if context.after and not card.ability.extra.is_first and not context.blueprint then
      G.E_MANAGER:add_event(Event({
        blocking = false,
        func = function()
          card.ability.extra.is_first = true
          card:flipbook_set_anim_state("unknown")
          card:flipbook_set_anim_extra_state("lifting end")
          return true
        end
      }))
    end
  end,
  pronouns = "it_its"
}

G.Phanta.centers["doublelift"] = {
  config = { extra = { cards_to_draw = 2 } },
  loc_vars = function(self, info_queue, card)
    return {
      vars = { card.ability.extra.cards_to_draw },
    }
  end,
  rarity = 2,
  atlas = "Phanta2",
  pos = { x = 5, y = 3 },
  cost = 5,
  blueprint_compat = false,
  eternal_compat = true,
  perishable_compat = true,
  calculate = function(self, card, context)
    if context.pre_discard and not context.blueprint then
      card.ability.extra.primed = true
    end

    if context.drawing_cards and card.ability.extra.primed and not context.blueprint then
      card.ability.extra.primed = nil
      if G.hand.config.card_limit - #G.hand.cards <= card.ability.extra.cards_to_draw then
        return { cards_to_draw = card.ability.extra.cards_to_draw }
      end
    end
  end,
  pronouns = "it_its"
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
  perishable_compat = true,
  pronouns = "it_its"
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
  end,
  pronouns = "it_its"
}

G.Phanta.centers["birthdaycard"] = {
  config = { extra = { added_xmult = 0.75, current_xmult = 1 } },
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
  end,
  pronouns = "it_its"

  -- ADD EDITION GATE!!!!!!!!!! :triumph:
}

G.Phanta.centers["leprechaun"] = {
  config = { extra = { mult = 17 } },
  loc_vars = function(self, info_queue, card)
    return { vars = { card.ability.extra.mult } }
  end,
  rarity = 1,
  atlas = 'Phanta2',
  pos = { x = 8, y = 3 },
  cost = 5,
  blueprint_compat = true,
  eternal_compat = true,
  perishable_compat = true,
  calculate = function(self, card, context)
    if context.joker_main then
      for _, v in ipairs(G.hand.cards) do
        if v:get_id() == 7 then return { mult = card.ability.extra.mult } end
      end
    end
  end,
  pronouns = "he_him"
}

G.Phanta.centers["shamrock"] = {
  loc_vars = function(self, info_queue, card)
    info_queue[#info_queue + 1] = G.P_CENTERS.m_lucky
    return {}
  end,
  rarity = 2,
  atlas = 'Phanta2',
  pos = { x = 7, y = 3 },
  cost = 7,
  blueprint_compat = false,
  eternal_compat = true,
  perishable_compat = true,
  calculate = function(self, card, context)
    if context.individual and context.cardarea == G.play and SMODS.has_enhancement(context.other_card, "m_lucky")
        and not (context.other_card:is_suit("Clubs") and context.other_card:get_id() == 7) and not context.blueprint then
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
  end,
  enhancement_gate = "m_lucky",
  pronouns = "it_its"
}

G.Phanta.centers["manga"] = {
  rarity = 2,
  atlas = 'Phanta2',
  pos = { x = 0, y = 5 },
  cost = 6,
  blueprint_compat = false,
  eternal_compat = true,
  perishable_compat = true,
  calculate = function(self, card, context)
    if context.ending_shop and not context.blueprint then
      local converted_tarots = {}
      for _, v in ipairs(G.consumeables.cards) do
        if v.config.center.set == "Tarot" and not v.phanta_claimed_by_manga then
          v.phanta_claimed_by_manga = true
          converted_tarots[#converted_tarots + 1] = v
        end
      end

      if next(converted_tarots) then
        G.E_MANAGER:add_event(Event({
          trigger = 'after',
          delay = 0.4,
          func = function()
            play_sound('tarot1')
            card:juice_up()
            return true
          end
        }))
        for i = 1, #converted_tarots do
          local percent = 1.15 - (i - 0.999) / (#converted_tarots - 0.998) * 0.3
          G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0.15,
            func = function()
              converted_tarots[i]:flip(); play_sound('card1', percent); converted_tarots[i]:juice_up(0.3, 0.3); return true
            end
          }))
        end
        delay(0.2)
        for i = 1, #converted_tarots do
          G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0.1,
            func = function()
              converted_tarots[i]:set_ability(phanta_poll_pool("phanta_chaff", "manga")); return true
            end
          }))
        end
        for i = 1, #converted_tarots do
          local percent = 0.85 + (i - 0.999) / (#converted_tarots - 0.998) * 0.3
          G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0.15,
            func = function()
              converted_tarots[i]:flip(); play_sound('tarot2', percent, 0.6); converted_tarots[i]:juice_up(0.3, 0.3); return true
            end
          }))
        end
      end
    end
  end,
  in_pool = function()
    return Phanta.config["hanafuda_enabled"]
  end,
  pronouns = "she_they"
}

G.Phanta.centers["haringjoker"] = {
  config = { extra = { xmult = 1.2 } },
  loc_vars = function(self, info_queue, card)
    return { vars = { card.ability.extra.xmult } }
  end,
  rarity = 1,
  atlas = 'Phanta2',
  pos = { x = 2, y = 6 },
  cost = 5,
  blueprint_compat = true,
  eternal_compat = true,
  perishable_compat = true,
  calculate = function(self, card, context)
    if context.other_joker and card ~= context.other_joker and context.other_joker:is_rarity("Common") then
      return { xmult = card.ability.extra.xmult, message_card = context.other_joker }
    end
  end,
  pronouns = "he_they"
}

G.Phanta.centers["occultbanner"] = {
  rarity = 3,
  atlas = 'Phanta2',
  pos = { x = 0, y = 8 },
  cost = 8,
  blueprint_compat = false,
  eternal_compat = true,
  perishable_compat = true,
  calculate = function(self, card, context)
    if context.end_of_round and not context.blueprint and not context.individual and not context.repetition and G.GAME.current_round.discards_used == 0 then
      G.GAME.current_round.phanta_next_shop_spectral = true
      return { message = localize("k_phanta_success_ex"), colour = G.C.GREEN }
    end
  end,
  pronouns = "it_its"
}

G.Phanta.centers["ontherun"] = {
  config = { extra = { added_mult = 1, current_mult = 0 } },
  loc_vars = function(self, info_queue, card)
    return { vars = { card.ability.extra.added_mult, card.ability.extra.current_mult } }
  end,
  rarity = 1,
  atlas = 'Phanta2',
  pos = { x = 1, y = 8 },
  cost = 5,
  blueprint_compat = true,
  eternal_compat = true,
  perishable_compat = false,
  calculate = function(self, card, context)
    if context.joker_main and card.ability.extra.current_mult > 0 then return { mult = card.ability.extra.current_mult } end

    if context.before then
      if G.GAME.current_round.discards_left > 0 then
        if card.ability.extra.current_mult > 0 then
          card.ability.extra.current_mult = 0
          return { message = localize("k_reset"), colour = G.C.RED }
        end
      else
        card.ability.extra.current_mult = card.ability.extra.current_mult + card.ability.extra.added_mult
        return { message = localize("k_upgrade_ex") }
      end
    end
  end,
  pronouns = "she_they"
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
    if context.first_hand_drawn and not context.blueprint then
      local eval = function() return G.GAME.current_round.hands_played == 0 end
      juice_card_until(card, eval, true)
    end

    if context.before and G.GAME.current_round.hands_played == 0 and not context.blueprint then
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
  end,
  pronouns = "he_they"
}

G.Phanta.centers["maskofthephantom"] = {
  loc_vars = function(self, info_queue, card)
    info_queue[#info_queue + 1] = G.P_CENTERS.m_phanta_ghostcard
    return {}
  end,
  rarity = 2,
  atlas = 'Phanta2',
  pos = { x = 3, y = 6 },
  cost = 6,
  blueprint_compat = false,
  eternal_compat = true,
  perishable_compat = true,
  calculate = function(self, card, context)
    if context.individual and context.cardarea == "unscored" and context.other_card:is_face() and not SMODS.has_enhancement(context.other_card, "m_phanta_ghostcard") and not context.blueprint then
      local _card = context.other_card
      G.E_MANAGER:add_event(Event({
        func = function()
          _card:set_ability("m_phanta_ghostcard")
          _card:juice_up()
          return true
        end
      }))
      return { message = localize { key = "m_phanta_ghostcard", type = "name_text", set = "Enhanced" }, message_card = card }
    end
  end,
  pronouns = "it_its"
}

G.Phanta.centers["plugsocket"] = {
  config = { extra = { xmult = 0.4 } },
  loc_vars = function(self, info_queue, card)
    info_queue[#info_queue + 1] = G.P_CENTERS.m_phanta_coppergratefresh
    return { vars = { card.ability.extra.xmult, 1 + (#count_base_copper_grates() * card.ability.extra.xmult) } }
  end,
  rarity = 2,
  atlas = 'PhantaMiscAnims4',
  pos = { x = 0, y = 1 },
  flipbook_anim = {
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
  end,
  pronouns = "it_its"
}

G.Phanta.centers["mrbigmoneybags"] = {
  config = { extra = { xmult = 2 } },
  rarity = 2,
  atlas = 'Phanta2',
  pos = { x = 11, y = 2 },
  cost = 30,
  loc_vars = function(self, info_queue, card)
    return { vars = { card.ability.extra.xmult } }
  end,
  blueprint_compat = true,
  eternal_compat = true,
  perishable_compat = true,
  calculate = function(self, card, context)
    if context.joker_main then return { xmult = card.ability.extra.xmult } end
  end,
  in_pool = function(self, args)
    return not (args and (args.source ~= "buf" or args.source ~= "jud" or args.source ~= "iris_ribbon"))
  end,
  pronouns = "he_him"
}

G.Phanta.centers["neonjoker"] = {
  config = { extra = { xmult = 3 } },
  rarity = 2,
  atlas = 'Phanta2',
  pos = { x = 10, y = 0 },
  flipbook_anim = {
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
          local suit = G.hand.cards[i].ability.phanta_actual_suit or G.hand.cards[i].base.suit
          for j = 1, #counted_suits do
            if suit == counted_suits[j] then is_new = false end
          end
          if is_new then counted_suits[#counted_suits + 1] = suit end
        else
          wilds = wilds + 1
        end
      end

      if #counted_suits + wilds >= 3 then
        return { xmult = card.ability.extra.xmult }
      end
    end
  end,
  pronouns = "any_all"
}

G.Phanta.centers["technojoker"] = {
  config = { extra = { xmult = 0.5 } },
  loc_vars = function(self, info_queue, card)
    return { vars = { card.ability.extra.xmult, 1 + (count_missing_ranks() * card.ability.extra.xmult) } }
  end,
  rarity = 3,
  atlas = 'Phanta2',
  pos = { x = 1, y = 0 },
  flipbook_anim = { { x = 1, y = 0, t = 0.5 }, { x = 2, y = 0, t = 0.5 } },
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
  end,
  pronouns = "they_them"
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
  end,
  enhancement_gate = "m_glass",
  pronouns = "any_all"
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
  perishable_compat = true,
  pronouns = "he_they"
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

  ease_dollars(-G.Phanta.profile_cost)

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

  ease_dollars(-G.Phanta.profile_cost)

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

  ease_dollars(-G.Phanta.profile_cost)

  if G.OVERLAY_MENU then G.FUNCS.exit_overlay_menu() end
  G.SETTINGS.paused = true
  G.FUNCS.overlay_menu {
    definition = create_profile_more_menu()
  }
end

G.FUNCS.phanta_can_purchase_charm_tag = function(e)
  if G.GAME.dollars - G.Phanta.profile_cost < to_big(G.GAME.bankrupt_at) then
    e.config.colour = G.C.UI.BACKGROUND_INACTIVE
    e.config.button = nil
  end
end

G.FUNCS.phanta_can_purchase_meteor_tag = function(e)
  if G.GAME.dollars - G.Phanta.profile_cost < to_big(G.GAME.bankrupt_at) then
    e.config.colour = G.C.UI.BACKGROUND_INACTIVE
    e.config.button = nil
  end
end

G.FUNCS.phanta_can_purchase_ethereal_tag = function(e)
  if G.GAME.dollars - G.Phanta.profile_cost < to_big(G.GAME.bankrupt_at) then
    e.config.colour = G.C.UI.BACKGROUND_INACTIVE
    e.config.button = nil
  end
end

G.Phanta.centers["l"] = {
  unlocked = false,
  check_for_unlock = function(self, args)
    return args.type == "win_custom" and (G.GAME.phanta_number_of_unscored or 0) <= 4
  end,
  config = { extra = { xmult = 2 } },
  loc_vars = function(self, info_queue, card)
    return { vars = { card.ability.extra.xmult } }
  end,
  rarity = 2,
  atlas = 'Phanta2',
  pos = { x = 4, y = 4 },
  cost = 6,
  blueprint_compat = true,
  eternal_compat = true,
  perishable_compat = true,
  calculate = function(self, card, context)
    if context.joker_main then
      local _, _, _, scoring_hand, _ = G.FUNCS.get_poker_hand_info(G.play.cards)

      local always_scores_count = 0
      for _, card in pairs(G.play.cards) do
        if card.config.center.always_scores then always_scores_count = always_scores_count + 1 end
      end

      if #scoring_hand + always_scores_count >= #G.play.cards then
        return { xmult = card.ability.extra.xmult }
      end
    end
  end,
  pronouns = "he_him"
}

G.Phanta.centers["mello"] = {
  unlocked = false,
  check_for_unlock = function(self, args)
    return args.type == "phanta_ten_rerolls"
  end,
  config = { extra = { xmult = 0.1, dollar_threshold = 10 } },
  loc_vars = function(self, info_queue, card)
    return {
      vars = { card.ability.extra.xmult, card.ability.extra.dollar_threshold, 1 + (card.ability.extra.xmult *
        math.max(0, math.floor((G.GAME.dollars + (G.GAME.dollar_buffer or 0)) / card.ability.extra.dollar_threshold))) }
    }
  end,
  rarity = 2,
  atlas = 'PhantaMiscAnims6',
  pos = { x = 2, y = 9 },
  flipbook_anim = {
    { x = 2, y = 9, t = 1.1 }, { x = 3, y = 9, t = 0.1 },
    { x = 2, y = 9, t = 0.5 }, { x = 3, y = 9, t = 0.1 },
    { x = 2, y = 9, t = 2.1 }, { x = 3, y = 9, t = 0.1 },
    { x = 2, y = 9, t = 1.4 }, { x = 3, y = 9, t = 0.1 },
    { x = 2, y = 9, t = 1.8 }, { x = 3, y = 9, t = 0.1 },
    { x = 4, y = 9, t = 0.1 }, { x = 5, y = 9, t = 0.15 }, { x = 6, y = 9, t = 0.2 },
    { x = 7, y = 9, t = 0.6 }, { x = 8, y = 9, t = 0.2 },
    { x = 9, y = 9, t = 0.2 }, { x = 10, y = 9, t = 0.15 }, { x = 11, y = 9, t = 0.05 }, { x = 0, y = 10, t = 0.05 },
    { x = 2,                            y = 10, t = 0.2 },
    { xrange = { first = 1, last = 2 }, y = 10, t = 0.2 },
    { xrange = { first = 1, last = 2 }, y = 10, t = 0.2 },
    { xrange = { first = 1, last = 2 }, y = 10, t = 0.2 },
    { xrange = { first = 1, last = 2 }, y = 10, t = 0.2 },
    { x = 1,                            y = 10, t = 0.1 }, { x = 3, y = 10, t = 0.2 }
  },
  cost = 6,
  blueprint_compat = true,
  eternal_compat = true,
  perishable_compat = true,
  calculate = function(self, card, context)
    if context.joker_main and G.GAME.dollars + (G.GAME.dollar_buffer or 0) >= card.ability.extra.dollar_threshold then
      return {
        xmult = 1 + (card.ability.extra.xmult *
          math.max(0, math.floor((G.GAME.dollars + (G.GAME.dollar_buffer or 0)) / card.ability.extra.dollar_threshold)))
      }
    end
  end,
  pronouns = "he_him"
}

G.Phanta.centers["near"] = {
  unlocked = false,
  check_for_unlock = function(self, args)
    return args.type == "phanta_five_marbles"
  end,
  config = { extra = { xmult = 2 } },
  loc_vars = function(self, info_queue, card)
    return { vars = { card.ability.extra.xmult } }
  end,
  rarity = 2,
  atlas = 'Phanta2',
  pos = { x = 3, y = 4 },
  cost = 6,
  blueprint_compat = true,
  eternal_compat = true,
  perishable_compat = true,
  calculate = function(self, card, context)
    if context.joker_main and G.jokers.cards[1] == card then
      return { xmult = card.ability.extra.xmult }
    end
  end,
  pronouns = "he_him"
}

G.Phanta.centers["deathnote"] = {
  unlocked = false,
  check_for_unlock = function(self, args)
    return args.type == "phanta_four_cards_remaining"
  end,
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
  perishable_compat = true,
  pronouns = "it_its"
}

G.Phanta.centers["cataclysm"] = {
  loc_vars = function(self, info_queue, card)
    local card1 = card.ability and card.ability.extra and card.ability.extra.card1 and
        card.ability.extra.card1 ~= "" and card.ability.extra.card1
    local card2 = card.ability and card.ability.extra and card.ability.extra.card2 and
        card.ability.extra.card2 ~= "" and card.ability.extra.card2
    return { vars = { ((card1 or card2) and (card1 and localize { set = "Planet", type = "name_text", key = card1 } or localize("phanta_none")) .. ", " .. (card2 and localize { set = "Planet", type = "name_text", key = card2 } or localize("phanta_none"))) or localize("phanta_cataclysm_no_planet") } }
  end,
  rarity = 2,
  atlas = 'PhantaMiscAnims7',
  pos = { x = 3, y = 7 },
  flipbook_pos_extra = {
    chunka = { x = 3, y = 6 }, -- bg
    chunkb = { x = 6, y = 6 },
    chunkc = { x = 9, y = 6 },
    chunkd = { x = 0, y = 7 },

    chunke = { x = 9, y = 5 }, -- mg
    chunkf = { x = 0, y = 6 },

    chunkg = { x = 0, y = 5 }, -- fg
    chunkh = { x = 3, y = 5 },
    chunki = { x = 6, y = 5 },

    console = { x = 6, y = 7 },

    buttona = { x = 0, y = 4 },
    buttonb = { x = 2, y = 4 },
    buttonc = { x = 4, y = 4 },
    buttond = { x = 6, y = 4 },
    buttone = { x = 8, y = 4 },
    buttonf = { x = 10, y = 4 },

    screena = { x = 5, y = 2 },
    screenb = { x = 0, y = 3 },

    shock = { x = 2, y = 2 }
  },
  flipbook_pos_extra_order = {
    "chunka", "chunkb", "chunkc", "chunkd",
    "chunke", "chunkf",
    "chunkg", "chunkh", "chunki",

    "console",
    "buttona", "buttonb", "buttonc", "buttond", "buttone", "buttonf",
    "screena", "screenb",
    "shock"
  },
  flipbook_anim = {
    { xrange = { first = 3, last = 5 }, y = 7, trandomrange = { first = 0.5, last = 1 } }
  },
  flipbook_anim_extra = {
    shock = { { xrange = { first = 2, last = 4 }, y = 2, t = 0.15 } },

    screena = {
      { x = 5,                             y = 2, t = 0.3 },
      { x = 6,                             y = 2, t = 0.1 },
      { x = 5,                             y = 2, t = 1.2 },
      { x = 6,                             y = 2, t = 0.1 },
      { x = 5,                             y = 2, t = 0.2 },
      { x = 6,                             y = 2, t = 0.1 },
      { x = 5,                             y = 2, t = 0.5 },
      { xrange = { first = 7, last = 10 }, y = 2, t = 0.1 },
      { x = 11,                            y = 2, t = 5 },
    },

    screenb = {
      { x = 0,                             y = 3, t = 0.5 },
      { x = 1,                             y = 3, t = 0.1 },
      { x = 0,                             y = 3, t = 1.8 },
      { x = 2,                             y = 3, t = 0.1 },
      { x = 0,                             y = 3, t = 3.3 },
      { x = 2,                             y = 3, t = 0.1 },
      { x = 0,                             y = 3, t = 0.4 },
      { x = 1,                             y = 3, t = 0.1 },
      { x = 0,                             y = 3, t = 0.1 },
      { x = 2,                             y = 3, t = 0.1 },
      { x = 0,                             y = 3, t = 1.6 },
      { xrange = { first = 3, last = 4 },  y = 3, t = 0.1 },
      { x = 5,                             y = 3, t = 3 },
      { xrange = { first = 6, last = 10 }, y = 3, t = 0.1 },
      { x = 11,                            y = 3, t = 3 },
    },



    buttona = { { xrange = { first = 0, last = 1 }, y = 4, trandomrange = { first = 0.5, last = 0.8 } } },
    buttonb = { { xrange = { first = 2, last = 3 }, y = 4, trandomrange = { first = 0.5, last = 0.8 } } },
    buttonc = { { xrange = { first = 4, last = 5 }, y = 4, trandomrange = { first = 0.5, last = 0.8 } } },
    buttond = { { xrange = { first = 6, last = 7 }, y = 4, trandomrange = { first = 0.5, last = 0.8 } } },
    buttone = { { xrange = { first = 8, last = 9 }, y = 4, trandomrange = { first = 0.5, last = 0.8 } } },
    buttonf = { { xrange = { first = 10, last = 11 }, y = 4, trandomrange = { first = 0.5, last = 0.8 } } },

    console = {
      { x = 6,                              y = 7, t = 0.2 },
      { xrange = { first = 7, last = 8 },   y = 7, t = 0.05 },
      { x = 9,                              y = 7, t = 0.2 },
      { xrange = { first = 10, last = 11 }, y = 7, t = 0.05 }
    },



    chunka = { { xrange = { first = 3, last = 5 }, y = 6, trandomrange = { first = 5, last = 20 } } },
    chunkb = { { xrange = { first = 6, last = 8 }, y = 6, trandomrange = { first = 5, last = 20 } } },
    chunkc = { { xrange = { first = 9, last = 11 }, y = 6, trandomrange = { first = 5, last = 20 } } },
    chunkd = { { xrange = { first = 0, last = 2 }, y = 7, trandomrange = { first = 5, last = 20 } } },
    chunke = { { xrange = { first = 9, last = 11 }, y = 5, trandomrange = { first = 5, last = 20 } } },
    chunkf = { { xrange = { first = 0, last = 2 }, y = 6, trandomrange = { first = 5, last = 20 } } },
    chunkg = { { xrange = { first = 0, last = 2 }, y = 5, trandomrange = { first = 5, last = 20 } } },
    chunkh = { { xrange = { first = 3, last = 5 }, y = 5, trandomrange = { first = 5, last = 20 } } },
    chunki = { { xrange = { first = 6, last = 8 }, y = 5, trandomrange = { first = 5, last = 20 } } }
  },
  cost = 7,
  blueprint_compat = false,
  eternal_compat = true,
  perishable_compat = true,
  pronouns = "any_all"
}

G.Phanta.centers["doodah"] = {
  unlocked = false,
  check_for_unlock = function(self, args)
    return args.type == "phanta_played_and_held_blue"
  end,
  rarity = 3,
  atlas = 'Phanta2',
  pos = { x = 10, y = 4 },
  cost = 8,
  blueprint_compat = true,
  eternal_compat = true,
  perishable_compat = true,
  calculate = function(self, card, context)
    if context.reroll_shop and count_consumables() < G.consumeables.config.card_limit then
      G.GAME.consumeable_buffer = G.GAME.consumeable_buffer + 1
      G.E_MANAGER:add_event(Event({
        delay = 0.3,
        blockable = false,
        func = function()
          play_sound("timpani")
          local new_card = create_card("Planet", G.consumables, nil, nil, nil, nil, nil, "doodah")
          new_card:add_to_deck()
          G.consumeables:emplace(new_card)
          G.GAME.consumeable_buffer = 0
          new_card:juice_up(0.3, 0.5)
          return true
        end
      }))
      return {
        message = localize { type = 'variable', key = 'a_planet', vars = { 1 } },
        colour = G.C.SECONDARY_SET.Planet
      }
    end
  end,
  pronouns = "it_its"
}
