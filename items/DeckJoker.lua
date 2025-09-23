-- Find the API in Jokers2.lua.
local deck_joker_red = {
    key = "b_red",
    loc_key = "red",

    pos = {
        x = 0,
        y = 0
    },
    atlas = "phanta_PhantaDeckJoker",

    blueprint_compat = false,
    eternal_compat = true,
    perishable_compat = true,

    config = {
        extra = {
            discards = 1
        }
    },
    add_to_deck = function(self, card, from_debuff)
        G.GAME.round_resets.discards = G.GAME.round_resets.discards + card.ability.extra.discards
        ease_discard(card.ability.extra.discards)
    end,
    remove_from_deck = function(self, card, from_debuff)
        G.GAME.round_resets.discards = G.GAME.round_resets.discards - card.ability.extra.discards
        ease_discard(-card.ability.extra.discards)
    end
}
deck_joker_red.loc_vars = { deck_joker_red.config.extra.discards }
phanta_add_deck_joker_deck(deck_joker_red)

local deck_joker_blue = {
    key = "b_blue",
    loc_key = "blue",

    pos = {
        x = 1,
        y = 0
    },
    atlas = "phanta_PhantaDeckJoker",

    blueprint_compat = false,
    eternal_compat = true,
    perishable_compat = true,

    config = {
        extra = {
            hands = 1
        }
    },
    add_to_deck = function(self, card, from_debuff)
        G.GAME.round_resets.hands = G.GAME.round_resets.hands + card.ability.extra.hands
        ease_hands_played(card.ability.extra.hands)
    end,
    remove_from_deck = function(self, card, from_debuff)
        G.GAME.round_resets.hands = G.GAME.round_resets.hands - card.ability.extra.hands
        ease_hands_played(-card.ability.extra.hands)
    end
}
deck_joker_blue.loc_vars = { deck_joker_blue.config.extra.hands }
phanta_add_deck_joker_deck(deck_joker_blue)

local deck_joker_yellow = {
    key = "b_yellow",
    loc_key = "yellow",

    pos = {
        x = 2,
        y = 0
    },
    atlas = "phanta_PhantaDeckJoker",

    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,

    config = {
        extra = {
            hands = 1,
            dollars = 5
        }
    },
    calculate = function(self, card, context)
        if context.end_of_round and not context.individual and not context.repetition and not context.blueprint then
            card.ability.extra.primed = next(SMODS.find_card("j_phanta_mrbigmoneybags")) or
                math.min(math.floor(G.GAME.dollars / 5), G.GAME.interest_cap / 5) ==
                G.GAME.interest_cap / 5
        end

        if context.starting_shop and card.ability.extra.primed then
            return {
                dollars = card.ability.extra.dollars
            }
        end
    end
}
deck_joker_yellow.loc_vars = { deck_joker_yellow.config.extra.dollars }
phanta_add_deck_joker_deck(deck_joker_yellow)

local deck_joker_green = {
    key = "b_green",
    loc_key = "green",

    pos = {
        x = 3,
        y = 0
    },
    atlas = "phanta_PhantaDeckJoker",

    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = false,

    config = {
        extra = {
            added_mult = 1,
            current_mult = 0
        }
    },
    calculate = function(self, card, context)
        if context.end_of_round and not context.individual and not context.repetition and not context.blueprint then
            if G.GAME.current_round.hands_left > 0 then
                card.ability.extra.current_mult = card.ability.extra.current_mult +
                    (card.ability.extra.added_mult * G.GAME.current_round.hands_left)
                return {
                    message = localize("k_upgrade_ex"),
                    colour = G.C.FILTER
                }
            end
        end

        if context.joker_main and card.ability.extra.current_mult > 0 then
            return {
                mult = card.ability.extra.current_mult
            }
        end
    end
}
deck_joker_green.loc_vars = { deck_joker_green.config.extra.added_mult, deck_joker_green.config.extra.current_mult }
phanta_add_deck_joker_deck(deck_joker_green)

local deck_joker_black = {
    key = "b_black",
    loc_key = "black",

    pos = {
        x = 4,
        y = 0
    },
    atlas = "phanta_PhantaDeckJoker",

    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,

    config = {
        extra = {
            chips = 25
        }
    },
    calculate = function(self, card, context)
        if context.other_joker and context.other_joker.config.center.rarity == 1 then
            return {
                chips = card.ability.extra.chips
            }
        end
    end
}
deck_joker_black.loc_vars = { deck_joker_black.config.extra.chips }
phanta_add_deck_joker_deck(deck_joker_black)

