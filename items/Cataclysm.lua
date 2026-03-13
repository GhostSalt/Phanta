G.FUNCS.run_cataclysm_menu = function(e)
  G.SETTINGS.paused = true
  G.GAME.phanta_current_cataclysm_card = e.config.ref_table
  G.GAME.phanta_current_cataclysm_card.ability = G.GAME.phanta_current_cataclysm_card.ability or {}
  G.GAME.phanta_current_cataclysm_card.ability.extra = G.GAME.phanta_current_cataclysm_card.ability.extra or {}
  G.FUNCS.overlay_menu {
    definition = create_cataclysm_more_menu(1)
  }
end

G.FUNCS.phanta_can_cataclysm_more = function(e)

end

function create_cataclysm_more_menu(page)
  local t = create_UIBox_generic_options({
    infotip = localize("phanta_cataclysm_more_tooltip"),
    back_func = "phanta_leave_cataclysm",
    contents = {
      {
        n = G.UIT.R,
        config = { align = "cm", padding = 0 },
        nodes = {
          create_tabs({
            tabs = {
              {
                label = localize("k_phanta_cataclysm_tab1"),
                chosen = not page or page == 1,
                tab_definition_function = G.UIDEF.phanta_cataclysm_tab1
              },
              {
                label = localize("k_phanta_cataclysm_tab2"),
                chosen = page == 2,
                tab_definition_function = G.UIDEF.phanta_cataclysm_tab2
              }
            },
            snap_to_nav = true,
            no_shoulders = true
          })
        }
      }
    }
  })
  return t
end

G.UIDEF.phanta_cataclysm_tab1 = function()
  G.OVERLAY_PHANTA_CATACLYSMCOLLECTION = 1
  local t = G.FUNCS.phanta_create_cataclysm_your_collection(1)
  return {
    n = G.UIT.ROOT,
    config = { align = "cm", padding = 0, colour = G.C.CLEAR, r = 0.1, minw = 7, minh = 4.2 },
    nodes = { {
      n = G.UIT.R,
      config = { align = "cm" },
      nodes = t
    } }
  }
end

G.UIDEF.phanta_cataclysm_tab2 = function()
  G.OVERLAY_PHANTA_CATACLYSMCOLLECTION = 2
  local t = G.FUNCS.phanta_create_cataclysm_your_collection(2)
  return {
    n = G.UIT.ROOT,
    config = { align = "cm", padding = 0, colour = G.C.CLEAR, r = 0.1, minw = 7, minh = 4.2 },
    nodes = { {
      n = G.UIT.R,
      config = { align = "cm" },
      nodes = t
    } }
  }
end




