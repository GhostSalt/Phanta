local jd_def = JokerDisplay.Definitions

jd_def["j_phanta_normalface"] = {
  text = {
    { text = "+" },
    { ref_table = "card.ability.extra", ref_value = "mult", retrigger_type = "mult" }
  },
  text_config = { colour = G.C.MULT }
}

jd_def["j_phanta_peekaboo"] = {
  text = {
    { text = "+" },
    { ref_table = "card.ability.extra", ref_value = "mult", retrigger_type = "mult" }
  },
  text_config = { colour = G.C.MULT }
}

jd_def["j_phanta_topsyturvy"] = {
  text = {
    { text = "+",                              colour = G.C.CHIPS },
    { ref_table = "card.joker_display_values", ref_value = "chips", colour = G.C.CHIPS, retrigger_type = "mult" }
  },
  reminder_text = {
    { ref_table = "card.joker_display_values", ref_value = "localised_text" }
  },
  calc_function = function(card)
    local chips = 0
    local text, _, scoring_hand = JokerDisplay.evaluate_hand()
    if text ~= 'Unknown' then
      for _, v in pairs(scoring_hand) do
        if v:get_id() and v:get_id() == 2 then
          local retriggers = JokerDisplay.calculate_card_triggers(v, scoring_hand)
          chips = chips + card.ability.extra.two_given_chips * retriggers
        elseif v:get_id() and v:get_id() == 3 then
          local retriggers = JokerDisplay.calculate_card_triggers(v, scoring_hand)
          chips = chips + card.ability.extra.three_given_chips * retriggers
        end
      end
    end
    card.joker_display_values.chips = chips
    card.joker_display_values.localised_text = "(" .. localize("k_phanta_twos") .. ", " .. localize("k_phanta_threes") .. ")"
  end
}

jd_def["j_phanta_giveway"] = {
  text = {
    {
      border_nodes = {
        { text = "X" },
        { ref_table = "card.ability.extra", ref_value = "xmult", retrigger_type = "exp" }
      }
    }
  },
  reminder_text = {
    { text = "(" },
    { ref_table = "card.joker_display_values", ref_value = "localised_text", colour = G.C.FILTER },
    { text = ")" }
  },
  calc_function = function(card)
    card.joker_display_values.localised_text = localize("k_phanta_before_scoring")
  end
}

jd_def["j_phanta_tipoftheiceberg"] = {
  text = {
    { text = "+" },
    { ref_table = "card.ability.extra", ref_value = "current_chips", retrigger_type = "mult" }
  },
  text_config = { colour = G.C.CHIPS }
}

jd_def["j_phanta_sailthestyx"] = {
  text = {
    { ref_table = "card.joker_display_values", ref_value = "active" }
  },
  calc_function = function(card)
    card.joker_display_values.active = card.ability.extra.slots_given and localize("k_active")
        or (card.ability.extra.current_sold .. "/" .. card.ability.extra.target_sold)
  end
}

jd_def["j_phanta_goldenghost"] = {
  text = {
    { text = "+$" },
    { ref_table = "card.joker_display_values", ref_value = "money" }
  },
  text_config = { colour = G.C.GOLD },
  reminder_text = {
    { ref_table = "card.joker_display_values", ref_value = "localised_text" }
  },
  calc_function = function(card)
    card.joker_display_values.money = card.ability.extra.current_money
    card.joker_display_values.localised_text = "(" .. localize("k_round") .. ")"
  end
}

jd_def["j_phanta_liam"] = {
  text = {
    {
      border_nodes = {
        { text = "X" },
        { ref_table = "card.joker_display_values", ref_value = "xmult", retrigger_type = "exp" }
      }
    }
  },
  calc_function = function(card)
    local gives = false
    local me = nil
    for i = 1, #G.jokers.cards do
      if G.jokers.cards[i] == card then
        me = i; break
      end
    end

    if me and me >= 1 and me <= #G.jokers.cards and G.jokers.cards[me + 1] and G.jokers.cards[me + 1]:is_rarity("Rare") then
      gives = true
    end

    card.joker_display_values.xmult = gives and card.ability.extra.xmult or 1
  end
}

