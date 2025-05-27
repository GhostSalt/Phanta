-- For rendering shaders on the souls

local scale_mod = 0.07 + 0.02 * math.sin(1.8 * G.TIMERS.REAL) +
    0.00 * math.sin((G.TIMERS.REAL - math.floor(G.TIMERS.REAL)) * math.pi * 14) *
    (1 - (G.TIMERS.REAL - math.floor(G.TIMERS.REAL))) ^ 3
local rotate_mod = 0.05 * math.sin(1.219 * G.TIMERS.REAL) +
    0.00 * math.sin((G.TIMERS.REAL) * math.pi * 5) * (1 - (G.TIMERS.REAL - math.floor(G.TIMERS.REAL))) ^ 2

SMODS.current_mod.optional_features = { cardareas = { unscored = true } }

to_big = to_big or function(x) return x end

SMODS.Atlas {
  key = "modicon",
  path = "PhantaIcon.png",
  px = 34,
  py = 34
}

SMODS.Atlas {
  key = "Phanta",
  path = "Phanta.png",
  px = 71,
  py = 95
}

SMODS.Atlas {
  key = "PhantaEnhancements",
  path = "PhantaEnhancements.png",
  px = 71,
  py = 95
}

SMODS.Atlas {
  key = "PhantaTarots",
  path = "PhantaTarots.png",
  px = 71,
  py = 95
}

SMODS.Atlas {
  key = "PhantaTags",
  path = "PhantaTags.png",
  px = 34,
  py = 34
}

G.C.PHANTA = {
  Zodiac = HEX("4E5779"),
  ZodiacAlt = HEX("5998ff")
}

G.C.PHANTA.MISC_COLOURS = {
  COPPER_FRESH = HEX("904931"),
  COPPER_EXPOSED = HEX("A77762"),
  COPPER_WEATHERED = HEX("838A67"),
  COPPER_OXIDISED = HEX("4FAB90")
}

local loc_colour_ref = loc_colour

function loc_colour(_c, default)
  if not G.ARGS.LOC_COLOURS then
    loc_colour_ref(_c, default)
  elseif not G.ARGS.LOC_COLOURS.phanta_colours then
    G.ARGS.LOC_COLOURS.phanta_colours = true

    local new_colors = {
      copper_fresh = G.C.COPPER_FRESH,
      copper_exposed = G.C.COPPER_EXPOSED,
      copper_weathered = G.C.COPPER_WEATHERED,
      copper_oxidised = G.C.COPPER_OXIDISED
    }

    for k, v in pairs(new_colors) do
      G.ARGS.LOC_COLOURS[k] = v
    end
  end

  return loc_colour_ref(_c, default)
end

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

function get_lowest(hand)
  local lowest = nil
  for k, v in ipairs(hand) do
    if not lowest or v:get_nominal() < lowest:get_nominal() then
      lowest = v
    end
  end
  if #hand > 0 then return { { lowest } } else return {} end
end

function count_prognosticators()
  return #SMODS.find_card("j_phanta_prognosticator") + (G.GAME and G.GAME.selected_back and G.GAME.selected_back and G.GAME.selected_back.effect and G.GAME.selected_back.effect.center.key == "b_phanta_todayandtomorrow" and 1 or 0)
end

function count_lucky_cards()
  local lucky_counter = 0
  if G.playing_cards then
    for _, card in pairs(G.playing_cards) do
      if SMODS.has_enhancement(card, "m_lucky") then
        lucky_counter = lucky_counter + 1
      end
    end
  end
  return lucky_counter
end

function get_previous_blind()
  if G.GAME.last_blind then
    if G.GAME.last_blind.boss then
      return "boss"
    elseif G.GAME.last_blind.big then
      return "big"
    end
  else
    return "small"
  end
end

SMODS.PokerHand {
  key = "junk",
  chips = 5,
  mult = 2,
  l_chips = 20,
  l_mult = 1,
  visible = false,
  above_hand = "High Card",
  example = {
    { 'C_A', false },
    { 'H_Q', false },
    { 'H_6', false },
    { 'C_3', false },
    { 'S_2', true }
  },
  evaluate = function(parts, hand)
    local lowest = get_lowest(hand)
    if next(lowest) and #hand >= 5 then return lowest else return {} end
  end
}

SMODS.Consumable {
  set = "Planet",
  key = "rubbish",
  pos = { x = 0, y = 2 },
  config = {
    hand_type = "phanta_junk",
    softlock = true
  },
  atlas = "PhantaTarots",
  loc_vars = function(self, info_queue, center)
    return {
      vars = {
        G.GAME.hands["phanta_junk"].level,
        localize("phanta_junk"),
        G.GAME.hands["phanta_junk"].l_mult,
        G.GAME.hands["phanta_junk"].l_chips,
        colours = { (to_big(G.GAME.hands["phanta_junk"].level) == to_big(1) and G.C.UI.TEXT_DARK or G.C.HAND_LEVELS[math.min(7, G.GAME.hands["phanta_junk"].level)]) }
      }
    }
  end
}

SMODS.PokerHand:take_ownership('High Card', {
  example = {
    { 'S_A', true },
    { 'D_Q', false },
    { 'D_9', false },
    { 'C_4', false },
  },
}, true)

SMODS.Enhancement {
  key = "ghostcard",
  atlas = "PhantaEnhancements",
  pos = { x = 0, y = 0 },
  config = { h_x_mult = 1, extra = { added_xmult = 0.25 } },
  loc_vars = function(self, info_queue, center)
    return { vars = { center.ability.h_x_mult, center.ability.extra.added_xmult } }
  end,
  calculate = function(self, card, context)
    if context.cardarea == "unscored" and context.main_scoring then
      card.ability.h_x_mult = card.ability.h_x_mult + card.ability.extra.added_xmult
      card_eval_status_text(card, 'extra', nil, nil, nil, { message = localize('k_upgrade_ex') })
    end
  end
}

SMODS.Seal {
  key = "ghostseal",
  loc_txt = {
    name = 'Ghost Seal',
    text = {
      "Creates a {C:spectral}Spectral{} card",
      "if played and not scored",
      "on {C:attention}final hand{} of round",
      "{C:inactive}(Must have room){}"
    }
  },
  badge_colour = HEX("cccccc"),
  atlas = "PhantaEnhancements",
  pos = { x = 1, y = 0 },

  calculate = function(self, card, context)
    if context.cardarea == "unscored" and context.main_scoring and G.GAME.current_round.hands_left == 0 and #G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit then
      G.E_MANAGER:add_event(Event({
        func = function()
          if G.consumeables.config.card_limit > #G.consumeables.cards then
            local new_card = create_card("Spectral", G.consumeables, nil, nil, nil, nil, nil, "ghostseal")
            new_card:add_to_deck()
            G.consumeables:emplace(new_card)
            card:juice_up()
          end
          return true
        end
      }))
    end
  end
}

SMODS.Consumable {
  set = "Tarot",
  key = "grave",
  loc_txt = {
    name = 'Grave',
    text = {
      "Enhances {C:attention}#1#{}",
      "selected card into a",
      "{C:attention}Ghost Card{}"
    }
  },
  pos = { x = 0, y = 0 },
  config = {
    mod_conv = "m_phanta_ghostcard",
    max_highlighted = 1
  },
  atlas = "PhantaTarots",
  loc_vars = function(self, info_queue, card)
    info_queue[#info_queue + 1] = G.P_CENTERS.m_phanta_ghostcard
    return { vars = { card.ability.max_highlighted } }
  end
}

SMODS.Consumable {
  set = "Spectral",
  key = "jinn",
  loc_txt = {
    name = 'Jinn',
    text = {
      "Add a {C:attention}Ghost Seal{}",
      "to {C:attention}1{} selected",
      "card held in hand"
    }
  },
  pos = { x = 1, y = 0 },
  config = {
    mod_conv = "phanta_ghost_seal",
    max_highlighted = 1
  },
  atlas = "PhantaTarots",
  loc_vars = function(self, info_queue, card)
    info_queue[#info_queue + 1] = { set = "Other", key = "phanta_ghostseal_seal" }
    return { vars = { card.ability.max_highlighted } }
  end,
  use = function(self, card, area, copier)
    local conv_card = G.hand.highlighted[1]
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
        conv_card:set_seal("phanta_ghostseal", nil, true)
        return true
      end
    }))

    delay(0.5)
    G.E_MANAGER:add_event(Event({
      trigger = 'after',
      delay = 0.2,
      func = function()
        G.hand:unhighlight_all()
        return true
      end
    }))
  end
}

SMODS.Consumable {
  set = "Spectral",
  key = "shard",
  loc_txt = {
    name = 'Shard',
    text = {
      "Creates the last",
      "{C:spectral}Spectral{} card used",
      "during this run",
      "{s:0.8,C:spectral}Shard{s:0.8} excluded"
    }
  },
  pos = { x = 2, y = 0 },
  atlas = "PhantaTarots",
  loc_vars = function(self, info_queue, card)
    local shard_card = G.GAME.last_spectral and G.P_CENTERS[G.GAME.last_spectral] or nil
    return {
      main_end = {
        {
          n = G.UIT.C,
          config = { align = "bm", padding = 0.02 },
          nodes = {
            {
              n = G.UIT.C,
              config = { align = "m", colour = ((not shard_card or shard_card.key == 'c_phanta_shard') and G.C.RED or G.C.GREEN), r = 0.05, padding = 0.05 },
              nodes = {
                { n = G.UIT.T, config = { text = ' ' .. (shard_card and localize { type = 'name_text', key = shard_card.key, set = shard_card.set } or localize('k_none')) .. ' ', colour = G.C.UI.TEXT_LIGHT, scale = 0.3, shadow = true } },
              }
            }
          }
        }
      }
    }
  end,
  can_use = function(self, card)
    return G.consumeables.config.card_limit >= #G.consumeables.cards and G.GAME.last_spectral ~= nil and
        G.GAME.last_spectral ~= "c_phanta_shard"
  end,
  use = function(self, card, area, copier)
    G.E_MANAGER:add_event(Event({
      trigger = 'after',
      delay = 0.4,
      func = function()
        if G.consumeables.config.card_limit > #G.consumeables.cards then
          play_sound('timpani')
          local new_card = create_card('Spectral', G.consumeables, nil, nil, nil, nil, G.GAME.last_spectral, 'shard')
          new_card:add_to_deck()
          G.consumeables:emplace(new_card)
          card:juice_up(0.3, 0.5)
        end
        return true
      end
    }))
    delay(0.6)
  end,
  in_pool = function()
    return G.GAME.selected_back.effect.center.key == "b_phanta_azran"
  end
}

