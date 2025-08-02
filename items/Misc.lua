SMODS.current_mod.optional_features = { cardareas = { unscored = true } }

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
    if not Phanta.config["junk_enabled"] then return false end
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
  end,
  in_pool = function()
    return Phanta.config["junk_enabled"]
  end
}

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
      "when played and unscored",
      "{C:inactive}(Must have room){}"
    }
  },
  badge_colour = HEX("cccccc"),
  atlas = "PhantaEnhancements",
  pos = { x = 1, y = 0 },

  calculate = function(self, card, context)
    if context.cardarea == "unscored" and context.main_scoring and count_consumables() < G.consumeables.config.card_limit then
      G.E_MANAGER:add_event(Event({
        func = function()
          if count_consumables() < G.consumeables.config.card_limit then
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

SMODS.Tarot {
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

SMODS.Tarot {
  key = "brazier",
  loc_txt = {
    name = 'Brazier',
    text = {
      "Enhances {C:attention}#1#{}",
      "selected card into a",
      "{C:attention}Copper Grate Card{} {C:inactive}(Fresh){}"
    }
  },
  pos = { x = 2, y = 2 },
  config = {
    mod_conv = "m_phanta_coppergratefresh",
    max_highlighted = 1
  },
  atlas = "PhantaTarots",
  loc_vars = function(self, info_queue, card)
    info_queue[#info_queue + 1] = G.P_CENTERS.m_phanta_coppergratefresh
    return { vars = { card.ability.max_highlighted } }
  end
}

SMODS.Tarot {
  key = "sculptor",
  loc_txt = {
    name = 'Sculptor',
    text = {
      "Enhances {C:attention}#1#{}",
      "selected card into a",
      "{C:attention}Marble Card{}"
    }
  },
  pos = { x = 3, y = 2 },
  config = {
    mod_conv = "m_phanta_marblecard",
    max_highlighted = 1
  },
  atlas = "PhantaTarots",
  loc_vars = function(self, info_queue, card)
    info_queue[#info_queue + 1] = G.P_CENTERS.m_phanta_marblecard
    return { vars = { card.ability.max_highlighted } }
  end
}

SMODS.Tarot {
  key = "beekeeper",
  pos = { x = 3, y = 0 },
  config = {
    extra = { conv = "e_phanta_waxed" },
    max_highlighted = 3
  },
  atlas = "PhantaTarots",
  loc_vars = function(self, info_queue, card)
    info_queue[#info_queue + 1] = G.P_CENTERS.e_phanta_waxed
    return { vars = { card.ability.max_highlighted } }
  end,
  use = function(self, card, area, copier)
    G.E_MANAGER:add_event(Event({
      trigger = 'after',
      delay = 0.4,
      func = function()
        play_sound('tarot1')
        card:juice_up(0.3, 0.5)
        return true
      end
    }))
    for i = 1, #G.hand.highlighted do
      local percent = 1.15 - (i - 0.999) / (#G.hand.highlighted - 0.998) * 0.3
      G.E_MANAGER:add_event(Event({
        trigger = 'after',
        delay = 0.15,
        func = function()
          G.hand.highlighted[i]:flip()
          play_sound('card1', percent)
          G.hand.highlighted[i]:juice_up(0.3, 0.3)
          return true
        end
      }))
    end
    delay(0.2)
    for i = 1, #G.hand.highlighted do
      G.E_MANAGER:add_event(Event({
        trigger = 'after',
        delay = 0.1,
        func = function()
          G.hand.highlighted[i]:set_edition(card.ability.extra.conv, true, true)
          return true
        end
      }))
    end
    for i = 1, #G.hand.highlighted do
      local percent = 0.85 + (i - 0.999) / (#G.hand.highlighted - 0.998) * 0.3
      G.E_MANAGER:add_event(Event({
        trigger = 'after',
        delay = 0.15,
        func = function()
          G.hand.highlighted[i]:flip()
          play_sound('tarot2', percent, 0.6)
          G.hand.highlighted[i]:juice_up(0.3, 0.3)
          return true
        end
      }))
    end
    G.E_MANAGER:add_event(Event({
      trigger = 'after',
      delay = 0.2,
      func = function()
        G.hand:unhighlight_all()
        return true
      end
    }))
    delay(0.5)
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
    mod_conv = "phanta_ghostseal_seal",
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
    return G.consumeables.config.card_limit >= count_consumables() and G.GAME.last_spectral ~= nil and
        G.GAME.last_spectral ~= "c_phanta_shard"
  end,
  use = function(self, card, area, copier)
    G.E_MANAGER:add_event(Event({
      trigger = 'after',
      delay = 0.4,
      func = function()
        if G.consumeables.config.card_limit > count_consumables() then
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
    return azran_active()
  end,
  set_badges = function(self, card, badges)
    badges[#badges + 1] = create_badge(localize('phanta_azran_exclusive'), G.C.SECONDARY_SET.Spectral, G.C.WHITE, 1)
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
    return azran_active()
  end,
  set_badges = function(self, card, badges)
    badges[#badges + 1] = create_badge(localize('phanta_azran_exclusive'), G.C.SECONDARY_SET.Spectral, G.C.WHITE, 1)
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
    return azran_active()
  end,
  set_badges = function(self, card, badges)
    badges[#badges + 1] = create_badge(localize('phanta_azran_exclusive'), G.C.SECONDARY_SET.Spectral, G.C.WHITE, 1)
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
    return azran_active()
  end,
  set_badges = function(self, card, badges)
    badges[#badges + 1] = create_badge(localize('phanta_azran_exclusive'), G.C.SECONDARY_SET.Spectral, G.C.WHITE, 1)
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
    return azran_active()
  end,
  set_badges = function(self, card, badges)
    badges[#badges + 1] = create_badge(localize('phanta_azran_exclusive'), G.C.SECONDARY_SET.Spectral, G.C.WHITE, 1)
  end
}

SMODS.Consumable {
  object_type = "Consumable",
  set = "Spectral",
  key = "bazaar",
  loc_txt = {
    name = 'Bazaar',
    text = {
      "Creates a",
      "{C:attention}Voucher Tag{}"
    }
  },
  pos = { x = 1, y = 2 },
  atlas = "PhantaTarots",
  loc_vars = function(self, info_queue, card)
    info_queue[#info_queue + 1] = G.P_TAGS.tag_voucher
    return {}
  end,
  can_use = function(self, card)
    return true
  end,
  use = function(self, card, area, copier)
    G.E_MANAGER:add_event(Event({
      trigger = 'after',
      delay = 0.4,
      func = function()
        add_tag(Tag('tag_voucher'))
        play_sound('generic1', 0.9 + math.random() * 0.1, 0.8)
        play_sound('holo1', 1.2 + math.random() * 0.1, 0.4)
        card:juice_up()
        return true
      end
    }))
    delay(0.6)
  end,
  in_pool = function()
    return azran_active()
  end,
  set_badges = function(self, card, badges)
    badges[#badges + 1] = create_badge(localize('phanta_azran_exclusive'), G.C.SECONDARY_SET.Spectral, G.C.WHITE, 1)
  end
}

SMODS.Consumable {
  object_type = "Consumable",
  set = "Spectral",
  key = "handprint",
  loc_txt = {
    name = 'Handprint',
    text = {
      "Permanently gain",
      "{C:blue}+#1#{} hand per round"
    }
  },
  pos = { x = 0, y = 3 },
  config = { extra = { added_hands = 1 } },
  atlas = "PhantaTarots",
  loc_vars = function(self, info_queue, card)
    return { vars = { card.ability.extra.added_hands } }
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
        G.GAME.round_resets.hands = G.GAME.round_resets.hands + card.ability.extra.added_hands
        ease_hands_played(card.ability.extra.added_hands)
        return true
      end
    }))
    delay(0.6)
  end,
  in_pool = function()
    return azran_active()
  end,
  set_badges = function(self, card, badges)
    badges[#badges + 1] = create_badge(localize('phanta_azran_exclusive'), G.C.SECONDARY_SET.Spectral, G.C.WHITE, 1)
  end
}

SMODS.Consumable {
  object_type = "Consumable",
  set = "Spectral",
  key = "exile",
  loc_txt = {
    name = 'Exile',
    text = {
      "Permanently gain",
      "{C:red}+#1#{} discard per round"
    }
  },
  pos = { x = 1, y = 3 },
  config = { extra = { added_discards = 1 } },
  atlas = "PhantaTarots",
  loc_vars = function(self, info_queue, card)
    return { vars = { card.ability.extra.added_discards } }
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
        G.GAME.round_resets.discards = G.GAME.round_resets.discards + card.ability.extra.added_discards
        ease_discard(card.ability.extra.added_discards)
        return true
      end
    }))
    delay(0.6)
  end,
  in_pool = function()
    return azran_active()
  end,
  set_badges = function(self, card, badges)
    badges[#badges + 1] = create_badge(localize('phanta_azran_exclusive'), G.C.SECONDARY_SET.Spectral, G.C.WHITE, 1)
  end
}






SMODS.Shader {
  key = "waxed",
  path = "phanta_waxed.fs"
}

SMODS.Sound({
  key = "waxed_card",
  path = "phanta_waxed_card.ogg"
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
    if (context.main_scoring and context.cardarea == G.play) or context.post_joker then
      return {
        xmult = self.config
            .xmult
      }
    end
  end
}






SMODS.Enhancement {
  key = "coppergratefresh",
  atlas = "PhantaEnhancements",
  pos = { x = 0, y = 1 },
  config = { Xmult = 2 },
  loc_vars = function(self, info_queue, center)
    info_queue[#info_queue + 1] = G.P_CENTERS.m_phanta_coppergrateexposed
    return { vars = { center.ability.Xmult } }
  end,
  calculate = function(self, card, context)
    if context.final_scoring_step and context.cardarea == G.play and not (card.edition and card.edition.key == 'e_phanta_waxed') and #SMODS.find_card("j_phanta_diamondaxe") == 0 then
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
  config = { Xmult = 1.75, bonus = 15 },
  loc_vars = function(self, info_queue, center)
    info_queue[#info_queue + 1] = G.P_CENTERS.m_phanta_coppergrateweathered
    return { vars = { center.ability.Xmult, center.ability.bonus } }
  end,
  calculate = function(self, card, context)
    if context.final_scoring_step and context.cardarea == G.play and not (card.edition and card.edition.key == 'e_phanta_waxed') and #SMODS.find_card("j_phanta_diamondaxe") == 0 then
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
    info_queue[#info_queue + 1] = G.P_CENTERS.m_phanta_coppergrateoxidised
    return { vars = { center.ability.Xmult, center.ability.bonus } }
  end,
  calculate = function(self, card, context)
    if context.final_scoring_step and context.cardarea == G.play and not (card.edition and card.edition.key == 'e_phanta_waxed') and #SMODS.find_card("j_phanta_diamondaxe") == 0 then
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
  config = { bonus = 50, extra = { primed = false } },
  loc_vars = function(self, info_queue, center)
    info_queue[#info_queue + 1] = G.P_CENTERS.e_phanta_waxed
    return { vars = { center.ability.bonus } }
  end,
  calculate = function(self, card, context)
    if context.before then card.ability.extra.primed = true end

    if context.destroy_card == card and context.cardarea == G.play and not (card.edition and card.edition.key == 'e_phanta_waxed') and #SMODS.find_card("j_phanta_diamondaxe") == 0 and card.ability.extra.primed then return { remove = true } end
  end,
  set_badges = function(self, card, badges)
    badges[#badges + 1] = create_badge(localize('phanta_copper_grate_oxidised'), G.C.PHANTA.MISC_COLOURS.COPPER_OXIDISED,
      G.C.WHITE, 1)
  end,
  in_pool = function() return false end
}

SMODS.Enhancement {
  key = "marblecard",
  atlas = "PhantaEnhancements",
  pos = { x = 2, y = 0 },
  config = { extra = { given_xmult = 2 } },
  loc_vars = function(self, info_queue, center)
    return { vars = { center.ability.extra.given_xmult } }
  end,
  calculate = function(self, card, context)
    if context.cardarea == "unscored" and context.main_scoring then
      return { xmult = card.ability.extra.given_xmult }
    end
  end
}








local sell_use_ref = G.UIDEF.use_and_sell_buttons

function G.UIDEF.use_and_sell_buttons(card)
  if not card or ((not card.config or not card.config.center or card.config.center.key ~= "j_phanta_profile") and (not card.ability or card.ability.set ~= "phanta_Zodiac")) then
    return sell_use_ref(card, self)
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

  local more =
  {
    n = G.UIT.C,
    config = { align = "cr" },
    nodes = {
      {
        n = G.UIT.C,
        config = { ref_table = card, align = "cr", maxw = 1.25, padding = 0.1, r = 0.08, minw = 1.25, minh = (card.area and card.area.config.type == 'joker') and 0 or 1, hover = true, shadow = true, colour = G.C.RED, button = 'run_profile_menu', func = 'phanta_can_profile_more' },
        nodes = {
          { n = G.UIT.B, config = { w = 0.1, h = 0.6 } },
          { n = G.UIT.T, config = { text = localize('b_phanta_more'), colour = G.C.UI.TEXT_LIGHT, scale = 0.55, shadow = true } }
        }
      }
    }
  }

  if card.config and card.config.center and card.config.center.key == "j_phanta_profile" then
    return {
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
              nodes = { sell }
            },
            {
              n = G.UIT.R,
              config = { align = 'cl' },
              nodes = { more }
            }
          }
        }
      }
    }
  end

  if card.area == G.pack_cards and G.pack_cards then
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

  return {
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
            nodes = { sell }
          }
        }
      },
    }
  }
end

G.FUNCS.run_profile_menu = function(e)
  G.SETTINGS.paused = true
  G.FUNCS.overlay_menu {
    definition = create_profile_more_menu()
  }
end

G.FUNCS.phanta_can_profile_more = function(e)

end

function create_profile_more_menu()
  local charm = UIBox_button({ button = 'phanta_purchase_charm_tag', func = 'phanta_can_purchase_charm_tag', label = { localize({ type = 'name_text', set = 'Tag', key = 'tag_charm'}) }, minw = 5, focus_args = { snap_to = true } })
  local meteor = UIBox_button({ button = 'phanta_purchase_meteor_tag', func = 'phanta_can_purchase_meteor_tag', label = { localize({ type = 'name_text', set = 'Tag', key = 'tag_meteor'}) }, minw = 5, focus_args = { snap_to = true } })
  local ethereal = UIBox_button({ button = 'phanta_purchase_ethereal_tag', func = 'phanta_can_purchase_ethereal_tag', label = { localize({ type = 'name_text', set = 'Tag', key = 'tag_ethereal'}) }, minw = 5, focus_args = { snap_to = true } })

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
  if G.GAME.dollars - 16 < G.GAME.bankrupt_at then
    e.config.colour = G.C.UI.BACKGROUND_INACTIVE
    e.config.button = nil
  end
end

G.FUNCS.phanta_can_purchase_meteor_tag = function(e)
  if G.GAME.dollars - 16 < G.GAME.bankrupt_at then
    e.config.colour = G.C.UI.BACKGROUND_INACTIVE
    e.config.button = nil
  end
end

G.FUNCS.phanta_can_purchase_ethereal_tag = function(e)
  if G.GAME.dollars - 16 < G.GAME.bankrupt_at then
    e.config.colour = G.C.UI.BACKGROUND_INACTIVE
    e.config.button = nil
  end
end






local can_select_card_ref = G.FUNCS.can_select_card
G.FUNCS.can_select_card = function(e)
  local card = e.config.ref_table
  if card.ability.set == 'phanta_Zodiac' then
    if count_consumables() < G.consumeables.config.card_limit then
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
  select_card = "consumeables",
  in_pool = function()
    return Phanta.config["zodiac_enabled"]
  end
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
  select_card = "consumeables",
  in_pool = function()
    return Phanta.config["zodiac_enabled"]
  end
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
  select_card = "consumeables",
  in_pool = function()
    return Phanta.config["zodiac_enabled"]
  end
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
  select_card = "consumeables",
  in_pool = function()
    return Phanta.config["zodiac_enabled"]
  end
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
  select_card = "consumeables",
  in_pool = function()
    return Phanta.config["zodiac_enabled"]
  end
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
  select_card = "consumeables",
  in_pool = function()
    return Phanta.config["zodiac_enabled"]
  end
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
  select_card = "consumeables",
  in_pool = function()
    return Phanta.config["zodiac_enabled"]
  end
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
  select_card = "consumeables",
  in_pool = function()
    return Phanta.config["zodiac_enabled"]
  end
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
  end,
  in_pool = function()
    return Phanta.config["zodiac_enabled"]
  end
}

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
  config = { extra = { xmult = 1.1 } },
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



SMODS.Atlas {
  key = "PhantaZodiacUpgradesDarkHour",
  path = "PhantaZodiacUpgradesDarkHour.png",
  px = 71,
  py = 95,
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
  soul_rate = 0.005,
  can_repeat_soul = false
}



















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
    if context.context == 'eval' and G.GAME.last_blind and (G.GAME.last_blind.boss or G.GAME.selected_sleeve == "sleeve_phanta_stormcaught") then
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
    if context.setting_blind and count_consumables() < G.consumeables.config.card_limit then
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
  pos = { x = 3, y = 0 },
  calculate = function(self, back, context)
    if G.GAME.current_round.hands_left == 0 and context.destroy_card and (context.cardarea == G.play or context.cardarea == "unscored") then
      return { remove = true }
    end
  end
}

SMODS.Back {
  key = 'silver',
  atlas = 'Decks',
  pos = { x = 4, y = 0 },
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
  pos = { x = 0, y = 1 },
  config = { extra = { given_joker_slots = 1, triggered = false } },
  loc_vars = function(self, info_queue, center)
    return { vars = { self.config.extra.given_joker_slots, self.config.extra.minus_hand_size } }
  end,
  calculate = function(self, back, context)
    if context.setting_blind and G.GAME.blind:get_type() == "Small" and G.GAME.round_resets.ante == 5 and not self.config.extra.triggered then
      G.jokers.config.card_limit = G.jokers.config.card_limit + 1
      self.config.extra.triggered = true

      if G.GAME.selected_sleeve ~= "sleeve_phanta_tally" then
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
  end
}

SMODS.Back {
  key = 'trickster',
  atlas = 'Decks',
  pos = { x = 1, y = 1 },
  calculate = function(self, back, context)
    if context.playing_card_added then
      for i = 1, #context.cards do
        G.E_MANAGER:add_event(Event({
          func = function()
            G.E_MANAGER:add_event(Event({
              delay = 0.3,
              blockable = false,
              func = function()
                if count_consumables() < G.consumeables.config.card_limit then
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
  pos = { x = 2, y = 1 },
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
  pos = { x = 3, y = 1 },
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

      if back_cards < (G.GAME.selected_sleeve == "sleeve_phanta_poltergeist" and 2 or 1) * self.config.extra.plus_hand_size then
        return { stay_flipped = true }
      end
    end
  end
}

SMODS.Back {
  key = 'invisible',
  atlas = 'Decks',
  pos = { x = 4, y = 3 },
  apply = function(self, back)
    G.E_MANAGER:add_event(Event({
      func = function()
        for i = 1, #G.playing_cards do
          if G.playing_cards[i]:get_id() == 14 and G.playing_cards[i]:is_suit("Spades") then
            G.playing_cards[i]:set_seal("phanta_ghostseal", true, true)
          end
        end
        return true
      end,
    }))
  end
}

SMODS.Back {
  key = 'hivis',
  atlas = 'Decks',
  pos = { x = 4, y = 1 },
  config = { vouchers = { 'v_directors_cut' } },
  loc_vars = function(self, info_queue, card)
    return { vars = { localize({ type = 'name_text', set = 'Voucher', key = self.config.vouchers[1] }) } }
  end
}

SMODS.Back {
  key = 'crate',
  atlas = 'Decks',
  pos = { x = 0, y = 2 },
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
  pos = { x = 1, y = 2 }
}

SMODS.Back {
  key = 'hazel',
  atlas = 'Decks',
  pos = { x = 2, y = 2 }
}

local get_new_boss_ref = get_new_boss

function get_new_boss()
  if G.GAME and G.GAME.selected_back and G.GAME.selected_back and G.GAME.selected_back.effect and G.GAME.selected_back.effect.center.key == "b_phanta_hazel" then
    return "bl_final_acorn"
  else
    return get_new_boss_ref()
  end
end

SMODS.Back {
  key = 'spectrum',
  atlas = 'Decks',
  pos = { x = 3, y = 2 },
  config = { discards = 1, dollars = 10, joker_slot = 1, extra_hand_bonus = 2, extra_discard_bonus = 1, no_interest = true, extra = { removed_shop_slots = 1 } },
  loc_vars = function(self, info_queue, card)
    return { vars = { self.config.extra.removed_shop_slots } }
  end,
  apply = function(self, back)
    G.GAME.starting_params.boosters_in_shop = G.GAME.starting_params.boosters_in_shop -
        self.config.extra.removed_shop_slots
  end
}



SMODS.Sound({
  key = "charged_deck",
  path = "phanta_charged_deck.ogg"
})

SMODS.Back {
  key = 'bloodred',
  atlas = 'Decks',
  pos = { x = 4, y = 2 },
  config = { extra = { discards = 3 } },
  loc_vars = function(self, info_queue, card)
    return { vars = { self.config.extra.discards } }
  end,
  calculate = function(self, back, context)
    if context.setting_blind and is_blind_boss() then
      G.E_MANAGER:add_event(Event({
        func = function()
          ease_discard(self.config.extra.discards)
          play_sound('phanta_charged_deck', 1, 0.75)
          return true
        end
      }))
    end
  end
}

SMODS.Back {
  key = 'deepblue',
  atlas = 'Decks',
  pos = { x = 0, y = 3 },
  config = { extra = { hands = 3 } },
  loc_vars = function(self, info_queue, card)
    return { vars = { self.config.extra.hands } }
  end,
  calculate = function(self, back, context)
    if context.setting_blind and is_blind_boss() then
      G.E_MANAGER:add_event(Event({
        func = function()
          ease_hands_played(self.config.extra.hands)
          play_sound('phanta_charged_deck', 1, 0.75)
          return true
        end
      }))
    end
  end
}

SMODS.Back {
  key = 'canaryyellow',
  atlas = 'Decks',
  pos = { x = 1, y = 3 },
  apply = function(self, back)
    G.E_MANAGER:add_event(Event({
      func = function()
        if G.jokers then
          local edition = G.GAME and G.GAME.selected_sleeve == "sleeve_phanta_canaryyellow" and "e_negative" or nil
          local no_edition = G.GAME and G.GAME.selected_sleeve == "sleeve_phanta_canaryyellow" and nil or true
          local card = SMODS.create_card({
            set = "Joker",
            area = G.jokers,
            key = "j_mail",
            no_edition = no_edition,
            edition =
                edition
          })
          card:add_to_deck()
          card:start_materialize()
          if G.GAME and G.GAME.selected_sleeve == "sleeve_phanta_canaryyellow" and "e_negative" then
            card:set_eternal(true)
          end
          G.jokers:emplace(card)
          return true
        end
      end
    }))
  end
}

SMODS.Back {
  key = 'meangreen',
  atlas = 'Decks',
  pos = { x = 2, y = 3 },
  config = { extra_hand_bonus = 0, extra = { extra_interest = 1 } },
  loc_vars = function(self, info_queue, card)
    return { vars = { self.config.extra.extra_interest + 1, self.config.extra_hand_bonus } }
  end,
  apply = function(self, back)
    G.GAME.interest_amount = G.GAME.interest_amount + self.config.extra.extra_interest
  end
}

SMODS.Back {
  key = 'pitchblack',
  atlas = 'Decks',
  pos = { x = 3, y = 3 },
  config = { vouchers = { 'v_overstock_norm' } },
  loc_vars = function(self, info_queue, card)
    return { vars = { localize({ type = 'name_text', set = 'Voucher', key = self.config.vouchers[1] }) } }
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

SMODS.PokerHand:take_ownership('Full House', {
  evaluate = function(parts, hand)
    if (#parts._3 < 1 and not (G.GAME.selected_partner == "pnr_phanta_conspiracist" and next(SMODS.find_card("j_phanta_conspiracist")))) or #parts._2 < 2 then return {} end
    return parts._all_pairs
  end
}, true)








SMODS.Atlas {
  key = "PhantaVouchers",
  path = "PhantaVouchers.png",
  px = 71,
  py = 95
}

SMODS.Voucher {
  key = "tabloid",
  pos = { x = 0, y = 0 },
  draw = function(self, card, layer)
    if self.discovered or card.params.bypass_discovery_center then
      card.children.center:draw_shader('booster', nil, card.ARGS.send_to_shader)
    end
  end,
  cost = 10,
  atlas = "PhantaVouchers",
  redeem = function(self, card)
    G.P_CENTERS["c_star"].in_pool = function() return false end
    G.P_CENTERS["c_moon"].in_pool = function() return false end
    G.P_CENTERS["c_sun"].in_pool = function() return false end
    G.P_CENTERS["c_world"].in_pool = function() return false end
  end
}

SMODS.Voucher {
  key = "broadcast",
  pos = { x = 1, y = 0 },
  draw = function(self, card, layer)
    if self.discovered or card.params.bypass_discovery_center then
      card.children.center:draw_shader('booster', nil, card.ARGS.send_to_shader)
    end
  end,
  cost = 10,
  atlas = "PhantaVouchers",
  requires = { 'v_phanta_tabloid' },
  redeem = function(self, card)
    G.P_CENTERS["c_hex"].in_pool = function() return false end
    G.P_CENTERS["c_ankh"].in_pool = function() return false end
    G.P_CENTERS["c_ouija"].in_pool = function() return false end
    G.P_CENTERS["c_sigil"].in_pool = function() return false end
  end
}
