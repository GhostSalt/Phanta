for k, v in ipairs(G.Phanta.thetrick_supported_planets) do
    SMODS.Consumable:take_ownership(v, {
        loc_vars = function(self, info_queue, card)
            return {
                vars = {
                    G.GAME.hands[card.ability.hand_type].level,
                    localize(card.ability.hand_type, 'poker_hands'),
                    G.GAME.hands[card.ability.hand_type].l_mult * (count_tricks(card) + 1),
                    G.GAME.hands[card.ability.hand_type].l_chips * (count_tricks(card) + 1),
                    colours = { (to_big(G.GAME.hands[card.ability.hand_type].level) == to_big(1) and G.C.UI.TEXT_DARK or G.C.HAND_LEVELS[math.min(7, G.GAME.hands[card.ability.hand_type].level)]) }
                }
            }
        end
    }, true)
end
