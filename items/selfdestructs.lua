SMODS.Rarity {
  key = "awful",
  badge_colour = HEX "444444",
  disable_if_empty = true
}

G.Phanta.centers["developerdifficulty"] = {
  config = { extra_slots_used = -1, extra = { lost_money = 3, lost_hands = 1, xmult = 0.666, lost_boosters = 1 }, immutable = { seen_ante = 0, last_seen_ante = 0 } },
  loc_vars = function(self, info_queue, card)
    local key = self.key
    if card.ability.immutable.seen_ante >= 2 then key = key .. "_" .. card.ability.immutable.seen_ante end
    return { key = key, vars = { card.ability.extra.lost_money, card.ability.extra.lost_hands, card.ability.extra.xmult, card.ability.extra.lost_boosters } }
  end,
  in_pool = function() return false end,
  no_collection = true,
  rarity = "phanta_awful",
  atlas = "Phanta2",
  pos = { x = 11, y = 11 },
  cost = 0,
  blueprint_compat = false,
  eternal_compat = false,
  perishable_compat = false,
  calculate = function(self, card, context)
    if context.joker_main and card.ability.immutable.seen_ante >= 6 then
      return { xmult = card.ability.extra.xmult }
    end

    if context.end_of_round and not context.individual and not context.repetition then
      if card.ability.immutable.seen_ante >= 2 then
        return { dollars = -card.ability.extra.lost_money }
      end
    end

    if context.ante_change and not context.blueprint then
      if card.ability.immutable.seen_ante < G.GAME.round_resets.ante + context.ante_change then
        card.ability.immutable.seen_ante = math.min(G.GAME.round_resets.ante + context.ante_change, 8)
        if card.ability.immutable.seen_ante >= 3 and card.ability.immutable.last_seen_ante < 3 then
          G.GAME.modifiers.all_phanta_pollutive = true
          G.E_MANAGER:add_event(Event({
            func = function()
              for _, v in ipairs(G.consumeables.cards) do
                if not v.ability.phanta_pollutive then
                  v:juice_up()
                  v:add_sticker("phanta_pollutive", true)
                end
              end
              return true
            end
          }))
        end
        if card.ability.immutable.seen_ante >= 4 and card.ability.immutable.last_seen_ante < 4 then
          G.GAME.modifiers.all_phanta_bestbefore = true
          G.E_MANAGER:add_event(Event({
            func = function()
              for _, v in ipairs(G.consumeables.cards) do
                if not v.ability.phanta_bestbefore then
                  v:juice_up()
                  v:add_sticker("phanta_bestbefore", true)
                end
              end
              return true
            end
          }))
        end
        if card.ability.immutable.seen_ante >= 5 and card.ability.immutable.last_seen_ante < 5 then
          G.GAME.round_resets.hands = G.GAME.round_resets.hands - card.ability.extra.lost_hands
          ease_hands_played(-card.ability.extra.lost_hands)
        end
        if card.ability.immutable.seen_ante >= 7 and card.ability.immutable.last_seen_ante < 7 then
          SMODS.change_booster_limit(-card.ability.extra.lost_boosters)
        end

        card.ability.immutable.last_seen_ante = card.ability.immutable.seen_ante
        return { message = localize("k_phanta_new_effect"), colour = G.C.RED }
      end
    end
  end,
  set_ability = function(self, card, initial, delay_sprites)
    SMODS.debuff_card(card, "prevent_debuff", "phanta_developerdifficulty")
  end,
  pronouns = "she_her"
}

local card_click = Card.click
function Card:click()
  if self.config.center.key ~= "j_phanta_developerdifficulty" then return card_click(self) end
end

local smods_eternal_ref = SMODS.is_eternal
function SMODS.is_eternal(card, trigger)
  if card.config.center.key ~= "j_phanta_developerdifficulty" then return smods_eternal_ref(card, trigger) end
  return true
end
