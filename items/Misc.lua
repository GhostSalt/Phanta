SMODS.current_mod.optional_features = { cardareas = { unscored = true } }

local sell_use_ref = G.UIDEF.use_and_sell_buttons

function G.UIDEF.use_and_sell_buttons(card)
  if G.OVERLAY_PHANTA_DEATHNOTECOLLECTION then
    return {
      n = G.UIT.ROOT,
      config = { padding = 0, colour = G.C.CLEAR },
      nodes = {
        {
          n = G.UIT.R,
          config = { ref_table = card, r = 0.08, padding = 0.1, align = "bm", minw = 0.5 * card.T.w - 0.15, maxw = 0.9 * card.T.w - 0.15, minh = 0.3 * card.T.h, hover = true, shadow = true, colour = G.C.RED, one_press = true, button = 'phanta_select_deathnote_card', func = 'phanta_can_select_deathnote_card' },
          nodes = {
            { n = G.UIT.T, config = { text = localize('b_select'), colour = G.C.UI.TEXT_LIGHT, scale = 0.45, shadow = true } }
          }
        },
      }
    }
  end

  if not card or ((not card.config or not card.config.center
          or (card.config.center.key ~= "j_phanta_profile" and card.config.center.key ~= "j_phanta_modping" and card.config.center.key ~= "j_phanta_deathnote"))
        and not (card.ability and (card.ability.set == "phanta_Zodiac" or card.ability.set == "phanta_Birthstone"))
        and not (card.ability and card.ability.perishable and card.ability.perish_tally == 0)) then
    return sell_use_ref(card)
  end

  local sell = {
    n = G.UIT.C,
    config = { align = "cr" },
    nodes = {
      {
        n = G.UIT.C,
        config = { ref_table = card, align = "cr", padding = 0.1, r = 0.08, minw = 1.25, hover = true, shadow = true, colour = G.C.UI.BACKGROUND_INACTIVE, one_press = true, button = 'sell_card', func = 'can_sell_card' },
        nodes = {
          { n = G.UIT.B, config = { w = 0.1, h = 0.6 } },
          {
            n = G.UIT.C,
            config = { align = "tm" },
            nodes = {
              {
                n = G.UIT.R,
                config = { align = "cm", maxw = 1.25 },
                nodes = {
                  { n = G.UIT.T, config = { text = localize('b_sell'), colour = G.C.UI.TEXT_LIGHT, scale = 0.4, shadow = true } }
                }
              },
              {
                n = G.UIT.R,
                config = { align = "cm" },
                nodes = {
                  { n = G.UIT.T, config = { text = localize('$'), colour = G.C.WHITE, scale = 0.4, shadow = true } },
                  { n = G.UIT.T, config = { ref_table = card, ref_value = 'sell_cost_label', colour = G.C.WHITE, scale = 0.55, shadow = true } }
                }
              }
            }
          }
        }
      },
    }
  }

  local profile_more =
  {
    n = G.UIT.C,
    config = { align = "cr" },
    nodes = {
      {
        n = G.UIT.C,
        config = { ref_table = card, align = "cr", maxw = 1.25, padding = 0.1, r = 0.08, minw = 1.25, minh = (card.area and card.area.config.type == 'joker') and 0 or 1, hover = true, shadow = true, colour = G.C.RED, button = 'run_profile_menu', func = 'phanta_can_profile_more' },
        nodes = {
          { n = G.UIT.B, config = { w = 0.1, h = 0.6 } },
          { n = G.UIT.T, config = { text = localize('b_phanta_more'), colour = G.C.UI.TEXT_LIGHT, scale = 0.55, shadow = true } }
        }
      }
    }
  }

  local modping_use =
  {
    n = G.UIT.C,
    config = { align = "cr" },
    nodes = {
      {
        n = G.UIT.C,
        config = { ref_table = card, align = "cr", maxw = 1.25, padding = 0.1, r = 0.08, minw = 1.25, minh = (card.area and card.area.config.type == 'joker') and 0 or 1, hover = true, shadow = true, colour = G.C.RED, button = 'phanta_modping_use', func = 'phanta_can_modping_use' },
        nodes = {
          { n = G.UIT.B, config = { w = 0.1, h = 0.6 } },
          { n = G.UIT.T, config = { text = localize('b_use'), colour = G.C.UI.TEXT_LIGHT, scale = 0.55, shadow = true } }
        }
      }
    }
  }

  local deathnote_more =
  {
    n = G.UIT.C,
    config = { align = "cr" },
    nodes = {
      {
        n = G.UIT.C,
        config = { ref_table = card, align = "cr", maxw = 1.25, padding = 0.1, r = 0.08, minw = 1.25, minh = (card.area and card.area.config.type == 'joker') and 0 or 1, hover = true, shadow = true, colour = G.C.RED, button = 'run_deathnote_menu', func = 'phanta_can_deathnote_more' },
        nodes = {
          { n = G.UIT.B, config = { w = 0.1, h = 0.6 } },
          { n = G.UIT.T, config = { text = localize('b_phanta_more'), colour = G.C.UI.TEXT_LIGHT, scale = 0.55, shadow = true } }
        }
      }
    }
  }

  if card.config and card.config.center and card.config.center.key == "j_phanta_profile" then
    return {
      n = G.UIT.ROOT,
      config = { padding = 0, colour = G.C.CLEAR },
      nodes = {
        {
          n = G.UIT.C,
          config = { padding = 0.15, align = 'cl' },
          nodes = {
            {
              n = G.UIT.R,
              config = { align = 'cl' },
              nodes = { sell }
            },
            {
              n = G.UIT.R,
              config = { align = 'cl' },
              nodes = { profile_more }
            }
          }
        }
      }
    }
  end

  if card.config and card.config.center and card.config.center.key == "j_phanta_modping" then
    return {
      n = G.UIT.ROOT,
      config = { padding = 0, colour = G.C.CLEAR },
      nodes = {
        {
          n = G.UIT.C,
          config = { padding = 0.15, align = 'cl' },
          nodes = {
            {
              n = G.UIT.R,
              config = { align = 'cl' },
              nodes = { sell }
            },
            {
              n = G.UIT.R,
              config = { align = 'cl' },
              nodes = { modping_use }
            }
          }
        }
      }
    }
  end

  if card.config and card.config.center and card.config.center.key == "j_phanta_deathnote" then
    return {
      n = G.UIT.ROOT,
      config = { padding = 0, colour = G.C.CLEAR },
      nodes = {
        {
          n = G.UIT.C,
          config = { padding = 0.15, align = 'cl' },
          nodes = {
            {
              n = G.UIT.R,
              config = { align = 'cl' },
              nodes = { sell }
            },
            {
              n = G.UIT.R,
              config = { align = 'cl' },
              nodes = { deathnote_more }
            }
          }
        }
      }
    }
  end

  if card.area == G.pack_cards and G.pack_cards then
    return {
      n = G.UIT.ROOT,
      config = { padding = 0, colour = G.C.CLEAR },
      nodes = {
        {
          n = G.UIT.R,
          config = { ref_table = card, r = 0.08, padding = 0.1, align = "bm", minw = 0.5 * card.T.w - 0.15, maxw = 0.9 * card.T.w - 0.15, minh = 0.3 * card.T.h, hover = true, shadow = true, colour = G.C.UI.BACKGROUND_INACTIVE, one_press = true, button = 'use_card', func = 'can_select_card' },
          nodes = {
            { n = G.UIT.T, config = { text = localize('b_select'), colour = G.C.UI.TEXT_LIGHT, scale = 0.45, shadow = true } }
          }
        },
      }
    }
  end

  return {
    n = G.UIT.ROOT,
    config = { padding = 0, colour = G.C.CLEAR },
    nodes = {
      {
        n = G.UIT.C,
        config = { padding = 0.15, align = 'cl' },
        nodes = {
          {
            n = G.UIT.R,
            config = { align = 'cl' },
            nodes = { sell }
          }
        }
      },
    }
  }
