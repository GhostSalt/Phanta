SMODS.Consumable {
  set = "Spectral",
  key = "jinn",
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

SMODS.Consumable {
  object_type = "Consumable",
  set = "Spectral",
  key = "genius",
  pos = { x = 2, y = 3 },
  config = {
    max_highlighted = 3
  },
  atlas = "PhantaTarots",
  loc_vars = function(self, info_queue, card)
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
          G.hand.highlighted[i]:set_seal(SMODS.poll_seal { type_key = "genius_seal", guaranteed = true }, true, true)
          G.hand.highlighted[i]:become_unknown("phanta_genius")
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
  end,
  in_pool = function()
    return azran_active()
  end,
  set_badges = function(self, card, badges)
    badges[#badges + 1] = create_badge(localize('phanta_azran_exclusive'), G.C.SECONDARY_SET.Spectral, G.C.WHITE, 1)
  end
}