local deck_joker_magic = {
    key = "b_magic",
    loc_key = "magic",

    pos = {
        x = 5,
        y = 0
    },
    atlas = "phanta_PhantaDeckJoker",

    rarity = 2,
    cost = 6,

    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,

    calculate = function(self, card, context)
        if context.setting_blind and count_consumables() < G.consumeables.config.card_limit and count_tarots() > 0 and
            count_planets() > 0 then
            local _card = card
            G.E_MANAGER:add_event(Event({
                func = function()
                    play_sound('timpani')
                    G.E_MANAGER:add_event(Event({
                        delay = 0.3,
                        blockable = false,
                        func = function()
                            local new_card = create_card("Spectral", G.consumables, nil, nil, nil, nil)
                            new_card:add_to_deck()
                            G.consumeables:emplace(new_card)
                            return true
                        end
                    }))
                    card_eval_status_text(_card, 'extra', nil, nil, nil, {
                        message = localize('k_plus_spectral'),
                        colour = G.C.SECONDARY_SET.Spectral
                    })
                    return true
                end
            }))
        end
    end
}
phanta_add_deck_joker_deck(deck_joker_magic)

local deck_joker_nebula = {
    key = "b_nebula",
    loc_key = "nebula",

    pos = {
        x = 6,
        y = 0
    },
    atlas = "phanta_PhantaDeckJoker",

    rarity = 2,
    cost = 6,

    info_queue = { G.P_TAGS.tag_meteor },

    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,

    calculate = function(self, card, context)
        if context.cardarea == G.jokers and context.before and G.GAME.current_round.hands_left == 0 then
            G.E_MANAGER:add_event(Event({
                func = function()
                    card_eval_status_text(card, 'extra', nil, nil, nil, {
                        message = '+' .. localize {
                            type = 'name_text',
                            key = 'tag_meteor',
                            set = 'Tag'
                        },
                        colour = G.C.SECONDARY_SET.Planet
                    })
                    add_tag(Tag('tag_meteor'))
                    play_sound('generic1', 0.9 + math.random() * 0.1, 0.8)
                    play_sound('holo1', 1.2 + math.random() * 0.1, 0.4)
                    return true
                end
            }))
        end
    end
}
phanta_add_deck_joker_deck(deck_joker_nebula)

local deck_joker_ghost = {
    key = "b_ghost",
    loc_key = "ghost",

    pos = {
        x = 7,
        y = 0
    },
    atlas = "phanta_PhantaDeckJoker",

    rarity = 2,
    cost = 5,

    info_queue = { G.P_CENTERS.c_fool },

    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,

    calculate = function(self, card, context)
        if context.selling_card and context.card.config.center.set == "Spectral" and count_consumables() <= G.consumeables.config.card_limit then
            G.E_MANAGER:add_event(Event({
                delay = 0.3,
                blockable = false,
                func = function()
                    play_sound("timpani")
                    local new_card = create_card("Tarot", G.consumables, nil, nil, nil, nil, "c_fool", 'deckjokerghost')
                    new_card:add_to_deck()
                    G.consumeables:emplace(new_card)
                    new_card:juice_up(0.3, 0.5)
                    return true
                end
            }))
        end
    end
}
phanta_add_deck_joker_deck(deck_joker_ghost)

local deck_joker_abandoned = {
    key = "b_abandoned",
    loc_key = "abandoned",

    pos = {
        x = 8,
        y = 0
    },
    atlas = "phanta_PhantaDeckJoker",

    rarity = 1,
    cost = 5,

    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,

    config = {
        extra = {
            mult = 6
        }
    },
    calculate = function(self, card, context)
        if context.individual and context.other_card:get_id() == 14 then return { mult = card.ability.extra.mult } end
    end
}
deck_joker_abandoned.loc_vars = { deck_joker_abandoned.config.extra.mult }
phanta_add_deck_joker_deck(deck_joker_abandoned)

local deck_joker_checkered = {
    key = "b_checkered",
    loc_key = "checkered",

    pos = {
        x = 9,
        y = 0
    },
    atlas = "phanta_PhantaDeckJoker",

    rarity = 1,
    cost = 5,

    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = false,

    config = {
        extra = {
            added_mult = 1, current_mult = 0
        }
    },
    calculate = function(self, card, context)
        if context.joker_main and card.ability.extra.current_mult > 0 then return { mult = card.ability.extra.current_mult } end

        if context.before and context.scoring_name == "Flush" and not context.blueprint then
            card.ability.extra.current_mult = card.ability.extra.current_mult + card.ability.extra.added_mult
            return { message = localize("k_upgrade_ex"), colour = G.C.FILTER }
        end
    end
}
deck_joker_checkered.loc_vars = { deck_joker_checkered.config.extra.added_mult, deck_joker_checkered.config.extra.current_mult }
phanta_add_deck_joker_deck(deck_joker_checkered)

local deck_joker_zodiac = {
    key = "b_zodiac",
    loc_key = "zodiac",

    pos = {
        x = 10,
        y = 0
    },
    atlas = "phanta_PhantaDeckJoker",

    rarity = 1,
    cost = 4,

    blueprint_compat = false,
    eternal_compat = true,
    perishable_compat = false,

    config = {
        extra = {
            rerolls = 1
        }
    },
    add_to_deck = function(self, card, from_debuff)
        SMODS.change_free_rerolls(card.ability.extra.rerolls)
    end,
    remove_from_deck = function(self, card, from_debuff)
        SMODS.change_free_rerolls(-card.ability.extra.rerolls)
    end
}
deck_joker_zodiac.loc_vars = { deck_joker_zodiac.config.extra.rerolls }
phanta_add_deck_joker_deck(deck_joker_zodiac)

