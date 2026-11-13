SMODS.Rarity {
  key = "awful",
  badge_colour = HEX "444444",
  disable_if_empty = true
}

G.Phanta.centers["developerdifficulty"] = {
  config = { extra_slots_used = -1, couponed = true, extra = { lost_money = 3, lost_hands = 1, xmult = 0.666, lost_boosters = 1 }, immutable = { seen_ante = 0, last_seen_ante = 0 } },
  loc_vars = function(self, info_queue, card)
    local key = self.key
    if card.ability.immutable.seen_ante >= 2 then key = key .. "_" .. card.ability.immutable.seen_ante end
    return { key = key, vars = { card.ability.extra.lost_money, card.ability.extra.lost_hands, card.ability.extra.xmult == 0.666 and card.ability.extra.xmult .. "" or card.ability.extra.xmult, card.ability.extra.lost_boosters } }
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

    if context.first_hand_drawn and card.ability.immutable.seen_ante >= 8 then
      SMODS.destroy_cards(context.hand_drawn)
      G.E_MANAGER:add_event(Event({
        func = function()
          card:juice_up()
          return true
        end
      }))
    end

    if context.end_of_round and not context.individual and not context.repetition then
      if card.ability.immutable.seen_ante >= 2 then
        return { dollars = -card.ability.extra.lost_money }
      end
    end

    if context.ante_change and not context.blueprint then
      if card.ability.immutable.seen_ante < G.GAME.round_resets.ante + context.ante_change then
        card.ability.immutable.seen_ante = G.GAME.round_resets.ante + context.ante_change
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
  add_to_deck = function(self, card, from_debuff)
    if not from_debuff then card.greyed = nil end
  end,
  set_ability = function(self, card, initial, delay_sprites)
    SMODS.debuff_card(card, "prevent_debuff", "phanta_developerdifficulty")
  end,
  pronouns = "she_her"
}

local card_click = Card.click
function Card:click()
  if self.config.center.key == "j_phanta_developerdifficulty" and self.area and self.area == G.jokers then
    return
  end
  return card_click(self)
end

local smods_eternal_ref = SMODS.is_eternal
function SMODS.is_eternal(card, trigger)
  if card and card.config and card.config.center.key == "j_phanta_developerdifficulty" then return true end
  return smods_eternal_ref(card, trigger)
end

local context_ref = SMODS.calculate_context
function SMODS.calculate_context(context, return_table)
  if context and context.starting_shop and G.GAME.modifiers.phanta_devdifficulty_available and G.shop_vouchers then
    G.GAME.modifiers.phanta_devdifficulty_available = nil

    G.shop_vouchers.config.card_limit = G.shop_vouchers.config.card_limit + 1
    local card = Card(G.shop_vouchers.T.x + G.shop_vouchers.T.w / 2, G.shop_vouchers.T.y, G.CARD_W, G.CARD_H,
      G.P_CARDS.empty,
      G.P_CENTERS.j_phanta_developerdifficulty, { bypass_discovery_center = true, bypass_discovery_ui = true })
    card:remove_sticker("phanta_sleepy")
    card.greyed = true
    create_shop_card_ui(card)
    card:start_materialize()
    G.shop_vouchers:emplace(card)
  end
  return context_ref(context, return_table)
end

G.phanta_dev_diff_dialogue_count = 16

G.FUNCS.phanta_can_leave_win_screen_new_run = function(e)
  if next(SMODS.find_card("j_phanta_developerdifficulty")) and G.phanta_dev_diff_dialogue_ix and G.phanta_dev_diff_dialogue_ix < G.phanta_dev_diff_dialogue_count and not G.PROFILES[G.SETTINGS.profile].phanta_seen_vent_dialogue then
    e.config.colour = G.C.UI.BACKGROUND_INACTIVE
    e.config.button = nil
  else
    e.config.colour = G.C.RED
    e.config.button = "notify_then_setup_run"
  end
end