SMODS.Consumable {
  set = "Spectral",
  key = "orbit",
  loc_txt = {
    name = 'Orbit',
    text = {
      "Upgrade your",
      "most played",
      "{C:attention}poker hand{}",
      "{C:attention}#1#{} times"
    }
  },
  pos = { x = 0, y = 1 },
  config = { extra = { no_of_upgrades = 3 } },
  atlas = "PhantaTarots",
  loc_vars = function(self, info_queue, card)
    return { vars = { card.ability.extra.no_of_upgrades } }
  end,
  can_use = function(self, card)
    return true
  end,
  use = function(self, card, area, copier)
    local hand_groupings, _tally = {}, 0, 0
    for k, v in pairs(G.GAME.hands) do
      if v.visible and v.played >= _tally then
        hand_groupings[#hand_groupings + 1] = { hand = v, hand_name = k }
        _tally = v.played
      end
    end

    local candidates = {}
    for _, v in pairs(hand_groupings) do
      if v.hand.played == _tally then candidates[#candidates + 1] = v end
    end

    chosen_group = pseudorandom_element(candidates, pseudoseed('orbit'))

    update_hand_text({ sound = 'button', volume = 0.7, pitch = 0.8, delay = 0.3 },
      {
        handname = localize(chosen_group.hand_name, 'poker_hands'),
        chips = chosen_group.hand.chips,
        mult = chosen_group
            .hand.mult,
        level = chosen_group.hand.level
      })
    level_up_hand(card, chosen_group.hand_name, false, card.ability.extra.no_of_upgrades)
    update_hand_text({ sound = 'button', volume = 0.7, pitch = 1.1, delay = 0 },
      { mult = 0, chips = 0, handname = '', level = '' })

    delay(0.6)
  end,
  in_pool = function()
    return G.GAME.selected_back.effect.center.key == "b_phanta_azran"
  end
}

SMODS.Consumable {
  set = "Spectral",
  key = "norwellwall",
  loc_txt = {
    name = 'Norwell Wall',
    text = {
      "Permanently gain",
      "{C:attention}+#1#{} hand size"
    }
  },
  pos = { x = 1, y = 1 },
  config = { extra = { added_hand_size = 1 } },
  atlas = "PhantaTarots",
  loc_vars = function(self, info_queue, card)
    return { vars = { card.ability.extra.added_hand_size } }
  end,
  can_use = function(self, card)
    return true
  end,
  use = function(self, card, area, copier)
    G.E_MANAGER:add_event(Event({
      trigger = 'after',
      delay = 0.4,
      func = function()
        play_sound('timpani')
        card:juice_up()
        G.hand:change_size(card.ability.extra.added_hand_size)
        return true
      end
    }))
    delay(0.6)
  end,
  in_pool = function()
    return G.GAME.selected_back.effect.center.key == "b_phanta_azran"
  end
}

SMODS.Consumable {
  object_type = "Consumable",
  set = "Spectral",
  key = "follower",
  loc_txt = {
    name = 'Follower',
    text = {
      "{C:attention}+#1#{} card slot",
      "available in shop"
    }
  },
  pos = { x = 2, y = 1 },
  config = { extra = { added_shop_slots = 1 } },
  atlas = "PhantaTarots",
  loc_vars = function(self, info_queue, card)
    return { vars = { card.ability.extra.added_shop_slots } }
  end,
  can_use = function(self, card)
    return true
  end,
  use = function(self, card, area, copier)
    G.E_MANAGER:add_event(Event({
      trigger = 'after',
      delay = 0.4,
      func = function()
        play_sound('timpani')
        card:juice_up()
        change_shop_size(card.ability.extra.added_shop_slots)
        return true
      end
    }))
    delay(0.6)
  end,
  in_pool = function()
    return G.GAME.selected_back.effect.center.key == "b_phanta_azran"
  end
}

SMODS.Consumable {
  object_type = "Consumable",
  set = "Spectral",
  key = "timeline",
  loc_txt = {
    name = 'Timeline',
    text = {
      "{C:attention}-#1#{} Ante,",
      "{C:attention}-#2#{} hand size"
    }
  },
  pos = { x = 3, y = 1 },
  config = { extra = { minus_antes = 1 } },
  atlas = "PhantaTarots",
  loc_vars = function(self, info_queue, card)
    return { vars = { card.ability.extra.minus_antes, G.GAME.phanta_timeline_minus_hand_size or 1 } }
  end,
  can_use = function(self, card)
    return true
  end,
  use = function(self, card, area, copier)
    G.E_MANAGER:add_event(Event({
      trigger = 'after',
      delay = 0.4,
      func = function()
        card:juice_up()
        ease_ante(-card.ability.extra.minus_antes)

        G.GAME.phanta_timeline_minus_hand_size = G.GAME.phanta_timeline_minus_hand_size or 1
        G.hand:change_size(-G.GAME.phanta_timeline_minus_hand_size)
        G.GAME.phanta_timeline_minus_hand_size = G.GAME.phanta_timeline_minus_hand_size + 1
        return true
      end
    }))
    delay(0.6)
  end,
  in_pool = function()
    return G.GAME.selected_back.effect.center.key == "b_phanta_azran"
  end
}






--[[SMODS.Shader {
  key = "waxed",
  path = "waxed.fs"
}

SMODS.Sound({
  key = "waxed_card",
  path = "phanta_waxed_card.ogg",
  replace = true
})

SMODS.Edition {
  key = 'waxed',
  shader = 'waxed',
  in_shop = true,
  sound = { sound = "phanta_waxed_card", per = 1, vol = 0.5 },
  weight = 20,
  badge_colour = HEX('C2B482'),
  extra_cost = 1,
  get_weight = function(self)
    return G.GAME.edition_rate * self.weight
  end,
  config = { xmult = 1.1 },
  loc_vars = function(self, info_queue)
    return { vars = { self.config.xmult } }
  end,
  calculate = function(self, card, context)
    if context.main_scoring and context.cardarea == G.play then return { xmult = self.config.xmult } end
  end,
  in_pool = function(v) return v.source == "standard_edition" end
}]] --





--[[
SMODS.Enhancement {
  key = "coppergratefresh",
  atlas = "PhantaEnhancements",
  pos = { x = 0, y = 1 },
  config = { Xmult = 2 },
  loc_vars = function(self, info_queue, center)
    return { vars = { center.ability.Xmult } }
  end,
  calculate = function(self, card, context)
    if context.destroy_card and context.cardarea == G.play and not (card.edition and card.edition.key == 'e_phanta_waxed') then
      card:set_ability(G.P_CENTERS.m_phanta_coppergrateexposed, nil, true)
      return false
    end
  end,
  set_badges = function(self, card, badges)
    badges[#badges + 1] = create_badge(localize('phanta_copper_grate_fresh'), G.C.PHANTA.MISC_COLOURS.COPPER_FRESH,
      G.C.WHITE, 1)
  end
}

SMODS.Enhancement {
  key = "coppergrateexposed",
  atlas = "PhantaEnhancements",
  pos = { x = 1, y = 1 },
  config = { Xmult = 1.5, bonus = 15 },
  loc_vars = function(self, info_queue, center)
    return { vars = { center.ability.Xmult, center.ability.bonus } }
  end,
  calculate = function(self, card, context)
    if context.destroy_card and context.cardarea == G.play and not (card.edition and card.edition.key == 'e_phanta_waxed') then
      card:set_ability(G.P_CENTERS.m_phanta_coppergrateweathered, nil, true)
      return false
    end
  end,
  set_badges = function(self, card, badges)
    badges[#badges + 1] = create_badge(localize('phanta_copper_grate_exposed'), G.C.PHANTA.MISC_COLOURS.COPPER_EXPOSED,
      G.C.WHITE, 1)
  end,
  in_pool = function() return false end
}

SMODS.Enhancement {
  key = "coppergrateweathered",
  atlas = "PhantaEnhancements",
  pos = { x = 0, y = 2 },
  config = { Xmult = 1.25, bonus = 30 },
  loc_vars = function(self, info_queue, center)
    return { vars = { center.ability.Xmult, center.ability.bonus } }
  end,
  calculate = function(self, card, context)
    if context.destroy_card and context.cardarea == G.play and not (card.edition and card.edition.key == 'e_phanta_waxed') then
      card:set_ability(G.P_CENTERS.m_phanta_coppergrateoxidised, nil, true)
      return false
    end
  end,
  set_badges = function(self, card, badges)
    badges[#badges + 1] = create_badge(localize('phanta_copper_grate_weathered'),
      G.C.PHANTA.MISC_COLOURS.COPPER_WEATHERED,
      G.C.WHITE, 1)
  end,
  in_pool = function() return false end
}

SMODS.Enhancement {
  key = "coppergrateoxidised",
  atlas = "PhantaEnhancements",
  pos = { x = 1, y = 2 },
  config = { bonus = 50 },
  loc_vars = function(self, info_queue, center)
    return { vars = { center.ability.bonus } }
  end,
  calculate = function(self, card, context)
    if context.destroy_card and context.cardarea == G.play and not (card.edition and card.edition.key == 'e_phanta_waxed') then return { remove = true } end
  end,
  set_badges = function(self, card, badges)
    badges[#badges + 1] = create_badge(localize('phanta_copper_grate_oxidised'), G.C.PHANTA.MISC_COLOURS.COPPER_OXIDISED,
      G.C.WHITE, 1)
  end,
  in_pool = function() return false end
}
]] --







local sell_use_ref = G.UIDEF.use_and_sell_buttons

function G.UIDEF.use_and_sell_buttons(card)
  if not card or not card.ability or card.ability.set ~= "phanta_Zodiac" then return sell_use_ref(card) end

  if (card.area == G.pack_cards and G.pack_cards) then
    return {
      n = G.UIT.ROOT,
      config = { padding = 0, colour = G.C.CLEAR },
      nodes = {
        {
          n = G.UIT.R,
          config = { ref_table = card, r = 0.08, padding = 0.1, align = "bm", minw = 0.5 * card.T.w - 0.15, maxw = 0.9 * card.T.w - 0.15, minh = 0.3 * card.T.h, hover = true, shadow = true, colour = G.C.UI.BACKGROUND_INACTIVE, one_press = true, button = 'use_card', func = 'can_select_card' },
          nodes = {
            { n = G.UIT.T, config = { text = localize('b_select'), colour = G.C.UI.TEXT_LIGHT, scale = 0.45, shadow = true } }
          }
        },
      }
    }
  end

  local sell = {
    n = G.UIT.C,
    config = { align = "cr" },
    nodes = {
      {
        n = G.UIT.C,
        config = { ref_table = card, align = "cr", padding = 0.1, r = 0.08, minw = 1.25, hover = true, shadow = true, colour = G.C.UI.BACKGROUND_INACTIVE, one_press = true, button = 'sell_card', func = 'can_sell_card' },
        nodes = {
          { n = G.UIT.B, config = { w = 0.1, h = 0.6 } },
          {
            n = G.UIT.C,
            config = { align = "tm" },
            nodes = {
              {
                n = G.UIT.R,
                config = { align = "cm", maxw = 1.25 },
                nodes = {
                  { n = G.UIT.T, config = { text = localize('b_sell'), colour = G.C.UI.TEXT_LIGHT, scale = 0.4, shadow = true } }
                }
              },
              {
                n = G.UIT.R,
                config = { align = "cm" },
                nodes = {
                  { n = G.UIT.T, config = { text = localize('$'), colour = G.C.WHITE, scale = 0.4, shadow = true } },
                  { n = G.UIT.T, config = { ref_table = card, ref_value = 'sell_cost_label', colour = G.C.WHITE, scale = 0.55, shadow = true } }
                }
              }
            }
          }
        }
      },
    }
  }

  local t = {
    n = G.UIT.ROOT,
    config = { padding = 0, colour = G.C.CLEAR },
    nodes = {
      {
        n = G.UIT.C,
        config = { padding = 0.15, align = 'cl' },
        nodes = {
          {
            n = G.UIT.R,
            config = { align = 'cl' },
            nodes = {
              sell
            }
          }
        }
      },
    }
  }
  return t
end

local can_select_card_ref = G.FUNCS.can_select_card
G.FUNCS.can_select_card = function(e)
    local card = e.config.ref_table
    if card.ability.set == 'phanta_Zodiac' then
        if #G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit then
            e.config.colour = G.C.GREEN
            e.config.button = 'use_card'
        else
            e.config.colour = G.C.UI.BACKGROUND_INACTIVE
            e.config.button = nil
        end
    else
        can_select_card_ref(e)
    end
end

SMODS.Atlas {
  key = "PhantaZodiacs",
  path = "PhantaZodiacs.png",
  px = 71,
  py = 95,
}

SMODS.ConsumableType {
  key = "phanta_Zodiac",
  primary_colour = HEX("4076cf"),
  secondary_colour = HEX("5998ff"),
  collection_rows = { 4, 4 },
  shop_rate = (G.GAME and G.GAME.selected_back and G.GAME.selected_back.effect and G.GAME.selected_back.effect.center and G.GAME.selected_back.effect.center.key) == "b_phanta_todayandtomorrow" and 1 or 0,
  default = "phanta_aries",
  can_stack = true,
  can_divide = true
}

SMODS.UndiscoveredSprite({
  key = "phanta_Zodiac",
  atlas = "PhantaZodiacs",
  path = "PhantaZodiacs.png",
  pos = { x = 1, y = 3 },
  px = 71,
  py = 95,
}):register()

SMODS.Atlas {
  key = "PhantaBoosters",
  path = "PhantaBoosters.png",
  px = 71,
  py = 95,
}

SMODS.Sound({
  vol = 1,
  key = "zodiac_pack_music",
  path = "phanta_zodiac_pack.ogg",
  select_music_track = function()
    if G.booster_pack and SMODS.OPENED_BOOSTER and
        (SMODS.OPENED_BOOSTER.config.center.key == 'p_phanta_zodiac_normal1'
          or SMODS.OPENED_BOOSTER.config.center.key == 'p_phanta_zodiac_normal2'
          or SMODS.OPENED_BOOSTER.config.center.key == 'p_phanta_zodiac_normal3'
          or SMODS.OPENED_BOOSTER.config.center.key == 'p_phanta_zodiac_normal4'
          or SMODS.OPENED_BOOSTER.config.center.key == 'p_phanta_zodiac_jumbo1'
          or SMODS.OPENED_BOOSTER.config.center.key == 'p_phanta_zodiac_jumbo2'
          or SMODS.OPENED_BOOSTER.config.center.key == 'p_phanta_zodiac_mega1'
          or SMODS.OPENED_BOOSTER.config.center.key == 'p_phanta_zodiac_mega2') then
      return true
    end
    return false
  end
})

SMODS.Booster {
  key = "zodiac_normal1",
  kind = "phanta_Zodiac",
  atlas = "PhantaBoosters",
  pos = { x = 0, y = 0 },
  config = { extra = 2, choose = 1 },
  cost = 4,
  weight = 0.64,
  create_card = function(self, card)
    return create_card("phanta_Zodiac", G.pack_cards, nil, nil, true, true, nil, "zodiac_normal1")
  end,
  ease_background_colour = function(self)
    ease_colour(G.C.DYN_UI.MAIN, G.C.PHANTA.Zodiac)
    ease_background_colour({ new_colour = G.C.PHANTA.Zodiac, special_colour = G.C.PHANTA.ZodiacAlt, contrast = 2 })
  end,
  loc_vars = function(self, info_queue, card)
    return { vars = { card.config.center.config.choose, card.ability.extra } }
  end,
  group_key = "k_phanta_zodiac_pack",
  select_card = "consumeables"
}

SMODS.Booster {
  key = "zodiac_normal2",
  kind = "phanta_Zodiac",
  atlas = "PhantaBoosters",
  pos = { x = 1, y = 0 },
  config = { extra = 2, choose = 1 },
  cost = 4,
  weight = 0.64,
  create_card = function(self, card)
    return create_card("phanta_Zodiac", G.pack_cards, nil, nil, true, true, nil, "zodiac_normal2")
  end,
  ease_background_colour = function(self)
    ease_colour(G.C.DYN_UI.MAIN, G.C.PHANTA.Zodiac)
    ease_background_colour({ new_colour = G.C.PHANTA.Zodiac, special_colour = G.C.PHANTA.ZodiacAlt, contrast = 2 })
  end,
  loc_vars = function(self, info_queue, card)
    return { vars = { card.config.center.config.choose, card.ability.extra } }
  end,
  group_key = "k_phanta_zodiac_pack",
  select_card = "consumeables"
}

SMODS.Booster {
  key = "zodiac_normal3",
  kind = "phanta_Zodiac",
  atlas = "PhantaBoosters",
  pos = { x = 2, y = 0 },
  config = { extra = 2, choose = 1 },
  cost = 4,
  weight = 0.64,
  create_card = function(self, card)
    return create_card("phanta_Zodiac", G.pack_cards, nil, nil, true, true, nil, "zodiac_normal3")
  end,
  ease_background_colour = function(self)
    ease_colour(G.C.DYN_UI.MAIN, G.C.PHANTA.Zodiac)
    ease_background_colour({ new_colour = G.C.PHANTA.Zodiac, special_colour = G.C.PHANTA.ZodiacAlt, contrast = 2 })
  end,
  loc_vars = function(self, info_queue, card)
    return { vars = { card.config.center.config.choose, card.ability.extra } }
  end,
  group_key = "k_phanta_zodiac_pack",
  select_card = "consumeables"
}

SMODS.Booster {
  key = "zodiac_normal4",
  kind = "phanta_Zodiac",
  atlas = "PhantaBoosters",
  pos = { x = 3, y = 0 },
  config = { extra = 2, choose = 1 },
  cost = 4,
  weight = 0.64,
  create_card = function(self, card)
    return create_card("phanta_Zodiac", G.pack_cards, nil, nil, true, true, nil, "zodiac_normal4")
  end,
  ease_background_colour = function(self)
    ease_colour(G.C.DYN_UI.MAIN, G.C.PHANTA.Zodiac)
    ease_background_colour({ new_colour = G.C.PHANTA.Zodiac, special_colour = G.C.PHANTA.ZodiacAlt, contrast = 2 })
  end,
  loc_vars = function(self, info_queue, card)
    return { vars = { card.config.center.config.choose, card.ability.extra } }
  end,
  group_key = "k_phanta_zodiac_pack",
  select_card = "consumeables"
}

SMODS.Booster {
  key = "zodiac_jumbo1",
  kind = "phanta_Zodiac",
  atlas = "PhantaBoosters",
  pos = { x = 0, y = 1 },
  config = { extra = 4, choose = 1 },
  cost = 6,
  weight = 0.32,
  create_card = function(self, card)
    return create_card("phanta_Zodiac", G.pack_cards, nil, nil, true, true, nil, "zodiac_jumbo1")
  end,
  ease_background_colour = function(self)
    ease_colour(G.C.DYN_UI.MAIN, G.C.PHANTA.Zodiac)
    ease_background_colour({ new_colour = G.C.PHANTA.Zodiac, special_colour = G.C.PHANTA.ZodiacAlt, contrast = 2 })
  end,
  loc_vars = function(self, info_queue, card)
    return { vars = { card.config.center.config.choose, card.ability.extra } }
  end,
  group_key = "k_phanta_zodiac_pack",
  select_card = "consumeables"
}

SMODS.Booster {
  key = "zodiac_jumbo2",
  kind = "phanta_Zodiac",
  atlas = "PhantaBoosters",
  pos = { x = 1, y = 1 },
  config = { extra = 4, choose = 1 },
  cost = 6,
  weight = 0.32,
  create_card = function(self, card)
    return create_card("phanta_Zodiac", G.pack_cards, nil, nil, true, true, nil, "zodiac_jumbo2")
  end,
  ease_background_colour = function(self)
    ease_colour(G.C.DYN_UI.MAIN, G.C.PHANTA.Zodiac)
    ease_background_colour({ new_colour = G.C.PHANTA.Zodiac, special_colour = G.C.PHANTA.ZodiacAlt, contrast = 2 })
  end,
  loc_vars = function(self, info_queue, card)
    return { vars = { card.config.center.config.choose, card.ability.extra } }
  end,
  group_key = "k_phanta_zodiac_pack",
  select_card = "consumeables"
}

SMODS.Booster {
  key = "zodiac_mega1",
  kind = "phanta_Zodiac",
  atlas = "PhantaBoosters",
  pos = { x = 2, y = 1 },
  config = { extra = 4, choose = 2 },
  cost = 8,
  weight = 0.08,
  create_card = function(self, card)
    return create_card("phanta_Zodiac", G.pack_cards, nil, nil, true, true, nil, "zodiac_mega1")
  end,
  ease_background_colour = function(self)
    ease_colour(G.C.DYN_UI.MAIN, G.C.PHANTA.Zodiac)
    ease_background_colour({ new_colour = G.C.PHANTA.Zodiac, special_colour = G.C.PHANTA.ZodiacAlt, contrast = 2 })
  end,
  loc_vars = function(self, info_queue, card)
    return { vars = { card.config.center.config.choose, card.ability.extra } }
  end,
  group_key = "k_phanta_zodiac_pack",
  select_card = "consumeables"
}

SMODS.Booster {
  key = "zodiac_mega2",
  kind = "phanta_Zodiac",
  atlas = "PhantaBoosters",
  pos = { x = 3, y = 1 },
  config = { extra = 4, choose = 2 },
  cost = 8,
  weight = 0.08,
  create_card = function(self, card)
    return create_card("phanta_Zodiac", G.pack_cards, nil, nil, true, true, nil, "zodiac_mega2")
  end,
  ease_background_colour = function(self)
    ease_colour(G.C.DYN_UI.MAIN, G.C.PHANTA.Zodiac)
    ease_background_colour({ new_colour = G.C.PHANTA.Zodiac, special_colour = G.C.PHANTA.ZodiacAlt, contrast = 2 })
  end,
  loc_vars = function(self, info_queue, card)
    return { vars = { card.config.center.config.choose, card.ability.extra } }
  end,
  group_key = "k_phanta_zodiac_pack",
  select_card = "consumeables"
}

SMODS.Tag {
  key = "sol",
  atlas = "PhantaTags",
  pos = { x = 0, y = 0 },
  apply = function(self, tag, context)
    if context.type == "new_blind_choice" then
      tag:yep("+", G.C.PHANTA.Zodiac, function()
        local key = "p_phanta_zodiac_jumbo1"
        local card = Card(
          G.play.T.x + G.play.T.w / 2 - G.CARD_W * 1.27 / 2,
          G.play.T.y + G.play.T.h / 2 - G.CARD_H * 1.27 / 2,
          G.CARD_W * 1.27,
          G.CARD_H * 1.27,
          G.P_CARDS.empty,
          G.P_CENTERS[key],
          { bypass_discovery_center = true, bypass_discovery_ui = true }
        )
        card.cost = 0
        card.from_tag = true
        G.FUNCS.use_card({ config = { ref_table = card } })
        card:start_materialize()
        return true
      end)
      tag.triggered = true
      return true
    end
  end
}

SMODS.Consumable {
  set = "phanta_Zodiac",
  key = "aries",
  pos = { x = 0, y = 0 },
  atlas = "PhantaZodiacs",
  loc_vars = function(self, info_queue, card)
    return { vars = { count_prognosticators() > 0 and "" or localize("phanta_aries_second") } }
  end,
  calculate = function(self, card, context)
    if context.before and (count_prognosticators() > 0 or G.GAME.current_round.hands_played == 1) and #G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit then -- Progs allow Tarots to be made on all hands. (Unstackable)
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
    return { vars = { (count_prognosticators() * 2) + 1, count_prognosticators() > 0 and localize("phanta_plural") or "" } }
  end,
  calculate = function(self, card, context)
    if context.repetition and context.cardarea == G.play and context.other_card == context.scoring_hand[1] then
      return { repetitions = count_prognosticators() > 0 and (count_prognosticators() * 2) + 1 } -- Progs add 2 retriggers each.
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
    return { vars = { card.ability.extra.money + (count_prognosticators() * 2) } }
  end,
  calculate = function(self, card, context)
    if context.before and (next(context.poker_hands['Two Pair']) or next(context.poker_hands['Full House'])) then
      return { dollars = card.ability.extra.money + (count_prognosticators() * 2) } -- Progs add $2 each.
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
    return { vars = { card.ability.extra.chips + (count_prognosticators() * 30) } }
  end,
  calculate = function(self, card, context)
    if context.individual and context.cardarea == G.play and context.other_card:is_suit("Clubs") then
      return { chips = card.ability.extra.chips + (count_prognosticators() * 30) } -- Progs add 30 Chips. (hardcoded so Cryptid doesn't make this nonsensical)
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
    return { vars = { card.ability.extra.mult + (count_prognosticators() * 4) } }
  end,
  calculate = function(self, card, context)
    if context.individual and context.cardarea == G.play and context.other_card:is_suit("Hearts") then
      return { mult = card.ability.extra.mult + (count_prognosticators() * 4) } -- Progs add 4 Mult.
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
      vars = { count_prognosticators() > 0 and localize("phanta_virgo_at_most") or "",
        card.ability.extra.hands + count_prognosticators(),
        count_prognosticators() > 0 and localize("phanta_plural") or "",
        count_prognosticators() == 0 and localize("phanta_virgo_creates_a") or "",
        count_prognosticators() > 0 and localize("phanta_virgo_creates_b") or "" }
    }
  end,
  calculate = function(self, card, context)
    if context.end_of_round and not context.individual and not context.repetition and G.GAME.current_round.hands_played <= card.ability.extra.hands + count_prognosticators() + 1 then -- Prog makes Virgo easier to proc.
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
  config = { extra = { xmult = 1.1 } },
  atlas = "PhantaZodiacs",
  loc_vars = function(self, info_queue, card)
    return { vars = { card.ability.extra.xmult + (count_prognosticators() * 0.2) } }
  end,
  calculate = function(self, card, context)
    if context.individual and context.cardarea == G.play and context.other_card:is_suit("Spades") then
      return { xmult = card.ability.extra.xmult + (count_prognosticators() * 0.2) } -- Prog adds X0.2 Mult.
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
      vars = { count_prognosticators() > 0 and localize("phanta_scorpio_extra_a") or "",
        count_prognosticators() > 0 and localize("phanta_scorpio_extra_b") or "" }
    }
  end,
  calculate = function(self, card, context)
    if context.individual and context.cardarea == G.play and context.other_card:is_suit("Diamonds") and #G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit then
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
            count_prognosticators() > 0 and planet or nil, "scorpio") -- Prog makes the created Planets specific to the played hand.
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
    return { vars = { card.ability.extra.added_discards + count_prognosticators(), count_prognosticators() > 0 and localize("phanta_plural") or "" } }
  end,
  add_to_deck = function(self, card, from_debuff)
    G.GAME.round_resets.discards = G.GAME.round_resets.discards + card.ability.extra.added_discards +
        count_prognosticators() -- Prog adds 1 discard.
    ease_discard(card.ability.extra.added_discards + count_prognosticators())
  end,
  remove_from_deck = function(self, card, from_debuff)
    G.GAME.round_resets.discards = G.GAME.round_resets.discards - card.ability.extra.added_discards -
        count_prognosticators()
    ease_discard(-(card.ability.extra.added_discards + count_prognosticators()))
  end,
  add_prog = function(self)
    G.GAME.round_resets.discards = G.GAME.round_resets.discards + 1
    ease_discard(1)
  end,
  remove_prog = function(self)
    G.GAME.round_resets.discards = G.GAME.round_resets.discards - 1
    ease_discard(-1)
  end
}

