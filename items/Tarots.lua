-- hai, Kusane! i am commenting this code to (hopefully) make ur Foolish development a bit easier

SMODS.Tarot {
  key = "philosopher",
  pos = { x = 1, y = 1 },
  config = {
    extra = { choices = 1, tarots = 3 },
  },
  atlas = "PhantaTarots",
  loc_vars = function(self, info_queue, card)
    return { vars = { card.ability.extra.choices, card.ability.extra.tarots } }
  end,
  can_use = function(self, card)
    return (G.consumeables and count_consumables() < G.consumeables.config.card_limit) or card.area == G.consumeables
  end,
  use = function(self, card, area, copier)
    delay(0.4)

    -- this runs a function down below, and the code will wait until it is done
    G.E_MANAGER:add_event(Event({
      func = function()
        G.FUNCS.phanta_run_philo_menu(card.ability.extra.tarots)
        return true
      end
    }))

    -- after the player has selected their tarot...
    G.E_MANAGER:add_event(Event({
      trigger = "after",
      delay = 0.4,
      func = function()
        -- if the menu was skipped...
        if not G.GAME.phanta_philo_cards then
          -- display "Nope!" a la Wheel of Fortune
          attention_text({
            text = localize("k_nope_ex"),
            scale = 1.3,
            hold = 1.4,
            major = card,
            backdrop_colour = G.C.SECONDARY_SET.Tarot,
            align = (G.STATE == G.STATES.TAROT_PACK or G.STATE == G.STATES.SPECTRAL_PACK or G.STATE == G.STATES.SMODS_BOOSTER_OPENED) and
                "tm" or "cm",
            offset = { x = 0, y = (G.STATE == G.STATES.TAROT_PACK or G.STATE == G.STATES.SPECTRAL_PACK or G.STATE == G.STATES.SMODS_BOOSTER_OPENED) and -0.2 or 0 },
            silent = true
          })

          -- and this part of the code plays the sound that goes with it
          G.E_MANAGER:add_event(Event({
            trigger = "after",
            delay = 0.06 * G.SETTINGS.GAMESPEED,
            blockable = false,
            blocking = false,
            func = function()
              play_sound("tarot2", 0.76, 0.4)
              delay(0.6)
              return true
            end
          }))
          play_sound("tarot2", 1, 0.4)
          card:juice_up(0.3, 0.5)
        else -- otherwise...
          -- for each chosen consumable (there may be more than one, if values have been manipulated)
          -- also count_consumables() is a function i defined in main.lua
          for i = 1, math.min(card.ability.extra.choices, G.consumeables.config.card_limit - count_consumables()) do
            -- do this, unblockably:
            G.E_MANAGER:add_event(Event({
              trigger = "after",
              delay = 0.4,
              blockable = false,
              func = function()
                -- if there is room...
                if G.consumeables.config.card_limit > #G.consumeables.cards then
                  -- bong
                  play_sound("timpani")
                  -- create the card the player asked for, with the edition it had
                  local _card = SMODS.add_card({ key = G.GAME.phanta_philo_cards[i].key, edition = G.GAME.phanta_philo_cards[i].edition })
                  -- remove any stickers it did not have
                  for k, v in pairs(SMODS.Stickers) do
                    if _card.ability[k] or _card[k] then
                      _card:remove_sticker(k)
                    end
                  end
                  -- add any stickers it had
                  for _, v in ipairs(G.GAME.phanta_philo_cards[i].stickers) do
                    _card:add_sticker(v, true)
                  end
                  card:juice_up(0.3, 0.5)
                end
                return true
              end
            }))
          end
        end
        return true
      end
    }))

    -- et voila
    delay(0.6)
  end
}

-- this is the function philo runs when used, it creates a menu
G.FUNCS.phanta_run_philo_menu = function(amount)
  -- clears user selection from previous philos
  G.GAME.phanta_philo_cards = nil
  -- a variable used to tell cards in the menu that their buttons should be different (used in Misc.lua)
  G.OVERLAY_PHANTA_PHILOCOLLECTION = true
  -- pause the action
  G.SETTINGS.paused = true
  -- create the menu
  G.FUNCS.overlay_menu {
    definition = phanta_create_philo_menu(amount)
  }
end

