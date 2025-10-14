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