SMODS.PokerHand {
  key = "junk",
  chips = 5,
  mult = 2,
  l_chips = 20,
  l_mult = 1,
  visible = false,
  above_hand = "High Card",
  example = {
    { 'C_A', false },
    { 'H_Q', false },
    { 'H_6', false },
    { 'C_3', false },
    { 'S_2', true }
  },
  evaluate = function(parts, hand)
    if not Phanta.config["junk_enabled"] then return false end
    local lowest = get_lowest(hand)
    if next(lowest) and #hand >= 5 then return lowest else return {} end
  end
}

SMODS.PokerHand:take_ownership('High Card', {
  example = {
    { 'S_A', true },
    { 'D_Q', false },
    { 'D_9', false },
    { 'C_4', false },
  },
}, true)







SMODS.PokerHand:take_ownership('Full House', {
  evaluate = function(parts, hand)
    if (#parts._3 < 1 and not (G.GAME.selected_partner == "pnr_phanta_conspiracist" and next(SMODS.find_card("j_phanta_conspiracist")))) or #parts._2 < 2 then return {} end
    return parts._all_pairs
  end
}, true)