local deck_joker_painted = {
    key = "b_painted",
    loc_key = "painted",

    pos = {
        x = 11,
        y = 0
    },
    atlas = "phanta_PhantaDeckJoker",

    rarity = 1,
    cost = 5,

    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = false,

    config = {
        extra = {
            added_mult = 2, current_mult = 0
        }
    },
    calculate = function(self, card, context)
        if context.joker_main and card.ability.extra.current_mult > 0 then return { mult = card.ability.extra.current_mult } end

        if context.before and context.scoring_name == "Straight Flush" and not context.blueprint then
            card.ability.extra.current_mult = card.ability.extra.current_mult + card.ability.extra.added_mult
            return { message = localize("k_upgrade_ex"), colour = G.C.FILTER }
        end
    end
}
deck_joker_painted.loc_vars = { deck_joker_painted.config.extra.added_mult, deck_joker_painted.config.extra.current_mult }
phanta_add_deck_joker_deck(deck_joker_painted)



















local deck_joker_stormcaught = {
    key = "b_phanta_stormcaught",
    loc_key = "stormcaught",

    pos = {
        x = 0,
        y = 2
    },
    atlas = "phanta_PhantaDeckJoker",

    rarity = 2,
    cost = 6,

    info_queue = { G.P_TAGS.tag_foil },

    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,

    calculate = function(self, card, context)
        if context.selling_card and context.card.config.center.set == "Joker" and context.card.config.center.rarity == 2 and context.card ~= card and not card.getting_sliced then
            G.E_MANAGER:add_event(Event({
                func = function()
                    card_eval_status_text(card, 'extra', nil, nil, nil, {
                        message = '+' .. localize {
                            type = 'name_text',
                            key = 'tag_foil',
                            set = 'Tag'
                        },
                        colour = G.C.FILTER
                    })
                    add_tag(Tag('tag_foil'))
                    play_sound('generic1', 0.9 + math.random() * 0.1, 0.8)
                    play_sound('holo1', 1.2 + math.random() * 0.1, 0.4)
                    return true
                end
            }))
        end
    end
}
phanta_add_deck_joker_deck(deck_joker_stormcaught)

local deck_joker_blurple = {
    key = "b_phanta_blurple",
    loc_key = "blurple",

    pos = {
        x = 1,
        y = 2
    },
    atlas = "phanta_PhantaDeckJoker",

    rarity = 2,
    cost = 6,

    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,

    calculate = function(self, card, context)
        if context.setting_blind and count_consumables() < G.consumeables.config.card_limit then
            G.E_MANAGER:add_event(Event({
                delay = 0.3,
                blockable = false,
                func = function()
                    play_sound('timpani')
                    local new_card = create_card("Tarot_Planet", G.consumables, nil, nil, nil, nil, nil,
                        'deckjokerblurple')
                    new_card:add_to_deck()
                    G.consumeables:emplace(new_card)
                    return true
                end
            }))
        end
    end
}
phanta_add_deck_joker_deck(deck_joker_blurple)

local deck_joker_azran = {
    key = "b_phanta_azran",
    loc_key = "azran",

    pos = {
        x = 2,
        y = 2
    },
    atlas = "phanta_PhantaDeckJoker",

    rarity = 2,
    cost = 6,

    info_queue = { G.P_CENTERS.c_phanta_shard },

    blueprint_compat = false,
    eternal_compat = false,
    perishable_compat = true,

    calculate = function(self, card, context)
        if context.ending_shop and not context.repetition then
            G.E_MANAGER:add_event(Event({
                delay = 0.3,
                blockable = false,
                func = function()
                    play_sound('timpani')
                    local new_card = create_card("Spectral", G.consumables, nil, nil, nil, nil, "c_phanta_shard",
                        'deckjokerazran')
                    new_card:set_edition({ negative = true })
                    new_card:add_to_deck()
                    G.consumeables:emplace(new_card)

                    card.T.r = -0.2
                    card:juice_up(0.3, 0.4)
                    card.states.drag.is = true
                    card.children.center.pinch.x = true
                    G.E_MANAGER:add_event(Event({
                        trigger = 'after',
                        delay = 0.3,
                        blockable = false,
                        func = function()
                            play_sound("phanta_tally_deck", 1, 0.5)
                            G.jokers:remove_card(card)
                            card:remove()
                            card = nil
                            return true
                        end
                    }))
                    return true
                end
            }))
        end
    end
}
phanta_add_deck_joker_deck(deck_joker_azran)

local deck_joker_badd = {
    key = "b_phanta_badd",
    loc_key = "badd",

    pos = {
        x = 3,
        y = 2
    },
    atlas = "phanta_PhantaDeckJoker",

    rarity = 2,
    cost = 6,

    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,

    config = { extra = { money = 3 } },
    calculate = function(self, card, context)
        if context.remove_playing_cards then
            return
            {
                dollars = card.ability.extra.money * #context.removed,
                card = card
            }
        end
    end
}
deck_joker_badd.loc_vars = { deck_joker_badd.config.extra.money }
phanta_add_deck_joker_deck(deck_joker_badd)
