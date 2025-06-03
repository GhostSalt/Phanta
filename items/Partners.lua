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
    if context.other_main and context.other_card and context.other_card.ability.set == "Tarot" then
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

--[[Partner_API.Partner {
  key = "cutcorners",
  name = "Cut Corners Partner",
  unlocked = false,
  discovered = true,
  pos = { x = 1, y = 0 },
  atlas = "PhantaPartners",
  config = { extra = { related_card = "j_phanta_cutcorners",  } },
  loc_vars = function(self, info_queue, card)
    local benefits = 0
    if next(SMODS.find_card(card.ability.extra.related_card)) then benefits = 0.5 end
    return { vars = { card.ability.extra.xmult + benefits } }
  end,
  calculate = function(self, card, context)
    if context.other_main and context.other_card and context.other_card.ability.set == "Tarot" then
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
}]]--