jd_def["j_phanta_datacube"] = {
  text = {
    { text = "+$" },
    { ref_table = "card.joker_display_values", ref_value = "dollars", retrigger_type = "mult" }
  },
  text_config = { colour = G.C.GOLD },
  reminder_text = {
    { text = "(" },
    { ref_table = "card.joker_display_values", ref_value = "datacube_card_rank", colour = G.C.FILTER },
    { text = ")" }
  },
  calc_function = function(card)
    card.joker_display_values.datacube_card_rank = localize((G.GAME.current_round.datacube_card.value or 2) .. "", 'ranks')

    local dollars = 0
    local text, _, scoring_hand = JokerDisplay.evaluate_hand()
    if text ~= 'Unknown' then
      for _, v in pairs(scoring_hand) do
        if v:get_id() and v:get_id() == G.GAME.current_round.datacube_card.id then
          dollars = card.ability.extra.money; break
        end
      end
    end
    card.joker_display_values.dollars = dollars
  end
}

jd_def["j_phanta_longtail"] = {
  text = {
    { text = "+$" },
    { ref_table = "card.joker_display_values", ref_value = "money", retrigger_type = "mult" }
  },
  text_config = { colour = G.C.GOLD },
  reminder_text = {
    { text = "(" },
    { ref_table = "card.joker_display_values", ref_value = "localised_text" },
    { text = ")" }
  },
  calc_function = function(card)
    local text, disp_text = G.FUNCS.get_poker_hand_info(G.hand.highlighted)
    local _text, _, scoring_hand = JokerDisplay.evaluate_hand()
    local is_valid = true
    if _text ~= 'Unknown' then
      for _, scoring_card in pairs(scoring_hand) do
        if scoring_card:is_face() then
          is_valid = false
          break
        end
      end
    end

    card.joker_display_values.money = text == "Straight" and is_valid and card.ability.extra.money or 0
    card.joker_display_values.localised_text = localize("Straight", "poker_hands")
  end
}

jd_def["j_phanta_luckynumber"] = {
  text = {
    { ref_table = "card.joker_display_values", ref_value = "count", retrigger_type = "mult" },
    { text = "x",                              scale = 0.35 },
    { text = "$",                              colour = G.C.GOLD },
    { ref_table = "card.joker_display_values", ref_value = "money", retrigger_type = "mult", colour = G.C.GOLD },
  },
  extra = {
    {
      { text = "(" },
      { ref_table = "card.joker_display_values", ref_value = "odds" },
      { text = ")" },
    }
  },
  extra_config = { colour = G.C.GREEN, scale = 0.3 },
  calc_function = function(card)
    local count = 0
    local text, _, scoring_hand = JokerDisplay.evaluate_hand()
    if text ~= 'Unknown' then
      for _, scoring_card in pairs(scoring_hand) do
        if scoring_card:get_id() == 3 or scoring_card:get_id() == 4 or scoring_card:get_id() == 9 then
          count = count + JokerDisplay.calculate_card_triggers(scoring_card, scoring_hand)
        end
      end
    end
    card.joker_display_values.count = count
    card.joker_display_values.money = card.ability.extra.money
    local numerator, denominator = 1, card.ability.extra.odds
    if SMODS then numerator, denominator = SMODS.get_probability_vars(card, numerator, denominator, "luckynumber") end
    card.joker_display_values.odds = localize { type = 'variable', key = "jdis_odds", vars = { numerator, denominator } }
  end
}

jd_def["j_phanta_absentjoker"] = {
  text = {
    { text = "+" },
    { ref_table = "card.joker_display_values", ref_value = "mult", retrigger_type = "mult" }
  },
  text_config = { colour = G.C.MULT },
  calc_function = function(card)
    card.joker_display_values.mult = G.jokers.config.card_limit - #G.jokers.cards >= 1 and card.ability.extra.mult or 0
  end
}