end

local can_select_card_ref = G.FUNCS.can_select_card
G.FUNCS.can_select_card = function(e)
  local card = e.config.ref_table
  if card.ability.set == 'phanta_Zodiac' then
    if count_consumables() < G.consumeables.config.card_limit then
      e.config.colour = G.C.GREEN
      e.config.button = 'use_card'
    else
      e.config.colour = G.C.UI.BACKGROUND_INACTIVE
      e.config.button = nil
    end
  else
    can_select_card_ref(e)
  end
end

local scu = set_consumeable_usage
function set_consumeable_usage(card)
  local ret = scu(card)
  if card.config.center.set == 'Spectral' then
    G.E_MANAGER:add_event(Event({
      trigger = 'immediate',
      func = function()
        G.E_MANAGER:add_event(Event({
          trigger = 'immediate',
          func = function()
            G.GAME.last_spectral = card.config.center_key
            return true
          end
        }))
        return true
      end
    }))
  end
  return ret
end

G.FUNCS.run_deathnote_menu = function(e)
  G.SETTINGS.paused = true
  G.GAME.phanta_current_deathnote_card = e.config.ref_table
  G.GAME.phanta_current_deathnote_card.ability = G.GAME.phanta_current_deathnote_card.ability or {}
  G.GAME.phanta_current_deathnote_card.ability.extra = G.GAME.phanta_current_deathnote_card.ability.extra or {}
  G.GAME.phanta_deathnote_name = G.GAME.phanta_current_deathnote_card.ability.extra.card_name or ""
  G.FUNCS.overlay_menu {
    definition = create_deathnote_more_menu(e)
  }
