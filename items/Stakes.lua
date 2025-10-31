SMODS.Atlas {
    key = "PhantaStakes",
    path = "PhantaStakes.png",
    px = 29,
    py = 29,
}

SMODS.Stake {
    key = "white",
    applied_stakes = {},
    above_stake = 'gold',
    prefix_config = { above_stake = { false } },
    atlas = "PhantaStakes",
    pos = { x = 0, y = 0 },
    sticker_atlas = "PhantaStickers",
    sticker_pos = { x = 1, y = 0 },
    modifiers = function()
        G.GAME.modifiers.modded_only = true
    end,
    colour = G.C.WHITE
}

SMODS.Stake {
    key = "red",
    applied_stakes = { "white" },
    above_stake = 'white',
    atlas = "PhantaStakes",
    pos = { x = 1, y = 0 },
    sticker_atlas = "PhantaStickers",
    sticker_pos = { x = 2, y = 0 },
    modifiers = function()
        G.GAME.modifiers.small_blind_reward = true
    end,
    colour = G.C.RED
}

SMODS.Stake {
    key = "green",
    applied_stakes = { "red" },
    above_stake = 'red',
    atlas = "PhantaStakes",
    pos = { x = 2, y = 0 },
    sticker_atlas = "PhantaStickers",
    sticker_pos = { x = 3, y = 0 },
    modifiers = function()
        G.GAME.modifiers.scaling = (G.GAME.modifiers.scaling or 1) + 1
    end,
    colour = G.C.GREEN
}

local main_menu_ref = Game.main_menu
function Game:main_menu(change_context)
    G.shared_sticker_consumable_eternal = Sprite(0, 0, G.CARD_W, G.CARD_H, G.ASSET_ATLAS["phanta_PhantaStickers"],
        { x = 0, y = 0 })
    G.shared_sticker_consumable_perishable = Sprite(0, 0, G.CARD_W, G.CARD_H, G.ASSET_ATLAS["phanta_PhantaStickers"],
        { x = 0, y = 2 })
    G.shared_sticker_consumable_rental = Sprite(0, 0, G.CARD_W, G.CARD_H, G.ASSET_ATLAS["phanta_PhantaStickers"],
        { x = 1, y = 2 })

    main_menu_ref(self, change_context)
end

local smods_sticker_drawstep_ref = SMODS.DrawSteps.stickers.func
SMODS.DrawSteps.stickers.func = function(self, layer)
    if self.ability.consumeable and self.config.center.set ~= "phanta_Zodiac" then
        if self.ability.eternal then
            G.shared_sticker_consumable_eternal.role.draw_major = self
            G.shared_sticker_consumable_eternal:draw_shader('dissolve', nil, nil, nil, self.children.center)
            G.shared_sticker_consumable_eternal:draw_shader('voucher', nil, self.ARGS.send_to_shader, nil,
                self.children.center)
            return
        elseif self.ability.perishable then
            G.shared_sticker_consumable_perishable.role.draw_major = self
            G.shared_sticker_consumable_perishable:draw_shader('dissolve', nil, nil, nil, self.children.center)
            G.shared_sticker_consumable_perishable:draw_shader('voucher', nil, self.ARGS.send_to_shader, nil,
                self.children.center)
            return
        elseif self.ability.rental then
            G.shared_sticker_consumable_rental.role.draw_major = self
            G.shared_sticker_consumable_rental:draw_shader('dissolve', nil, nil, nil, self.children.center)
            G.shared_sticker_consumable_rental:draw_shader('voucher', nil, self.ARGS.send_to_shader, nil,
                self.children.center)
            return
        end
    end
    smods_sticker_drawstep_ref(self, layer)
end

SMODS.Stake {
    key = "black",
    applied_stakes = { "green" },
    above_stake = 'green',
    atlas = "PhantaStakes",
    pos = { x = 4, y = 0 },
    sticker_atlas = "PhantaStickers",
    sticker_pos = { x = 0, y = 1 },
    modifiers = function()
        G.GAME.modifiers.enable_eternal_consumables = true
    end,
    colour = G.C.BLACK
}

