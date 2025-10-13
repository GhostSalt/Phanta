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

SMODS.Blind {
    key = "shark",
    atlas = "PhantaBlinds",
    pos = { x = 0, y = 2 },
    boss = { min = 3 },
    boss_colour = HEX("57B5C3"),
    calculate = function(self, blind, context)
        if context.after and not blind.disabled then
            if not context.scoring_hand then return end
            local enhanced = {}
            for k, v in ipairs(context.scoring_hand) do
                if next(SMODS.get_enhancements(v)) then enhanced[#enhanced + 1] = v end
            end
            if #enhanced <= 0 then return end
            blind.triggered = true
            G.E_MANAGER:add_event(Event({
                trigger = 'after',
                delay = 0.4,
                func = function()
                    G.E_MANAGER:add_event(Event({
                        trigger = 'after',
                        delay = 0.06 * G.SETTINGS.GAMESPEED,
                        blockable = false,
                        blocking = false,
                        func = function()
                            play_sound('tarot2', 0.76, 0.4); return true
                        end
                    }))
                    play_sound('tarot2', 1, 0.4)
                    SMODS.juice_up_blind()
                    return true
                end
            }))
            for i = 1, #enhanced do
                local percent = 1.15 - (i - 0.999) / (#enhanced - 0.998) * 0.3
                G.E_MANAGER:add_event(Event({
                    trigger = 'after',
                    delay = 0.15,
                    func = function()
                        enhanced[i]:flip()
                        play_sound('card1', percent)
                        enhanced[i]:juice_up(0.3, 0.3)
                        return true
                    end
                }))
            end
            delay(0.2)
            for i = 1, #enhanced do
                G.E_MANAGER:add_event(Event({
                    trigger = 'after',
                    delay = 0.1,
                    func = function()
                        enhanced[i]:set_ability(SMODS.poll_enhancement { guaranteed = true })
                        return true
                    end
                }))
            end
            for i = 1, #enhanced do
                local percent = 0.85 + (i - 0.999) / (#enhanced - 0.998) * 0.3
                G.E_MANAGER:add_event(Event({
                    trigger = 'after',
                    delay = 0.15,
                    func = function()
                        enhanced[i]:flip()
                        play_sound('tarot2', percent, 0.6)
                        enhanced[i]:juice_up(0.3, 0.3)
                        return true
                    end
                }))
            end
            delay(1)
        end
    end,
    in_pool = function()
        if not G.playing_cards then return false end
        local enhancement_tally = 0
        for k, v in pairs(G.playing_cards) do
            if next(SMODS.get_enhancements(v)) then enhancement_tally = enhancement_tally + 1 end
            if enhancement_tally >= 10 then return true end
        end
        return false
    end
}

SMODS.Blind {
    key = "strings",
    atlas = "PhantaBlinds",
    pos = { x = 0, y = 3 },
    boss = { min = 4 },
    boss_colour = HEX("98635A"),
    calculate = function(self, blind, context)
        if context.debuff_card and context.debuff_card.area ~= G.jokers and not blind.disabled then
            return { debuff = true }
        end
        if context.final_scoring_step and not blind.disabled and #G.play.cards == 4 then
            G.E_MANAGER:add_event(Event({
                trigger = 'immediate',
                func = function()
                    blind:disable()
                    return true
                end
            }))
        end
    end
}

SMODS.Blind {
    key = "moth",
    atlas = "PhantaBlinds",
    pos = { x = 0, y = 4 },
    boss = { min = 4 },
    boss_colour = HEX("A5C674"),
    calculate = function(self, blind, context)
        if context.debuff_card and context.debuff_card.area ~= G.jokers and not blind.disabled
            and (context.debuff_card:get_id() == 14 or context.debuff_card:get_id() == 2 or context.debuff_card:get_id() == 3) then
            return { debuff = true }
        end
    end
}

SMODS.Blind {
    key = "toxin",
    atlas = "PhantaBlinds",
    pos = { x = 0, y = 5 },
    boss = { min = 2 },
    boss_colour = HEX("71569D"),
    calculate = function(self, blind, context)
        if context.debuff_hand and G.GAME.current_round.hands_played == 0 and not blind.disabled then
            blind.triggered = true
            return { debuff = true }
        end
    end
}

--[[SMODS.Blind {
    key = "centre",
    atlas = "PhantaBlinds",
    pos = { x = 0, y = 6 },
    boss = { min = 2 },
    boss_colour = HEX("318F60"),
    calculate = function(self, blind, context)
        if context.debuff_card and context.debuff_card.phanta_centre_debuffed and not blind.disabled then
            return { debuff = true }
        end
    end,
    set_blind = function(self)
        for i = 1, 8 do
            G.deck.cards[i].phanta_centre_debuffed = true
        end
        for i = #G.deck.cards, #G.deck.cards - 4, -1 do
            G.deck.cards[i].phanta_centre_debuffed = true
        end
    end,
    disable = function(self)
        if G.playing_cards then
            for _, v in ipairs(G.playing_cards) do
                v.phanta_centre_debuffed = false
            end
        end
    end
}
]]--