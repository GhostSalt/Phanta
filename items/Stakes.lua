SMODS.Atlas {
    key = "PhantaStakes",
    path = "PhantaStakes.png",
    px = 29,
    py = 29,
}

SMODS.Stake {
    key = "white",
    applied_stakes = {},
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

SMODS.Stake {
    key = "black",
    applied_stakes = { "green" },
    above_stake = 'green',
    atlas = "PhantaStakes",
    pos = { x = 4, y = 0 },
    sticker_atlas = "PhantaStickers",
    sticker_pos = { x = 0, y = 1 },
    modifiers = function()
        G.GAME.modifiers.enable_phanta_pollutive = true
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
        G.GAME.modifiers.enable_phanta_bestbefore = true
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

local smods_context_ref = SMODS.calculate_context
function SMODS.calculate_context(context, return_table, no_resolve)
    local ret = smods_context_ref(context, return_table, no_resolve)
    if context.check_eternal and G.GAME.modifiers.enable_eternal_consumables and context.other_card.ability and context.other_card.ability.eternal then
        ret = ret or {}
        ret["phanta_black_stake"] = { phanta_black_stake_eternal = { no_destroy = { override_compat = true } } }
        (return_table or {})["phanta_black_stake"] = ret["phanta_black_stake"]
    end
    return return_table or ret
end