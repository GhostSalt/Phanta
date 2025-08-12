SMODS.Atlas {
    key = "PhantaBlinds",
    path = "PhantaBlinds.png",
    px = 34,
    py = 34,
    atlas_table = "ANIMATION_ATLAS",
    frames = 21
}

SMODS.Blind {
    key = "answer",
    atlas = "PhantaBlinds",
    pos = { x = 0, y = 0 },
    boss = { min = 1 },
    boss_colour = HEX("4BA431"),
    collection_loc_vars = function(self)
        local num, denom = SMODS.get_probability_vars(self, 1, 3, "theanswer")
        return { vars = { num, denom } }
    end,
    loc_vars = function(self)
        local num, denom = SMODS.get_probability_vars(self, 1, 3, "theanswer")
        return { vars = { num, denom } }
    end,
    vars = { vars = { 1, 3 } },
    set_blind = function(self)
        if G.deck and G.deck.cards then
            for _, v in ipairs(G.deck.cards) do
                if SMODS.pseudorandom_probability(self, "theanswer", 1, 3) then
                    v:become_unknown("phanta_answer")
                end
            end
        end
    end,
    disable = function(self)
        if G.deck and G.deck.cards then
            for _, v in ipairs(G.deck.cards) do
                v:release_unknown("phanta_answer")
            end
        end
    end
}

function Card:become_unknown(cause)
    self.ability.phanta_actual_suit = self.base.suit
    if not self.ability.phanta_unknown_cause then self.ability.phanta_unknown_cause = {} end
    self.ability.phanta_unknown_cause[cause] = true
    self:change_suit("phanta_unknown")
end

function Card:release_unknown(cause)
    if not self.ability.phanta_unknown_cause then self.ability.phanta_unknown_cause = {} end
    self.ability.phanta_unknown_causes[cause] = nil
    local no_causes = true
    for k, v in pairs(self.ability.phanta_unknown_causes) do
        if v then no_causes = false end
    end
    if no_causes then self:change_suit(self.ability.phanta_actual_suit) end
end

local is_suit_ref = Card.is_suit
function Card:is_suit(suit, bypass_debuff, flush_calc, lie_about_unknowns)
    local _card = self
    if _card.base.suit == "phanta_unknown" and not lie_about_unknowns then
        _card.base.suit = _card.ability.phanta_actual_suit or "phanta_unknown"
    end
    return is_suit_ref(_card, suit, bypass_debuff, flush_calc)
end
