local jd_def = JokerDisplay.Definitions

jd_def["j_phanta_ignaize"] = {
  text = {
    {
      border_nodes = {
        { text = "X" },
        { ref_table = "card.ability.extra", ref_value = "current_xmult", retrigger_type = "exp" }
      }
    }
  }
}

jd_def["j_phanta_goldor"] = {
  text = {
    { text = "+$",                      colour = G.C.GOLD },
    { ref_table = "card.joker_display_values", ref_value = "money", retrigger_type = "mult", colour = G.C.GOLD },
    { text = " " },
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
    local money = 0
    local xmult = 1
    local text, _, scoring_hand = JokerDisplay.evaluate_hand()
    if text ~= 'Unknown' then
      for _, v in pairs(next(G.play.cards) and G.play.cards or G.hand.highlighted) do
        if SMODS.in_scoring(v, scoring_hand) and SMODS.has_enhancement(v, "m_gold") then
          local triggers = JokerDisplay.calculate_card_triggers(v, scoring_hand)
          money = money + (card.ability.extra.money * triggers)
          xmult = xmult * (card.ability.extra.xmult ^ triggers)
        end
      end
    end
    card.joker_display_values.money = money
    card.joker_display_values.xmult = xmult
    card.joker_display_values.localised_text = localize("k_phanta_gold_cards")
  end
}

jd_def["j_phanta_godoor"] = {
  text = {
    {
      border_nodes = {
        { text = "X" },
        { ref_table = "card.ability.extra", ref_value = "current_xmult", retrigger_type = "exp" }
      }
    }
  }
}

jd_def["j_phanta_fainfol"] = {
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
    { ref_table = "card.joker_display_values", ref_value = "fainfol_suit" },
    { text = ")" }
  },
  calc_function = function(card)
    local xmult = 1
    for _, v in ipairs(G.hand.cards) do
      if not v.highlighted then
        if v.facing ~= 'back' and not v.debuff and v:is_suit(G.GAME.current_round.fainfol_card.suit) then
          xmult = xmult * (card.ability.extra.xmult ^ JokerDisplay.calculate_card_triggers(v, nil, true))
        end
      end
    end
    card.joker_display_values.xmult = xmult
    card.joker_display_values.fainfol_suit = localize(G.GAME.current_round.fainfol_card.suit, 'suits_plural')
  end,
  style_function = function(card, text, reminder_text, extra)
    if reminder_text and reminder_text.children[2] then
      reminder_text.children[2].config.colour = lighten(G.C.SUITS[G.GAME.current_round.fainfol_card.suit], 0.35)
    end
    return false
  end
}

jd_def["j_phanta_granwyrm"] = {
  text = {
    {
      border_nodes = {
        { text = "X" },
        { ref_table = "card.ability.extra", ref_value = "current_xmult", retrigger_type = "exp" }
      }
    }
  },
  reminder_text = {
    { ref_table = "card.joker_display_values", ref_value = "progress" }
  },
  calc_function = function(card)
    card.joker_display_values.progress = card.ability.extra.current_unscored .. "/" .. card.ability.extra.target_unscored
  end
}