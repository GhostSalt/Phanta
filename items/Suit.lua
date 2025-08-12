SMODS.Atlas {
    key = "PhantaSuits",
    path = "PhantaSuits.png",
    px = 71,
    py = 95
}

SMODS.Atlas {
    key = "PhantaSuitUI",
    path = "PhantaSuitUI.png",
    px = 18,
    py = 18
}

SMODS.Suit {
    key = "unknown",
    card_key = "UNKNOWN",
    lc_atlas = "PhantaSuits",
    hc_atlas = "PhantaSuits",
    lc_ui_atlas = "PhantaSuitUI",
    hc_ui_atlas = "PhantaSuitUI",
    lc_colour = HEX("818181"),
    hc_colour = HEX("818181"),
    pos = { y = 0 },
    ui_pos = { x = 0, y = 0 },
    in_pool = function (self, args)
        return false
    end
}