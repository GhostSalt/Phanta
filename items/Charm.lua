SMODS.Atlas {
    key = "PhantaCharms",
    path = "PhantaCharms.png",
    px = 68,
    py = 68
}

Bakery_API.credit(Bakery_API.Charm {
    key = "silo",
    pos = { x = 0, y = 0 },
    atlas = 'PhantaCharms',
    artist = 'GhostSalt',
    config = {
        extra = {}
    },
    calculate = function(self, card, context)
        if context.setting_blind and not (context.blueprint_card or card).getting_sliced then
            G.GAME.consumeable_buffer = G.GAME.consumeable_buffer + 1
            G.E_MANAGER:add_event(Event({
                func = function()
                    G.E_MANAGER:add_event(Event({
                        func = function()
                            local key = pseudorandom_element(G.P_CENTER_POOLS.phanta_CatanResource, pseudoseed('monopolychosenresource')).key
                            local new_card = create_card("phanta_CatanResource", G.consumables, nil, nil, nil, nil, key, 'silo')
                            new_card:add_to_deck()
                            G.consumeables:emplace(new_card)
                            G.GAME.consumeable_buffer = 0
                            new_card:juice_up(0.3, 0.5)
                            return true
                        end
                    }))
                    card_eval_status_text(context.blueprint_card or card, 'extra', nil, nil, nil,
                        { message = "+1 Resource", colour = G.C.PHANTA.Resource })
                    return true
                end
            }))
        end
    end
})