SMODS.Consumable {
  set = "phanta_Zodiac",
  key = "capricorn",
  pos = { x = 1, y = 2 },
  config = { extra = { money = 2 } },
  atlas = "PhantaZodiacs",
  loc_vars = function(self, info_queue, card)
    return { vars = { card.ability.extra.money + (count_prognosticators() * 2) } }
  end,
  calculate = function(self, card, context)
    if context.reroll_shop then return { dollars = card.ability.extra.money + (count_prognosticators() * 2) } end -- Prog adds $2 to each reroll reward.
  end
}

SMODS.Consumable {
  set = "phanta_Zodiac",
  key = "aquarius",
  pos = { x = 2, y = 2 },
  config = { extra = { added_hands = 1 } },
  atlas = "PhantaZodiacs",
  loc_vars = function(self, info_queue, card)
    return { vars = { card.ability.extra.added_hands + count_prognosticators(), count_prognosticators() > 0 and localize("phanta_plural") or "" } }
  end,
  add_to_deck = function(self, card, from_debuff)
    G.GAME.round_resets.hands = G.GAME.round_resets.hands + card.ability.extra.added_hands + count_prognosticators()
    ease_hands_played(card.ability.extra.added_hands + count_prognosticators())
  end,
  remove_from_deck = function(self, card, from_debuff)
    G.GAME.round_resets.hands = G.GAME.round_resets.hands - card.ability.extra.added_hands - count_prognosticators()
    ease_hands_played(-(card.ability.extra.added_hands + count_prognosticators()))
  end,
  add_prog = function(self)
    G.GAME.round_resets.hands = G.GAME.round_resets.hands + 1
    ease_hands_played(1)
  end,
  remove_prog = function(self)
    G.GAME.round_resets.hands = G.GAME.round_resets.hands - 1
    ease_hands_played(-1)
  end
}