SMODS.Stake {
    key = "blue",
    applied_stakes = { "black" },
    above_stake = 'black',
    atlas = "PhantaStakes",
    pos = { x = 3, y = 0 },
    sticker_atlas = "PhantaStickers",
    sticker_pos = { x = 4, y = 0 },
    modifiers = function()
        G.GAME.modifiers.enable_perishable_consumables = true
    end,
    colour = G.C.BLUE
}

SMODS.Stake {
    key = "purple",
    applied_stakes = { "blue" },
    above_stake = 'blue',
    atlas = "PhantaStakes",
    pos = { x = 0, y = 1 },
    sticker_atlas = "PhantaStickers",
    sticker_pos = { x = 1, y = 1 },
    modifiers = function()
        G.GAME.modifiers.scaling = (G.GAME.modifiers.scaling or 1) + 1
    end,
    colour = G.C.PURPLE
}

SMODS.Stake {
    key = "orange",
    applied_stakes = { "purple" },
    above_stake = 'purple',
    atlas = "PhantaStakes",
    pos = { x = 1, y = 1 },
    sticker_atlas = "PhantaStickers",
    sticker_pos = { x = 2, y = 1 },
    modifiers = function()
        G.GAME.modifiers.enable_phanta_sleepy = true
    end,
    colour = G.C.ORANGE
}

SMODS.Stake {
    key = "gold",
    applied_stakes = { "orange" },
    above_stake = 'orange',
    atlas = "PhantaStakes",
    pos = { x = 2, y = 1 },
    sticker_atlas = "PhantaStickers",
    sticker_pos = { x = 3, y = 1 },
    modifiers = function()
        G.GAME.modifiers.fewer_shop_slots_pre_reroll = 1
    end,
    colour = G.C.GOLD,
    shiny = true,
}

local create_card_ref = create_card
function create_card(_type, area, legendary, _rarity, skip_materialize, soulable, forced_key, key_append)
    local card = create_card_ref(_type, area, legendary, _rarity, skip_materialize, soulable, forced_key, key_append)
    local eternal_perishable_poll = pseudorandom((area == G.pack_cards and 'packetper' or 'etperpoll') ..
        G.GAME.round_resets.ante)
    if card.ability and card.ability.consumeable and card.config.center.set ~= "phanta_StarterPack" and G.GAME.modifiers.enable_eternal_consumables and eternal_perishable_poll > 0.65 then
        card:set_eternal(true)
    elseif card.ability and card.ability.consumeable and card.config.center.set ~= "phanta_StarterPack" and G.GAME.modifiers.enable_perishable_consumables and eternal_perishable_poll > 0.3 then
        card:set_perishable(true)
    end
    if card.ability and card.ability.consumeable and card.config.center.set ~= "phanta_StarterPack" and G.GAME.modifiers.enable_rental_consumables and pseudorandom((area == G.pack_cards and 'packssjr' or 'ssjr') .. G.GAME.round_resets.ante) > 0.7 then
        card:set_rental(true)
    end
    return card
end

local smods_context_ref = SMODS.calculate_context
function SMODS.calculate_context(context, return_table, no_resolve)
    local ret = smods_context_ref(context, return_table, no_resolve)
    if context.check_eternal and G.GAME.modifiers.enable_eternal_consumables and context.other_card.ability and context.other_card.ability.eternal then
        if not ret then ret = {} end
        ret["phanta_black_stake"] = { phanta_black_stake_eternal = { no_destroy = { override_compat = true } } }
        if return_table then return_table["phanta_black_stake"] = ret["phanta_black_stake"] end
    end
    if not return_table then return ret end
end

local set_perishable_ref = Card.set_perishable
function Card:set_perishable(_perishable) 
    set_perishable_ref(self, _perishable)
    if G.GAME.modifiers.enable_perishable_consumables and self.ability.perishable and self.ability.consumeable then 
        self.ability.perish_tally = 2
    end
end