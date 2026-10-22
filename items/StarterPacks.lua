SMODS.Atlas {
  key = "PhantaStarterPacks1",
  path = "PhantaStarterPacks1.png",
  px = 71,
  py = 95
}

SMODS.ConsumableType {
  key = "phanta_StarterPack",
  primary_colour = HEX("444444"),
  secondary_colour = HEX("444444"),
  collection_rows = { 4, 4 },
  shop_rate = 0,
  default = "c_phanta_piratepack",
  can_stack = true,
  can_divide = true,
  in_pool = function()
    return true -- Phanta.config["starter_pack_enabled"]
  end
}

SMODS.UndiscoveredSprite({
  key = "phanta_StarterPack",
  atlas = "PhantaStarterPacks1",
  pos = { x = 4, y = 0 },
  px = 71,
  py = 95,
}):register()

function phanta_simple_starter_pack(args)
  if not args.set then args.set = "phanta_StarterPack" end
  if not args.cost then args.cost = 7 end
  if not args.atlas then args.atlas = "PhantaStarterPacks1" end

  if not args.can_use then
    args.can_use = function(self, card)
      return true
    end
  end

  if not args.use then
    args.use = function(self, card, area, copier)
      card.opening = true
      G.E_MANAGER:add_event(Event({
        trigger = "before",
        delay = 1.3 * math.sqrt(G.SETTINGS.GAMESPEED),
        func = function()
          G.play:remove_card(card)
          card:explode()
          return true
        end
      }))

      local all_cards = {}
      local card_count = 0

      for i = 1, #card.ability.starter_cards do
        for j = 0, (card.ability.starter_cards[i].count or 1) - 1 do
          card_count = card_count + 1
          local rank = card.ability.starter_cards[i].rank
          if rank == "Face" then
            rank = pseudorandom_element({ "Jack", "Queen", "King" },
              pseudoseed("starter_pack_" .. i))
          end

          G.E_MANAGER:add_event(Event({
            func = function()
              all_cards[#all_cards + 1] = SMODS.add_card {
                set = "Base",
                area = G.play,
                enhancement = card.ability.starter_cards[i].enhancement,
                seal = card.ability.starter_cards[i].seal,
                edition = card.ability.starter_cards[i].edition,
                rank = rank,
                suit = card.ability.starter_cards[i].suit,
                silent = true,
                immediate = true
              }
              local new_card = all_cards[#all_cards]
              if card.ability.starter_cards[i].unknown_suit then
                new_card:become_unknown(card.config.center.key)
              end
              new_card.states.visible = nil
              --new_card.facing = "back"
              --new_card.sprite_facing = "back"
              return true
            end
          }))
        end
      end

      delay(0.2)

      for i = 1, card_count do
        G.E_MANAGER:add_event(Event({
          trigger = "before",
          delay = 0.5,
          func = function()
            all_cards[i]:start_materialize({ G.C.SECONDARY_SET.Enhanced })
            return true
          end
        }))
      end
      delay(1.3)

      for i = card_count, 1, -1 do
        G.E_MANAGER:add_event(Event({
          trigger = "after",
          delay = 0.25,
          func = function()
            draw_card(G.play, G.deck, 90, "up", nil, all_cards[i])
            SMODS.calculate_context({ playing_card_added = true, cards = { all_cards[i] } })
            return true
          end
        }))
      end
    end
  end

  if not args.add_to_deck then
    args.add_to_deck = function(self, card, from_debuff)
      G.GAME.PhantaStarterPacks = G.GAME.PhantaStarterPacks or {}
      G.GAME.PhantaStarterPacks.purchased_this_ante = true
      G.GAME.PhantaStarterPacks.ante_pack = nil
    end
  end

  if not args.draw then
    args.draw = function(self, card, layer)
      card.children.center:draw_shader("booster", nil, card.ARGS.send_to_shader)
    end
  end

  if not args.display_size then args.display_size = { w = 1.27 * 71, h = 1.27 * 95 } end
  if not args.mouse_damping then args.mouse_damping = 1.5 end

  SMODS.Consumable(args)
end

phanta_simple_starter_pack {
  key = "performerpack",
  pos = { x = 0, y = 0 },
  config = { starter_cards = {
    { count = 1, enhancement = "m_steel", rank = "Jack",  suit = "Hearts" },
    { count = 2, seal = "Red",            suit = "Hearts" } } },
  loc_vars = function(self, info_queue, card)
    info_queue[#info_queue + 1] = G.P_CENTERS.m_steel
    info_queue[#info_queue + 1] = G.P_SEALS.Red
  end
}

phanta_simple_starter_pack {
  key = "polyculepack",
  pos = { x = 1, y = 0 },
  config = { starter_cards = {
    { count = 1, enhancement = "m_lucky", rank = "Queen", suit = "Hearts" },
    { count = 2, enhancement = "m_lucky", rank = "Queen" } } },
  loc_vars = function(self, info_queue, card)
    info_queue[#info_queue + 1] = G.P_CENTERS.m_lucky
  end
}

phanta_simple_starter_pack {
  key = "powerhousepack",
  pos = { x = 2, y = 0 },
  config = { starter_cards = {
    { count = 1, enhancement = "m_steel", seal = "Red", rank = "King", suit = "Hearts" },
    { count = 2, unknown_suit = true } } },
  loc_vars = function(self, info_queue, card)
    info_queue[#info_queue + 1] = G.P_SEALS.Red
    info_queue[#info_queue + 1] = G.P_CENTERS.m_steel
  end
}

phanta_simple_starter_pack {
  key = "passionatepack",
  pos = { x = 3, y = 0 },
  config = { starter_cards = {
    { count = 3, suit = "Hearts" },
    { count = 1, edition = "e_polychrome", suit = "Hearts" } } },
  loc_vars = function(self, info_queue, card)
    info_queue[#info_queue + 1] = G.P_CENTERS.e_polychrome
  end
}

phanta_simple_starter_pack {
  key = "plentifulpack",
  pos = { x = 0, y = 1 },
  config = { starter_cards = {
    { count = 1, seal = "Purple",         suit = "Clubs", rank = "Jack" },
    { count = 2, enhancement = "m_lucky", suit = "Clubs" } } },
  loc_vars = function(self, info_queue, card)
    info_queue[#info_queue + 1] = G.P_SEALS.Purple
    info_queue[#info_queue + 1] = G.P_CENTERS.m_lucky
  end
}

phanta_simple_starter_pack {
  key = "plazapack",
  pos = { x = 1, y = 1 },
  config = { starter_cards = {
    { count = 1, enhancement = "m_gold",  suit = "Clubs", rank = "Queen" },
    { count = 2, enhancement = "m_lucky", rank = "Face" } } },
  loc_vars = function(self, info_queue, card)
    info_queue[#info_queue + 1] = G.P_CENTERS.m_gold
    info_queue[#info_queue + 1] = G.P_CENTERS.m_lucky
  end
}

phanta_simple_starter_pack {
  key = "palacepack",
  pos = { x = 2, y = 1 },
  config = { starter_cards = {
    { count = 1, seal = "Purple",        suit = "Clubs", rank = "King" },
    { count = 1, seal = "Purple",        suit = "Clubs", rank = "Queen" },
    { count = 1, enhancement = "m_stone" } } },
  loc_vars = function(self, info_queue, card)
    info_queue[#info_queue + 1] = G.P_SEALS.Purple
    info_queue[#info_queue + 1] = G.P_CENTERS.m_stone
  end
}

phanta_simple_starter_pack {
  key = "partypack",
  pos = { x = 3, y = 1 },
  config = { starter_cards = {
    { count = 2, suit = "Clubs" },
    { count = 2, edition = "e_holo", suit = "Clubs" } } },
  loc_vars = function(self, info_queue, card)
    info_queue[#info_queue + 1] = G.P_CENTERS.e_holo
  end
}

phanta_simple_starter_pack {
  key = "pilfererpack",
  pos = { x = 0, y = 2 },
  config = { starter_cards = {
    { count = 1, enhancement = "m_glass", rank = "Jack", suit = "Diamonds" },
    { count = 1, enhancement = "m_gold",  rank = "Ace" },
    { count = 1, seal = "Gold",           rank = "Ace" } } },
  loc_vars = function(self, info_queue, card)
    info_queue[#info_queue + 1] = G.P_CENTERS.m_glass
    info_queue[#info_queue + 1] = G.P_CENTERS.m_gold
    info_queue[#info_queue + 1] = G.P_SEALS.Gold
  end
}

phanta_simple_starter_pack {
  key = "prettypack",
  pos = { x = 1, y = 2 },
  config = { starter_cards = {
    { count = 1, seal = "Gold",           rank = "Queen", suit = "Diamonds" },
    { count = 2, enhancement = "m_glass", rank = "Queen" } } },
  loc_vars = function(self, info_queue, card)
    info_queue[#info_queue + 1] = G.P_SEALS.Gold
    info_queue[#info_queue + 1] = G.P_CENTERS.m_glass
  end
}

phanta_simple_starter_pack {
  key = "privilegedpack",
  pos = { x = 2, y = 2 },
  config = { starter_cards = {
    { count = 2, enhancement = "m_gold", rank = "King", suit = "Diamonds" },
    { count = 1, seal = "Gold" } } },
  loc_vars = function(self, info_queue, card)
    info_queue[#info_queue + 1] = G.P_CENTERS.m_gold
    info_queue[#info_queue + 1] = G.P_SEALS.Gold
  end
}

phanta_simple_starter_pack {
  key = "pompouspack",
  pos = { x = 3, y = 2 },
  config = { starter_cards = {
    { count = 2, suit = "Diamonds" },
    { count = 2, seal = "Gold",    suit = "Diamonds" } } },
  loc_vars = function(self, info_queue, card)
    info_queue[#info_queue + 1] = G.P_SEALS.Gold
  end
}

phanta_simple_starter_pack {
  key = "piratepack",
  pos = { x = 0, y = 3 },
  config = { starter_cards = {
    { count = 2, enhancement = "m_lucky", rank = "Jack", suit = "Spades" },
    { count = 1, enhancement = "m_gold",  seal = "Blue" } } },
  loc_vars = function(self, info_queue, card)
    info_queue[#info_queue + 1] = G.P_CENTERS.m_lucky
    info_queue[#info_queue + 1] = G.P_CENTERS.m_gold
    info_queue[#info_queue + 1] = G.P_SEALS.Blue
  end
}

phanta_simple_starter_pack {
  key = "punitivepack",
  pos = { x = 1, y = 3 },
  config = { starter_cards = {
    { count = 1, suit = "Spades",         edition = "e_foil", rank = "Queen" },
    { count = 2, enhancement = "m_bonus", seal = "Blue" } } },
  loc_vars = function(self, info_queue, card)
    info_queue[#info_queue + 1] = G.P_CENTERS.e_foil
    info_queue[#info_queue + 1] = G.P_SEALS.Blue
  end
}

phanta_simple_starter_pack {
  key = "presidentpack",
  pos = { x = 2, y = 3 },
  config = { starter_cards = {
    { count = 1, enhancement = "m_steel", suit = "Spades", rank = "King" },
    { count = 2, enhancement = "m_bonus", rank = "King" } } },
  loc_vars = function(self, info_queue, card)
    info_queue[#info_queue + 1] = G.P_CENTERS.m_steel
    info_queue[#info_queue + 1] = G.P_CENTERS.m_bonus
  end
}

phanta_simple_starter_pack {
  key = "pointypack",
  pos = { x = 3, y = 3 },
  config = { starter_cards = {
    { count = 4, edition = "e_foil", suit = "Spades" } } },
  loc_vars = function(self, info_queue, card)
    info_queue[#info_queue + 1] = G.P_CENTERS.e_foil
  end
}










SMODS.Atlas {
  key = "PhantaStarterPacks2",
  path = "PhantaStarterPacks2.png",
  px = 71,
  py = 95
}

phanta_simple_starter_pack {
  key = "paranormalpack",
  pos = { x = 0, y = 0 },
  config = { starter_cards = {
    { count = 2, enhancement = "m_phanta_ghostcard" },
    { count = 1, seal = "phanta_ghostseal" }, } },
  atlas = "PhantaStarterPacks2",
  loc_vars = function(self, info_queue, card)
    info_queue[#info_queue + 1] = G.P_CENTERS.m_phanta_ghostcard
  end
}

phanta_simple_starter_pack {
  key = "potmakerpack",
  pos = { x = 1, y = 0 },
  config = { starter_cards = {
    { count = 2, enhancement = "m_phanta_coppergratefresh" },
    { count = 1, enhancement = "m_phanta_coppergratefresh", edition = "e_phanta_waxed" } } },
  atlas = "PhantaStarterPacks2",
  loc_vars = function(self, info_queue, card)
    --info_queue[#info_queue + 1] = G.P_CENTERS.e_phanta_waxed
    info_queue[#info_queue + 1] = G.P_CENTERS.m_phanta_coppergratefresh
  end
}

phanta_simple_starter_pack {
  key = "plinthmakerpack",
  pos = { x = 2, y = 0 },
  config = { starter_cards = { { count = 3, enhancement = "m_phanta_marblecard" } } },
  atlas = "PhantaStarterPacks2",
  loc_vars = function(self, info_queue, card)
    info_queue[#info_queue + 1] = G.P_CENTERS.m_phanta_marblecard
  end
}






local context_ref = SMODS.calculate_context

function SMODS.calculate_context(context, return_table)
  G.GAME.PhantaStarterPacks = G.GAME.PhantaStarterPacks or {}

  if G.GAME.last_blind and G.GAME.last_blind.boss then
    G.GAME.PhantaStarterPacks.purchased_this_ante = false
    G.GAME.PhantaStarterPacks.ante_pack = nil
  end

  if context and context.starting_shop and Phanta.config["starter_pack_enabled"] and not G.GAME.PhantaStarterPacks.purchased_this_ante and G.shop_booster then
    local key = pseudorandom_element(G.P_CENTER_POOLS.phanta_StarterPack,
      pseudoseed("shopstarter" .. G.GAME.round_resets.ante)).key
    if G.GAME.PhantaStarterPacks.ante_pack ~= nil then
      key = G.GAME.PhantaStarterPacks.ante_pack
    end
    G.GAME.PhantaStarterPacks.ante_pack = key
    local card = SMODS.create_card { key = key, area = G.shop_booster, bypass_discovery_center = true, bypass_discovery_ui = true }
    card["shop_booster"] = true
    G.shop_booster:emplace(card)
    phanta_create_shop_starter_pack_ui(card)
  end
  return context_ref(context, return_table)
end

function phanta_create_shop_starter_pack_ui(card)
  G.E_MANAGER:add_event(Event({
    trigger = "after",
    delay = 0.43,
    blocking = false,
    blockable = false,
    func = (function()
      if card.opening then return true end
      local t1 = {
        n = G.UIT.ROOT,
        config = { minw = 0.6, align = "tm", colour = darken(G.C.BLACK, 0.2), shadow = true, r = 0.05, padding = 0.05, minh = 1 },
        nodes = {
          {
            n = G.UIT.R,
            config = { align = "cm", colour = lighten(G.C.BLACK, 0.1), r = 0.1, minw = 1, minh = 0.55, emboss = 0.05, padding = 0.03 },
            nodes = {
              { n = G.UIT.O, config = { object = DynaText({ string = { { prefix = localize("$"), ref_table = card, ref_value = "cost" } }, colours = { G.C.MONEY }, shadow = true, silent = true, bump = true, pop_in = 0, scale = 0.5 }) } },
            }
          }
        }
      }
      local t2 = {
        n = G.UIT.ROOT,
        config = { id = "buy_and_use", ref_table = card, minw = 1.1, maxw = 1.3, padding = 0.1, align = "bm", colour = G.C.GREEN, shadow = true, r = 0.08, minh = 0.94, func = "phanta_can_open_starter_pack", one_press = true, button = "buy_from_shop", hover = true },
        nodes = {
          { n = G.UIT.T, config = { text = localize("b_open"), colour = G.C.WHITE, scale = 0.5 } }
        }
      }

      card.children.price = UIBox {
        definition = t1,
        config = {
          align = "tm",
          offset = { x = 0, y = 1.5 },
          major = card,
          bond = "Weak",
          parent = card
        }
      }

      card.children.buy_button = UIBox {
        definition = t2,
        config = {
          align = "bm",
          offset = { x = 0, y = -0.3 },
          major = card,
          bond = "Weak",
          parent = card
        }
      }

      card.children.price.alignment.offset.y = 0.5

      return true
    end)
  }))
end

G.FUNCS.phanta_can_open_starter_pack = function(e)
  local ret = G.FUNCS.can_buy_and_use(e)
  if e.config.colour == G.C.SECONDARY_SET.Voucher then
    e.config.colour = G.C.GREEN
  end
  return ret
end

SMODS.Joker:take_ownership("j_hologram", {
  config = { extra = 0.25, extra_if_starters = 0.2, Xmult = 1 },
  loc_vars = function(self, info_queue, card)
    return { vars = { Phanta.config["starter_pack_enabled"] and card.ability.extra_if_starters or card.ability.extra, card.ability.Xmult } }
  end,
  calculate = function(self, card, context)
    if context.playing_card_added and not context.blueprint then
      card.ability.Xmult = card.ability.Xmult +
          #context.cards *
          (Phanta.config["starter_pack_enabled"] and card.ability.extra_if_starters or card.ability.extra)
      return { message = localize { type = "variable", key = "a_xmult", vars = { card.ability.Xmult } }, }
    end
    if context.joker_main then return { Xmult = card.ability.Xmult } end
  end
}, true)