G.FUNCS.phanta_can_leave_win_screen_main_menu = function(e)
  if next(SMODS.find_card("j_phanta_developerdifficulty")) and G.phanta_dev_diff_dialogue_ix and G.phanta_dev_diff_dialogue_ix < G.phanta_dev_diff_dialogue_count and not G.PROFILES[G.SETTINGS.profile].phanta_seen_vent_dialogue then
    e.config.colour = G.C.UI.BACKGROUND_INACTIVE
    e.config.button = nil
  else
    e.config.colour = G.C.RED
    e.config.button = "go_to_menu"
  end
end

G.FUNCS.phanta_can_leave_win_screen_exit_overlay = function(e)
  if next(SMODS.find_card("j_phanta_developerdifficulty")) and G.phanta_dev_diff_dialogue_ix and G.phanta_dev_diff_dialogue_ix < G.phanta_dev_diff_dialogue_count and not G.PROFILES[G.SETTINGS.profile].phanta_seen_vent_dialogue then
    e.config.colour = G.C.UI.BACKGROUND_INACTIVE
    e.config.button = nil
  else
    e.config.colour = G.C.BLUE
    e.config.button = "exit_overlay_menu"
  end
end

for i = 1, G.phanta_dev_diff_dialogue_count do
  SMODS.JimboQuip {
    key = "phanta_win_developerdifficulty_" .. i,
    type = "win",
    extra = {
      center = "j_phanta_developerdifficulty",
      filter = function(self, type) return false end,
      particle_colours = {
        HEX "444444",
        HEX "666666",
        HEX "888888",
      }
    }
  }
end

function phanta_dev_diff_jimbo()
  if G.phanta_dev_diff_me_jimbo then
    G.phanta_dev_diff_me_jimbo:remove(); G.phanta_dev_diff_me_jimbo = nil
  end
  G.phanta_dev_diff_dialogue_ix = 1
  G.ACC = 0
  G.E_MANAGER:add_event(Event({
    trigger = "after",
    delay = 2.5,
    blocking = "false",
    func = function()
      local extra = SMODS.JimboQuips["phanta_win_developerdifficulty_1"].extra
      G.phanta_dev_diff_me_jimbo = Card_Character(extra); G.phanta_dev_diff_me_jimbo.children.card.states.focus.can = true
      local spot = G.OVERLAY_MENU:get_UIE_by_ID("jimbo_spot")
      spot.config.object:remove()
      spot.config.object = G.phanta_dev_diff_me_jimbo
      G.phanta_dev_diff_me_jimbo.ui_object_updated = true
      phanta_dev_diff_jimbo_talk()
      return true
    end
  }))
end

function phanta_dev_diff_jimbo_talk()
  if G.OVERLAY_MENU and G.OVERLAY_MENU:get_UIE_by_ID("jimbo_spot") then
    local extra = SMODS.JimboQuips["phanta_win_developerdifficulty_" .. G.phanta_dev_diff_dialogue_ix].extra
    extra.x = 0
    extra.y = 5
    G.phanta_dev_diff_me_jimbo:add_speech_bubble("phanta_win_developerdifficulty_" .. G.phanta_dev_diff_dialogue_ix, "tm",
      extra)
    G.phanta_dev_diff_me_jimbo:say_stuff((extra and extra.times) or 5, false,
      "phanta_win_developerdifficulty_" .. G.phanta_dev_diff_dialogue_ix)
    if G.phanta_dev_diff_dialogue_ix < G.phanta_dev_diff_dialogue_count then
      G.phanta_dev_diff_me_jimbo:add_button(localize("b_next"), "phanta_advance_dev_diff_jimbo", G.C.RED, nil, true)
    else
      G.phanta_dev_diff_dialogue_ix = nil
    end
  end
end

function G.FUNCS.phanta_advance_dev_diff_jimbo(e)
  G.phanta_dev_diff_dialogue_ix = G.phanta_dev_diff_dialogue_ix + 1
  G.phanta_dev_diff_me_jimbo:remove_button()
  if G.phanta_dev_diff_dialogue_ix >= G.phanta_dev_diff_dialogue_count then
    if not G.PROFILES[G.SETTINGS.profile].phanta_seen_vent_dialogue then G.PROFILES[G.SETTINGS.profile].phanta_seen_vent_dialogue = true end
  end
  G:save_settings()
  phanta_dev_diff_jimbo_talk()
end