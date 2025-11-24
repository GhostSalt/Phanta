SMODS.current_mod.optional_features = { cardareas = { unscored = true } }

local sell_use_ref = G.UIDEF.use_and_sell_buttons

function G.UIDEF.use_and_sell_buttons(card)
  if not card or ((not card.config or not card.config.center
          or (card.config.center.key ~= "j_phanta_profile" and card.config.center.key ~= "j_phanta_modping" and card.config.center.key ~= "j_phanta_deathnote"))
        and not (card.ability and (card.ability.set == "phanta_Zodiac" or card.ability.set == "phanta_Birthstone"))
        and not (card.ability and card.ability.perishable and card.ability.perish_tally ~= 0)) then
    return sell_use_ref(card, self)
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