G.FUNCS.phanta_create_cataclysm_your_collection = function(page)
  local deck_tables = {}
  G.your_collection = {}
  for j = 1, 2 do
    G.your_collection[j] = CardArea(
      G.ROOM.T.x + 0.2 * G.ROOM.T.w / 2, G.ROOM.T.h,
      6 * 0.9 * G.CARD_W,
      0.95 * 0.9 * G.CARD_H,
      { card_limit = 6, type = "title", highlight_limit = 1, collection = true })
    table.insert(deck_tables,
      {
        n = G.UIT.R,
        config = { align = "cm", padding = 0.07, no_fill = true },
        nodes = {
          { n = G.UIT.O, config = { object = G.your_collection[j] } }
        }
      }
    )
    G.your_collection[j].config.phanta_cataclysm_selectable = true
  end

  local set = "Planet"
  local consumable_options = {}
  for i = 1, math.ceil(#G.P_CENTER_POOLS[set] / (6 * #G.your_collection)) do
    table.insert(consumable_options, localize('k_page') .. ' ' .. tostring(i) .. '/' .. tostring(math.ceil(#G.P_CENTER_POOLS[set] / (6 * #G.your_collection))))
  end

  for i = 1, 6 do
    for j = 1, #G.your_collection do
      local center = G.P_CENTER_POOLS[set][i + (j - 1) * 6]
      if not center then break end
      local old_used_jokers = G.GAME.used_jokers[center.key]
      local card = Card(G.your_collection[j].T.x + G.your_collection[j].T.w / 2, G.your_collection[j].T.y, G.CARD_W * 0.9, G.CARD_H * 0.9, nil, center)
      G.your_collection[j]:emplace(card)
      G.GAME.used_jokers[center.key] = old_used_jokers
    end
  end

  INIT_COLLECTION_CARD_ALERTS()
  local current_planet = G.GAME.phanta_current_cataclysm_card and G.GAME.phanta_current_cataclysm_card.ability.extra and G.GAME.phanta_current_cataclysm_card.ability.extra["card" .. page]
  local t = {
    {
      n = G.UIT.C,
      config = { align = "cm" },
      nodes = {
        {
          n = G.UIT.R,
          config = { align = "cm", r = 0.1, colour = G.C.BLACK, emboss = 0.05, padding = 0.1 },
          nodes = {
            {
              n = G.UIT.T,
              config = { text = current_planet and localize { set = "Planet", type = "name_text", key = current_planet } or localize("phanta_cataclysm_no_planet"), colour = G.C.UI.TEXT_LIGHT, scale = 0.5, padding = 0.1 },
              nodes = {}
            },
          }
        },
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
        { n = G.UIT.R, config = { align = "cm", r = 0.1, colour = G.C.BLACK, emboss = 0.05 }, nodes = deck_tables },
        {
          n = G.UIT.R,
          config = { align = "cm" },
          nodes = {
            create_option_cycle({ options = consumable_options, w = 4.5, cycle_shoulders = true, opt_callback = "phanta_cataclysm_update_collection", current_option = 1, colour = G.C.RED, no_pips = true, focus_args = { snap_to = true, nav = 'wide' } })
          }
        }
      }
    }
  }
  return t
end

G.FUNCS.phanta_leave_cataclysm = function(e)
  G.OVERLAY_PHANTA_CATACLYSMCOLLECTION = nil

  if G.OVERLAY_MENU then G.FUNCS.exit_overlay_menu() end
  G.SETTINGS.paused = false
end

G.FUNCS.phanta_cataclysm_update_collection = function(args)
  local deck_tables = {}

  if not args or not args.cycle_config then return end
  for j = 1, #G.your_collection do
    for i = #G.your_collection[j].cards, 1, -1 do
      local c = G.your_collection[j]:remove_card(G.your_collection[j].cards[i])
      c:remove()
      c = nil
    end
  end

  for i = 1, 6 do
    for j = 1, #G.your_collection do
      local center = G.P_CENTER_POOLS["Planet"][i + (j - 1) * 6 + (6 * #G.your_collection * (args.cycle_config.current_option - 1))]
      if not center then break end

      local old_used_jokers = G.GAME.used_jokers[center.key]
      local card = Card(G.your_collection[j].T.x + G.your_collection[j].T.w / 2, G.your_collection[j].T.y, G.CARD_W * 0.9, G.CARD_H * 0.9, nil, center)
      G.GAME.used_jokers[center.key] = old_used_jokers

      G.your_collection[j]:emplace(card)
    end
  end
end





local card_can_highlight = CardArea.can_highlight
function CardArea:can_highlight(card)
  if self.config.phanta_cataclysm_selectable then
    return card.config.center.discovered
  end
  return card_can_highlight(self, card)
end

G.FUNCS.phanta_select_cataclysm_card = function(e)
  G.GAME.phanta_current_cataclysm_card.ability.extra["card" .. G.OVERLAY_PHANTA_CATACLYSMCOLLECTION] = e.config.ref_table

  if G.OVERLAY_MENU then G.FUNCS.exit_overlay_menu() end
  G.SETTINGS.paused = true
  G.FUNCS.overlay_menu {
    definition = create_cataclysm_more_menu(G.OVERLAY_PHANTA_CATACLYSMCOLLECTION)
  }
end

G.FUNCS.phanta_can_select_cataclysm_card = function(e)

end




local smodsatpref = SMODS.add_to_pool
function SMODS.add_to_pool(prototype_obj, args)
  if not G.jokers then return smodsatpref(prototype_obj, args) end
  for _, v in ipairs(G.jokers.cards) do
    if v.config.center.key == "j_phanta_cataclysm" then
      if v.ability.extra and (v.ability.extra.card1 == prototype_obj.key or v.ability.extra.card2 == prototype_obj.key) then
        return false
      end
    end
  end
  return smodsatpref(prototype_obj, args)
end



local controllerkpuref = Controller.key_press_update
function Controller:key_press_update(key, dt)
  if key == "escape" and G.SETTINGS.paused and G.OVERLAY_PHANTA_CATACLYSMCOLLECTION then
    G.FUNCS.phanta_leave_cataclysm()
  end
  return controllerkpuref(self, key, dt)
end