G.FUNCS.phanta_create_philo_cards = function(amount)
  -- this is the menu code itself
  -- initialise the card area
  G.your_collection = {}
  -- create a collection row for the cards to go into
  -- there's currently a bug where cards cannot be selected, until you deselect a currently selected card, oops
  G.your_collection[1] = CardArea(G.ROOM.T.x + 0.2 * G.ROOM.T.w / 2, G.ROOM.T.h, 3 * G.CARD_W,
    0.9 * G.CARD_H, { card_limit = 3, type = "title", highlight_limit = 1, collection = true })
  G.your_collection[1].config.phanta_cataclysm_selectable = true --Reusing this variable from Cataclysm

  -- creating, crucially not adding, the cards
  for i = 1, amount do
    local card = SMODS.create_card { set = "Tarot", key_append = "philosopher" }
    G.your_collection[1]:emplace(card)
  end
  -- idk what this does. prolly for the ! for new things
  INIT_COLLECTION_CARD_ALERTS()

  -- and then, return the ui
  local t = {
    {
      n = G.UIT.C,
      config = { align = "cm" },
      nodes = {
        {
          n = G.UIT.R,
          config = { align = "cm" },
          nodes = {
            {
              n = G.UIT.B,
              config = { w = 3, h = 0.2 },
              nodes = {}
            }
          }
        },
        {
          n = G.UIT.R,
          config = { align = "cm", r = 0.1, colour = G.C.BLACK, emboss = 0.05 },
          nodes = {
            {
              n = G.UIT.R,
              config = { align = "cm", padding = 0.07, no_fill = true },
              nodes = {
                { n = G.UIT.O, config = { object = G.your_collection[1] } }
              }
            }
          }
        }
      }
    }
  }
  return t
end

-- this function is a little silly, but it gets called by the function that philo calls. it creates the menu, basically
function phanta_create_philo_menu(amount)
  return create_UIBox_generic_options({
    infotip = localize("phanta_philo_menu_tooltip"),
    contents = G.FUNCS.phanta_create_philo_cards(amount),
    back_label = localize("b_skip"),
    back_func = "phanta_leave_philo"
  })
end

-- cards call this when selected (used in Misc.lua)
G.FUNCS.phanta_select_philo_card = function(e)
  -- the card is marked as selected
  G.GAME.phanta_philo_cards = G.GAME.phanta_philo_cards or {}
  G.GAME.phanta_philo_cards[#G.GAME.phanta_philo_cards + 1] = e.config.ref_table
  -- currently, you cannot pick more than one card, which i plan to rectify at some point
  G.FUNCS.phanta_leave_philo()
end

-- used in Misc.lua, but does nothing. this means the consumables can always be selected
G.FUNCS.phanta_can_select_philo_card = function(e) end

-- called when leaving the menu
G.FUNCS.phanta_leave_philo = function(e)
  -- we are no longer in the philo collection, so reset the thingies
  G.OVERLAY_PHANTA_PHILOCOLLECTION = nil
  if G.OVERLAY_MENU then G.FUNCS.exit_overlay_menu() end
  G.SETTINGS.paused = false
end

-- checks if the player pressed escape, and handles that
local controllerkpuref = Controller.key_press_update
function Controller:key_press_update(key, dt)
  if key == "escape" and G.SETTINGS.paused and G.OVERLAY_PHANTA_PHILOCOLLECTION then
    G.FUNCS.phanta_leave_philo()
  end
  return controllerkpuref(self, key, dt)
end

-- this one is easier to grasp lol
SMODS.Tarot {
  key = "gatherer",
  pos = { x = 0, y = 1 },
  config = {
    extra = { money = 11 },
  },
  atlas = "PhantaTarots",
  loc_vars = function(self, info_queue, card)
    return { vars = { card.ability.extra.money } }
  end,
  can_use = function(self, card)
    return true
  end,
  use = function(self, card, area, copier)
    -- gives money :)
    G.E_MANAGER:add_event(Event({
      trigger = "after",
      delay = 0.4,
      func = function()
        play_sound("timpani")
        card:juice_up(0.3, 0.5)
        ease_dollars(card.ability.extra.money, true)
        return true
      end
    }))
    delay(0.6)
  end
}

