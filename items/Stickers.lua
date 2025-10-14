SMODS.Atlas {
    key = "PhantaStickers",
    path = "PhantaStickers.png",
    px = 71,
    py = 95,
}

SMODS.Sticker {
    key = "sleepy",
    atlas = "PhantaStickers",
    pos = { x = 2, y = 2 },
    badge_colour = HEX 'c75985',
    default_compat = true,
    sets = { Joker = true },
    rate = 0.25,
    needs_enable_flag = true,
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.sleepy_rounds or 2, card.ability.sleepy_tally or G.GAME.phanta_sleepy_rounds } }
    end,
    apply = function(self, card, val)
        card.ability[self.key] = val
        if card.ability[self.key] == val then
            card.ability.sleepy_tally = G.GAME.phanta_sleepy_rounds
            card.ability.sleepy_rounds = G.GAME.phanta_sleepy_rounds
        end
    end
}

local card_add_to_deck_ref = Card.add_to_deck
function Card:add_to_deck(from_debuff)
    card_add_to_deck_ref(self, from_debuff)
    if self.ability.phanta_sleepy then self:set_debuff(true) end
end

local set_debuff_ref = Card.set_debuff
function Card:set_debuff(should_debuff)
    if self.ability.phanta_sleepy and self.ability.sleepy_tally > 0 then 
        if not self.debuff then
            self.debuff = true
            if self.area == G.jokers then self:remove_from_deck(true) end
        end
        return
    end
    set_debuff_ref(self, should_debuff)
end