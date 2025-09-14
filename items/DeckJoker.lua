-- Find the API in Jokers2.lua.

local deck_joker_red = {
    key = "b_red",
    loc_key = "red",

    pos = { x = 0, y = 0 },
    atlas = "phanta_PhantaDeckJoker",

    blueprint_compat = false,
    eternal_compat = true,
    perishable_compat = true,

    config = { extra = { discards = 1 } },
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

    pos = { x = 1, y = 0 },
    atlas = "phanta_PhantaDeckJoker",

    blueprint_compat = false,
    eternal_compat = true,
    perishable_compat = true,

    config = { extra = { hands = 1 } },
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

    pos = { x = 2, y = 0 },
    atlas = "phanta_PhantaDeckJoker",

    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,

    config = { extra = { hands = 1, dollars = 5 } },
    calculate = function(self, card, context)
        if context.end_of_round and not context.individual and not context.repetition and not context.blueprint then
            card.ability.extra.primed = next(SMODS.find_card("j_phanta_mrbigmoneybags"))
                or math.min(math.floor(G.GAME.dollars / 5), G.GAME.interest_cap / 5) == G.GAME.interest_cap / 5
        end

        if context.starting_shop and card.ability.extra.primed then
            return { dollars = card.ability.extra.dollars }
        end
    end
}
deck_joker_yellow.loc_vars = { deck_joker_yellow.config.extra.dollars }
phanta_add_deck_joker_deck(deck_joker_yellow)

local deck_joker_green = {
    key = "b_green",
    loc_key = "green",

    pos = { x = 3, y = 0 },
    atlas = "phanta_PhantaDeckJoker",

    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,

    config = { extra = { added_mult = 1, current_mult = 0 } },
    calculate = function(self, card, context)
        if context.end_of_round and not context.individual and not context.repetition and not context.blueprint then
            if G.GAME.current_round.hands_left > 0 then
                card.ability.extra.current_mult = card.ability.extra.current_mult +
                (card.ability.extra.added_mult * G.GAME.current_round.hands_left)
                return { message = localize("k_upgrade_ex"), colour = G.C.FILTER }
            end
        end

        if context.joker_main and card.ability.extra.current_mult > 0 then
            return { mult = card.ability.extra.current_mult }
        end
    end
}
deck_joker_green.loc_vars = { deck_joker_green.config.extra.added_mult, deck_joker_green.config.extra.current_mult }
phanta_add_deck_joker_deck(deck_joker_green)

local deck_joker_black = {
    key = "b_black",
    loc_key = "black",

    pos = { x = 4, y = 0 },
    atlas = "phanta_PhantaDeckJoker",

    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,

    config = { extra = { chips = 25 } },
    calculate = function(self, card, context)
        if context.other_joker and context.other_joker.config.center.rarity == 1 then
            return { chips = card.ability.extra.chips }
        end
    end
}
deck_joker_black.loc_vars = { deck_joker_black.config.extra.chips }
phanta_add_deck_joker_deck(deck_joker_black)