-- the next tarots are standard tarot code for enhancements
SMODS.Tarot {
  key = "grave",
  loc_txt = {
    name = "Grave",
    text = {
      "Enhances {C:attention}#1#{}",
      "selected card into a",
      "{C:attention}Ghost Card{}"
    }
  },
  pos = { x = 0, y = 0 },
  config = {
    mod_conv = "m_phanta_ghostcard",
    max_highlighted = 1
  },
  atlas = "PhantaTarots",
  loc_vars = function(self, info_queue, card)
    info_queue[#info_queue + 1] = G.P_CENTERS.m_phanta_ghostcard
    return { vars = { card.ability.max_highlighted } }
  end
}

SMODS.Tarot {
  key = "brazier",
  pos = { x = 2, y = 0 },
  config = {
    mod_conv = "m_phanta_coppergratefresh",
    max_highlighted = 1
  },
  atlas = "PhantaTarots",
  loc_vars = function(self, info_queue, card)
    info_queue[#info_queue + 1] = G.P_CENTERS.m_phanta_coppergratefresh
    return { vars = { card.ability.max_highlighted } }
  end
}

SMODS.Tarot {
  key = "sculptor",
  pos = { x = 3, y = 0 },
  config = {
    mod_conv = "m_phanta_marblecard",
    max_highlighted = 1
  },
  atlas = "PhantaTarots",
  loc_vars = function(self, info_queue, card)
    info_queue[#info_queue + 1] = G.P_CENTERS.m_phanta_marblecard
    return { vars = { card.ability.max_highlighted } }
  end
}

-- this does the same thing as the above, just with an edition instead. this is what the game does for those tarots
SMODS.Tarot {
  key = "beekeeper",
  pos = { x = 1, y = 0 },
  config = {
    extra = { conv = "e_phanta_waxed" },
    max_highlighted = 2
  },
  atlas = "PhantaTarots",
  loc_vars = function(self, info_queue, card)
    info_queue[#info_queue + 1] = G.P_CENTERS.e_phanta_waxed
    return { vars = { card.ability.max_highlighted } }
  end,
  use = function(self, card, area, copier)
    G.E_MANAGER:add_event(Event({
      trigger = "after",
      delay = 0.4,
      func = function()
        play_sound("tarot1")
        card:juice_up(0.3, 0.5)
        return true
      end
    }))
    for i = 1, #G.hand.highlighted do
      local percent = 1.15 - (i - 0.999) / (#G.hand.highlighted - 0.998) * 0.3
      G.E_MANAGER:add_event(Event({
        trigger = "after",
        delay = 0.15,
        func = function()
          G.hand.highlighted[i]:flip()
          play_sound("card1", percent)
          G.hand.highlighted[i]:juice_up(0.3, 0.3)
          return true
        end
      }))
    end
    delay(0.2)
    for i = 1, #G.hand.highlighted do
      G.E_MANAGER:add_event(Event({
        trigger = "after",
        delay = 0.1,
        func = function()
          G.hand.highlighted[i]:set_edition(card.ability.extra.conv, true, true)
          return true
        end
      }))
    end
    for i = 1, #G.hand.highlighted do
      local percent = 0.85 + (i - 0.999) / (#G.hand.highlighted - 0.998) * 0.3
      G.E_MANAGER:add_event(Event({
        trigger = "after",
        delay = 0.15,
        func = function()
          G.hand.highlighted[i]:flip()
          play_sound("tarot2", percent, 0.6)
          G.hand.highlighted[i]:juice_up(0.3, 0.3)
          return true
        end
      }))
    end
    G.E_MANAGER:add_event(Event({
      trigger = "after",
      delay = 0.2,
      func = function()
        G.hand:unhighlight_all()
        return true
      end
    }))
    delay(0.5)
  end
}

SMODS.Tarot {
  key = "exorcist",
  pos = { x = 3, y = 1 },
  config = {
    extra = { highlight = 1, destroy = 3 },
  },
  atlas = "PhantaTarots",
  loc_vars = function(self, info_queue, card)
    return { vars = { card.ability.extra.highlight, card.ability.extra.destroy } }
  end,
  can_use = function(self, card)
    return #G.hand.cards > 0 and #G.hand.highlighted == card.ability.extra.highlight
  end,
  use = function(self, card, area, copier)
    -- create a new list of cards
    local cards = {}
    -- this for loop checks for all unselected cards
    for _, v in ipairs(G.hand.cards) do
      local fresh = true
      for __, vv in ipairs(G.hand.highlighted) do
        if vv == v then
          fresh = false; break
        end
      end
      if fresh then cards[#cards + 1] = v end
    end

    -- more tables
    local destroyed_cards = {}
    local temp_hand = {}

    -- i don't remember how this works, but immolate does it so. yay
    for _, playing_card in ipairs(cards) do temp_hand[#temp_hand + 1] = playing_card end
    table.sort(temp_hand,
      function(a, b)
        return not a.playing_card or not b.playing_card or a.playing_card < b.playing_card
      end
    )
    pseudoshuffle(temp_hand, "exorcist_cards")
    for i = 1, card.ability.extra.destroy do destroyed_cards[#destroyed_cards + 1] = temp_hand[i] end

    -- normal tarot things
    G.E_MANAGER:add_event(Event({
      trigger = "after",
      delay = 0.4,
      func = function()
        play_sound("tarot1")
        card:juice_up(0.3, 0.5)
        return true
      end
    }))
    G.E_MANAGER:add_event(Event({
      trigger = "after",
      delay = 0.2,
      func = function()
        SMODS.destroy_cards(destroyed_cards)
        return true
      end
    }))
    G.E_MANAGER:add_event(Event({
      trigger = "after",
      delay = 0.3,
      func = function()
        G.hand:unhighlight_all()
        return true
      end
    }))
  end
}

SMODS.Tarot {
  key = "angel",
  pos = { x = 2, y = 1 },
  config = {
    extra = { highlight_limit = 1, rank_increase = 1 },
  },
  atlas = "PhantaTarots",
  loc_vars = function(self, info_queue, card)
    return { vars = { card.ability.extra.highlight_limit, card.ability.extra.rank_increase } }
  end,
  can_use = function(self, card)
    return #G.hand.cards > 0 and #G.hand.highlighted <= card.ability.extra.highlight_limit
  end,
  use = function(self, card, area, copier)
    -- this is similar to exorcist, but with a strength effect instead :D
    local cards = {}
    for _, v in ipairs(G.hand.cards) do
      local fresh = true
      for __, vv in ipairs(G.hand.highlighted) do
        if vv == v then
          fresh = false; break
        end
      end
      if fresh then cards[#cards + 1] = v end
    end
    G.E_MANAGER:add_event(Event({
      trigger = "after",
      delay = 0.4,
      func = function()
        play_sound("tarot1")
        card:juice_up(0.3, 0.5)
        return true
      end
    }))
    for i = 1, #cards do
      local percent = 1.15 - (i - 0.999) / (#cards - 0.998) * 0.3
      G.E_MANAGER:add_event(Event({
        trigger = "after",
        delay = 0.15,
        func = function()
          cards[i]:flip()
          play_sound("card1", percent)
          cards[i]:juice_up(0.3, 0.3)
          return true
        end
      }))
    end
    delay(0.2)
    for i = 1, #cards do
      G.E_MANAGER:add_event(Event({
        func = function()
          assert(SMODS.modify_rank(cards[i], card.ability.extra.rank_increase))
          return true
        end
      }))
    end
    for i = 1, #cards do
      local percent = 0.85 + (i - 0.999) / (#cards - 0.998) * 0.3
      G.E_MANAGER:add_event(Event({
        trigger = "after",
        delay = 0.15,
        func = function()
          cards[i]:flip()
          play_sound("tarot2", percent, 0.6)
          cards[i]:juice_up(0.3, 0.3)
          return true
        end
      }))
    end
    G.E_MANAGER:add_event(Event({
      trigger = "after",
      delay = 0.2,
      func = function()
        G.hand:unhighlight_all()
        return true
      end
    }))
    delay(0.5)
  end
}

SMODS.Tarot {
  key = "sludge",
  pos = { x = 0, y = 2 },
  config = {
    extra = { cards = 1 },
  },
  atlas = "PhantaTarots",
  loc_vars = function(self, info_queue, card)
    info_queue[#info_queue + 1] = { key = "debuffed_default", set = "Other", vars = {} }
    return { vars = { card.ability.extra.cards } }
  end,
  use = function(self, card, area, copier)
    -- sludge ^w^
    -- immolate things again
    local destroyed_cards = {}
    local temp_hand = {}

    for _, playing_card in ipairs(G.hand.cards) do temp_hand[#temp_hand + 1] = playing_card end
    table.sort(temp_hand,
      function(a, b)
        return not a.playing_card or not b.playing_card or a.playing_card < b.playing_card
      end
    )
    pseudoshuffle(temp_hand, "sludge_cards")
    for i = 1, card.ability.extra.cards do destroyed_cards[#destroyed_cards + 1] = temp_hand[i] end

    G.E_MANAGER:add_event(Event({
      trigger = "after",
      delay = 0.4,
      func = function()
        play_sound("tarot1")
        card:juice_up(0.3, 0.5)
        return true
      end
    }))
    G.E_MANAGER:add_event(Event({
      trigger = "after",
      delay = 0.5,
      func = function()
        SMODS.destroy_cards(destroyed_cards)
        return true
      end
    }))
    G.E_MANAGER:add_event(Event({
      trigger = "after",
      delay = 0.2,
      func = function()
        play_sound("timpani")
        card:juice_up(0.3, 0.5)
        -- for each card we destroyed...
        for i = 1, card.ability.extra.cards do
          -- create a new one and add it
          local _card = SMODS.add_card { set = "Base", key_append = "sludge_debuffed" }
          -- debuff it if needed (which, like. i am doing after it so. heh. my jarona)
          G.GAME.blind:debuff_card(_card)
          -- debuff it forever and ever
          SMODS.debuff_card(_card, true, "phanta_sludge")
          -- resort the hand
          G.hand:sort()
          -- and tell everything that this happened
          SMODS.calculate_context({ playing_card_added = true, cards = { _card } })
        end
        return true
      end
    }))
    G.E_MANAGER:add_event(Event({
      trigger = "after",
      delay = 0.3,
      func = function()
        G.hand:unhighlight_all()
        return true
      end
    }))
  end,
  can_use = function(self, card)
    return #G.hand.cards > 0
  end,
  in_pool = function()
    return false
  end
}
