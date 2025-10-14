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

SMODS.Enhancement {
  key = "coppergratefresh",
  atlas = "PhantaEnhancements",
  pos = { x = 0, y = 1 },
  config = { Xmult = 2 },
  loc_vars = function(self, info_queue, center)
    if center.fake_card and not Phanta.config.copper_grate_expanded then
      info_queue[#info_queue + 1] = G.P_CENTERS.e_phanta_waxed
      return { key = "m_phanta_coppergratefreshshorter", vars = { center.ability.Xmult } }
    end
    info_queue[#info_queue + 1] = G.P_CENTERS.m_phanta_coppergrateexposed
    return { vars = { center.ability.Xmult } }
  end,
  calculate = function(self, card, context)
    if context.final_scoring_step and context.cardarea == G.play and not (card.edition and card.edition.key == 'e_phanta_waxed') and #SMODS.find_card("j_phanta_diamondaxe") == 0 then
      card:set_ability(G.P_CENTERS.m_phanta_coppergrateexposed, nil, true)
      return { message = localize('phanta_copper_grate_exposed'), colour = G.C.PHANTA.MISC_COLOURS.COPPER_EXPOSED }
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
    if center.fake_card and not Phanta.config.copper_grate_expanded then
      info_queue[#info_queue + 1] = G.P_CENTERS.e_phanta_waxed
      return { key = "m_phanta_coppergrateexposedshorter", vars = { center.ability.Xmult, center.ability.bonus } }
    end
    info_queue[#info_queue + 1] = G.P_CENTERS.m_phanta_coppergrateweathered
    return { vars = { center.ability.Xmult, center.ability.bonus } }
  end,
  calculate = function(self, card, context)
    if context.final_scoring_step and context.cardarea == G.play and not (card.edition and card.edition.key == 'e_phanta_waxed') and #SMODS.find_card("j_phanta_diamondaxe") == 0 then
      card:set_ability(G.P_CENTERS.m_phanta_coppergrateweathered, nil, true)
      return { message = localize('phanta_copper_grate_weathered'), colour = G.C.PHANTA.MISC_COLOURS.COPPER_WEATHERED }
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
    if center.fake_card and not Phanta.config.copper_grate_expanded then
      info_queue[#info_queue + 1] = G.P_CENTERS.e_phanta_waxed
      return { key = "m_phanta_coppergrateweatheredshorter", vars = { center.ability.Xmult, center.ability.bonus } }
    end
    info_queue[#info_queue + 1] = G.P_CENTERS.m_phanta_coppergrateoxidised
    return { vars = { center.ability.Xmult, center.ability.bonus } }
  end,
  calculate = function(self, card, context)
    if context.final_scoring_step and context.cardarea == G.play and not (card.edition and card.edition.key == 'e_phanta_waxed') and #SMODS.find_card("j_phanta_diamondaxe") == 0 then
      card:set_ability(G.P_CENTERS.m_phanta_coppergrateoxidised, nil, true)
      return { message = localize('phanta_copper_grate_oxidised'), colour = G.C.PHANTA.MISC_COLOURS.COPPER_OXIDISED }
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
    if center.fake_card and not Phanta.config.copper_grate_expanded then
      info_queue[#info_queue + 1] = G.P_CENTERS.e_phanta_waxed
      return { key = "m_phanta_coppergrateoxidisedshorter", vars = { center.ability.bonus } }
    end
    info_queue[#info_queue + 1] = G.P_CENTERS.e_phanta_waxed
    return { vars = { center.ability.bonus } }
  end,
  calculate = function(self, card, context)
    if context.before then card.ability.extra.primed = true end

    if context.destroy_card == card and context.cardarea == G.play and not (card.edition and card.edition.key == 'e_phanta_waxed') and #SMODS.find_card("j_phanta_diamondaxe") == 0 and card.ability.extra.primed then
      G.E_MANAGER:add_event(Event({
        func = function()
          play_sound("phanta_oxidised_break", 0.9 + math.random() * 0.1, 1)
          return true
        end
      }))
      return { remove = true }
    end
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