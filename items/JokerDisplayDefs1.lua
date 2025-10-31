local jd_def = JokerDisplay.Definitions

jd_def["j_phanta_bootleg"] = {
  text = {
    { text = "+",                       colour = G.C.CHIPS },
    { ref_table = "card.ability.extra", ref_value = "chips", colour = G.C.CHIPS, retrigger_type = "mult" },
    { text = "+",                       colour = G.C.MULT },
    { ref_table = "card.ability.extra", ref_value = "mult",  colour = G.C.MULT,  retrigger_type = "mult" }
  }
}

jd_def["j_phanta_trainstation"] = {
  text = {
    { text = "+" },
    { ref_table = "card.ability.extra", ref_value = "current_mult", retrigger_type = "mult" }
  },
  text_config = { colour = G.C.MULT },
  reminder_text = {
    { text = "(" },
    { ref_table = "card.joker_display_values", ref_value = "train_station_card_rank", colour = G.C.FILTER },
    { text = ")" }
  },
  calc_function = function(card)
    card.joker_display_values.train_station_card_rank = localize((G.GAME.current_round.train_station_card.value or 2) .. "", 'ranks')
  end
}

jd_def["j_phanta_hintcoin"] = {
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
    card.joker_display_values.money = G.GAME and
        ((G.GAME.current_round.hands_played == 1 and not next(G.play.cards)) or (G.GAME.current_round.hands_left == 2 and next(G.play.cards)))
        and card.ability.extra.money or 0
    card.joker_display_values.localised_text = localize("k_phanta_second_hand")
  end
}

jd_def["j_phanta_dollarsign"] = {
  text = {
    { text = "+$" },
    { ref_table = "card.joker_display_values", ref_value = "money", retrigger_type = "mult" }
  },
  text_config = { colour = G.C.GOLD },
  calc_function = function(card)
    local has_five = false
    local money_string = tostring(G.GAME.dollars)
    for i = 1, #money_string do
      if string.sub(money_string, i, i) == '5' then has_five = true end
    end
    card.joker_display_values.money = has_five and card.ability.extra.money or 0
  end
}

jd_def["j_phanta_yellow"] = {
  text = {
    { text = "+$" },
    { ref_table = "card.joker_display_values", ref_value = "money" }
  },
  text_config = { colour = G.C.GOLD },
  reminder_text = {
    { ref_table = "card.joker_display_values", ref_value = "localised_text" }
  },
  calc_function = function(card)
    if G.GAME.round % 2 == 1 then
      card.joker_display_values.money = card.ability.extra.odd_money
    else
      card.joker_display_values.money = card.ability.extra.even_money
    end
    card.joker_display_values.localised_text = "(" .. localize("k_round") .. ")"
  end
}

jd_def["j_phanta_purplegoldenjoker"] = {
  text = {
    { text = "+$" },
    { ref_table = "card.joker_display_values", ref_value = "money" }
  },
  text_config = { colour = G.C.GOLD },
  reminder_text = {
    { ref_table = "card.joker_display_values", ref_value = "localised_text" }
  },
  calc_function = function(card)
    card.joker_display_values.money = math.max(math.min(count_tarots() * card.ability.extra.money, card.ability.extra.money_cap), 0)
    card.joker_display_values.localised_text = "(" .. localize("k_round") .. ")"
  end
}