end

G.FUNCS.phanta_can_deathnote_more = function(e)

end

function create_deathnote_more_menu(e)
  local t = create_UIBox_generic_options({
    infotip = localize("phanta_deathnote_more_tooltip"),
    contents = {
      {
        n = G.UIT.R,
        config = { align = "cm", padding = 0 },
        nodes = {
          create_tabs({
            tabs = {
              {
                label = localize("k_phanta_deathnote_tab1"),
                chosen = true,
                tab_definition_function = G.UIDEF.phanta_deathnote_tab1
              },
              {
                label = localize("k_phanta_deathnote_tab2"),
                tab_definition_function = G.UIDEF.phanta_deathnote_tab2
              },
              {
                label = localize("k_phanta_deathnote_tab3"),
                tab_definition_function = G.UIDEF.phanta_deathnote_tab3
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

G.UIDEF.phanta_deathnote_tab1 = function()
  local t = { {
    n = G.UIT.R,
    config = { r = 0.1, align = "cm", padding = 0.2, colour = G.C.BLACK, emboss = 0.05 },
    nodes = {
      {
        n = G.UIT.C,
        config = {},
        nodes = {
          {
            n = G.UIT.R,
            config = { padding = 0.1 },
            nodes = {
              create_text_input({
                w = 8,
                h = 1,
                max_length = 100,
                extended_corpus = true,
                prompt_text = localize("phanta_deathnote_more_text"),
                ref_table = G.GAME,
                ref_value = "phanta_deathnote_name",
                keyboard_offset = 1
              })
            }
          },
          {
            n = G.UIT.R,
            config = { padding = 0.1, align = "cm" },
            nodes = {
              {
                n = G.UIT.C,
                config = { align = "cm", padding = 0.1 },
                nodes = {
                  UIBox_button({
                    button = "phanta_set_deathnote_card",
                    func = "phanta_can_set_deathnote_card",
                    label = { localize("phanta_set") },
                    minw = 2,
                    colour = G.C.GREEN
                  })
                }
              },
              {
                n = G.UIT.C,
                config = { align = "cm", padding = 0.1 },
                nodes = {
                  UIBox_button({
                    button = "phanta_clear_deathnote_input",
                    func = "phanta_can_clear_deathnote_input",
                    label = { localize("phanta_clear") },
                    minw = 2
                  })
                }
              }
            }
          }
        }
      }
    }
  } }

  return { n = G.UIT.ROOT, config = { align = "cm", padding = 0, colour = G.C.CLEAR, r = 0.1, minw = 7, minh = 4.2 }, nodes = t }
end

G.UIDEF.phanta_deathnote_tab2 = function()
  local t = { {
    n = G.UIT.C,
    config = { align = "cl" },
    nodes = {

      {
        n = G.UIT.R,
        config = { align = "cm" },
        nodes = {
          {
            n = G.UIT.C,
            config = { align = "cm", padding = 0.1 },
            nodes = {
              UIBox_button({
                button = "phanta_deathnote_visit_jokers_collection",
                func = "phanta_can_deathnote_visit_jokers_collection",
                label = { localize("phanta_jokers") },
                minw = 3
              })
            }
          },
          {
            n = G.UIT.C,
            config = { align = "cm", padding = 0.1 },
            nodes = {
              UIBox_button({
                button = "phanta_deathnote_visit_consumables_collection",
                func = "phanta_can_deathnote_visit_consumables_collection",
                label = { localize("phanta_consumables") },
                minw = 3
              })
            }
          }
        }
      }
    }
  } }

  return { n = G.UIT.ROOT, config = { align = "cm", padding = 0, colour = G.C.CLEAR, r = 0.1, minw = 7, minh = 4.2 }, nodes = t }
end

G.UIDEF.phanta_deathnote_tab3 = function()
  local prev_buttons = {}
  prev_buttons[#prev_buttons + 1] = {
    n = G.UIT.R,
    config = { padding = 0.1 },
    nodes = {
      {
        n = G.UIT.T,
        config = { text = localize("phanta_deathnote_recent_names"), colour = G.C.UI.TEXT_LIGHT, scale = 0.5, padding = 0.1 },
        nodes = {}
      }
    }
  }
  for i = 1, 5 do
    prev_buttons[#prev_buttons + 1] = {
      n = G.UIT.R,
      config = { padding = 0.1 },
      nodes = {
        UIBox_button({
          ref_table = { ix = i },
          button = "phanta_use_previous_deathnote_card",
          func = "phanta_can_use_previous_deathnote_card",
          label = { G.GAME.phanta_deathnote_previous_names and G.GAME.phanta_deathnote_previous_names[i] or localize("phanta_none") },
          w = 6,
          colour = G.C.GREEN
        })
      }
    }
  end

  local t = { {
    n = G.UIT.C,
    config = { align = "cr" },
    nodes = {
      {
        n = G.UIT.R,
        config = { r = 0.1, align = "cm", padding = 0.2, colour = G.C.BLACK, emboss = 0.05 },
        nodes = {
          {
            n = G.UIT.C,
            config = {},
            nodes = prev_buttons
          }
        }
      }
    }
  } }

  return { n = G.UIT.ROOT, config = { align = "cm", padding = 0, colour = G.C.CLEAR, r = 0.1, minw = 7, minh = 4.2 }, nodes = t }
end







G.FUNCS.phanta_deathnote_visit_jokers_collection = function(e)
  G.OVERLAY_PHANTA_DEATHNOTECOLLECTION = true

  if G.OVERLAY_MENU then G.FUNCS.exit_overlay_menu() end
  G.SETTINGS.paused = true
  G.FUNCS.overlay_menu({ definition = phanta_create_uibox_deathnote_jokers_collection(e) })
end

G.FUNCS.phanta_can_deathnote_visit_jokers_collection = function(e)
  e.config.colour = G.C.RED
  e.config.button = "phanta_deathnote_visit_jokers_collection"
end

-- Thanks, Revo!
phanta_create_uibox_deathnote_jokers_collection = function(e)
  local deck_tables = {}

  G.your_collection = {}
  for j = 1, 3 do
    G.your_collection[j] = CardArea(
      G.ROOM.T.x + 0.2 * G.ROOM.T.w / 2, G.ROOM.T.h,
      5 * G.CARD_W,
      0.95 * G.CARD_H,
      { card_limit = 5, type = "title", highlight_limit = 1, collection = true })
    table.insert(deck_tables,
      {
        n = G.UIT.R,
        config = { align = "cm", padding = 0.07, no_fill = true },
        nodes = {
          { n = G.UIT.O, config = { object = G.your_collection[j] } }
        }
      }
    )
    G.your_collection[j].config.phanta_deathnote_selectable = true
  end

  local joker_options = {}
  for i = 1, math.ceil(#G.P_CENTER_POOLS["Joker"] / (5 * #G.your_collection)) do
    table.insert(joker_options, localize('k_page') .. ' ' .. tostring(i) .. '/' .. tostring(math.ceil(#G.P_CENTER_POOLS["Joker"] / (5 * #G.your_collection))))
  end

  for i = 1, 5 do
    for j = 1, #G.your_collection do
      local center = G.P_CENTER_POOLS["Joker"][i + (j - 1) * 5]
      if not center then break end
      local card = Card(G.your_collection[j].T.x + G.your_collection[j].T.w / 2, G.your_collection[j].T.y, G.CARD_W, G.CARD_H, nil, center)
      card.sticker = get_joker_win_sticker(center)
      G.your_collection[j]:emplace(card)
    end
  end

  INIT_COLLECTION_CARD_ALERTS()

  local t = create_UIBox_generic_options({
    back_func = 'phanta_leave_deathnote_jokers_collection',
    contents = {
      { n = G.UIT.R, config = { align = "cm", r = 0.1, colour = G.C.BLACK, emboss = 0.05 }, nodes = deck_tables },
      {
        n = G.UIT.R,
        config = { align = "cm" },
        nodes = {
          create_option_cycle({ options = joker_options, w = 4.5, cycle_shoulders = true, opt_callback = 'phanta_your_deathnote_jokers_collection', current_option = 1, colour = G.C.RED, no_pips = true, focus_args = { snap_to = true, nav = 'wide' } })
        }
      },
    }
  })
  return t
end

G.FUNCS.phanta_leave_deathnote_jokers_collection = function(e)
  G.OVERLAY_PHANTA_DEATHNOTECOLLECTION = false

  if G.OVERLAY_MENU then G.FUNCS.exit_overlay_menu() end
  G.SETTINGS.paused = true
  G.FUNCS.overlay_menu({ definition = create_deathnote_more_menu(e) })
end

G.FUNCS.phanta_your_deathnote_jokers_collection = function(args)
  local jokers = {}

  if not args or not args.cycle_config then return end
  for j = 1, #G.your_collection do
    for i = #G.your_collection[j].cards, 1, -1 do
      local c = G.your_collection[j]:remove_card(G.your_collection[j].cards[i])
      c:remove()
      c = nil
    end
  end
  for i = 1, 5 do
    for j = 1, #G.your_collection do
      local center = G.P_CENTER_POOLS["Joker"][i + (j - 1) * 5 + (5 * #G.your_collection * (args.cycle_config.current_option - 1))]
      if not center then break end
      local card = Card(G.your_collection[j].T.x + G.your_collection[j].T.w / 2, G.your_collection[j].T.y, G.CARD_W, G.CARD_H, G.P_CARDS.empty, center)

      G.your_collection[j]:emplace(card)
    end
  end
end






G.FUNCS.phanta_deathnote_visit_consumables_collection = function(e)
  if G.OVERLAY_MENU then G.FUNCS.exit_overlay_menu() end
  G.SETTINGS.paused = true
  G.FUNCS.overlay_menu({ definition = phanta_create_uibox_deathnote_consumables_collection(e) })
end

G.FUNCS.phanta_can_deathnote_visit_consumables_collection = function(e)
  e.config.colour = G.C.RED
  e.config.button = "phanta_deathnote_visit_consumables_collection"
end

function phanta_create_uibox_deathnote_consumables_collection(e)
  local t = create_UIBox_generic_options({
    colour = G.ACTIVE_MOD_UI and ((G.ACTIVE_MOD_UI.ui_config or {}).collection_colour or
      (G.ACTIVE_MOD_UI.ui_config or {}).colour),
    bg_colour = G.ACTIVE_MOD_UI and ((G.ACTIVE_MOD_UI.ui_config or {}).collection_bg_colour or
      (G.ACTIVE_MOD_UI.ui_config or {}).bg_colour),
    back_colour = G.ACTIVE_MOD_UI and ((G.ACTIVE_MOD_UI.ui_config or {}).collection_back_colour or
      (G.ACTIVE_MOD_UI.ui_config or {}).back_colour),
    outline_colour = G.ACTIVE_MOD_UI and ((G.ACTIVE_MOD_UI.ui_config or {}).collection_outline_colour or
      (G.ACTIVE_MOD_UI.ui_config or {}).outline_colour),
    back_func = "phanta_leave_deathnote_consumables_collection",
    contents = {
      {
        n = G.UIT.C,
        config = { align = 'cm', minw = 11.5, minh = 6 },
        nodes = {
          { n = G.UIT.O, config = { id = "phanta_deathnote_consumable_collection", object = Moveable() }, }
        }
      },
    }
  })
  G.E_MANAGER:add_event(Event({
    func = function()
      G.FUNCS.phanta_deathnote_consumables_page({ cycle_config = { current_option = 1 } })
      return true
    end
  }))
  return t
end

G.FUNCS.phanta_deathnote_consumables_page = function(args)
  if not args or not args.cycle_config then return end
  if G.OVERLAY_MENU then
    local uie = G.OVERLAY_MENU:get_UIE_by_ID("phanta_deathnote_consumable_collection")
    if uie then
      if uie.config.object then
        uie.config.object:remove()
      end
      uie.config.object = UIBox {
        definition = phanta_deathnote_consumable_collection_page(args.cycle_config.current_option),
        config = { align = 'cm', parent = uie }
      }
    end
  end
end

phanta_deathnote_consumable_collection_page = function(page)
  local nodes_per_page = 10
  local page_offset = nodes_per_page * ((page or 1) - 1)
  local type_buf = {}
  if G.ACTIVE_MOD_UI then
    for _, v in ipairs(SMODS.ConsumableType.visible_buffer) do
      if modsCollectionTally(G.P_CENTER_POOLS[v]).of > 0 then type_buf[#type_buf + 1] = v end
    end
  else
    type_buf = SMODS.ConsumableType.visible_buffer
  end
  local center_options = {}
  for i = 1, math.ceil(#type_buf / nodes_per_page) do
    table.insert(center_options,
      localize('k_page') ..
      ' ' .. tostring(i) .. '/' .. tostring(math.ceil(#type_buf / nodes_per_page)))
  end
  local option_nodes = { create_option_cycle({
    options = center_options,
    w = 4.5,
    cycle_shoulders = true,
    opt_callback = 'phanta_deathnote_consumables_page',
    focus_args = { snap_to = true, nav = 'wide' },
    current_option = page or 1,
    colour = G.ACTIVE_MOD_UI and (G.ACTIVE_MOD_UI.ui_config or {}).collection_option_cycle_colour or G.C.RED,
    no_pips = true
  }) }
  local function create_consumable_nodes(_start, _end)
    local t = {}
    for i = _start, _end do
      local key = type_buf[i]
      if not key then
        if i == _start then break end
        t[#t + 1] = { n = G.UIT.R, config = { align = 'cm', minh = 0.81 }, nodes = {} }
      else
        t[#t + 1] = UIBox_button({
          ref_table = { set = key },
          button = "phanta_deathnote_visit_consumable_type",
          label = { localize('b_' .. key:lower() .. '_cards') },
          count = G.ACTIVE_MOD_UI and modsCollectionTally(G.P_CENTER_POOLS[key]) or G.DISCOVER_TALLIES[key:lower() .. 's'],
          minw = 4,
          id = id,
          colour = G.C.SECONDARY_SET[key],
          text_colour = G.C.UI[key]
        })
      end
    end
    return t
  end

  local t = {
    n = G.UIT.C,
    config = { align = 'cm' },
    nodes = {
      {
        n = G.UIT.R,
        config = { align = "cm" },
        nodes = {
          { n = G.UIT.C, config = { align = "tm", padding = 0.15 }, nodes = create_consumable_nodes(page_offset + 1, page_offset + math.ceil(nodes_per_page / 2)) },
          { n = G.UIT.C, config = { align = "tm", padding = 0.15 }, nodes = create_consumable_nodes(page_offset + 1 + math.ceil(nodes_per_page / 2), page_offset + nodes_per_page) },
        }
      },
      { n = G.UIT.R, config = { align = "cm" }, nodes = option_nodes },
    }
  }
  return t
end

G.FUNCS.phanta_deathnote_visit_consumable_type = function(e)
  G.OVERLAY_PHANTA_DEATHNOTECOLLECTION = true

  if G.OVERLAY_MENU then G.FUNCS.exit_overlay_menu() end
  G.SETTINGS.paused = true
  G.FUNCS.overlay_menu({ definition = phanta_deathnote_your_collection_consumable_type(e) })
end




phanta_deathnote_your_collection_consumable_type = function(e)
  local deck_tables = {}

  G.your_collection = {}
  for j = 1, 3 do
    G.your_collection[j] = CardArea(
      G.ROOM.T.x + 0.2 * G.ROOM.T.w / 2, G.ROOM.T.h,
      5 * G.CARD_W,
      0.95 * G.CARD_H,
      { card_limit = 5, type = "title", highlight_limit = 1, collection = true })
    table.insert(deck_tables,
      {
        n = G.UIT.R,
        config = { align = "cm", padding = 0.07, no_fill = true },
        nodes = {
          { n = G.UIT.O, config = { object = G.your_collection[j] } }
        }
      }
    )
    G.your_collection[j].config.phanta_deathnote_selectable = true
  end

  local set = e.config.ref_table.set
  local consumable_options = {}
  for i = 1, math.ceil(#G.P_CENTER_POOLS[set] / (5 * #G.your_collection)) do
    table.insert(consumable_options, localize('k_page') .. ' ' .. tostring(i) .. '/' .. tostring(math.ceil(#G.P_CENTER_POOLS[set] / (5 * #G.your_collection))))
  end

  for i = 1, 5 do
    for j = 1, #G.your_collection do
      local center = G.P_CENTER_POOLS[set][i + (j - 1) * 5]
      if not center then break end
      local card = Card(G.your_collection[j].T.x + G.your_collection[j].T.w / 2, G.your_collection[j].T.y, G.CARD_W, G.CARD_H, nil, center)
      G.your_collection[j]:emplace(card)
    end
  end

  INIT_COLLECTION_CARD_ALERTS()
  local t = create_UIBox_generic_options({
    back_func = 'phanta_leave_deathnote_consumable_type',
    contents = {
      { n = G.UIT.R, config = { align = "cm", r = 0.1, colour = G.C.BLACK, emboss = 0.05 }, nodes = deck_tables },
      {
        n = G.UIT.R,
        config = { align = "cm" },
        nodes = {
          create_option_cycle({ phanta_deathnote_set = set, options = consumable_options, w = 4.5, cycle_shoulders = true, opt_callback = 'phanta_deathnote_your_collection_consumable_type_thing', current_option = 1, colour = G.C.RED, no_pips = true, focus_args = { snap_to = true, nav = 'wide' } })
        }
      },
    }
  })
  return t
end

G.FUNCS.phanta_leave_deathnote_consumable_type = function(e)
  G.OVERLAY_PHANTA_DEATHNOTECOLLECTION = false

  if G.OVERLAY_MENU then G.FUNCS.exit_overlay_menu() end
  G.SETTINGS.paused = true
  G.FUNCS.overlay_menu({ definition = phanta_create_uibox_deathnote_consumables_collection(e) })
end

G.FUNCS.phanta_leave_deathnote_consumables_collection = function(e)
  G.OVERLAY_PHANTA_DEATHNOTECOLLECTION = false

  if G.OVERLAY_MENU then G.FUNCS.exit_overlay_menu() end
  G.SETTINGS.paused = true
  G.FUNCS.overlay_menu({ definition = create_deathnote_more_menu(e) })
end

G.FUNCS.phanta_deathnote_your_collection_consumable_type_thing = function(args)
  local deck_tables = {}

  if not args or not args.cycle_config then return end
  for j = 1, #G.your_collection do
    for i = #G.your_collection[j].cards, 1, -1 do
      local c = G.your_collection[j]:remove_card(G.your_collection[j].cards[i])
      c:remove()
      c = nil
    end
  end

  for i = 1, 5 do
    for j = 1, #G.your_collection do
      local center = G.P_CENTER_POOLS[args.cycle_config.phanta_deathnote_set][i + (j - 1) * 5 + (5 * #G.your_collection * (args.cycle_config.current_option - 1))]
      if not center then break end
      local card = Card(G.your_collection[j].T.x + G.your_collection[j].T.w / 2, G.your_collection[j].T.y, G.CARD_W, G.CARD_H, nil, center)
      G.your_collection[j]:emplace(card)
    end
  end
end





local card_can_highlight = CardArea.can_highlight
function CardArea:can_highlight(card)
  if self.config.phanta_deathnote_selectable then
    return card.config.center.discovered
  end
  return card_can_highlight(self, card)
end

G.FUNCS.phanta_select_deathnote_card = function(e)
  G.OVERLAY_PHANTA_DEATHNOTECOLLECTION = false
  G.GAME.phanta_deathnote_name = localize { set = e.config.ref_table.config.center.set, type = "name_text", key = e.config.ref_table.config.center.key }
  G.FUNCS.phanta_set_deathnote_card(e)
end

G.FUNCS.phanta_can_select_deathnote_card = function(e)

end

G.FUNCS.phanta_set_deathnote_card = function(e)
  if not phanta_deathnote_is_existing_card() then
    if G.GAME.phanta_deathnote_name:lower() == G.PROFILES[G.SETTINGS.profile].name:lower() then
      G.STATE = G.STATES.GAME_OVER
      if not G.GAME.won and not G.GAME.seeded and not G.GAME.challenge then
        G.PROFILES[G.SETTINGS.profile].high_scores.current_streak.amt = 0
      end
      G:save_settings()
      G.FILE_HANDLER.force = true
      G.STATE_COMPLETE = false
      G.SETTINGS.paused = false
      return
    end
    if G.GAME.phanta_deathnote_name:lower() == "balatro" then
      G:save_settings()
      G:save_progress()
      love.event.quit(0)
      return
    end
  end

  phanta_deathnote_set_prev_names(G.GAME.phanta_deathnote_name)
  G.GAME.phanta_current_deathnote_card.ability.extra.card_name = G.GAME.phanta_deathnote_name

  if G.OVERLAY_MENU then G.FUNCS.exit_overlay_menu() end
  G.SETTINGS.paused = true
  G.FUNCS.overlay_menu {
    definition = create_deathnote_more_menu(e)
  }
end

G.FUNCS.phanta_can_set_deathnote_card = function(e)
  if G.GAME.phanta_deathnote_name:lower() == G.PROFILES[G.SETTINGS.profile].name:lower()
      or G.GAME.phanta_deathnote_name:lower() == "balatro" then
    e.config.colour = G.C.RED
    e.config.button = "phanta_set_deathnote_card"
    return
  end

  if not phanta_deathnote_is_existing_card() then
    e.config.colour = G.C.UI.BACKGROUND_INACTIVE
    e.config.button = nil
  else
    e.config.colour = G.C.GREEN
    e.config.button = "phanta_set_deathnote_card"
  end
end





G.FUNCS.phanta_clear_deathnote_input = function(e)
  G.GAME.phanta_deathnote_name = ""
  G.GAME.phanta_current_deathnote_card.ability.extra.card_name = ""
  if G.OVERLAY_MENU then G.FUNCS.exit_overlay_menu() end
  G.SETTINGS.paused = true
  G.FUNCS.overlay_menu {
    definition = create_deathnote_more_menu(e)
  }
end

G.FUNCS.phanta_can_clear_deathnote_input = function(e) -- Commented out to allow the name to always be clearable.
  --[[if not G.GAME.phanta_deathnote_name or #G.GAME.phanta_deathnote_name == 0 then
    e.config.colour = G.C.UI.BACKGROUND_INACTIVE
    e.config.button = nil
  else
    e.config.colour = G.C.RED
    e.config.button = "phanta_clear_deathnote_input"
  end]] --
end







G.FUNCS.phanta_use_previous_deathnote_card = function(e)
  local name = G.GAME.phanta_deathnote_previous_names and G.GAME.phanta_deathnote_previous_names[e.config.ref_table.ix]
  if not name then return end

  G.GAME.phanta_deathnote_name = name
  G.FUNCS.phanta_set_deathnote_card()
end

G.FUNCS.phanta_can_use_previous_deathnote_card = function(e)
  if G.GAME.phanta_deathnote_previous_names and G.GAME.phanta_deathnote_previous_names[e.config.ref_table.ix] then
    e.config.colour = G.C.GREEN
    e.config.button = "phanta_use_previous_deathnote_card"
  else
    e.config.colour = G.C.UI.BACKGROUND_INACTIVE
    e.config.button = nil
  end
  return
end

phanta_deathnote_set_prev_names = function(name)
  if not G.GAME.phanta_deathnote_previous_names then
    G.GAME.phanta_deathnote_previous_names = {}
  end

  local old_names = G.GAME.phanta_deathnote_previous_names
  local new_names = { name }

  for i = 1, #old_names do
    if old_names[i] ~= name then
      table.insert(new_names, old_names[i])
    end
    if #new_names >= 5 then break end
  end

  G.GAME.phanta_deathnote_previous_names = new_names
end





function phanta_deathnote_is_existing_card()
  local banned = { "Voucher", "Back", "Enhanced", "Edition", "Booster" }
  local valid = false
  for k, v in pairs(G.P_CENTERS) do
    if localize { key = k, type = "name_text", set = v.set }:lower() == G.GAME.phanta_deathnote_name:lower() then
      local is_banned = false
      for i, banned_key in ipairs(banned) do
        if v.set == banned_key then is_banned = true end
      end
      if not is_banned then
        valid = true
        break
      end
    end
  end
  return valid
end

local create_card_ref = create_card
function create_card(_type, area, legendary, _rarity, skip_materialize, soulable, forced_key, key_append)
  local card = create_card_ref(_type, area, legendary, _rarity, skip_materialize, soulable, forced_key, key_append)
  local notes = SMODS.find_card("j_phanta_deathnote")
  if next(notes) then
    for i, v in ipairs(notes) do
      if v and v.ability and v.ability.extra and v.ability.extra.card_name
          and localize { key = card.config.center.key, type = "name_text", set = card.config.center.set }:lower() == v.ability.extra.card_name:lower() then
        card:set_edition("e_negative")
      end
    end
  end
  return card
end

local smods_create_card_ref = SMODS.create_card
function SMODS:create_card(t)
  local card = smods_create_card_ref(self, t)
  local notes = SMODS.find_card("j_phanta_deathnote")
  if next(notes) then
    for i, v in ipairs(notes) do
      if v and v.ability and v.ability.extra and v.ability.extra.card_name
          and localize { key = card.config.center.key, type = "name_text", set = card.config.center.set }:lower() == v.ability.extra.card_name:lower() then
        card:set_edition("e_negative")
      end
    end
  end
  return card
end
