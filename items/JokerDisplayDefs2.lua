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

jd_def["j_phanta_absentjoker"] = {
  text = {
    { text = "+" },
    { ref_table = "card.joker_display_values", ref_value = "mult", retrigger_type = "mult" }
  },
  text_config = { colour = G.C.MULT },
  calc_function = function(card)
    card.joker_display_values.mult = G.jokers.config.card_limit - #G.jokers.cards == 1 and card.ability.extra.mult or 0
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

jd_def["j_phanta_88888888"] = {
  text = {
    { text = "+",                              colour = G.C.CHIPS },
    { ref_table = "card.joker_display_values", ref_value = "chips", colour = G.C.CHIPS, retrigger_type = "mult" },
    { text = " +",                              colour = G.C.MULT },
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
        if SMODS.in_scoring(v, scoring_hand) and v:is_face() then
          xmult = xmult * (card.ability.extra.xmult ^ JokerDisplay.calculate_card_triggers(v, scoring_hand))
        end
      end
    end
    card.joker_display_values.xmult = xmult
    card.joker_display_values.localised_text = localize("k_phanta_face_cards")
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
    { text = "+" },
    { ref_table = "card.ability.extra", ref_value = "chips", retrigger_type = "mult" }
  },
  text_config = { colour = G.C.CHIPS },
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
        if not SMODS.in_scoring(v, G.hand.highlighted) and v:get_id() == 3 then
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

jd_def["j_phanta_manga"] = {
  text = {
    { text = "+" },
    { ref_table = "card.joker_display_values", ref_value = "hanafudas", retrigger_type = "mult" },
  },
  text_config = { colour = G.C.SECONDARY_SET.phanta_Hanafuda },
  calc_function = function(card)
    local is_seven = false
    local is_eight = false
    for _, v in pairs(G.hand.highlighted) do
      if v:get_id() == 7 then is_seven = true end
      if v:get_id() == 8 then is_eight = true end
    end
    card.joker_display_values.hanafudas = G.GAME.current_round.discards_left > 0 and is_seven and is_eight and count_consumables() < G.consumeables.config.card_limit and 1 or 0
  end
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
    { ref_table = "card.joker_display_values", ref_value = "joker_name", colour = G.C.FILTER }
  },
  calc_function = function(card)
    local name = card.ability and card.ability.extra and card.ability.extra.card_name and card.ability.extra.card_name ~= "" and card.ability.extra.card_name
    card.joker_display_values.localised_text = name and localize("phanta_deathnote_name_present") or localize("phanta_deathnote_no_name")
    card.joker_display_values.joker_name = name and name or ""
  end
}