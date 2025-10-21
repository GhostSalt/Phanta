SMODS.Atlas {
    key = "PhantaSuits",
    path = "PhantaSuits.png",
    px = 71,
    py = 95
}

SMODS.Atlas {
    key = "PhantaSuitUI",
    path = "PhantaSuitUI.png",
    px = 18,
    py = 18
}

SMODS.Suit {
    key = "unknown",
    card_key = "UNKNOWN",
    lc_atlas = "PhantaSuits",
    hc_atlas = "PhantaSuits",
    lc_ui_atlas = "PhantaSuitUI",
    hc_ui_atlas = "PhantaSuitUI",
    lc_colour = HEX("818181"),
    hc_colour = HEX("818181"),
    pos = { y = 0 },
    ui_pos = { x = 0, y = 0 },
    in_pool = function(self, args)
        return false
    end
}

function Card:become_unknown(cause)
    if self.base.suit ~= "phanta_unknown" then self.ability.phanta_actual_suit = self.base.suit end
    if not self.ability.phanta_unknown_causes then self.ability.phanta_unknown_causes = {} end
    self.ability.phanta_unknown_causes[cause] = (self.ability.phanta_unknown_causes[cause] or 0) + 1
    self:change_suit("phanta_unknown")
end

function Card:release_unknown(cause)
    if not self.ability.phanta_unknown_causes then self.ability.phanta_unknown_causes = {} end
    local cause_comp = self.ability.phanta_unknown_causes[cause]
    if cause_comp and cause_comp > 0 then self.ability.phanta_unknown_causes[cause] = cause_comp - 1 end
    local no_causes = true
    for k, v in pairs(self.ability.phanta_unknown_causes) do
        if v and v > 0 then no_causes = false end
    end
    G.phanta_lie_about_unknowns = true
    if no_causes and self:is_suit("phanta_unknown", nil, nil) then
        G.phanta_change_from_release = true; self:change_suit(self.ability.phanta_actual_suit or "phanta_unknown")
    end
end

local is_suit_ref = Card.is_suit
function Card:is_suit(suit, bypass_debuff, flush_calc)
    local ref_return = nil
    if self.base.suit == "phanta_unknown" and not G.phanta_lie_about_unknowns then
        self.base.suit = self.ability.phanta_actual_suit or "phanta_unknown"
        ref_return = is_suit_ref(self, suit, bypass_debuff, flush_calc)
        self.base.suit = "phanta_unknown"
    elseif suit == "phanta_unknown" then
        return self.base.suit == suit
    else
        ref_return = is_suit_ref(self, suit, bypass_debuff, flush_calc)
    end

    G.phanta_lie_about_unknowns = nil
    return ref_return
end

local change_suit_ref = Card.change_suit
function Card:change_suit(new_suit)
    local from_release = G.phanta_change_from_release
    G.phanta_change_from_release = nil
    if self.base.suit == "phanta_unknown" and new_suit ~= "phanta_unknown" and not from_release then
        self.ability.phanta_actual_suit = new_suit
    else
        if new_suit ~= "phanta_unknown" then self.ability.phanta_actual_suit = nil end
        return change_suit_ref(self, new_suit)
    end
end