jd_def["j_phanta_pottedpeashooter"] = {
  text = {
    { text = "+" },
    { ref_table = "card.joker_display_values", ref_value = "mult", retrigger_type = "mult" }
  },
  text_config = { colour = G.C.MULT },
  calc_function = function(card)
    card.joker_display_values.mult = G.jokers.cards[#G.jokers.cards] == card and card.ability.extra.mult or 0
  end
}

jd_def["j_phanta_venndiagram"] = {
  text = {
    { text = "+" },
    { ref_table = "card.ability.extra", ref_value = "current_chips", retrigger_type = "mult" }
  },
  text_config = { colour = G.C.CHIPS }
}

jd_def["j_phanta_visionary"] = {
  text = {
    {
      border_nodes = {
        { text = "X" },
        { ref_table = "card.ability.extra", ref_value = "current_xmult", retrigger_type = "exp" }
      }
    }
  }
}

jd_def["j_phanta_88888888"] = {
  text = {
    { text = "+",                              colour = G.C.CHIPS },
    { ref_table = "card.joker_display_values", ref_value = "chips", colour = G.C.CHIPS, retrigger_type = "mult" },
    { text = " +",                             colour = G.C.MULT },
    { ref_table = "card.joker_display_values", ref_value = "mult",  colour = G.C.MULT,  retrigger_type = "mult" }
  },
  reminder_text = {
    { ref_table = "card.joker_display_values", ref_value = "localised_text" }
  },
  calc_function = function(card)
    local chips = 0
    local mult = 0
    local text, _, scoring_hand = JokerDisplay.evaluate_hand()
    if text ~= 'Unknown' then
      for _, v in pairs(scoring_hand) do
        if v:get_id() and v:get_id() == 8 then
          local retriggers = JokerDisplay.calculate_card_triggers(v, scoring_hand)
          chips = chips + card.ability.extra.given_chips * retriggers
          mult = mult + card.ability.extra.given_mult * retriggers
        end
      end
    end
    card.joker_display_values.chips = chips
    card.joker_display_values.mult = mult
    card.joker_display_values.localised_text = "(" .. localize("k_phanta_eights") .. ")"
  end
}

jd_def["j_phanta_flushed"] = {
  text = {
    { text = "+" },
    { ref_table = "card.ability.extra", ref_value = "current_mult", retrigger_type = "mult" }
  },
  text_config = { colour = G.C.MULT }
}

jd_def["j_phanta_thumper"] = {
  text = {
    { ref_table = "card.joker_display_values", ref_value = "count", retrigger_type = "mult" },
    { text = "x",                              scale = 0.35 },
    { text = "$",                              colour = G.C.GOLD },
    { ref_table = "card.joker_display_values", ref_value = "money", retrigger_type = "mult", colour = G.C.GOLD },
  },
  extra = {
    {
      { text = "(" },
      { ref_table = "card.joker_display_values", ref_value = "odds" },
      { text = ")" },
    }
  },
  extra_config = { colour = G.C.GREEN, scale = 0.3 },
  calc_function = function(card)
    local count = 0
    local text, _, scoring_hand = JokerDisplay.evaluate_hand()
    if text ~= 'Unknown' then
      for _, v in pairs(next(G.play.cards) and G.play.cards or G.hand.highlighted) do
        if not SMODS.in_scoring(v, scoring_hand) and v:is_face() then
          count = count + JokerDisplay.calculate_card_triggers(v, scoring_hand)
        end
      end
    end
    card.joker_display_values.count = count
    card.joker_display_values.money = card.ability.extra.money
    local numerator, denominator = 1, card.ability.extra.odds
    if SMODS then numerator, denominator = SMODS.get_probability_vars(card, numerator, denominator, "thumper") end
    card.joker_display_values.odds = localize { type = 'variable', key = "jdis_odds", vars = { numerator, denominator } }
  end
}

jd_def["j_phanta_coldjoker"] = {
  text = {
    { text = "+" },
    { ref_table = "card.ability.extra", ref_value = "current_chips", retrigger_type = "mult" }
  },
  text_config = { colour = G.C.CHIPS }
}

jd_def["j_phanta_patientjoker"] = {
  text = {
    { text = "+" },
    { ref_table = "card.joker_display_values", ref_value = "mult", retrigger_type = "mult" }
  },
  text_config = { colour = G.C.MULT },
  reminder_text = {
    { text = "(" },
    { ref_table = "card.joker_display_values", ref_value = "localised_text", colour = lighten(G.C.SUITS["Diamonds"], 0.35) },
    { text = ")" }
  },
  calc_function = function(card)
    local diamonds = 0
    local text, _, scoring_hand = JokerDisplay.evaluate_hand()
    if text ~= 'Unknown' then
      for _, v in pairs(scoring_hand) do
        if v:is_suit("Diamonds") then
          diamonds = diamonds + 1
        end
      end
    end
    card.joker_display_values.mult = diamonds > 0 and card.ability.extra.mult or 0
    card.joker_display_values.localised_text = localize("Diamonds", "suits_plural")
  end
}

jd_def["j_phanta_blissedjoker"] = {
  text = {
    { text = "+" },
    { ref_table = "card.joker_display_values", ref_value = "mult", retrigger_type = "mult" }
  },
  text_config = { colour = G.C.MULT },
  reminder_text = {
    { text = "(" },
    { ref_table = "card.joker_display_values", ref_value = "localised_text", colour = lighten(G.C.SUITS["Hearts"], 0.35) },
    { text = ")" }
  },
  calc_function = function(card)
    local hearts = 0
    local text, _, scoring_hand = JokerDisplay.evaluate_hand()
    if text ~= 'Unknown' then
      for _, v in pairs(scoring_hand) do
        if v:is_suit("Hearts") then
          hearts = hearts + 1
        end
      end
    end
    card.joker_display_values.mult = hearts > 0 and card.ability.extra.mult or 0
    card.joker_display_values.localised_text = localize("Hearts", "suits_plural")
  end
}

jd_def["j_phanta_forgivingjoker"] = {
  text = {
    { text = "+" },
    { ref_table = "card.joker_display_values", ref_value = "mult", retrigger_type = "mult" }
  },
  text_config = { colour = G.C.MULT },
  reminder_text = {
    { text = "(" },
    { ref_table = "card.joker_display_values", ref_value = "localised_text", colour = lighten(G.C.SUITS["Spades"], 0.35) },
    { text = ")" }
  },
  calc_function = function(card)
    local spades = 0
    local text, _, scoring_hand = JokerDisplay.evaluate_hand()
    if text ~= 'Unknown' then
      for _, v in pairs(scoring_hand) do
        if v:is_suit("Spades") then
          spades = spades + 1
        end
      end
    end
    card.joker_display_values.mult = spades > 0 and card.ability.extra.mult or 0
    card.joker_display_values.localised_text = localize("Spades", "suits_plural")
  end
}

jd_def["j_phanta_temperedjoker"] = {
  text = {
    { text = "+" },
    { ref_table = "card.joker_display_values", ref_value = "mult", retrigger_type = "mult" }
  },
  text_config = { colour = G.C.MULT },
  reminder_text = {
    { text = "(" },
    { ref_table = "card.joker_display_values", ref_value = "localised_text", colour = lighten(G.C.SUITS["Clubs"], 0.35) },
    { text = ")" }
  },
  calc_function = function(card)
    local clubs = 0
    local text, _, scoring_hand = JokerDisplay.evaluate_hand()
    if text ~= 'Unknown' then
      for _, v in pairs(scoring_hand) do
        if v:is_suit("Clubs") then
          clubs = clubs + 1
        end
      end
    end
    card.joker_display_values.mult = clubs > 0 and card.ability.extra.mult or 0
    card.joker_display_values.localised_text = localize("Clubs", "suits_plural")
  end
}

jd_def["j_phanta_returnticket"] = {
  text = {
    { ref_table = "card.joker_display_values", ref_value = "active" }
  },
  calc_function = function(card)
    card.joker_display_values.active = card.ability.extra.current_rounds >= card.ability.extra.rounds_required and localize("k_active")
        or (card.ability.extra.current_rounds .. "/" .. card.ability.extra.rounds_required)
  end
}

jd_def["j_phanta_testpage"] = {
  text = {
    { text = "+" },
    { ref_table = "card.ability.extra", ref_value = "current_chips", retrigger_type = "mult" }
  },
  text_config = { colour = G.C.CHIPS }
}

jd_def["j_phanta_flagsignal"] = {
  text = {
    { text = "+" },
    { ref_table = "card.ability.extra", ref_value = "current_mult", retrigger_type = "mult" }
  },
  text_config = { colour = G.C.MULT }
}

jd_def["j_phanta_signofthehorns"] = {
  text = {
    { text = "+" },
    { ref_table = "card.joker_display_values", ref_value = "mult", retrigger_type = "mult" },
  },
  text_config = { colour = G.C.MULT },
  calc_function = function(card)
    local playing_hand = next(G.play.cards)
    local mult = 0
    for _, playing_card in ipairs(G.hand.cards) do
      if playing_hand or not playing_card.highlighted then
        if playing_card.facing and not (playing_card.facing == 'back') and not playing_card.debuff and playing_card:get_id() == 3 then
          mult = mult + card.ability.extra.mult * JokerDisplay.calculate_card_triggers(playing_card, nil, true)
        end
      end
    end
    card.joker_display_values.mult = mult
  end
}

jd_def["j_phanta_jackolantern"] = {
  text = {
    {
      border_nodes = {
        { text = "X" },
        { ref_table = "card.joker_display_values", ref_value = "xmult", retrigger_type = "exp" }
      }
    }
  },
  reminder_text = {
    { text = "(" },
    { ref_table = "card.joker_display_values", ref_value = "localised_text", colour = G.C.FILTER },
    { text = ")" }
  },
  calc_function = function(card)
    local xmult = 1
    local text, _, scoring_hand = JokerDisplay.evaluate_hand()
    if text ~= 'Unknown' then
      for _, v in pairs(next(G.play.cards) and G.play.cards or G.hand.highlighted) do
        if SMODS.in_scoring(v, scoring_hand) and v:is_face() and next(SMODS.get_enhancements(v)) then
          xmult = xmult * (card.ability.extra.xmult ^ JokerDisplay.calculate_card_triggers(v, scoring_hand))
        end
      end
    end
    card.joker_display_values.xmult = xmult
    card.joker_display_values.localised_text = localize("k_phanta_enhanced_faces")
  end
}

jd_def["j_phanta_runicjoker"] = {
  text = {
    {
      border_nodes = {
        { text = "X" },
        { ref_table = "card.joker_display_values", ref_value = "xmult", retrigger_type = "exp" }
      }
    }
  },
  reminder_text = {
    { text = "(" },
    { ref_table = "card.joker_display_values", ref_value = "localised_text", colour = G.C.FILTER },
    { text = ")" }
  },
  calc_function = function(card)
    local xmult = 1
    local text, _, scoring_hand = JokerDisplay.evaluate_hand()
    if text ~= 'Unknown' then
      for _, v in pairs(next(G.play.cards) and G.play.cards or G.hand.highlighted) do
        if SMODS.in_scoring(v, scoring_hand) and SMODS.has_enhancement(v, "m_stone") then
          xmult = xmult * (card.ability.extra.xmult ^ JokerDisplay.calculate_card_triggers(v, scoring_hand))
        end
      end
    end
    card.joker_display_values.xmult = xmult
    card.joker_display_values.localised_text = localize("k_phanta_stone_cards")
  end
}

jd_def["j_phanta_heartbreak"] = {
  text = {
    {
      border_nodes = {
        { text = "X" },
        { ref_table = "card.joker_display_values", ref_value = "xmult", retrigger_type = "exp" }
      }
    }
  },
  reminder_text = {
    { text = "(" },
    { ref_table = "card.joker_display_values", ref_value = "localised_text", colour = lighten(G.C.SUITS["Hearts"], 0.35) },
    { text = ")" }
  },
  calc_function = function(card)
    local xmult = 1
    local text, _, scoring_hand = JokerDisplay.evaluate_hand()
    if text ~= 'Unknown' then
      for _, v in pairs(next(G.play.cards) and G.play.cards or G.hand.highlighted) do
        if SMODS.in_scoring(v, scoring_hand) then
          xmult = xmult * (card.ability.extra.current_xmult ^ JokerDisplay.calculate_card_triggers(v, scoring_hand))
        end
      end
    end
    card.joker_display_values.xmult = xmult
    card.joker_display_values.localised_text = localize("Hearts", "suits_plural")
  end
}

jd_def["j_phanta_distance"] = {
  text = {
    { text = "+" },
    { ref_table = "card.ability.extra", ref_value = "chips", retrigger_type = "mult" }
  },
  text_config = { colour = G.C.CHIPS },
}

jd_def["j_phanta_thefall"] = {
  text = {
    {
      border_nodes = {
        { text = "X" },
        { ref_table = "card.ability.extra", ref_value = "current_xmult", retrigger_type = "exp" }
      }
    }
  }
}

jd_def["j_phanta_barton"] = {
  text = {
    { text = "+" },
    { ref_table = "card.joker_display_values", ref_value = "mult", retrigger_type = "mult" }
  },
  reminder_text = {
    { text = "(" },
    { ref_table = "card.joker_display_values", ref_value = "localised_text" },
    { text = ")" }
  },
  text_config = { colour = G.C.MULT },
  calc_function = function(card)
    card.joker_display_values.mult = (next(SMODS.find_card("j_phanta_inspectorchelmey")) or count_unique_tarots() >= card.ability.extra.requirement) and card.ability.extra.mult or 0
    card.joker_display_values.localised_text = count_unique_tarots() .. "/" .. card.ability.extra.requirement
  end
}

jd_def["j_phanta_inspectorchelmey"] = {
  text = {
    {
      border_nodes = {
        { text = "X" },
        { ref_table = "card.joker_display_values", ref_value = "xmult", retrigger_type = "exp" }
      }
    }
  },
  reminder_text = {
    { text = "(" },
    { ref_table = "card.joker_display_values", ref_value = "localised_text" },
    { text = ")" }
  },
  calc_function = function(card)
    card.joker_display_values.xmult = (next(SMODS.find_card("j_phanta_barton")) or count_unique_planets() >= card.ability.extra.requirement) and card.ability.extra.xmult or 1
    card.joker_display_values.localised_text = count_unique_planets() .. "/" .. card.ability.extra.requirement
  end
}

jd_def["j_phanta_zeroii"] = {
  extra = {
    {
      { text = "(" },
      { ref_table = "card.joker_display_values", ref_value = "odds" },
      { text = ")" }
    }
  },
  extra_config = { colour = G.C.GREEN, scale = 0.3 },
  calc_function = function(card)
    local numerator, denominator = SMODS.get_probability_vars(card, 1, card.ability.extra.odds, "zeroii")
    card.joker_display_values.odds = localize { type = 'variable', key = "jdis_odds", vars = { numerator, denominator } }
  end
}

jd_def["j_phanta_theriddler"] = {
  text = {
    {
      border_nodes = {
        { text = "X" },
        { ref_table = "card.ability.extra", ref_value = "xmult", retrigger_type = "exp" }
      }
    }
  },
}

jd_def["j_phanta_yatagarasucard"] = {
  text = {
    { text = "+$" },
    { ref_table = "card.joker_display_values", ref_value = "dollars", retrigger_type = "mult" },
  },
  text_config = { colour = G.C.GOLD },
  reminder_text = {
    { text = "(" },
    { ref_table = "card.joker_display_values", ref_value = "localized_text", colour = G.C.FILTER },
    { text = ")" }
  },
  calc_function = function(card)
    local dollars = 0
    local text, _, scoring_hand = JokerDisplay.evaluate_hand()
    if text ~= 'Unknown' then
      for _, v in pairs(scoring_hand) do
        if v:get_id() and v:get_id() == 3 then
          dollars = dollars + card.ability.extra.money * JokerDisplay.calculate_card_triggers(v, scoring_hand)
        end
      end
    end
    card.joker_display_values.dollars = dollars
    card.joker_display_values.localized_text = localize("k_phanta_threes")
  end
}

jd_def["j_phanta_widget"] = {
  text = {
    {
      border_nodes = {
        { text = "X" },
        { ref_table = "card.ability.extra", ref_value = "current_xmult", retrigger_type = "exp" }
      }
    }
  },
  reminder_text = {
    { text = "(" },
    { ref_table = "card.joker_display_values", ref_value = "widget_suit" },
    { text = ")" }
  },
  calc_function = function(card)
    card.joker_display_values.widget_suit = localize(G.GAME.current_round.phanta_widget_suit, 'suits_singular')
  end,
  style_function = function(card, text, reminder_text, extra)
    if reminder_text and reminder_text.children[2] then
      reminder_text.children[2].config.colour = lighten(G.C.SUITS[G.GAME.current_round.phanta_widget_suit], 0.35)
    end
    return false
  end
}

jd_def["j_phanta_astro"] = {
  text = {
    { text = "+" },
    { ref_table = "card.joker_display_values", ref_value = "chips", retrigger_type = "mult" }
  },
  text_config = { colour = G.C.CHIPS },
  calc_function = function(card)
    card.joker_display_values.chips = card.ability.extra.chips * count_planets()
  end
}

jd_def["j_phanta_dougdimmadome"] = {
  text = {
    {
      border_nodes = {
        { text = "X" },
        { ref_table = "card.joker_display_values", ref_value = "xmult", retrigger_type = "exp" }
      }
    }
  },
  calc_function = function(card)
    card.joker_display_values.xmult = 1 + (card.ability.extra.added_xmult * phanta_dougdimmadome_count_duplicates())
  end
}

jd_def["j_phanta_doublingcube"] = {
  text = {
    {
      border_nodes = {
        { text = "X" },
        { ref_table = "card.joker_display_values", ref_value = "xmult", retrigger_type = "exp" }
      }
    }
  },
  calc_function = function(card)
    local numbers_only = true
    local text, _, scoring_hand = JokerDisplay.evaluate_hand()
    if text ~= 'Unknown' then
      for _, v in pairs(scoring_hand) do
        if SMODS.has_no_rank(v) or v:is_face() or v:get_id() == 14 then
          numbers_only = false
        end
      end
    end
    card.joker_display_values.xmult = numbers_only and card.ability.extra.xmult or 1
  end
}

jd_def["j_phanta_robojoker"] = {
  extra = {
    {
      { text = "(" },
      { ref_table = "card.joker_display_values", ref_value = "odds" },
      { text = ")" }
    }
  },
  extra_config = { colour = G.C.GREEN, scale = 0.3 },
  calc_function = function(card)
    local numerator, denominator = SMODS.get_probability_vars(card, 1, card.ability.extra.odds, "robojoker")
    card.joker_display_values.odds = localize { type = 'variable', key = "jdis_odds", vars = { numerator, denominator } }
  end
}

jd_def["j_phanta_modping"] = {
  text = {
    { text = "$" },
    { ref_table = "card.ability.extra", ref_value = "money_needed", retrigger_type = "mult" },
  },
  text_config = { colour = G.C.GOLD }
}

jd_def["j_phanta_birthdaycard"] = {
  text = {
    {
      border_nodes = {
        { text = "X" },
        { ref_table = "card.ability.extra", ref_value = "current_xmult", retrigger_type = "exp" }
      }
    }
  }
}

jd_def["j_phanta_leprechaun"] = {
  text = {
    { text = "+" },
    { ref_table = "card.joker_display_values", ref_value = "mult", retrigger_type = "mult" }
  },
  text_config = { colour = G.C.MULT },
  calc_function = function(card)
    card.joker_display_values.mult = G.hand and next(G.hand.cards) and G.hand.cards[#G.hand.cards]:get_id() == 7 and card.ability.extra.given_mult or 0
  end
}

jd_def["j_phanta_haringjoker"] = {
  reminder_text = {
    { text = "(" },
    { ref_table = "card.joker_display_values", ref_value = "count",          colour = G.C.ORANGE },
    { text = "x" },
    { ref_table = "card.joker_display_values", ref_value = "localized_text", colour = G.C.BLUE },
    { text = ")" }
  },
  calc_function = function(card)
    local count = 0
    if G.jokers then
      for _, joker_card in ipairs(G.jokers.cards) do
        if joker_card ~= card and joker_card.config.center.rarity and joker_card:is_rarity("Common") then
          count = count + 1
        end
      end
    end
    card.joker_display_values.count = count
    card.joker_display_values.localized_text = localize("k_common")
  end,
  mod_function = function(card, mod_joker)
    return { xmult = (card:is_rarity("Common") and mod_joker ~= card and mod_joker.ability.extra.xmult ^ JokerDisplay.calculate_joker_triggers(mod_joker) or nil) }
  end
}

jd_def["j_phanta_ontherun"] = {
  text = {
    { text = "+" },
    { ref_table = "card.ability.extra", ref_value = "current_mult", retrigger_type = "mult" }
  },
  text_config = { colour = G.C.MULT }
}

jd_def["j_phanta_plugsocket"] = {
  text = {
    {
      border_nodes = {
        { text = "X" },
        { ref_table = "card.joker_display_values", ref_value = "xmult", retrigger_type = "exp" }
      }
    }
  },
  calc_function = function(card)
    card.joker_display_values.xmult = 1 + (#count_base_copper_grates() * card.ability.extra.xmult)
  end
}

jd_def["j_phanta_mrbigmoneybags"] = {
  text = {
    {
      border_nodes = {
        { text = "X" },
        { ref_table = "card.ability.extra", ref_value = "xmult", retrigger_type = "exp" }
      }
    }
  }
}

jd_def["j_phanta_neonjoker"] = {
  text = {
    {
      border_nodes = {
        { text = "X" },
        { ref_table = "card.joker_display_values", ref_value = "xmult", retrigger_type = "exp" }
      }
    }
  },
  calc_function = function(card)
    local wilds = 0
    local counted_suits = {}
    local text, _, scoring_hand = JokerDisplay.evaluate_hand()
    if text ~= 'Unknown' then
      for _, v in pairs(G.hand.cards) do
        if not SMODS.has_any_suit(v) then
          local is_new = true
          local suit = v.ability.phanta_actual_suit or v.base.suit
          for j = 1, #counted_suits do
            if suit == counted_suits[j] then is_new = false end
          end
          if is_new then counted_suits[#counted_suits + 1] = suit end
        else
          wilds = wilds + 1
        end
      end
    end

    card.joker_display_values.xmult = #counted_suits + wilds >= 4 and card.ability.extra.xmult or 1
  end
}

jd_def["j_phanta_technojoker"] = {
  text = {
    {
      border_nodes = {
        { text = "X" },
        { ref_table = "card.joker_display_values", ref_value = "xmult", retrigger_type = "exp" }
      }
    }
  },
  calc_function = function(card)
    card.joker_display_values.xmult = 1 + (count_missing_ranks() * card.ability.extra.xmult)
  end
}

jd_def["j_phanta_crystaljoker"] = {
  text = {
    {
      border_nodes = {
        { text = "X" },
        { ref_table = "card.joker_display_values", ref_value = "xmult", retrigger_type = "exp" }
      }
    }
  },
  calc_function = function(card)
    local xmult = 1
    for _, v in ipairs(G.hand.cards) do
      if not v.highlighted then
        if v.facing ~= 'back' and not v.debuff and SMODS.has_enhancement(v, "m_glass") then
          xmult = xmult * (v.ability.Xmult ^ JokerDisplay.calculate_card_triggers(v, nil, true))
        end
      end
    end
    card.joker_display_values.xmult = xmult
  end
}

jd_def["j_phanta_profile"] = {
  text = {
    { text = "$" },
    { ref_table = "G.Phanta", ref_value = "profile_cost", retrigger_type = "mult" },
  },
  text_config = { colour = G.C.GOLD }
}

jd_def["j_phanta_l"] = {
  text = {
    {
      border_nodes = {
        { text = "X" },
        { ref_table = "card.joker_display_values", ref_value = "xmult", retrigger_type = "exp" }
      }
    }
  },
  calc_function = function(card)
    local all_scored = true
    local text, _, scoring_hand = JokerDisplay.evaluate_hand()
    if text ~= 'Unknown' then
      for _, v in pairs(next(G.play.cards) and G.play.cards or G.hand.highlighted) do
        if not SMODS.in_scoring(v, scoring_hand) then
          all_scored = false
        end
      end
    end

    card.joker_display_values.xmult = all_scored and card.ability.extra.xmult or 1
  end
}

jd_def["j_phanta_mello"] = {
  text = {
    {
      border_nodes = {
        { text = "X" },
        { ref_table = "card.joker_display_values", ref_value = "xmult", retrigger_type = "exp" }
      }
    }
  },
  calc_function = function(card)
    card.joker_display_values.xmult = 1 + (card.ability.extra.xmult * math.max(0, math.floor((G.GAME.dollars + (G.GAME.dollar_buffer or 0)) / card.ability.extra.dollar_threshold)))
  end
}

jd_def["j_phanta_near"] = {
  text = {
    {
      border_nodes = {
        { text = "X" },
        { ref_table = "card.joker_display_values", ref_value = "xmult", retrigger_type = "exp" }
      }
    }
  },
  calc_function = function(card)
    card.joker_display_values.xmult = G.jokers.cards[1] == card and card.ability.extra.xmult or 1
  end
}

jd_def["j_phanta_deathnote"] = {
  text = {
    { ref_table = "card.joker_display_values", ref_value = "localised_text" },
    { ref_table = "card.joker_display_values", ref_value = "card_name",     colour = G.C.FILTER }
  },
  calc_function = function(card)
    local name = card.ability and card.ability.extra and card.ability.extra.card_name and card.ability.extra.card_name ~= "" and card.ability.extra.card_name
    card.joker_display_values.localised_text = name and "" or localize("phanta_deathnote_no_name")
    card.joker_display_values.card_name = name and name or ""
  end
}
