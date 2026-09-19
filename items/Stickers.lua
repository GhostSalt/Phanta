SMODS.Atlas {
    key = "PhantaStickers",
    path = "PhantaStickers.png",
    px = 71,
    py = 95,
}

G.phanta_pollutive_cost = 5

SMODS.Sticker {
    key = "pollutive",
    atlas = "PhantaStickers",
    pos = { x = 0, y = 0 },
    badge_colour = HEX "c75985",
    default_compat = true,
    needs_enable_flag = true,
    loc_vars = function(self, info_queue, card)
        return { vars = { G.phanta_pollutive_cost } }
    end,
    should_apply = function(self, card, center, area, bypass_roll)
        if card.ability and card.ability.consumeable and card.ability.set ~= "phanta_StarterPack" and G.GAME.modifiers["enable_" .. self.key] then
            self.last_roll = pseudorandom((area == G.pack_cards and "packssj" or "shopssj") .. self.key .. G.GAME.round_resets.ante)
            return bypass_roll or self.last_roll > (1 - self.rate)
        end
    end,
    draw = function(self, card, layer)
        if card.ability.set == "phanta_Hanafuda" then
            G.shared_stickers[self.key]:set_sprite_pos { x = 4, y = 2 }
        elseif card.ability.set == "phanta_Zodiac" then
            G.shared_stickers[self.key]:set_sprite_pos { x = 3, y = 2 }
        elseif card.ability.consumeable then
            G.shared_stickers[self.key]:set_sprite_pos { x = 0, y = 0 }
        else
            G.shared_stickers[self.key]:set_sprite_pos { x = 3, y = 2 }
        end
        G.shared_stickers[self.key].role.draw_major = card
        G.shared_stickers[self.key]:draw_shader("dissolve", nil, nil, nil, card.children.center)
        G.shared_stickers[self.key]:draw_shader("voucher", nil, card.ARGS.send_to_shader, nil, card.children.center)
    end,
    apply = function(self, card, val)
        SMODS.Sticker.apply(self, card, val)
        card.ability.extra_value = -card.sell_cost - G.phanta_pollutive_cost
        card:set_cost()
    end
}

SMODS.Sticker {
    key = "bestbefore",
    atlas = "PhantaStickers",
    pos = { x = 4, y = 1 },
    badge_colour = HEX "4f5da1",
    default_compat = true,
    needs_enable_flag = true,
    rate = 0.5,
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = G.P_CENTERS.c_phanta_sludge
        return { vars = { 2, card.ability.phanta_bestbefore_timer } }
    end,
    should_apply = function(self, card, center, area, bypass_roll)
        if card.ability and card.ability.consumeable and card.ability.set ~= "phanta_StarterPack" and G.GAME.modifiers["enable_" .. self.key] then
            self.last_roll = pseudorandom((area == G.pack_cards and "packssj" or "shopssj") .. self.key .. G.GAME.round_resets.ante)
            return bypass_roll or self.last_roll > (1 - self.rate)
        end
    end,
    draw = function(self, card, layer)
        if card.ability.set == "phanta_Hanafuda" then
            G.shared_stickers[self.key]:set_sprite_pos { x = 1, y = 2 }
        elseif card.ability.set == "phanta_Zodiac" then
            G.shared_stickers[self.key]:set_sprite_pos { x = 4, y = 1 }
        elseif card.ability.consumeable then
            G.shared_stickers[self.key]:set_sprite_pos { x = 0, y = 2 }
        else
            G.shared_stickers[self.key]:set_sprite_pos { x = 4, y = 1 }
        end
        G.shared_stickers[self.key].role.draw_major = card
        G.shared_stickers[self.key]:draw_shader("dissolve", nil, nil, nil, card.children.center)
        G.shared_stickers[self.key]:draw_shader("voucher", nil, card.ARGS.send_to_shader, nil, card.children.center)
    end,
    apply = function(self, card, val)
        SMODS.Sticker.apply(self, card, val)
        card.ability.phanta_bestbefore_timer = 2
    end,
    calculate = function(self, card, context)
        if context.end_of_round and context.main_eval and not context.game_over then
            card.ability.phanta_bestbefore_timer = card.ability.phanta_bestbefore_timer - 1
            if card.ability.phanta_bestbefore_timer > 0 then
                return { message = localize { type = "variable", key = "a_remaining", vars = { card.ability.phanta_bestbefore_timer } }, colour = G.C.FILTER }
            else
                G.E_MANAGER:add_event(Event({
                    trigger = "before",
                    delay = 0.4,
                    func = function()
                        card:flip()
                        play_sound("card1")
                        card:juice_up(0.3, 0.3)
                        return true
                    end
                }))
                delay(0.2)
                G.E_MANAGER:add_event(Event({
                    trigger = "before",
                    delay = 0.2,
                    func = function()
                        card:set_ability("c_phanta_sludge")
                        card:remove_sticker("phanta_pollutive")
                        card:remove_sticker("phanta_bestbefore")
                        return true
                    end
                }))
                G.E_MANAGER:add_event(Event({
                    trigger = "before",
                    delay = 0.1,
                    func = function()
                        card:flip()
                        play_sound("tarot2", 1, 0.6)
                        return true
                    end
                }))
                return { message = localize { key = "c_phanta_sludge", type = "name_text", set = "Tarot" }, colour = G.C.SECONDARY_SET.Tarot }
            end
        end
    end
}

SMODS.Sticker {
    key = "sleepy",
    config = { extra = { rounds = 2 } },
    atlas = "PhantaStickers",
    pos = { x = 2, y = 2 },
    badge_colour = HEX "c75985",
    default_compat = true,
    rate = 0.25,
    needs_enable_flag = true,
    loc_vars = function(self, info_queue, card)
        return { vars = { self.config.extra.rounds, card.ability.phanta_sleepy_tally or self.config.extra.rounds } }
    end,
    apply = function(self, card, val)
        SMODS.Sticker.apply(self, card, val)
        card.ability.phanta_sleepy_tally = self.config.extra.rounds
    end,
}