SMODS.Consumable {
  set = "phanta_Zodiac",
  key = "pisces",
  pos = { x = 3, y = 2 },
  config = { extra = { added_value = 5 } },
  atlas = "PhantaZodiacs",
  loc_vars = function(self, info_queue, card)
    return { vars = { card.ability.extra.added_value + (count_prognosticators() * 3) } }
  end,
  calculate = function(self, card, context)
    if context.skipping_booster then
      card.ability.extra_value = card.ability.extra_value + card.ability.extra.added_value +
          (count_prognosticators() * 3) -- Prog adds $3 extra sell value.
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
  loc_vars = function(self, info_queue, card)
    return { vars = { card.ability.extra.xmult + (count_prognosticators() * 2) } }
  end,
  calculate = function(self, card, context)
    if context.individual and context.cardarea == "unscored" and context.other_card:is_suit("Clubs") then
      return { xmult = card.ability.extra.xmult + (count_prognosticators() * 2) } -- Prog adds X2 Mult.
    end
  end,

  hidden = true,
  soul_rate = 0.005,
  can_repeat_soul = false
}

















SMODS.Joker {
  key = 'bootleg',
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

SMODS.Joker {
  key = 'dropdownlist',
  rarity = 1,
  atlas = 'Phanta',
  pos = { x = 11, y = 3 },
  cost = 2,
  blueprint_compat = true,
  eternal_compat = true,
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

SMODS.Joker {
  key = 'trainstation',
  config = { extra = { added_mult = 1, current_mult = 0 } },
  loc_vars = function(self, info_queue, card)
    return { vars = { card.ability.extra.added_mult, localize((G.GAME.current_round.train_station_card.value or 2) .. "", 'ranks'), card.ability.extra.current_mult } }
  end,
  rarity = 1,
  atlas = 'Phanta',
  pos = { x = 5, y = 8 },
  cost = 6,
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
  end
}

SMODS.Joker {
  key = 'hintcoin',
  config = { extra = { money = 5 } },
  rarity = 1,
  atlas = 'Phanta',
  pos = { x = 6, y = 4 },
  cost = 4,
  blueprint_compat = true,
  eternal_compat = true,
  perishable_compat = true,
  loc_vars = function(self, info_queue, card)
    return { vars = { card.ability.extra.money } }
  end,
  calculate = function(self, card, context)
    if context.joker_main and G.GAME.current_round.hands_played == 1 then
      return { dollars = card.ability.extra.money }
    end
  end
}

SMODS.Joker {
  key = 'yellow',
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

SMODS.Joker {
  key = 'purplegoldenjoker',
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

SMODS.Joker {
  key = 'holeinthejoker',
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

SMODS.Joker {
  key = 'shootingstar',
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

SMODS.Joker {
  key = 'binman',
  config = { extra = { given_money = 3 } },
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
    return G.GAME.hands["phanta_junk"].visible
  end
}

SMODS.Joker {
  key = 'onemanstrash',
  no_pool_flag = "one_mans_trash_sold",
  config = { extra = { added_mult = 1, current_mult = 0 } },
  loc_vars = function(self, info_queue, card)
    return { vars = { card.ability.extra.added_mult, card.ability.extra.current_mult } }
  end,
  rarity = 1,
  atlas = 'Phanta',
  pos = { x = 3, y = 7 },
  cost = 5,
  blueprint_compat = true,
  eternal_compat = true,
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

SMODS.Joker {
  key = 'anothermanstreasure',
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

SMODS.Joker {
  key = 'oracle',
  rarity = 1,
  atlas = 'Phanta',
  pos = { x = 2, y = 8 },
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

SMODS.Joker {
  key = 'thief',
  rarity = 1,
  atlas = 'Phanta',
  pos = { x = 3, y = 8 },
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

SMODS.Joker {
  key = 'detective',
  rarity = 2,
  atlas = 'Phanta',
  pos = { x = 6, y = 5 },
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

--[[
SMODS.Joker {
  key = 'timetable',
  config = { extra = { discards = 1, hands = 1, hand_size = 1, current_blind = "small" } },
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
    card.ability.extra.current_blind = get_previous_blind()
    if card.ability.extra.current_blind == "small" then
      G.GAME.round_resets.discards = G.GAME.round_resets.discards + card.ability.extra.discards
      ease_discard(card.ability.extra.discards)
    elseif card.ability.extra.current_blind == "big" then
      G.GAME.round_resets.hands = G.GAME.round_resets.hands + card.ability.extra.hands
      ease_hands_played(card.ability.extra.hands)
    else
      G.hand:change_size(card.ability.extra.hand_size)
    end
  end,
  remove_from_deck = function(self, card, from_debuff)
    if card.ability.extra.current_blind == "small" then
      G.GAME.round_resets.discards = G.GAME.round_resets.discards - card.ability.extra.discards
      ease_discard(-card.ability.extra.discards)
    elseif card.ability.extra.current_blind == "big" then
      G.GAME.round_resets.hands = G.GAME.round_resets.hands - card.ability.extra.hands
      ease_hands_played(-card.ability.extra.hands)
    else
      G.hand:change_size(-card.ability.extra.hand_size)
    end
  end,
  calculate = function(self, card, context)
    if context.end_of_round and not context.individual and not context.repetition then
      if card.ability.extra.current_blind == "small" then
        card.ability.extra.current_blind = "big"

        G.GAME.round_resets.discards = G.GAME.round_resets.discards - card.ability.extra.discards
        G.GAME.round_resets.hands = G.GAME.round_resets.hands + card.ability.extra.hands
        ease_discard(-card.ability.extra.discards)
        ease_hands_played(card.ability.extra.hands)
      elseif card.ability.extra.current_blind == "big" then
        card.ability.extra.current_blind = "boss"

        G.GAME.round_resets.hands = G.GAME.round_resets.hands - card.ability.extra.hands
        ease_hands_played(-card.ability.extra.hands)
        G.hand:change_size(card.ability.extra.hand_size)
      else
        card.ability.extra.current_blind = "small"

        G.GAME.round_resets.discards = G.GAME.round_resets.discards + card.ability.extra.discards
        G.hand:change_size(-card.ability.extra.hand_size)
        ease_discard(card.ability.extra.discards)
      end
    end
  end
}
]] --

SMODS.Joker {
  key = 'mazebean',
  config = { extra = { current_hand_size = 0, target_antes = 2, current_antes = 0 } },
  loc_vars = function(self, info_queue, card)
    return { vars = { card.ability.extra.current_hand_size, card.ability.extra.target_antes, card.ability.extra.target_antes - card.ability.extra.current_antes } }
  end,
  rarity = 2,
  atlas = 'Phanta',
  pos = { x = 9, y = 10 },
  cost = 6,
  blueprint_compat = false,
  eternal_compat = true,
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

SMODS.Joker {
  key = 'new2dsxl',
  config = { extra = { lost_hand_size = 2, given_xhands = 2 } },
  loc_vars = function(self, info_queue, card)
    return { vars = { card.ability.extra.lost_hand_size, card.ability.extra.given_xhands } }
  end,
  rarity = 3,
  atlas = 'Phanta',
  pos = { x = 10, y = 6 },
  cost = 8,
  blueprint_compat = true,
  eternal_compat = true,
  perishable_compat = true,
  add_to_deck = function(self, card, from_debuff)
    G.hand:change_size(-card.ability.extra.lost_hand_size)
  end,
  remove_from_deck = function(self, card, from_debuff)
    G.hand:change_size(card.ability.extra.lost_hand_size)
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
  end
}



SMODS.Joker {
  key = 'playerpin',
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

SMODS.Joker {
  key = 'junpei',
  config = { extra = { given_mult = 9 } },
  loc_vars = function(self, info_queue, card)
    return { vars = { card.ability.extra.given_mult } }
  end,
  rarity = 1,
  atlas = 'Phanta',
  pos = { x = 10, y = 7 },
  cost = 4,
  blueprint_compat = true,
  eternal_compat = true,
  perishable_compat = true,
  calculate = function(self, card, context)
    if context.individual and context.cardarea == G.play and context.other_card:get_id() == 5 then
      return { mult = card.ability.extra.given_mult }
    end
  end
}

SMODS.Joker {
  key = 'sigma',
  loc_vars = function(self, info_queue, card)
    info_queue[#info_queue + 1] = G.P_CENTERS.m_bonus
    return {}
  end,
  rarity = 1,
  atlas = 'Phanta',
  pos = { x = 11, y = 7 },
  cost = 4,
  blueprint_compat = true,
  eternal_compat = true,
  perishable_compat = true,
  calculate = function(self, card, context)
    if context.repetition and context.cardarea == G.play and SMODS.has_enhancement(context.other_card, "m_bonus") then
      return { repetitions = 1 }
    end
  end
}

SMODS.Joker {
  key = 'redkeycards',
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
        colour =
            G.C.RED
      }
    end

    -- The whole will be / is spent thing is for Blueprint compat.
    if context.after and card.ability.extra.will_be_spent then
      card.ability.extra.will_be_spent = false
      card.ability.extra.is_spent = true
    end

    if context.end_of_round then card.ability.extra.is_spent = false end
  end
}

SMODS.Joker {
  key = 'bluekeycards',
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
        colour =
            G.C.BLUE
      }
    end

    if context.after and card.ability.extra.will_be_spent then
      card.ability.extra.will_be_spent = false
      card.ability.extra.is_spent = true
    end

    if context.end_of_round then card.ability.extra.is_spent = false end
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

SMODS.Joker {
  key = 'nonuniformday',
  config = { extra = { odds = 2 } },
  loc_vars = function(self, info_queue, card)
    info_queue[#info_queue + 1] = G.P_CENTERS.m_wild
    return { vars = { (G.GAME.probabilities.normal or 1), card.ability.extra.odds } }
  end,
  rarity = 1,
  atlas = 'Phanta',
  pos = { x = 2, y = 11 },
  cost = 5,
  blueprint_compat = true,
  eternal_compat = true,
  perishable_compat = true,
  calculate = function(self, card, context)
    if context.individual and context.cardarea == G.play and #G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit and SMODS.has_enhancement(context.other_card, "m_wild") and pseudorandom('nonuniformday') < G.GAME.probabilities.normal / card.ability.extra.odds then
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
  end
}

SMODS.Joker {
  key = 'badhairday',
  config = { extra = { odds = 2 } },
  loc_vars = function(self, info_queue, card)
    info_queue[#info_queue + 1] = G.P_CENTERS.m_wild
    return { vars = { (G.GAME.probabilities.normal or 1), card.ability.extra.odds } }
  end,
  rarity = 2,
  atlas = 'Phanta',
  pos = { x = 10, y = 3 },
  cost = 6,
  blueprint_compat = true,
  eternal_compat = true,
  perishable_compat = true,
  calculate = function(self, card, context)
    if context.destroy_card and context.cardarea == G.hand and SMODS.has_enhancement(context.other_card, "m_wild") and pseudorandom('badhairday') < G.GAME.probabilities.normal / card.ability.extra.odds then
      return true
    end
  end
}

SMODS.Joker {
  key = 'animalinstinct',
  config = { extra = { added_mult = 3, current_mult = 0 } },
  loc_vars = function(self, info_queue, card)
    return { vars = { card.ability.extra.added_mult, card.ability.extra.current_mult } }
  end,
  rarity = 2,
  atlas = 'Phanta',
  pos = { x = 6, y = 3 },
  cost = 6,
  blueprint_compat = true,
  eternal_compat = true,
  perishable_compat = false,
  calculate = function(self, card, context)
    if context.joker_main and card.ability.extra.current_mult > 0 then return { mult = card.ability.extra.current_mult } end

    if context.remove_playing_cards and not context.blueprint then
      card.ability.extra.current_mult = card.ability.extra.current_mult +
          (#context.removed * card.ability.extra.added_mult)
      return { message = localize("k_upgrade_ex"), color = G.C.FILTER, card = card }
    end
  end
}

SMODS.Joker {
  key = 'teastainedjoker',
  config = { extra = { odds = 5, added_mult = 3, current_mult = 0 } },
  loc_vars = function(self, info_queue, card)
    info_queue[#info_queue + 1] = G.P_CENTERS.m_lucky
    return { vars = { (G.GAME.probabilities.normal or 1), card.ability.extra.odds, card.ability.extra.added_mult, card.ability.extra.current_mult } }
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
      elseif pseudorandom('teastainedjoker') < G.GAME.probabilities.normal / card.ability.extra.odds then
        card.ability.extra.current_mult = card.ability.extra.current_mult + card.ability.extra.added_mult
        return {
          message = localize('k_upgrade_ex'),
          card = card
        }
      end
    end
  end
}

SMODS.Sound({
  key = "teabag",
  path = "phanta_teabag.ogg",
  replace = true
})

SMODS.Joker {
  key = 'teabag',
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

SMODS.Joker {
  key = 'forsakenscroll',
  config = { extra = { odds = 25, given_xmult = 3 } },
  loc_vars = function(self, info_queue, card)
    info_queue[#info_queue + 1] = G.P_CENTERS.m_lucky
    return { vars = { (G.GAME.probabilities.normal or 1) * count_lucky_cards(), card.ability.extra.odds, card.ability.extra.given_xmult } }
  end,
  rarity = 2,
  atlas = 'Phanta',
  pos = { x = 2, y = 5 },
  cost = 6,
  blueprint_compat = true,
  eternal_compat = true,
  perishable_compat = false,
  calculate = function(self, card, context)
    if context.joker_main and pseudorandom('forsakenscroll') < (G.GAME.probabilities.normal * count_lucky_cards()) / card.ability.extra.odds then
      return { xmult = card.ability.extra.given_xmult }
    end
  end
}

SMODS.Joker {
  key = 'exitsign',
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

SMODS.Joker {
  key = 'task',
  config = { extra = { added_money = 1, current_money = 0 } },
  rarity = 2,
  atlas = 'Phanta',
  pos = { x = 5, y = 10 },
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

SMODS.Joker {
  key = 'saltcircle',
  config = { extra = { chips = 177 } },
  rarity = 1,
  atlas = 'Phanta',
  pos = { x = 6, y = 1 },
  cost = 6,
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

SMODS.Joker {
  key = 'stitchintime',
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

SMODS.Joker {
  key = 'shackles',
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

--[[SMODS.Joker {
  key = 'html',
  config = { extra = { mult = 1 } },
  rarity = 1,
  atlas = 'Phanta',
  pos = { x = 9, y = 3 },
  cost = 4,
  blueprint_compat = false,
  eternal_compat = true,
  perishable_compat = true,
  loc_vars = function(self, info_queue, card)
    return { vars = { card.ability.extra.mult } }
  end,
  calculate = function(self, card, context)
    if context.joker_main and G.GAME.current_round.hands_played == 0 then
      hand_mult = mod_mult(card.ability.extra.mult)
      update_hand_text({ delay = 0 }, { mult = hand_mult })
      return { message = localize("phanta_mult_equals") .. card.ability.extra.mult, colour = G.C.MULT, card = card }
    end
  end
}]] --

SMODS.Joker {
  key = 'ghost',
  config = { extra = { x_mult = 1 } },
  rarity = 3,
  atlas = 'Phanta',
  pos = { x = 0, y = 0 },
  draw = function(self, card, layer)
    card.children.center:draw_shader('voucher', nil, card.ARGS.send_to_shader)
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

SMODS.Joker {
  key = 'html',
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

SMODS.Joker {
  key = 'knowledgeofthecollege',
  config = { extra = { given_xmult = 3 } },
  rarity = 3,
  atlas = 'Phanta',
  pos = { x = 9, y = 7 },
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

--[[
SMODS.Joker {
  key = 'theapparition',
  rarity = 2,
  atlas = 'Phanta',
  pos = { x = 7, y = 1 },
  draw = function(self, card, layer)
    card.children.center:draw_shader('voucher', nil, card.ARGS.send_to_shader)
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

SMODS.Joker {
  key = 'willothewisp',
  rarity = 2,
  atlas = 'Phanta',
  pos = { x = 7, y = 10 },
  cost = 6,
  blueprint_compat = true,
  eternal_compat = true,
  perishable_compat = true,
  calculate = function(self, card, context)
    if context.individual and context.cardarea == "unscored" and context.other_card.ability.name == "Ghost Card" then
      return { xmult = context.other_card.ability.config.h_x_mult }
    end
  end
}
]] --

SMODS.Joker {
  key = 'stickercollection',
  config = { extra = { retriggers = 3 } },
  rarity = 2,
  atlas = 'Phanta',
  pos = { x = 2, y = 10 },
  cost = 6,
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
    return G.GAME.hands["phanta_junk"].visible
  end
}

SMODS.Joker {
  key = 'photocopy',
  config = { extra = { odds = 2 } },
  rarity = 2,
  atlas = 'Phanta',
  pos = { x = 5, y = 11 },
  cost = 6,
  loc_vars = function(self, info_queue, card)
    return { vars = { (G.GAME.probabilities.normal or 1), card.ability.extra.odds } }
  end,
  blueprint_compat = true,
  eternal_compat = true,
  perishable_compat = true,
  calculate = function(self, card, context)
    if context.cardarea == G.play and context.repetition and pseudorandom('photocopy') < G.GAME.probabilities.normal / card.ability.extra.odds then
      return { repetitions = 1 }
    end
  end
}

SMODS.Joker {
  key = 'prognosticator',
  rarity = 2,
  atlas = 'Phanta',
  pos = { x = 10, y = 10 },
  cost = 6,
  blueprint_compat = false,
  eternal_compat = true,
  perishable_compat = true,
  add_to_deck = function(self, card, from_debuff)
    if G.consumeables then
      for _, card in pairs(G.consumeables.cards) do
        if card.ability.set == "phanta_Zodiac" and card.config.center.add_prog then
          card.config.center:add_prog()
        end
      end
    end
  end,
  remove_from_deck = function(self, card, from_debuff)
    if G.consumeables then
      for _, card in pairs(G.consumeables.cards) do
        if card.ability.set == "phanta_Zodiac" and card.config.center.remove_prog then
          card.config.center:remove_prog()
        end
      end
    end
  end,
}

SMODS.Joker {
  key = 'grimreaper',
  rarity = 2,
  atlas = 'Phanta',
  pos = { x = 9, y = 4 },
  cost = 6,
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
        if not has_death and v.ability.set == "Tarot" and v.config.center.key == "c_death" then
          has_death = true
          v.grim_reaper_queued_to_destroy = true
        end
      end

      if has_death then return true end
    end

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
  end
}

SMODS.Joker {
  key = 'layton',
  config = { extra = { out_of_odds = 4, added_mult = 75 } },
  rarity = 2,
  atlas = 'Phanta',
  pos = { x = 0, y = 8 },
  cost = 7,
  blueprint_compat = true,
  eternal_compat = true,
  perishable_compat = true,
  loc_vars = function(self, info_queue, card)
    return { vars = { (G.GAME.probabilities.normal or 1) * count_tarots(), card.ability.extra.out_of_odds, card.ability.extra.added_mult } }
  end,
  calculate = function(self, card, context)
    if context.joker_main then
      local tarot_count = G.GAME.probabilities.normal * count_tarots()
      if next(SMODS.find_card("j_phanta_luke")) or (tarot_count > 0 and pseudorandom('layton') < tarot_count / card.ability.extra.out_of_odds) then
        return { mult = card.ability.extra.added_mult }
      end
    end
  end
}

SMODS.Joker {
  key = 'luke',
  config = { extra = { out_of_odds = 4, x_mult = 3 } },
  rarity = 2,
  atlas = 'Phanta',
  pos = { x = 1, y = 8 },
  cost = 7,
  blueprint_compat = true,
  eternal_compat = true,
  perishable_compat = true,
  loc_vars = function(self, info_queue, card)
    return { vars = { (G.GAME.probabilities.normal or 1) * count_planets(), card.ability.extra.out_of_odds, card.ability.extra.x_mult } }
  end,
  calculate = function(self, card, context)
    if context.joker_main then
      local planet_count = G.GAME.probabilities.normal * count_planets()
      if next(SMODS.find_card("j_phanta_layton")) or (planet_count > 0 and pseudorandom('luke') < planet_count / card.ability.extra.out_of_odds) then
        return { xmult = card.ability.extra.x_mult }
      end
    end
  end
}

SMODS.Joker {
  key = 'descole',
  rarity = 2,
  atlas = 'Phanta',
  pos = { x = 11, y = 4 },
  cost = 7,
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
      if #G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit then
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
  end
}

SMODS.Joker {
  key = 'engineer',
  rarity = 2,
  atlas = 'Phanta',
  pos = { x = 7, y = 8 },
  cost = 6,
  blueprint_compat = true,
  eternal_compat = true,
  perishable_compat = true,
  calculate = function(self, card, context)
    if context.joker_main then
      if context.scoring_name == "phanta_junk" and #G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit then
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
    return G.GAME.hands["phanta_junk"].visible
  end
}

SMODS.Joker {
  key = 'apollosbracelet',
  rarity = 3,
  atlas = 'Phanta',
  pos = { x = 4, y = 10 },
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

SMODS.Joker {
  key = 'candle',
  config = { extra = { added_xmult = 0.25, current_xmult = 1 } },
  rarity = 2,
  atlas = 'Phanta',
  pos = { x = 5, y = 7 },
  cost = 7,
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
      for i = 1, #G.consumeables.cards do
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
  end
}

SMODS.Joker {
  key = 'web',
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

SMODS.Joker {
  key = 'cutcorners',
  config = { extra = { added_mult = 1, current_mult = 0, no_of_cards = 4 } },
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

SMODS.Joker {
  key = 'blottedjoker',
  config = { extra = { added_chips = 20, current_chips = 0 } },
  rarity = 2,
  atlas = 'Phanta',
  pos = { x = 11, y = 0 },
  cost = 5,
  loc_vars = function(self, info_queue, card)
    info_queue[#info_queue + 1] = G.P_CENTERS.m_bonus
    return { vars = { card.ability.extra.added_chips, card.ability.extra.current_chips } }
  end,
  blueprint_compat = true,
  eternal_compat = true,
  perishable_compat = false,
  calculate = function(self, card, context)
    if context.joker_main and card.ability.extra.current_chips > 0 then
      return { chips = card.ability.extra.current_chips }
    end

    if context.cardarea == G.jokers and context.before and not context.blueprint then
      local bonus_cards = {}
      for k, v in ipairs(context.scoring_hand) do
        if SMODS.has_enhancement(v, "m_bonus") and not v.debuff and not v.blotted_selected then
          bonus_cards[#bonus_cards + 1] = v
          v.blotted_selected = true
          v:set_ability(G.P_CENTERS.c_base, nil, true)
          G.E_MANAGER:add_event(Event({
            func = function()
              v:juice_up()
              v.blotted_selected = nil
              return true
            end
          }))
        end
      end

      if #bonus_cards > 0 then
        card.ability.extra.current_chips = card.ability.extra.current_chips +
            (card.ability.extra.added_chips * #bonus_cards)
        return {
          message = localize { type = 'variable', key = 'a_chips', vars = { card.ability.extra.current_chips } },
          colour = G.C.CHIPS,
          card = card
        }
      end
    end
  end
}

SMODS.Joker {
  key = 'bloodpact',
  config = { extra = { added_mult = 5, current_mult = 0 } },
  rarity = 2,
  atlas = 'Phanta',
  pos = { x = 3, y = 5 },
  cost = 5,
  loc_vars = function(self, info_queue, card)
    info_queue[#info_queue + 1] = G.P_CENTERS.m_mult
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
      local mult_cards = {}
      for k, v in ipairs(context.scoring_hand) do
        if SMODS.has_enhancement(v, "m_mult") and not v.debuff and not v.bloodpact_selected then
          mult_cards[#mult_cards + 1] = v
          v.bloodpact_selected = true
          v:set_ability(G.P_CENTERS.c_base, nil, true)
          G.E_MANAGER:add_event(Event({
            func = function()
              v:juice_up()
              v.bloodpact_selected = nil
              return true
            end
          }))
        end
      end

      if #mult_cards > 0 then
        card.ability.extra.current_mult = card.ability.extra.current_mult + (card.ability.extra.added_mult * #mult_cards)
        return {
          message = localize { type = 'variable', key = 'a_mult', vars = { card.ability.extra.current_mult } },
          colour = G.C.MULT,
          card = card
        }
      end
    end
  end
}

SMODS.Joker {
  key = 'tnetennba',
  config = { extra = { added_mult = 3, current_mult = 0 } },
  rarity = 2,
  atlas = 'Phanta',
  pos = { x = 9, y = 9 },
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

SMODS.Joker {
  key = 'technicolourjoker',
  config = { extra = { given_mult = 7 } },
  rarity = 1,
  atlas = 'Phanta',
  pos = { x = 9, y = 1 },
  cost = 7,
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
  end
}

SMODS.Joker {
  key = 'identity',
  config = { extra = { no_of_cards = 2 } },
  rarity = 2,
  atlas = 'Phanta',
  pos = { x = 1, y = 0 },
  cost = 8,
  loc_vars = function(self, info_queue, card)
    return { vars = { card.ability.extra.no_of_cards } }
  end,
  draw = function(self, card, layer)
    card.children.center:draw_shader('voucher', nil, card.ARGS.send_to_shader)
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

SMODS.Joker {
  key = 'tricolour',
  loc_txt = {
    name = 'Tricolour',
    text = {
      "{C:mult}+#1#{} Mult if played",
      "hand contains exactly",
      "{C:attention}3{} unique scoring {C:attention}suits{}"
    }
  },
  config = { extra = { mult = 17 } },
  rarity = 1,
  atlas = 'Phanta',
  pos = { x = 8, y = 7 },
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

SMODS.Joker {
  key = 'beadnecklace',
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

SMODS.Joker {
  key = 'p5joker',
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

SMODS.Joker {
  key = 'crescent',
  rarity = 1,
  atlas = 'Phanta',
  pos = { x = 3, y = 0 },
  cost = 4,
  blueprint_compat = true,
  eternal_compat = true,
  perishable_compat = true,
  calculate = function(self, card, context)
    if context.selling_card and context.card.config.center.set == "Planet" and #G.consumeables.cards + G.GAME.consumeable_buffer <= G.consumeables.config.card_limit then
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

SMODS.Joker {
  key = 'shoppinglist',
  config = { extra = { added_mult = 4, target = 5, current_bought = 0, current_mult = 0 } },
  rarity = 1,
  atlas = 'Phanta',
  pos = { x = 7, y = 4 },
  cost = 4,
  loc_vars = function(self, info_queue, card)
    return { vars = { card.ability.extra.added_mult, card.ability.extra.target, card.ability.extra.target - card.ability.extra.current_bought, card.ability.extra.current_mult } }
  end,
  blueprint_compat = true,
  eternal_compat = true,
  perishable_compat = false,
  calculate = function(self, card, context)
    if context.joker_main and card.ability.extra.current_mult > 0 then
      return { mult = card.ability.extra.current_mult }
    end

    if context.buying_card and not context.blueprint then
      card.ability.extra.current_bought = card.ability.extra.current_bought + 1
      if card.ability.extra.current_bought == card.ability.extra.target then
        card.ability.extra.current_bought = 0
        card.ability.extra.current_mult = card.ability.extra.current_mult + card.ability.extra.added_mult
        return {
          message = localize('k_upgrade_ex'),
          card = card
        }
      else
        return {
          message = card.ability.extra.current_bought .. "/" .. card.ability.extra.target,
          colour = G.C.FILTER,
          card = card
        }
      end
    end
  end
}

SMODS.Joker {
  key = 'ransomnote',
  config = { extra = { money = 25, joker_tally = 0, jokers_required = 5 } },
  rarity = 2,
  atlas = 'Phanta',
  pos = { x = 3, y = 10 },
  cost = 6,
  loc_vars = function(self, info_queue, card)
    return { vars = { card.ability.extra.money, card.ability.extra.jokers_required, card.ability.extra.jokers_required - card.ability.extra.joker_tally } }
  end,
  blueprint_compat = true,
  eternal_compat = true,
  perishable_compat = true,
  calculate = function(self, card, context)
    if context.selling_card and context.card.config.center.set == "Joker" and not card.getting_sliced then
      card.ability.extra.joker_tally = card.ability.extra.joker_tally + 1
      if card.ability.extra.joker_tally == card.ability.extra.jokers_required then
        card.ability.extra.joker_tally = 0
        return { dollars = card.ability.extra.money }
      else
        return {
          message = card.ability.extra.joker_tally .. "/" .. card.ability.extra.jokers_required,
          colour = G.C.FILTER,
          card = card
        }
      end
    end
  end
}

SMODS.Joker {
  key = 'purplejoker',
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

SMODS.Joker {
  key = 'monetjoker',
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

SMODS.Joker {
  key = 'charcoaljoker',
  config = { extra = { added_mult = 2, current_mult = 0 } },
  rarity = 2,
  atlas = 'Phanta',
  pos = { x = 4, y = 5 },
  cost = 6,
  loc_vars = function(self, info_queue, card)
    return { vars = { card.ability.extra.added_mult, card.ability.extra.current_mult } }
  end,
  blueprint_compat = true,
  eternal_compat = true,
  perishable_compat = false,
  calculate = function(self, card, context)
    if context.joker_main and card.ability.extra.current_mult > 0 then return { mult = card.ability.extra.current_mult } end

    if context.discard and context.other_card == context.full_hand[#context.full_hand] and not context.blueprint then
      local non_spades_present = false
      for k, v in ipairs(context.full_hand) do
        if not v:is_suit("Spades") then non_spades_present = true end
      end
      if not non_spades_present then
        card.ability.extra.current_mult = card.ability.extra.current_mult + card.ability.extra.added_mult
        return {
          message = localize('k_upgrade_ex'),
          card = card
        }
      end
    end
  end
}

SMODS.Joker {
  key = 'goldenfiddle',
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

SMODS.Joker {
  key = 'reverie',
  rarity = 2,
  atlas = 'Phanta',
  pos = { x = 5, y = 0 },
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
    if context.setting_blind and not (context.blueprint_card or self).getting_sliced and #G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit then
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

SMODS.Joker {
  key = 'sees',
  rarity = 2,
  atlas = 'Phanta',
  pos = { x = 2, y = 4 },
  cost = 6,
  loc_vars = function(self, info_queue, card)
    info_queue[#info_queue + 1] = G.P_CENTERS.c_moon
    return {}
  end,
  blueprint_compat = true,
  eternal_compat = true,
  perishable_compat = true,
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
            end
          }))
          card_eval_status_text(context.blueprint_card or card, 'extra', nil, nil, nil,
            { message = "+1 Moon", colour = G.C.PURPLE })
          return true
        end
      }))
    end
  end
}

SMODS.Joker {
  key = 'scissorsaresharp',
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
    if context.setting_blind and not (context.blueprint_card or self).getting_sliced and #G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit then
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

SMODS.Joker {
  key = 'caesarcipher',
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
  eternal_compat = true,
  perishable_compat = true,
  loc_vars = function(self, info_queue, card)
    return { vars = { card.ability.extra.chosen_tarot, card.ability.extra.money } }
  end,
  calculate = function(self, card, context)

  end
}]] --

SMODS.Joker {
  key = 'timepiece',
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
    if context.cardarea == G.jokers and context.before and G.GAME.current_round.hands_left == 0 and not (context.blueprint_card or card).getting_sliced and #G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit then
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
            end
          }))
          card_eval_status_text(context.blueprint_card or card, 'extra', nil, nil, nil,
            { message = "+1 Death", colour = G.C.PURPLE })
          return true
        end
      }))
    end
  end
}

SMODS.Joker {
  key = 'introspection',
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
    if context.setting_blind and not (context.blueprint_card or card).getting_sliced and #G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit then
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

SMODS.Joker {
  key = 'blindjoker',
  config = { extra = { no_of_aces = 2 } },
  rarity = 2,
  atlas = 'Phanta',
  pos = { x = 1, y = 1 },
  cost = 6,
  loc_vars = function(self, info_queue, card)
    return { vars = { card.ability.extra.no_of_aces } }
  end,
  blueprint_compat = true,
  eternal_compat = true,
  perishable_compat = true,
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

SMODS.Joker {
  key = 'spaceinvader',
  config = { extra = { no_of_planets = 2 } },
  rarity = 2,
  atlas = 'Phanta',
  pos = { x = 6, y = 2 },
  cost = 6,
  loc_vars = function(self, info_queue, card)
    info_queue[#info_queue + 1] = G.P_CENTERS.tag_voucher
    return { vars = { card.ability.extra.no_of_planets } }
  end,
  blueprint_compat = true,
  eternal_compat = true,
  perishable_compat = true,
  calculate = function(self, card, context)
    if context.setting_blind and #G.consumeables.cards == 0 then
      G.E_MANAGER:add_event(Event({
        func = function()
          card_eval_status_text(context.blueprint_card or card, 'extra', nil, nil, nil, { message = localize { type = 'variable', key = 'a_planets', vars = { card.ability.extra.no_of_planets } }, colour = G.C.Planet })
          play_sound("timpani")

          for i = 1, card.ability.extra.no_of_planets do
            if #G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit then
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
    c.ability = c.ability or {}
    c.ability.space_invader_x = c.ability.space_invader_x or pseudorandom(pseudoseed("spaceinvaderx"), 6, 8)
    if card and card.children and card.children.center and card.children.center.set_sprite_pos then
      card.children.center:set_sprite_pos({
        x = c.ability.space_invader_x,
        y = c.config.center.pos.y
      })
    end
  end
}

SMODS.Joker {
  key = 'witchsmark',
  rarity = 3,
  atlas = 'Phanta',
  pos = { x = 0, y = 10 },
  cost = 8,
  blueprint_compat = true,
  eternal_compat = true,
  perishable_compat = true,
  calculate = function(self, card, context)
    if context.joker_main and #G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit then
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

SMODS.Joker {
  key = 'modernart',
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

SMODS.Joker {
  key = 'sketch',
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

SMODS.Joker {
  key = 'conspiracist',
  config = { extra = { odds = 2 } },
  rarity = 1,
  atlas = 'Phanta',
  pos = { x = 0, y = 5 },
  cost = 5,
  loc_vars = function(self, info_queue, card)
    info_queue[#info_queue + 1] = G.P_CENTERS.c_earth
    return { vars = { (G.GAME.probabilities.normal or 1), card.ability.extra.odds } }
  end,
  blueprint_compat = true,
  eternal_compat = true,
  perishable_compat = true,
  calculate = function(self, card, context)
    if context.cardarea == G.jokers and context.before and not (context.blueprint_card or card).getting_sliced and #G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit
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
            end
          }))
          card_eval_status_text(context.blueprint_card or card, 'extra', nil, nil, nil,
            { message = "+1 Earth", colour = G.C.BLUE })
          return true
        end
      }))
    end
  end
}

SMODS.Joker {
  key = 'wavyjoker',
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
          card_eval_status_text(context.blueprint_card or card, 'extra', nil, nil, nil, { message = localize { type = 'variable', key = 'a_tarots', vars = { card.ability.extra.no_of_tarots } }, colour = G.C.Tarot })
          play_sound("timpani")
          for i = 1, card.ability.extra.no_of_tarots do
            if #G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit then
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

-- This code is so jank, sorry :sob:
SMODS.Joker {
  key = 'sudoku',
  config = { extra = { ranks = { ["2"] = 0, ["3"] = 0, ["4"] = 0, ["5"] = 0, ["6"] = 0, ["7"] = 0, ["8"] = 0, ["9"] = 0, ["14"] = 0 }, no_of_upgrades = 1 } },
  rarity = 1,
  atlas = 'Phanta',
  pos = { x = 9, y = 2 },
  cost = 4,
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

SMODS.Joker {
  key = 'ceaseanddesist',
  config = { extra = { no_of_upgrades = 1 } },
  rarity = 2,
  atlas = 'Phanta',
  pos = { x = 5, y = 9 },
  cost = 6,
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

SMODS.Joker {
  key = 'thepolicemun',
  config = { extra = { no_of_upgrades = 2 } },
  rarity = 2,
  atlas = 'Phanta',
  pos = { x = 8, y = 4 },
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

SMODS.Joker {
  key = 'nojoke',
  config = { extra = { mult_per_straight = 4 } },
  rarity = 1,
  atlas = 'Phanta',
  pos = { x = 11, y = 2 },
  cost = 4,
  loc_vars = function(self, info_queue, card)
    return { vars = { card.ability.extra.mult_per_straight, G.GAME.hands["Straight"].level * card.ability.extra.mult_per_straight } }
  end,
  blueprint_compat = true,
  eternal_compat = true,
  perishable_compat = true,
  calculate = function(self, card, context)
    if context.joker_main then
      return { mult = (G.GAME.hands["Straight"].level * card.ability.extra.mult_per_straight):to_number() }
    end
  end
}

--[[SMODS.Joker {
  key = 'diningtable',
  rarity = 2,
  atlas = 'Phanta',
  pos = { x = 1, y = 10 },
  cost = 7,
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
        if not rank_tallies[v.rank] then
          rank_tallies[v.rank] = 0
        end
        rank_tallies[v.rank] = rank_tallies[v.rank] + 1
        sendInfoMessage("rank " .. v.rank, self.key)
      end
      sendInfoMessage("" .. (rank_tallies[2] or 0), self.key)
      sendInfoMessage("" .. (rank_tallies[3] or 0), self.key)
      sendInfoMessage("" .. (rank_tallies[4] or 0), self.key)
      sendInfoMessage("" .. (rank_tallies[5] or 0), self.key)
      sendInfoMessage("" .. (rank_tallies[6] or 0), self.key)
      sendInfoMessage("" .. (rank_tallies[7] or 0), self.key)
      sendInfoMessage("" .. (rank_tallies[8] or 0), self.key)
      sendInfoMessage("" .. (rank_tallies[9] or 0), self.key)
      sendInfoMessage("" .. (rank_tallies[10] or 0), self.key)
      sendInfoMessage("" .. (rank_tallies[11] or 0), self.key)
      sendInfoMessage("" .. (rank_tallies[12] or 0), self.key)
      sendInfoMessage("" .. (rank_tallies[13] or 0), self.key)
      sendInfoMessage("" .. (rank_tallies[14] or 0), self.key)

      local candidates = {}
      for k, v in ipairs(context.scoring_hand) do
        if rank_tallies[v.rank] == 2 then
          candidates[#candidates + 1] = v
        end
      end

      if #candidates > 0 then
        for c in candidates do
          c:set_ability(G.P_CENTERS.m_glass, nil, true)
          G.E_MANAGER:add_event(Event({
            func = function()
              c:juice_up()
              return true
            end
          }))
        end
        return { message = localize("phanta_become_glass"), colour = G.C.FILTER, card = card }
      end
    end
  end
}]] --

SMODS.Joker {
  key = 'eyeofprovidence',
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

SMODS.Joker {
  key = 'emotionaldamage',
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

SMODS.Joker {
  key = 'thespear',
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
      return true
    end
  end
}

SMODS.Joker {
  key = 'thefuse',
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
      return true
    end
  end
}

SMODS.Joker {
  key = 'themace',
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
      return true
    end
  end
}

SMODS.Joker {
  key = 'thedagger',
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
      return true
    end
  end
}

SMODS.Joker {
  key = 'evidence',
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
    if context.joker_main and card.ability.extra.current_xmult > 1 then return { xmult = card.ability.extra.current_xmult } end

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
  end
}

SMODS.Joker {
  key = 'lily',
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

SMODS.Joker {
  key = 'selfportrait',
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

SMODS.Joker {
  key = 'caniossoul',
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

SMODS.Joker {
  key = 'tribouletssoul',
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

SMODS.Joker {
  key = 'yorickssoul',
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

SMODS.Joker {
  key = 'chicotssoul',
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

SMODS.Joker {
  key = 'perkeossoul',
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

    if context.end_of_round and not context.individual and not context.repetition and #G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit then
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

SMODS.Joker {
  key = 'spectretile',
  config = { extra = { odds = 3 } },
  rarity = 2,
  atlas = 'Phanta',
  pos = { x = 10, y = 5 },
  cost = 6,
  blueprint_compat = true,
  eternal_compat = true,
  perishable_compat = true,
  loc_vars = function(self, info_queue, card)
    return { vars = { (G.GAME.probabilities.normal or 1), card.ability.extra.odds } }
  end,
  calculate = function(self, card, context)
    if context.buying_card and context.card.config.center.set == "Joker" and pseudorandom('spectretile') < G.GAME.probabilities.normal / card.ability.extra.odds and #G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit then
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

SMODS.Joker {
  key = 'possession',
  config = { extra = { odds = 13 } },
  rarity = 3,
  atlas = 'Phanta',
  pos = { x = 8, y = 0 },
  soul_pos = { x = 9, y = 0 },
  cost = 8,
  blueprint_compat = true,
  eternal_compat = true,
  perishable_compat = true,
  loc_vars = function(self, info_queue, card)
    return { vars = { (G.GAME.probabilities.normal or 1), card.ability.extra.odds } }
  end,
  calculate = function(self, card, context)
    if context.buying_card and context.card.config.center.set == "Joker" and not context.card.edition and pseudorandom('possession') < G.GAME.probabilities.normal / card.ability.extra.odds then
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

SMODS.Joker {
  key = 'ignaize',
  config = { extra = { current_xmult = 1, added_xmult = 0.1 } },
  rarity = 4,
  atlas = 'Phanta',
  pos = { x = 2, y = 1 },
  soul_pos = { x = 3, y = 2,
    draw = function(card, scale_mod, rotate_mod)
      card.children.floating_sprite:draw_shader('dissolve', 0, nil, nil, card.children.center, scale_mod, rotate_mod, nil,
        0.1 + 0.03 * math.sin(1.8 * G.TIMERS.REAL), nil, 0.6)
      card.children.floating_sprite:draw_shader('dissolve', nil, nil, nil, card.children.center, scale_mod, rotate_mod)
      card.children.floating_sprite:draw_shader('voucher', 0, nil, nil, card.children.center, scale_mod, rotate_mod, nil,
        0.1 + 0.03 * math.sin(1.8 * G.TIMERS.REAL), nil, 0.6)
      card.children.floating_sprite:draw_shader('voucher', nil, nil, nil, card.children.center, scale_mod, rotate_mod)
    end },
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

SMODS.Joker {
  key = 'dimere',
  rarity = 4,
  atlas = 'Phanta',
  pos = { x = 3, y = 1 },
  soul_pos = { x = 4, y = 2,
    draw = function(card, scale_mod, rotate_mod)
      card.children.floating_sprite:draw_shader('dissolve', 0, nil, nil, card.children.center, scale_mod, rotate_mod, nil,
        0.1 + 0.03 * math.sin(1.8 * G.TIMERS.REAL), nil, 0.6)
      card.children.floating_sprite:draw_shader('dissolve', nil, nil, nil, card.children.center, scale_mod, rotate_mod)
      card.children.floating_sprite:draw_shader('voucher', 0, nil, nil, card.children.center, scale_mod, rotate_mod, nil,
        0.1 + 0.03 * math.sin(1.8 * G.TIMERS.REAL), nil, 0.6)
      card.children.floating_sprite:draw_shader('voucher', nil, nil, nil, card.children.center, scale_mod, rotate_mod)
    end },
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

SMODS.Joker {
  key = 'goldor',
  config = { extra = { money = 3, xmult = 3 } },
  rarity = 4,
  atlas = 'Phanta',
  pos = { x = 4, y = 1 },
  soul_pos = { x = 5, y = 2,
    draw = function(card, scale_mod, rotate_mod)
      card.children.floating_sprite:draw_shader('dissolve', 0, nil, nil, card.children.center, scale_mod, rotate_mod, nil,
        0.1 + 0.03 * math.sin(1.8 * G.TIMERS.REAL), nil, 0.6)
      card.children.floating_sprite:draw_shader('dissolve', nil, nil, nil, card.children.center, scale_mod, rotate_mod)
      card.children.floating_sprite:draw_shader('voucher', 0, nil, nil, card.children.center, scale_mod, rotate_mod, nil,
        0.1 + 0.03 * math.sin(1.8 * G.TIMERS.REAL), nil, 0.6)
      card.children.floating_sprite:draw_shader('voucher', nil, nil, nil, card.children.center, scale_mod, rotate_mod)
    end },
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

SMODS.Joker {
  key = 'famalia',
  rarity = 4,
  atlas = 'Phanta',
  pos = { x = 5, y = 1 },
  soul_pos = { x = 0, y = 3,
    draw = function(card, scale_mod, rotate_mod)
      card.children.floating_sprite:draw_shader('dissolve', 0, nil, nil, card.children.center, scale_mod, rotate_mod, nil,
        0.1 + 0.03 * math.sin(1.8 * G.TIMERS.REAL), nil, 0.6)
      card.children.floating_sprite:draw_shader('dissolve', nil, nil, nil, card.children.center, scale_mod, rotate_mod)
      card.children.floating_sprite:draw_shader('voucher', 0, nil, nil, card.children.center, scale_mod, rotate_mod, nil,
        0.1 + 0.03 * math.sin(1.8 * G.TIMERS.REAL), nil, 0.6)
      card.children.floating_sprite:draw_shader('voucher', nil, nil, nil, card.children.center, scale_mod, rotate_mod)
    end },
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

SMODS.Joker {
  key = 'godoor',
  config = { extra = { added_xmult = 1, current_xmult = 1, counted_rerolls = 0 } },
  rarity = 4,
  atlas = 'Phanta',
  pos = { x = 0, y = 2 },
  soul_pos = { x = 1, y = 3,
    draw = function(card, scale_mod, rotate_mod)
      card.children.floating_sprite:draw_shader('dissolve', 0, nil, nil, card.children.center, scale_mod, rotate_mod, nil,
        0.1 + 0.03 * math.sin(1.8 * G.TIMERS.REAL), nil, 0.6)
      card.children.floating_sprite:draw_shader('dissolve', nil, nil, nil, card.children.center, scale_mod, rotate_mod)
      card.children.floating_sprite:draw_shader('voucher', 0, nil, nil, card.children.center, scale_mod, rotate_mod, nil,
        0.1 + 0.03 * math.sin(1.8 * G.TIMERS.REAL), nil, 0.6)
      card.children.floating_sprite:draw_shader('voucher', nil, nil, nil, card.children.center, scale_mod, rotate_mod)
    end },
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

SMODS.Joker {
  key = 'fainfol',
  config = { extra = { xmult = 1.5 } },
  rarity = 4,
  atlas = 'Phanta',
  pos = { x = 1, y = 2 },
  soul_pos = { x = 2, y = 3,
    draw = function(card, scale_mod, rotate_mod)
      card.children.floating_sprite:draw_shader('dissolve', 0, nil, nil, card.children.center, scale_mod, rotate_mod, nil,
        0.1 + 0.03 * math.sin(1.8 * G.TIMERS.REAL), nil, 0.6)
      card.children.floating_sprite:draw_shader('dissolve', nil, nil, nil, card.children.center, scale_mod, rotate_mod)
      card.children.floating_sprite:draw_shader('voucher', 0, nil, nil, card.children.center, scale_mod, rotate_mod, nil,
        0.1 + 0.03 * math.sin(1.8 * G.TIMERS.REAL), nil, 0.6)
      card.children.floating_sprite:draw_shader('voucher', nil, nil, nil, card.children.center, scale_mod, rotate_mod)
    end },
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
  end
}

SMODS.Joker {
  key = 'granwyrm',
  config = { extra = { added_xmult = 0.8, current_unscored = 0, target_unscored = 16, current_xmult = 1 } },
  rarity = 4,
  atlas = 'Phanta',
  pos = { x = 2, y = 2 },
  --[[soul_pos = { x = 3, y = 3,
    draw = function(card, scale_mod, rotate_mod)
      card.ARGS.send_to_shader = card.ARGS.send_to_shader or {}

      card.children.floating_sprite:draw_shader(nil, 0, nil, nil, card.children.center, scale_mod, rotate_mod, nil,
        0.1 + 0.03 * math.sin(1.8 * G.TIMERS.REAL), nil, 0.6)
      card.children.floating_sprite:draw_shader(nil, nil, nil, nil, card.children.center, scale_mod, rotate_mod)
      card.children.floating_sprite:draw_shader('voucher', nil, card.ARGS.send_to_shader, nil, card.children.center,
        scale_mod, rotate_mod, nil, 0.1 + 0.03 * math.sin(1.8 * G.TIMERS.REAL), nil, 0.6)
    end },]] --
  soul_pos = { x = 3, y = 3,
    draw = function(card, scale_mod, rotate_mod)
      card.children.floating_sprite:draw_shader('dissolve', 0, nil, nil, card.children.center, scale_mod, rotate_mod, nil,
        0.1 + 0.03 * math.sin(1.8 * G.TIMERS.REAL), nil, 0.6)
      card.children.floating_sprite:draw_shader('dissolve', nil, nil, nil, card.children.center, scale_mod, rotate_mod)
      card.children.floating_sprite:draw_shader('voucher', 0, nil, nil, card.children.center, scale_mod, rotate_mod, nil,
        0.1 + 0.03 * math.sin(1.8 * G.TIMERS.REAL), nil, 0.6)
      card.children.floating_sprite:draw_shader('voucher', nil, nil, nil, card.children.center, scale_mod, rotate_mod)
    end },
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

local igo = Game.init_game_object
function Game:init_game_object()
  local ret = igo(self)
  ret.current_round.train_station_card = { id = nil, value = nil }
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
    local chosen_card = pseudorandom_element(valid_cards, pseudoseed('fainfol' .. G.GAME.round_resets.ante))
    G.GAME.current_round.fainfol_card.suit = chosen_card.base.suit
  end
  if not G.GAME.current_round.train_station_card.id then
    G.GAME.current_round.train_station_card.id = 2
  elseif G.GAME.current_round.train_station_card.id == 14 then
    G.GAME.current_round.train_station_card.id = 2
  else
    G.GAME.current_round.train_station_card.id = G.GAME.current_round.train_station_card.id + 1
  end

  local value_table = { '2', '3', '4', '5', '6', '7', '8', '9', '10', 'Jack', 'Queen', 'King', 'Ace' }
  G.GAME.current_round.train_station_card.value = value_table[G.GAME.current_round.train_station_card.id - 1]
end

local scu = set_consumeable_usage
function set_consumeable_usage(card)
  local ret = scu(card)
  if card.config.center.set == 'Spectral' then
    G.E_MANAGER:add_event(Event({
      trigger = 'immediate',
      func = function()
        G.E_MANAGER:add_event(Event({
          trigger = 'immediate',
          func = function()
            G.GAME.last_spectral = card.config.center_key
            return true
          end
        }))
        return true
      end
    }))
  end
  return ret
end

SMODS.Atlas {
  key = "Decks",
  path = "PhantaBacks.png",
  px = 71,
  py = 95
}

SMODS.Back {
  key = 'stormcaught',
  atlas = 'Decks',
  pos = { x = 0, y = 0 },
  calculate = function(self, back, context)
    if context.context == 'eval' and G.GAME.last_blind and G.GAME.last_blind.boss then
      G.E_MANAGER:add_event(Event({
        func = function()
          add_tag(Tag('tag_uncommon'))
          play_sound('generic1', 0.9 + math.random() * 0.1, 0.8)
          play_sound('holo1', 1.2 + math.random() * 0.1, 0.4)
          return true
        end
      }))
    end
  end,
  apply = function(self, back)
    G.E_MANAGER:add_event(Event({
      func = function()
        add_tag(Tag('tag_uncommon'))
        play_sound('generic1', 0.9 + math.random() * 0.1, 0.8)
        play_sound('holo1', 1.2 + math.random() * 0.1, 0.4)
        return true
      end
    }))
  end
}

SMODS.Back {
  key = 'blurple',
  atlas = 'Decks',
  pos = { x = 1, y = 0 },
  calculate = function(self, back, context)
    if context.setting_blind and #G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit then
      G.E_MANAGER:add_event(Event({
        delay = 0.3,
        blockable = false,
        func = function()
          play_sound('timpani')
          local new_card = create_card("Tarot_Planet", G.consumables, nil, nil, nil, nil, nil, 'blurpledeck')
          new_card:add_to_deck()
          G.consumeables:emplace(new_card)
          return true
        end
      }))
    end
  end
}

SMODS.Back {
  key = 'azran',
  atlas = 'Decks',
  pos = { x = 2, y = 0 }
}

SMODS.Back {
  key = 'badd',
  atlas = 'Decks',
  pos = { x = 0, y = 1 },
  calculate = function(self, back, context)
    if G.GAME.current_round.hands_left == 0 and context.destroy_card and (context.cardarea == G.play or context.cardarea == "unscored") then
      return { remove = true }
    end
  end
}

SMODS.Back {
  key = 'silver',
  atlas = 'Decks',
  pos = { x = 1, y = 1 },
  config = { extra = { given_money = 1, minus_hand_size = 1 } },
  loc_vars = function(self, info_queue, center)
    return { vars = { self.config.extra.given_money, self.config.extra.minus_hand_size } }
  end,
  apply = function(self, back)
    G.GAME.starting_params.hand_size = G.GAME.starting_params.hand_size - self.config.extra.minus_hand_size
  end,
  calculate = function(self, back, context)
    if context.individual and context.cardarea == "unscored" then
      SMODS.calculate_effect({ dollars = self.config.extra.given_money }, context.other_card)
    end
  end
}

SMODS.Sound({
  key = "tally_deck",
  path = "phanta_tally_deck.ogg",
  replace = true
})

SMODS.Back {
  key = 'tally',
  atlas = 'Decks',
  pos = { x = 2, y = 1 },
  config = { extra = { given_joker_slots = 1, triggered = false } },
  loc_vars = function(self, info_queue, center)
    return { vars = { self.config.extra.given_joker_slots, self.config.extra.minus_hand_size } }
  end,
  calculate = function(self, back, context)
    if context.setting_blind and G.GAME.blind:get_type() == "Small" and G.GAME.round_resets.ante == 5 and not self.config.extra.triggered then
      G.jokers.config.card_limit = G.jokers.config.card_limit + 1
      self.config.extra.triggered = true
      local destructable_jokers = {}
      for i = 1, #G.jokers.cards do
        if not G.jokers.cards[i].ability.eternal and not G.jokers.cards[i].getting_sliced then
          destructable_jokers[#destructable_jokers + 1] =
              G.jokers.cards[i]
        end
      end
      local joker_to_destroy = #destructable_jokers > 0 and
          pseudorandom_element(destructable_jokers, pseudoseed('tallydeck')) or nil

      if joker_to_destroy and not (context.blueprint_card or self).getting_sliced then
        joker_to_destroy.getting_sliced = true
        G.E_MANAGER:add_event(Event({
          func = function()
            play_sound("phanta_tally_deck", 1, 0.75)
            joker_to_destroy:start_dissolve({ G.C.RED }, nil, 1.6)
            return true
          end
        }))
      end
    end
  end
}

SMODS.Back {
  key = 'trickster',
  atlas = 'Decks',
  pos = { x = 0, y = 2 },
  calculate = function(self, back, context)
    if context.playing_card_added then
      for i = 1, #context.cards do
        G.E_MANAGER:add_event(Event({
          func = function()
            G.E_MANAGER:add_event(Event({
              delay = 0.3,
              blockable = false,
              func = function()
                if #G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit then
                  play_sound('timpani')
                  local new_card = create_card("Tarot", G.consumables, nil, nil, nil, nil, 'c_hanged_man')
                  new_card:add_to_deck()
                  G.consumeables:emplace(new_card)
                end
                return true
              end
            }))

            return true
          end
        }))
      end
    end
  end
}

SMODS.Back {
  key = 'barrier',
  atlas = 'Decks',
  pos = { x = 1, y = 2 },
  calculate = function(self, back, context)
    if context.skipping_booster then
      if not G.GAME.barrier_extra_hand_size then
        G.GAME.barrier_extra_hand_size = 1
      else
        G.GAME.barrier_extra_hand_size = G.GAME.barrier_extra_hand_size + 1
      end

      G.hand:change_size(1)
    end

    if context.end_of_round and G.GAME.barrier_extra_hand_size and G.GAME.barrier_extra_hand_size > 0 then
      G.hand:change_size(-G.GAME.barrier_extra_hand_size)
      G.GAME.barrier_extra_hand_size = 0
    end
  end
}

SMODS.Back {
  key = 'poltergeist',
  atlas = 'Decks',
  pos = { x = 2, y = 2 },
  config = { extra = { plus_hand_size = 2 } },
  loc_vars = function(self, info_queue, center)
    return { vars = { self.config.extra.plus_hand_size } }
  end,
  apply = function(self, back)
    G.GAME.starting_params.hand_size = G.GAME.starting_params.hand_size + self.config.extra.plus_hand_size
  end,
  calculate = function(self, back, context)
    if context.stay_flipped then
      local back_cards = 0
      for i = 1, #G.hand.cards do if G.hand.cards[i].facing == 'back' then back_cards = back_cards + 1 end end

      if back_cards < self.config.extra.plus_hand_size then
        return { stay_flipped = true }
      end
    end
  end
}

SMODS.Back {
  key = 'hivis',
  atlas = 'Decks',
  pos = { x = 0, y = 3 },
  config = { vouchers = { 'v_directors_cut' } },
  loc_vars = function(self, info_queue, card)
    return { vars = { localize({ type = 'name_text', set = 'Voucher', key = self.config.vouchers[1] }) } }
  end
}

SMODS.Back {
  key = 'crate',
  atlas = 'Decks',
  pos = { x = 1, y = 3 },
  config = { extra = { added_slots = 2 } },
  loc_vars = function(self, info_queue, card)
    return { vars = { self.config.extra.added_slots } }
  end,
  apply = function(self, back)
    G.GAME.starting_params.consumable_slots = G.GAME.starting_params.consumable_slots + self.config.extra.added_slots
  end
}

SMODS.Back {
  key = 'todayandtomorrow',
  atlas = 'Decks',
  pos = { x = 2, y = 3 }
}

local ref1 = Card.start_dissolve
function Card:start_dissolve()
  if self.config and self.config.center and self.config.center.phanta_shatters then
    return self:shatter()
  else
    return ref1(self)
  end
end
