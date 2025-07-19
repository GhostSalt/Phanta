SMODS.current_mod.optional_features = { cardareas = { unscored = true } }

SMODS.Atlas {
  key = "PhantaPartners",
  px = 46,
  py = 58,
  path = "PhantaPartners.png"
}

Partner_API.Partner {
  key = "ghost",
  name = "Ghost Partner",
  unlocked = false,
  discovered = true,
  pos = { x = 0, y = 0 },
  draw = function(self, card, layer)
    card.children.center:draw_shader('voucher', nil, card.ARGS.send_to_shader)
  end,
  atlas = "PhantaPartners",
  individual_quips = true,
  config = { extra = { xmult = 1.5 } },
  link_config = { j_phanta_ghost = 1 },
  loc_vars = function(self, info_queue, card)
    local benefits = 0
    --[[if next(SMODS.find_card(card.ability.extra.related_card))]] -- then benefits = 0.5 end
    if link_level == 1 then benefits = 0.5 end
    return { vars = { card.ability.extra.xmult + benefits } }
  end,
  calculate = function(self, card, context)
    if context.other_consumeable and context.other_consumeable.ability.set == "Tarot" then
      local benefits = 0
      if link_level == 1 then benefits = 0.5 end
      return { xmult = card.ability.extra.xmult + benefits }
    end
  end,
  check_for_unlock = function(self, args)
    for _, v in pairs(G.P_CENTER_POOLS["Joker"]) do
      if v.key == "j_phanta_ghost" then
        if get_joker_win_sticker(v, true) >= 8 then
          return true
        end
        break
      end
    end
  end
}

Partner_API.Partner {
  key = "cutcorners",
  name = "Cut Corners Partner",
  unlocked = false,
  discovered = true,
  pos = { x = 1, y = 0 },
  atlas = "PhantaPartners",
  config = { extra = { levels = 1, all_hands = { "High Card", "Pair", "Two Pair", "Three of a Kind", "Four of a Kind" }, xmult = 2, hand_threshold = 4 } },
  link_config = { j_phanta_cutcorners = 1 },
  loc_vars = function(self, info_queue, card)
    local link_level = self:get_link_level()
    local key = self.key
    if link_level == 1 then key = key .. "_" .. link_level end
    return { key = key, vars = { card.ability.extra.levels + 1, card.ability.extra.xmult, card.ability.extra.hand_threshold } }
  end,
  calculate = function(self, card, context)
    if self:get_link_level() == 1 and context.joker_main and G.GAME.current_round.hands_left < card.ability.extra.hand_threshold then
      return { xmult = card.ability.extra.xmult }
    end
  end,
  calculate_begin = function(self, card)
    for k, v in pairs(G.GAME.hands) do
      local counts = false
      for _, name in ipairs(card.ability.extra.all_hands) do
        counts = counts or k == name
      end
      if counts then
        level_up_hand(card, k, true, card.ability.extra.levels)
      end
    end
  end,
  check_for_unlock = function(self, args)
    for _, v in pairs(G.P_CENTER_POOLS["Joker"]) do
      if v.key == "j_phanta_cutcorners" then
        if get_joker_win_sticker(v, true) >= 8 then
          return true
        end
        break
      end
    end
  end
}

Partner_API.Partner {
  key = "nojoke",
  name = "No Joke Partner",
  unlocked = false,
  discovered = true,
  pos = { x = 3, y = 0 },
  atlas = "PhantaPartners",
  config = { extra = { init_levels = 3, after_levels = 1, xmult = 2, hand_threshold = 4 } },
  link_config = { j_phanta_nojoke = 1 },
  loc_vars = function(self, info_queue, card)
    local link_level = self:get_link_level()
    local key = self.key
    if link_level == 1 then key = key .. "_" .. link_level end
    return { key = key, vars = { card.ability.extra.init_levels + 1, card.ability.extra.after_levels } }
  end,
  calculate = function(self, card, context)
    local link_level = self:get_link_level()
    if context.setting_blind and link_level == 1 and is_blind_boss() then
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
          level_up_hand(card, "Straight", nil, card.ability.extra.after_levels)
          update_hand_text({ sound = 'button', volume = 0.7, pitch = 0.8, delay = 0.3 },
            { mult = 0, chips = 0, handname = '', level = '' })
          return true
        end
      }))
    end
  end,
  calculate_begin = function(self, card)
    level_up_hand(card, "Straight", true, card.ability.extra.init_levels)
  end,
  check_for_unlock = function(self, args)
    for _, v in pairs(G.P_CENTER_POOLS["Joker"]) do
      if v.key == "j_phanta_nojoke" then
        if get_joker_win_sticker(v, true) >= 8 then
          return true
        end
        break
      end
    end
  end
}