jd_def["j_phanta_holeinthejoker"] = {
  text = {
    { text = "+$" },
    { ref_table = "card.joker_display_values", ref_value = "money" }
  },
  text_config = { colour = G.C.GOLD },
  reminder_text = {
    { ref_table = "card.joker_display_values", ref_value = "localised_text" }
  },
  calc_function = function(card)
    card.joker_display_values.money = math.max((G.jokers.config.card_limit - (#G.jokers.cards - #SMODS.find_card("j_phanta_holeinthejoker"))) * card.ability.extra.money, 0)
    card.joker_display_values.localised_text = "(" .. localize("k_round") .. ")"
  end
}

jd_def["j_phanta_shootingstar"] = {
  text = {
    { text = "+$" },
    { ref_table = "card.joker_display_values", ref_value = "money", retrigger_type = "mult" }
  },
  text_config = { colour = G.C.GOLD },
  reminder_text = {
    { text = "(" },
    { ref_table = "card.joker_display_values", ref_value = "localised_text", colour = G.C.SUITS.Diamonds },
    { text = ")" }
  },
  calc_function = function(card)
    local count = 0
    local count_increment = card.ability.extra.money
    for _, v in pairs(G.hand.highlighted) do
      if v.facing and not (v.facing == 'back') and v:is_suit("Diamonds") then
        count = count + count_increment
        count_increment = count_increment + card.ability.extra.added_money
      end
    end
    card.joker_display_values.money = math.max(count, 0)
    card.joker_display_values.localised_text = localize("Diamonds", "suits_plural")
  end
}

jd_def["j_phanta_binman"] = {
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
    card.joker_display_values.money = text == "phanta_junk" and card.ability.extra.given_money or 0
    card.joker_display_values.localised_text = localize("phanta_junk", "poker_hands")
  end
}

jd_def["j_phanta_onemanstrash"] = {
  text = {
    { text = "+" },
    { ref_table = "card.ability.extra", ref_value = "current_mult", retrigger_type = "mult" }
  },
  text_config = { colour = G.C.MULT }
}

jd_def["j_phanta_anothermanstreasure"] = {
  text = {
    {
      border_nodes = {
        { text = "X" },
        { ref_table = "card.ability.extra", ref_value = "current_xmult", retrigger_type = "exp" }
      }
    }
  }
}

jd_def["j_phanta_timetable"] = {
  text = {
    { ref_table = "card.joker_display_values", ref_value = "bonus" }
  },
  reminder_text = {
    { text = "(" },
    { ref_table = "card.joker_display_values", ref_value = "localised_text" },
    { ref_table = "card.joker_display_values", ref_value = "next_bonus" },
    { text = ")" }
  },
  calc_function = function(card)
    card.joker_display_values.localised_text = localize("k_phanta_timetable_next")

    if is_blind_small() then
      card.joker_display_values.bonus = localize { type = 'variable', key = 'a_discard', vars = { card.ability.extra.discards } }
      card.joker_display_values.next_bonus = localize { type = 'variable', key = 'a_hand', vars = { card.ability.extra.hands } }
    end
    if is_blind_big() then
      card.joker_display_values.bonus = localize { type = 'variable', key = 'a_hand', vars = { card.ability.extra.hands } }
      card.joker_display_values.next_bonus = localize { type = 'variable', key = 'a_handsize', vars = { card.ability.extra.hand_size } }
    end
    if is_blind_boss() then
      card.joker_display_values.bonus = localize { type = 'variable', key = 'a_handsize', vars = { card.ability.extra.hand_size } }
      card.joker_display_values.next_bonus = localize { type = 'variable', key = 'a_discard', vars = { card.ability.extra.discards } }
    end
  end,
  style_function = function(card, text, reminder_text, extra)
    if text and text.children[1] and reminder_text and reminder_text.children[3] then
      if is_blind_small() then
        text.children[1].config.colour = G.C.RED
        reminder_text.children[3].config.colour = G.C.BLUE
      end
      if is_blind_big() then
        text.children[1].config.colour = G.C.BLUE
        reminder_text.children[3].config.colour = G.C.FILTER
      end
      if is_blind_boss() then
        text.children[1].config.colour = G.C.FILTER
        reminder_text.children[3].config.colour = G.C.RED
      end
    end
    return false
  end
}

jd_def["j_phanta_mazebean"] = {
  text = {
    { ref_table = "card.joker_display_values", ref_value = "bonus" }
  },
  text_config = { colour = G.C.FILTER },
  reminder_text = {
    { text = "(" },
    { ref_table = "card.ability.extra", ref_value = "current_antes" },
    { text = "/" },
    { ref_table = "card.ability.extra", ref_value = "target_antes" },
    { text = ")" }
  },
  calc_function = function(card)
    card.joker_display_values.bonus = localize { type = 'variable', key = 'a_handsize', vars = { card.ability.extra.current_hand_size } }
  end
}

jd_def["j_phanta_playerpin"] = {
  retrigger_function = function(playing_card, scoring_hand, held_in_hand, joker_card)
    if held_in_hand or not SMODS.in_scoring(playing_card, scoring_hand) then return 0 end
    return playing_card ~= scoring_hand[1] and playing_card ~= scoring_hand[#scoring_hand] and
        1 * JokerDisplay.calculate_joker_triggers(joker_card) or 0 -- (sic)
  end
}

jd_def["j_phanta_junpei"] = {
  text = {
    { text = "+",                              colour = G.C.MULT },
    { ref_table = "card.joker_display_values", ref_value = "mult", colour = G.C.MULT, retrigger_type = "mult" }
  },
  reminder_text = {
    { ref_table = "card.joker_display_values", ref_value = "localised_text" }
  },
  calc_function = function(card)
    local mult = 0
    local text, _, scoring_hand = JokerDisplay.evaluate_hand()
    if text ~= 'Unknown' then
      for _, v in pairs(scoring_hand) do
        if v:get_id() and v:get_id() == 5 then
          local retriggers = JokerDisplay.calculate_card_triggers(v, scoring_hand)
          mult = mult + card.ability.extra.given_mult * retriggers
        end
      end
    end
    card.joker_display_values.mult = mult
    card.joker_display_values.localised_text = "(" .. localize("k_phanta_fives") .. ")"
  end
}

jd_def["j_phanta_sigma"] = {
  retrigger_function = function(playing_card, scoring_hand, held_in_hand, joker_card)
    if held_in_hand or not SMODS.in_scoring(playing_card, scoring_hand) then return 0 end
    return SMODS.has_enhancement(playing_card, "m_bonus") and 1 * JokerDisplay.calculate_joker_triggers(joker_card) or 0 -- (sic)
  end
}

jd_def["j_phanta_carlos"] = {
  text = {
    { text = "+" },
    { ref_table = "card.ability.extra", ref_value = "current_chips", retrigger_type = "mult" }
  },
  text_config = { colour = G.C.CHIPS }
}

jd_def["j_phanta_q"] = {
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
    local text, _, scoring_hand = JokerDisplay.evaluate_hand()
    local queens = {}
    if text ~= 'Unknown' then
      for _, v in pairs(scoring_hand) do
        if v:get_id() == 12 then
          table.insert(queens, v)
        end
      end
    end
    card.joker_display_values.xmult = #queens >= 2 and (card.ability.extra.given_xmult ^ JokerDisplay.calculate_card_triggers(queens[1], scoring_hand))
        * (card.ability.extra.given_xmult ^ JokerDisplay.calculate_card_triggers(queens[2], scoring_hand)) or 1
    card.joker_display_values.localised_text = localize("k_phanta_queens")
  end
}

jd_def["j_phanta_diana"] = {
  text = {
    { text = "+" },
    { ref_table = "card.ability.extra", ref_value = "current_mult", retrigger_type = "mult" }
  },
  text_config = { colour = G.C.MULT }
}

jd_def["j_phanta_redkeycards"] = {
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
    { ref_table = "card.joker_display_values", ref_value = "localised_text_a", colour = G.C.FILTER },
    { text = ", " },
    { ref_table = "card.joker_display_values", ref_value = "localised_text_b", colour = G.C.FILTER },
    { text = ", " },
    { ref_table = "card.joker_display_values", ref_value = "localised_text_c", colour = G.C.FILTER },
    { text = ")" }
  },
  calc_function = function(card)
    card.joker_display_values.localised_text_a = localize("k_aces")
    card.joker_display_values.localised_text_b = localize("k_phanta_twos")
    card.joker_display_values.localised_text_c = localize("k_phanta_threes")
  end
}

jd_def["j_phanta_bluekeycards"] = {
  text = {
    { text = "+" },
    { ref_table = "card.ability.extra", ref_value = "current_chips", retrigger_type = "mult" }
  },
  text_config = { colour = G.C.CHIPS },
  reminder_text = {
    { text = "(" },
    { ref_table = "card.joker_display_values", ref_value = "localised_text_a", colour = G.C.FILTER },
    { text = ", " },
    { ref_table = "card.joker_display_values", ref_value = "localised_text_b", colour = G.C.FILTER },
    { text = ", " },
    { ref_table = "card.joker_display_values", ref_value = "localised_text_c", colour = G.C.FILTER },
    { text = ")" }
  },
  calc_function = function(card)
    card.joker_display_values.localised_text_a = localize("k_phanta_sixes")
    card.joker_display_values.localised_text_b = localize("k_phanta_sevens")
    card.joker_display_values.localised_text_c = localize("k_phanta_eights")
  end
}

jd_def["j_phanta_kylehyde"] = {
  extra = {
    {
      { text = "(" },
      { ref_table = "card.joker_display_values", ref_value = "odds" },
      { text = ")" }
    }
  },
  extra_config = { colour = G.C.GREEN, scale = 0.3 },
  calc_function = function(card)
    local numerator, denominator = SMODS.get_probability_vars(card, 1, card.ability.extra.odds, "kylehyde")
    card.joker_display_values.odds = localize { type = 'variable', key = "jdis_odds", vars = { numerator, denominator } }
  end
}

jd_def["j_phanta_inception"] = {
  text = {
    { text = "+" },
    { ref_table = "card.joker_display_values", ref_value = "mult", retrigger_type = "mult" }
  },
  text_config = { colour = G.C.MULT },
  calc_function = function(card)
    card.joker_display_values.mult = card.ability.extra.current_mult + card.ability.extra.added_mult
  end
}

jd_def["j_phanta_a1z26"] = {
  text = {
    { text = "+" },
    { ref_table = "card.joker_display_values", ref_value = "mult", retrigger_type = "mult" }
  },
  text_config = { colour = G.C.CHIPS },
  reminder_text = {
    { text = "(" },
    { ref_table = "card.joker_display_values", ref_value = "localised_text", colour = G.C.ORANGE },
    { text = ")" }
  },
  calc_function = function(card)
    local text, _, scoring_hand = JokerDisplay.evaluate_hand()
    local first_card = JokerDisplay.calculate_leftmost_card(scoring_hand)
    card.joker_display_values.mult = first_card and first_card:get_id() == 14 and (card.ability.extra.mult * JokerDisplay.calculate_card_triggers(first_card, scoring_hand)) or 0
    card.joker_display_values.localised_text = localize("k_aces")
  end
}

jd_def["j_phanta_nonuniformday"] = {
  text = {
    { text = "+" },
    { ref_table = "card.joker_display_values", ref_value = "count", retrigger_type = "mult" }
  },
  text_config = { colour = G.C.SECONDARY_SET.Tarot },
  extra = {
    {
      { text = "(" },
      { ref_table = "card.joker_display_values", ref_value = "odds" },
      { text = ")" }
    }
  },
  extra_config = { colour = G.C.GREEN, scale = 0.3 },
  calc_function = function(card)
    local count = 0
    local text, _, scoring_hand = JokerDisplay.evaluate_hand()
    if text ~= 'Unknown' then
      for _, v in pairs(scoring_hand) do
        if SMODS.has_enhancement(v, "m_wild") then
          count = count + JokerDisplay.calculate_card_triggers(v, scoring_hand)
        end
      end
    end
    card.joker_display_values.count = count
    local numerator, denominator = SMODS.get_probability_vars(card, 1, card.ability.extra.odds, "nonuniformday")
    card.joker_display_values.odds = localize { type = 'variable', key = "jdis_odds", vars = { numerator, denominator } }
  end
}

jd_def["j_phanta_scratchart"] = {
  text = {
    {
      border_nodes = {
        { text = "X" },
        { ref_table = "card.ability.extra", ref_value = "current_xmult", retrigger_type = "exp" }
      }
    }
  }
}

jd_def["j_phanta_animalinstinct"] = {
  text = {
    {
      border_nodes = {
        { text = "X" },
        { ref_table = "card.ability.extra", ref_value = "current_xmult", retrigger_type = "exp" }
      }
    }
  }
}

jd_def["j_phanta_target"] = {
  text = {
    { text = "+" },
    { ref_table = "card.ability.extra", ref_value = "current_mult", retrigger_type = "mult" }
  },
  text_config = { colour = G.C.MULT }
}

jd_def["j_phanta_teastainedjoker"] = {
  text = {
    { text = "+" },
    { ref_table = "card.ability.extra", ref_value = "current_mult", retrigger_type = "mult" }
  },
  text_config = { colour = G.C.MULT },
  extra = {
    {
      { text = "(" },
      { ref_table = "card.joker_display_values", ref_value = "odds" },
      { text = ")" }
    }
  },
  extra_config = { colour = G.C.GREEN, scale = 0.3 },
  calc_function = function(card)
    local numerator, denominator = SMODS.get_probability_vars(card, 1, card.ability.extra.odds, "teastainedjoker")
    card.joker_display_values.odds = localize { type = 'variable', key = "jdis_odds", vars = { numerator, denominator } }
  end
}

jd_def["j_phanta_forsakenscroll"] = {
  text = {
    {
      border_nodes = {
        { text = "X" },
        { ref_table = "card.ability.extra", ref_value = "given_xmult", retrigger_type = "exp" }
      }
    }
  },
  extra = {
    {
      { text = "(" },
      { ref_table = "card.joker_display_values", ref_value = "odds" },
      { text = ")" }
    }
  },
  extra_config = { colour = G.C.GREEN, scale = 0.3 },
  calc_function = function(card)
    local numerator, denominator = SMODS.get_probability_vars(card, count_lucky_cards(), card.ability.extra.odds, "forsakenscroll")
    card.joker_display_values.odds = localize { type = 'variable', key = "jdis_odds", vars = { numerator, denominator } }
  end
}

jd_def["j_phanta_exitsign"] = {
  text = {
    { text = "+$" },
    { ref_table = "card.joker_display_values", ref_value = "money", retrigger_type = "mult" }
  },
  text_config = { colour = G.C.GOLD },
  calc_function = function(card)
    card.joker_display_values.money = G.GAME and G.GAME.current_round.discards_left == 0 and
        ((G.GAME.current_round.hands_left == 1 and not next(G.play.cards)) or (G.GAME.current_round.hands_left == 0 and next(G.play.cards)))
        and card.ability.extra.money_given or 0
  end
}

jd_def["j_phanta_task"] = {
  text = {
    { text = "+$" },
    { ref_table = "card.ability.extra", ref_value = "current_money", retrigger_type = "mult" }
  },
  text_config = { colour = G.C.GOLD }
}

jd_def["j_phanta_saltcircle"] = {
  text = {
    { text = "=",                       colour = G.C.CHIPS },
    { ref_table = "card.ability.extra", ref_value = "chips", colour = G.C.CHIPS }
  }
}

jd_def["j_phanta_thenecronomicon"] = {
  text = {
    { ref_table = "card.joker_display_values", ref_value = "chips" }
  },
  calc_function = function(card)
    card.joker_display_values.chips = #count_rank(6) == 0 and ("=" .. card.ability.extra.chips) or localize("phanta_inactive")
  end,
  style_function = function(card, text, reminder_text, extra)
    if text and text.children[1] then
      text.children[1].config.colour = #count_rank(6) == 0 and G.C.CHIPS or G.C.JOKER_GREY
    end
    return false
  end
}

jd_def["j_phanta_stitchintime"] = {
  text = {
    { text = "+" },
    { ref_table = "card.ability.extra", ref_value = "current_chips", retrigger_type = "mult" }
  },
  text_config = { colour = G.C.CHIPS },
  reminder_text = {
    { text = "(" },
    { ref_table = "card.joker_display_values", ref_value = "localised_text", colour = G.C.FILTER },
    { text = ")" }
  },
  calc_function = function(card)
    card.joker_display_values.localised_text = localize("k_phanta_nines")
  end
}

jd_def["j_phanta_shackles"] = {
  text = {
    { text = "+" },
    { ref_table = "card.ability.extra", ref_value = "chips", retrigger_type = "mult" }
  },
  text_config = { colour = G.C.CHIPS },
}

jd_def["j_phanta_ghost"] = {
  text = {
    {
      border_nodes = {
        { text = "X" },
        { ref_table = "card.joker_display_values", ref_value = "xmult", retrigger_type = "exp" }
      }
    }
  },
  calc_function = function(card)
    card.joker_display_values.xmult = 1 + (count_tarots() * card.ability.extra.xmult)
  end
}

jd_def["j_phanta_html"] = {
  text = {
    { text = "+" },
    { ref_table = "card.joker_display_values", ref_value = "mult", retrigger_type = "mult" }
  },
  text_config = { colour = G.C.MULT },
  reminder_text = {
    { text = "(" },
    { ref_table = "card.joker_display_values", ref_value = "localised_text" },
    { text = ")" }
  },
  calc_function = function(card)
    local mult = 0
    local text, _, scoring_hand = JokerDisplay.evaluate_hand()
    if text ~= 'Unknown' then
      for _, v in pairs(next(G.play.cards) and G.play.cards or G.hand.highlighted) do
        if not SMODS.in_scoring(v, scoring_hand) then
          mult = mult + (card.ability.extra.given_mult * JokerDisplay.calculate_card_triggers(v, scoring_hand))
        end
      end
    end
    card.joker_display_values.mult = mult
    card.joker_display_values.localised_text = localize("k_phanta_unscored")
  end
}

jd_def["j_phanta_knowledgeofthecollege"] = {
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
    { ref_table = "card.joker_display_values", ref_value = "localised_text_a" },
    { text = " " },
    { ref_table = "card.joker_display_values", ref_value = "localised_text_b", colour = G.C.FILTER },
    { text = ")" }
  },
  calc_function = function(card)
    local xmult = 1
    local text, _, scoring_hand = JokerDisplay.evaluate_hand()
    if text ~= 'Unknown' then
      for _, v in pairs(next(G.play.cards) and G.play.cards or G.hand.highlighted) do
        if not SMODS.in_scoring(v, scoring_hand) and v:get_id() == 14 then
          xmult = xmult * (card.ability.extra.given_xmult ^ JokerDisplay.calculate_card_triggers(v, scoring_hand))
        end
      end
    end
    card.joker_display_values.xmult = xmult
    card.joker_display_values.localised_text_a = localize("k_phanta_unscored")
    card.joker_display_values.localised_text_b = localize("k_aces")
  end
}

jd_def["j_phanta_theapparition"] = {
  retrigger_function = function(playing_card, scoring_hand, held_in_hand, joker_card)
    if held_in_hand or SMODS.in_scoring(playing_card, scoring_hand) then return 0 end
    return 1 * JokerDisplay.calculate_joker_triggers(joker_card) or 0 -- (sic)
  end
}

jd_def["j_phanta_willothewisp"] = {
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
    local text, _, scoring_hand = JokerDisplay.evaluate_hand()
    if text ~= 'Unknown' then
      for _, v in pairs(next(G.play.cards) and G.play.cards or G.hand.highlighted) do
        if not SMODS.in_scoring(v, scoring_hand) and SMODS.has_enhancement(v, "m_phanta_ghostcard") then
          local given_xmult = v.ability.h_x_mult
          for i = 1, JokerDisplay.calculate_card_triggers(v, scoring_hand) do
            xmult = xmult * given_xmult
            given_xmult = given_xmult + v.ability.extra.added_xmult
          end
        end
      end
    end
    card.joker_display_values.xmult = xmult
  end
}

jd_def["j_phanta_stickercollection"] = {
  retrigger_function = function(playing_card, scoring_hand, held_in_hand, joker_card)
    if held_in_hand or not SMODS.in_scoring(playing_card, scoring_hand) then return 0 end
    local text, disp_text = G.FUNCS.get_poker_hand_info(G.hand.highlighted)
    return text == "phanta_junk" and get_lowest(scoring_hand)[1][1]:get_id() == playing_card:get_id() and
        3 * JokerDisplay.calculate_joker_triggers(joker_card) or 0
  end
}

jd_def["j_phanta_photocopy"] = {
  extra = {
    {
      { text = "(" },
      { ref_table = "card.joker_display_values", ref_value = "odds" },
      { text = ")" }
    }
  },
  extra_config = { colour = G.C.GREEN, scale = 0.3 },
  calc_function = function(card)
    local numerator, denominator = SMODS.get_probability_vars(card, 1, card.ability.extra.odds, "photocopy")
    card.joker_display_values.odds = localize { type = 'variable', key = "jdis_odds", vars = { numerator, denominator } }
  end,
  retrigger_function = function(playing_card, scoring_hand, held_in_hand, joker_card)
    if held_in_hand or not SMODS.in_scoring(playing_card, scoring_hand) then return 0 end
    return 1 * JokerDisplay.calculate_joker_triggers(joker_card)
  end
}

jd_def["j_phanta_doubledice"] = {
  text = {
    { text = "+" },
    { ref_table = "card.joker_display_values", ref_value = "mult", retrigger_type = "mult" }
  },
  text_config = { colour = G.C.MULT },
  reminder_text = {
    { text = "(" },
    { ref_table = "card.joker_display_values", ref_value = "localised_text" },
    { text = ")" }
  },
  calc_function = function(card)
    local mult = 0
    local text, _, scoring_hand = JokerDisplay.evaluate_hand()
    if text ~= 'Unknown' then
      for _, v in pairs(scoring_hand) do
        if v:get_id() and v:get_id() == 7 then
          local retriggers = JokerDisplay.calculate_card_triggers(v, scoring_hand)
          mult = mult + (count_common_jokers() * card.ability.extra.added_mult * retriggers)
        end
      end
    end
    card.joker_display_values.mult = mult
    card.joker_display_values.localised_text = localize("k_phanta_sevens")
  end
}

jd_def["j_phanta_grimreaper"] = {
  text = {
    {
      border_nodes = {
        { text = "X" },
        { ref_table = "card.ability.extra", ref_value = "current_xmult", retrigger_type = "exp" }
      }
    }
  }
}

jd_def["j_phanta_professorlayton"] = {
  text = {
    { text = "+" },
    { ref_table = "card.ability.extra", ref_value = "added_mult", retrigger_type = "mult" }
  },
  text_config = { colour = G.C.MULT },
  extra = {
    {
      { text = "(" },
      { ref_table = "card.joker_display_values", ref_value = "odds" },
      { text = ")" }
    }
  },
  extra_config = { colour = G.C.GREEN, scale = 0.3 },
  calc_function = function(card)
    local numerator, denominator = SMODS.get_probability_vars(card, next(SMODS.find_card("j_phanta_luketriton")) and card.ability.extra.out_of_odds or count_tarots(), card.ability.extra.out_of_odds, "professorlayton")
    card.joker_display_values.odds = localize { type = 'variable', key = "jdis_odds", vars = { numerator, denominator } }
  end
}

jd_def["j_phanta_luketriton"] = {
  text = {
    {
      border_nodes = {
        { text = "X" },
        { ref_table = "card.ability.extra", ref_value = "xmult", retrigger_type = "exp" }
      }
    }
  },
  extra = {
    {
      { text = "(" },
      { ref_table = "card.joker_display_values", ref_value = "odds" },
      { text = ")" }
    }
  },
  extra_config = { colour = G.C.GREEN, scale = 0.3 },
  calc_function = function(card)
    local numerator, denominator = SMODS.get_probability_vars(card, next(SMODS.find_card("j_phanta_professorlayton")) and card.ability.extra.out_of_odds or count_planets(), card.ability.extra.out_of_odds, "luketriton")
    card.joker_display_values.odds = localize { type = 'variable', key = "jdis_odds", vars = { numerator, denominator } }
  end
}

jd_def["j_phanta_psychelock"] = {
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
      for _, v in pairs(scoring_hand) do
        if v:get_id() and v:get_id() == 9 then
          xmult = xmult + card.ability.extra.xmult * JokerDisplay.calculate_card_triggers(v, scoring_hand)
        end
      end
    end
    card.joker_display_values.xmult = xmult
    card.joker_display_values.localised_text = localize("k_phanta_nines")
  end
}

jd_def["j_phanta_milesedgeworth"] = {
  text = {
    {
      border_nodes = {
        { text = "X" },
        { ref_table = "card.joker_display_values", ref_value = "xmult", retrigger_type = "exp" }
      }
    }
  },
  calc_function = function(card)
    card.joker_display_values.xmult = 1 + (#count_steel_kings() * card.ability.extra.xmult)
  end
}

jd_def["j_phanta_apollosbracelet"] = {
  retrigger_function = function(playing_card, scoring_hand, held_in_hand, joker_card)
    if held_in_hand or not SMODS.in_scoring(playing_card, scoring_hand) then return 0 end
    return next(SMODS.get_enhancements(playing_card)) and 1 * JokerDisplay.calculate_joker_triggers(joker_card) or 0 -- (sic)
  end
}

jd_def["j_phanta_candle"] = {
  text = {
    {
      border_nodes = {
        { text = "X" },
        { ref_table = "card.ability.extra", ref_value = "current_xmult", retrigger_type = "exp" }
      }
    }
  }
}

jd_def["j_phanta_web"] = {
  text = {
    { text = "+" },
    { ref_table = "card.joker_display_values", ref_value = "mult", retrigger_type = "mult" }
  },
  text_config = { colour = G.C.MULT },
  reminder_text = {
    { text = "(2 " },
    { ref_table = "card.joker_display_values", ref_value = "localised_text" },
    { text = ")" }
  },
  calc_function = function(card)
    local spades = 0
    local text, _, scoring_hand = JokerDisplay.evaluate_hand()
    if text ~= 'Unknown' then
      for _, v in pairs(G.hand.cards) do
        if not SMODS.in_scoring(v, G.hand.highlighted) and v:is_suit("Spades") then
          spades = spades + 1
        end
      end
    end
    card.joker_display_values.mult = (spades > card.ability.extra.required_spades) and card.ability.extra.given_mult or 0
    card.joker_display_values.localised_text = localize("Spades", "suits_plural")
  end
}

jd_def["j_phanta_cutcorners"] = {
  text = {
    { text = "+" },
    { ref_table = "card.ability.extra", ref_value = "current_mult", retrigger_type = "mult" }
  },
  text_config = { colour = G.C.MULT }
}

jd_def["j_phanta_bloodpact"] = {
  text = {
    {
      border_nodes = {
        { text = "X" },
        { ref_table = "card.ability.extra", ref_value = "xmult", retrigger_type = "exp" }
      }
    }
  }
}

jd_def["j_phanta_tnetennba"] = {
  text = {
    { text = "+" },
    { ref_table = "card.ability.extra", ref_value = "current_mult", retrigger_type = "mult" }
  },
  text_config = { colour = G.C.MULT }
}

jd_def["j_phanta_technicolourjoker"] = {
  text = {
    { text = "+",                              colour = G.C.MULT },
    { ref_table = "card.joker_display_values", ref_value = "mult", colour = G.C.MULT, retrigger_type = "mult" }
  },
  reminder_text = {
    { ref_table = "card.joker_display_values", ref_value = "localised_text" }
  },
  calc_function = function(card)
    local mult = 0
    local text, _, scoring_hand = JokerDisplay.evaluate_hand()
    if text ~= 'Unknown' then
      for _, v in pairs(scoring_hand) do
        if SMODS.has_enhancement(v, "m_wild") then
          local retriggers = JokerDisplay.calculate_card_triggers(v, scoring_hand)
          mult = mult + card.ability.extra.given_mult * retriggers
        end
      end
    end
    card.joker_display_values.mult = mult
    card.joker_display_values.localised_text = "(" .. localize("k_phanta_wild_cards") .. ")"
  end
}

jd_def["j_phanta_tricolour"] = {
  text = {
    { text = "+" },
    { ref_table = "card.joker_display_values", ref_value = "mult", retrigger_type = "mult" }
  },
  text_config = { colour = G.C.MULT },
  reminder_text = {
    { text = "(" },
    { ref_table = "card.joker_display_values", ref_value = "localised_text" },
    { text = ")" }
  },
  calc_function = function(card)
    local wilds = 0
    local counted_suits = {}
    local text, _, scoring_hand = JokerDisplay.evaluate_hand()
    if text ~= 'Unknown' then
      for _, v in pairs(scoring_hand) do
        if not SMODS.has_any_suit(v) then
          local is_new = true
          for j = 1, #counted_suits do
            if v.ability.phanta_actual_suit or v.base.suit == counted_suits[j] then is_new = false end
          end
          if is_new then counted_suits[#counted_suits + 1] = v.ability.phanta_actual_suit or v.base.suit end
        else
          wilds = wilds + 1
        end
      end
    end
    card.joker_display_values.mult = (#counted_suits <= 3 and #counted_suits + wilds >= 3) and card.ability.extra.mult or 0
    card.joker_display_values.localised_text = localize("k_phanta_exactly_three_suits")
  end
}

jd_def["j_phanta_beadnecklace"] = {
  text = {
    { text = "+" },
    { ref_table = "card.ability.extra", ref_value = "current_mult", retrigger_type = "mult" }
  },
  text_config = { colour = G.C.MULT }
}

jd_def["j_phanta_p5joker"] = {
  text = {
    { text = "+" },
    { ref_table = "card.ability.extra", ref_value = "current_mult", retrigger_type = "mult" }
  },
  text_config = { colour = G.C.MULT }
}

jd_def["j_phanta_shoppinglist"] = {
  text = {
    { text = "+" },
    { ref_table = "card.ability.extra", ref_value = "current_mult", retrigger_type = "mult" }
  },
  text_config = { colour = G.C.MULT }
}

jd_def["j_phanta_purplejoker"] = {
  text = {
    { text = "+" },
    { ref_table = "card.ability.extra", ref_value = "current_mult", retrigger_type = "mult" }
  },
  text_config = { colour = G.C.MULT }
}

jd_def["j_phanta_charcoaljoker"] = {
  text = {
    { text = "+" },
    { ref_table = "card.ability.extra", ref_value = "current_chips", retrigger_type = "mult" }
  },
  text_config = { colour = G.C.CHIPS }
}

jd_def["j_phanta_introspection"] = {
  text = {
    { text = "+" },
    { ref_table = "card.joker_display_values", ref_value = "localised_text" }
  },
  calc_function = function(card)
    card.joker_display_values.localised_text = ({ localize("k_tarot"), localize("k_planet") })[card.ability.extra.chosen_type + 1]
  end,
  style_function = function(card, text, reminder_text, extra)
    local colour = ({ G.C.SECONDARY_SET.Tarot, G.C.SECONDARY_SET.Planet })[card.ability.extra.chosen_type + 1]
    if text and text.children[1] then
      text.children[1].config.colour = colour
    end
    if text and text.children[2] then
      text.children[2].config.colour = colour
    end
    return false
  end
}

jd_def["j_phanta_modernart"] = {
  text = {
    { text = "(" },
    { text = "$",         colour = G.C.GOLD },
    { ref_table = "card", ref_value = "sell_cost", colour = G.C.GOLD },
    { text = ")" },
  }
}

jd_def["j_phanta_sketch"] = {
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
    local text, _, scoring_hand = JokerDisplay.evaluate_hand()
    local cards = SMODS.merge_lists(G.play.cards, G.hand.highlighted)
    if text ~= 'Unknown' then
      for _, v in pairs(cards) do
        if not SMODS.in_scoring(v, cards) then
          xmult = xmult + card.ability.extra.xmult
        end
      end
    end
    card.joker_display_values.xmult = xmult
  end
}

jd_def["j_phanta_conspiracist"] = {
  extra = {
    {
      { text = "(" },
      { ref_table = "card.joker_display_values", ref_value = "odds" },
      { text = ")" }
    }
  },
  extra_config = { colour = G.C.GREEN, scale = 0.3 },
  calc_function = function(card)
    local numerator, denominator = SMODS.get_probability_vars(card, 1, card.ability.extra.odds, "conspiracist")
    card.joker_display_values.odds = localize { type = 'variable', key = "jdis_odds", vars = { numerator, denominator } }
  end
}

jd_def["j_phanta_sudoku"] = {
  text = {
    { ref_table = "card.joker_display_values", ref_value = "ranks" }
  },
  calc_function = function(card)
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
    card.joker_display_values.ranks = rank_list
  end
}

jd_def["j_phanta_nojoke"] = {
  text = {
    { text = "+" },
    { ref_table = "card.joker_display_values", ref_value = "mult", retrigger_type = "mult" }
  },
  text_config = { colour = G.C.MULT },
  calc_function = function(card)
    card.joker_display_values.mult = G.GAME.hands["Straight"].level * card.ability.extra.mult_per_straight
  end
}

jd_def["j_phanta_dottodot"] = {
  text = {
    {
      border_nodes = {
        { text = "X" },
        { ref_table = "card.joker_display_values", ref_value = "xmult", retrigger_type = "exp" }
      }
    }
  },
  calc_function = function(card)
    card.joker_display_values.xmult = card.ability.extra.active and card.ability.extra.xmult or 1
  end
}

jd_def["j_phanta_eyeofprovidence"] = {
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
        if SMODS.in_scoring(v, scoring_hand) and v:get_id() == 14 and v:is_suit("Spades") then
          xmult = xmult * (card.ability.extra.xmult ^ JokerDisplay.calculate_card_triggers(v, scoring_hand))
        end
      end
    end
    card.joker_display_values.xmult = xmult
    card.joker_display_values.localised_text = localize("k_phanta_ace_of_spades")
  end
}

jd_def["j_phanta_plumber"] = {
  text = {
    {
      border_nodes = {
        { text = "X" },
        { ref_table = "card.ability.extra", ref_value = "current_xmult", retrigger_type = "exp" }
      }
    }
  }
}

jd_def["j_phanta_thefuse"] = {
  text = {
    {
      border_nodes = {
        { text = "X" },
        { ref_table = "card.ability.extra", ref_value = "current_xmult", retrigger_type = "exp" }
      }
    }
  }
}








-- You should prolly do The Mace at some point. You're only not doing it because it's 1:40am and you're tired. :3:3:3:3:3:3:3:3:3:3:3:3:3:3:3:3:3:3:3:3:3:3:3:3:3:3:3:3:3:3:3:3:3:3:3:3:3:3:3:3:3
-- SPACE INTENTIONALLY LEFT BLANK
















jd_def["j_phanta_thedagger"] = {
  text = {
    { text = "+" },
    { ref_table = "card.ability.extra", ref_value = "current_mult", retrigger_type = "mult" }
  },
  text_config = { colour = G.C.MULT }
}

jd_def["j_phanta_evidence"] = {
  text = {
    {
      border_nodes = {
        { text = "X" },
        { ref_table = "card.ability.extra", ref_value = "current_xmult", retrigger_type = "exp" }
      }
    }
  }
}

jd_def["j_phanta_lily"] = {
  text = {
    { text = "+" },
    { ref_table = "card.joker_display_values", ref_value = "chips", retrigger_type = "mult" }
  },
  text_config = { colour = G.C.CHIPS },
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
    card.joker_display_values.chips = diamonds == 1 and card.ability.extra.given_chips or 0
  end
}

jd_def["j_phanta_selfportrait"] = {
  text = {
    { ref_table = "card.joker_display_values", ref_value = "active" }
  },
  calc_function = function(card)
    card.joker_display_values.active = card.ability.extra.current_rounds >= card.ability.extra.rounds_required and localize("k_active")
    or (card.ability.extra.current_rounds .. "/" .. card.ability.extra.rounds_required)
  end
}

jd_def["j_phanta_caniossoul"] = {
  text = {
    {
      border_nodes = {
        { text = "X" },
        { ref_table = "card.ability.extra", ref_value = "current_xmult", retrigger_type = "exp" }
      }
    }
  }
}

jd_def["j_phanta_tribouletssoul"] = {
  text = {
    {
      border_nodes = {
        { text = "X" },
        { ref_table = "card.ability.extra", ref_value = "given_xmult", retrigger_type = "exp" }
      }
    }
  },
  reminder_text = {
    { text = "(" },
    { ref_table = "card.joker_display_values", ref_value = "localised_text", colour = G.C.FILTER },
    { text = ")" }
  },
  calc_function = function(card)
    card.joker_display_values.localised_text = localize("k_phanta_king_and_queen")
  end
}

jd_def["j_phanta_yorickssoul"] = {
  text = {
    {
      border_nodes = {
        { text = "X" },
        { ref_table = "card.ability.extra", ref_value = "current_xmult", retrigger_type = "exp" }
      }
    }
  }
}

jd_def["j_phanta_chicotssoul"] = {
  text = {
    {
      border_nodes = {
        { text = "X" },
        { ref_table = "card.ability.extra", ref_value = "current_xmult", retrigger_type = "exp" }
      }
    }
  }
}

jd_def["j_phanta_perkeossoul"] = {
  text = {
    {
      border_nodes = {
        { text = "X" },
        { ref_table = "card.ability.extra", ref_value = "current_xmult", retrigger_type = "exp" }
      }
    }
  }
}

jd_def["j_phanta_spectretile"] = {
  extra = {
    {
      { text = "(" },
      { ref_table = "card.joker_display_values", ref_value = "odds" },
      { text = ")" }
    }
  },
  extra_config = { colour = G.C.GREEN, scale = 0.3 },
  calc_function = function(card)
    local numerator, denominator = SMODS.get_probability_vars(card, 1, card.ability.extra.odds, "spectretile")
    card.joker_display_values.odds = localize { type = 'variable', key = "jdis_odds", vars = { numerator, denominator } }
  end
}

jd_def["j_phanta_possession"] = {
  extra = {
    {
      { text = "(" },
      { ref_table = "card.joker_display_values", ref_value = "odds" },
      { text = ")" }
    }
  },
  extra_config = { colour = G.C.GREEN, scale = 0.3 },
  calc_function = function(card)
    local numerator, denominator = SMODS.get_probability_vars(card, 1, card.ability.extra.odds, "possession")
    card.joker_display_values.odds = localize { type = 'variable', key = "jdis_odds", vars = { numerator, denominator } }
  end
}