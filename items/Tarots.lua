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
    G.E_MANAGER:add_event(Event({
      func = function()
        G.FUNCS.phanta_run_philo_menu(card.ability.extra.tarots)
        return true
      end
    }))
    G.E_MANAGER:add_event(Event({
      trigger = "after",
      delay = 0.4,
      func = function()
        if not G.GAME.phanta_philo_cards then
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
        else
          for i = 1, math.min(card.ability.extra.choices, G.consumeables.config.card_limit - count_consumables()) do
            G.E_MANAGER:add_event(Event({
              trigger = "after",
              delay = 0.4,
              blockable = false,
              func = function()
                if G.consumeables.config.card_limit > #G.consumeables.cards then
                  play_sound("timpani")
                  SMODS.add_card({ key = G.GAME.phanta_philo_cards[i] })
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
    delay(0.6)
  end
}

G.FUNCS.phanta_run_philo_menu = function(amount)
  G.GAME.phanta_philo_cards = nil
  G.OVERLAY_PHANTA_PHILOCOLLECTION = true
  G.SETTINGS.paused = true
  G.FUNCS.overlay_menu {
    definition = phanta_create_philo_menu(amount)
  }
end

G.FUNCS.phanta_create_philo_cards = function(amount)
  local deck_tables = {}
  G.your_collection = {}
  G.your_collection[1] = CardArea(G.ROOM.T.x + 0.2 * G.ROOM.T.w / 2, G.ROOM.T.h, 3 * G.CARD_W,
    0.9 * G.CARD_H, { card_limit = 3, type = "title", highlight_limit = 1, collection = true })
  table.insert(deck_tables,
    {
      n = G.UIT.R,
      config = { align = "cm", padding = 0.07, no_fill = true },
      nodes = {
        { n = G.UIT.O, config = { object = G.your_collection[1] } }
      }
    }
  )
  G.your_collection[1].config.phanta_cataclysm_selectable = true --Reusing this variable from Cataclysm

  for i = 1, amount do
    local card = SMODS.create_card { set = "Tarot", key_append = "philosopher" }
    G.your_collection[1]:emplace(card)
  end
  INIT_COLLECTION_CARD_ALERTS()

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
        { n = G.UIT.R, config = { align = "cm", r = 0.1, colour = G.C.BLACK, emboss = 0.05 }, nodes = deck_tables }
      }
    }
  }
  return t
end

function phanta_create_philo_menu(amount)
  return create_UIBox_generic_options({
    infotip = localize("phanta_philo_menu_tooltip"),
    contents = G.FUNCS.phanta_create_philo_cards(amount),
    back_label = localize("b_skip"),
    back_func = "phanta_leave_philo"
  })
end

G.FUNCS.phanta_select_philo_card = function(e)
  G.GAME.phanta_philo_cards = G.GAME.phanta_philo_cards or {}
  G.GAME.phanta_philo_cards[#G.GAME.phanta_philo_cards + 1] = e.config.ref_table
  G.FUNCS.phanta_leave_philo()
end

G.FUNCS.phanta_can_select_philo_card = function(e) end

G.FUNCS.phanta_leave_philo = function(e)
  G.OVERLAY_PHANTA_PHILOCOLLECTION = nil
  if G.OVERLAY_MENU then G.FUNCS.exit_overlay_menu() end
  G.SETTINGS.paused = false
end

local controllerkpuref = Controller.key_press_update
function Controller:key_press_update(key, dt)
  if key == "escape" and G.SETTINGS.paused and G.OVERLAY_PHANTA_PHILOCOLLECTION then
    G.FUNCS.phanta_leave_philo()
  end
  return controllerkpuref(self, key, dt)
end

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
    return #G.hand.highlighted <= card.ability.extra.highlight_limit
  end,
  use = function(self, card, area, copier)
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
        trigger = "after",
        delay = 0.1,
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
