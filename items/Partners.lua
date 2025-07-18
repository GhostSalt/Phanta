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
  config = { extra = { related_card = "j_phanta_ghost", xmult = 1.5 } },
  loc_vars = function(self, info_queue, card)
    local benefits = 0
    if next(SMODS.find_card(card.ability.extra.related_card)) then benefits = 0.5 end
    return { vars = { card.ability.extra.xmult + benefits } }
  end,
  calculate = function(self, card, context)
    if context.other_consumeable and context.other_consumeable.ability.set == "Tarot" then
      local benefits = 0
      if next(SMODS.find_card(card.ability.extra.related_card)) then benefits = 0.5 end
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
  config = { extra = { related_card = "j_phanta_cutcorners", levels = 1, all_hands = { "High Card", "Pair", "Two Pair", "Three of a Kind", "Four of a Kind" } } },
  loc_vars = function(self, info_queue, card)
    local benefits = 0
    if next(SMODS.find_card(card.ability.extra.related_card)) then benefits = 0.5 end
    return { vars = {  } }
  end,
  calculate = function(self, card, context)

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
