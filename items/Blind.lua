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
    boss = { min = 2 },
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
        if G.playing_cards then
            for _, v in ipairs(G.playing_cards) do
                if SMODS.pseudorandom_probability(self, "theanswer", 1, 3) then
                    v:become_unknown("phanta_answer")
                end
            end
        end
    end,
    defeat = function(self)
        if G.playing_cards then
            for _, v in ipairs(G.playing_cards) do
                v:release_unknown("phanta_answer")
            end
        end
    end,
    disable = function(self)
        if G.playing_cards then
            for _, v in ipairs(G.playing_cards) do
                v:release_unknown("phanta_answer")
            end
        end
    end
}

SMODS.Blind {
    key = "proton",
    atlas = "PhantaBlinds",
    pos = { x = 0, y = 1 },
    boss = { min = 1 },
    boss_colour = HEX("DE3939"),
    debuff_hand = function(self, cards, hand, handname, check)
        local _, _, _, scoring_hand, _ = G.FUNCS.get_poker_hand_info(cards)

        local always_scores_count = 0
        for _, card in pairs(cards) do
            if card.config.center.always_scores then always_scores_count = always_scores_count + 1 end
        end

        if #scoring_hand + always_scores_count < #cards then return true end
    end
}
