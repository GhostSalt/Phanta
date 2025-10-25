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
  path = "PhantaStarterPacks1.png",
  pos = { x = 4, y = 0 },
  px = 71,
  py = 95,
}):register()

local game_start_run_ref = Game.start_run

function Game:start_run(args)
  game_start_run_ref(self, args)
  for k, v in pairs(G.P_CENTERS) do
    if v.set == "phanta_StarterPack" then
      local card = v

      v.can_use = function()
        return true
      end

      v.use = function()
        local all_cards = {}

        for i = 1, #v.config.starter_cards do
          for j = 0, (v.config.starter_cards[i].count or 1) - 1 do
            local rank = v.config.starter_cards[i].rank
            if rank == "Face" then
              rank = pseudorandom_element({ "Jack", "Queen", "King" },
                pseudoseed('starter_pack_' .. i))
            end

            all_cards[#all_cards + 1] = SMODS.create_card { set = "Base", area = G.discard,
              enhancement = v.config.starter_cards[i].enhancement, seal = v.config.starter_cards[i].seal, edition = v.config.starter_cards[i].edition, rank = rank, suit = v.config.starter_cards[i].suit }
            G.playing_card = (G.playing_card and G.playing_card + 1) or 1
            all_cards[#all_cards].playing_card = G.playing_card
            table.insert(G.playing_cards, all_cards[#all_cards])

            local new_card = all_cards[#all_cards]

            G.E_MANAGER:add_event(Event({
              func = function()
                new_card:start_materialize({ G.C.SECONDARY_SET.Enhanced })
                G.play:emplace(new_card)
                all_cards[i]:add_to_deck()
                return true
              end
            }))
            G.E_MANAGER:add_event(Event({
              func = function()
                G.deck.config.card_limit = G.deck.config.card_limit + 1
                return true
              end
            }))
            G.E_MANAGER:add_event(Event({
              func = function()
                delay(0.75)
                return true
              end
            }))
          end
        end


        for i = #all_cards, 1, -1 do
          G.E_MANAGER:add_event(Event({
            func = function()
              draw_card(G.play, G.deck, 90, 'up', nil, all_cards[i])
              SMODS.calculate_context({ playing_card_added = true, cards = { all_cards[i] } })
              delay(0.25)
              return true
            end
          }))
        end
      end

      v.add_to_deck = function()
        G.GAME.PhantaStarterPacks = G.GAME.PhantaStarterPacks or {}
        G.GAME.PhantaStarterPacks.purchased_this_ante = true
        G.GAME.PhantaStarterPacks.ante_pack = nil
      end

      v.draw = function(self, card, layer)
        card.children.center:draw_shader('booster', nil, card.ARGS.send_to_shader)
      end

      v.display_size = { w = 1.27 * 71, h = 1.27 * 95 }
      v.mouse_damping = 1.5
    end
  end
end

SMODS.Consumable {
  set = "phanta_StarterPack",
  key = "performerpack",
  pos = { x = 0, y = 0 },
  cost = 8,
  config = { starter_cards = {
    { count = 1, enhancement = "m_mult", rank = "Jack",  suit = "Hearts" },
    { count = 1, rank = "2",             suit = "Hearts" },
    { count = 1, rank = "3",             suit = "Hearts" },
    { count = 1, rank = "4",             suit = "Hearts" },
    { count = 1, rank = "5",             suit = "Hearts" } } },
  atlas = "PhantaStarterPacks1",
  loc_vars = function(self, info_queue, card)
    info_queue[#info_queue + 1] = G.P_CENTERS.m_mult
  end
}

SMODS.Consumable {
  set = "phanta_StarterPack",
  key = "polyculepack",
  pos = { x = 1, y = 0 },
  cost = 8,
  config = { starter_cards = {
    { count = 1, rank = "Queen", suit = "Hearts" },
    { count = 3, rank = "Queen" },
    { count = 1, rank = "Ace",   suit = "Hearts" } } },
  atlas = "PhantaStarterPacks1"
}

SMODS.Consumable {
  set = "phanta_StarterPack",
  key = "powerhousepack",
  pos = { x = 2, y = 0 },
  cost = 8,
  config = { starter_cards = {
    { count = 1, enhancement = "m_steel", seal = "Red", rank = "King", suit = "Hearts" },
    { count = 3 } } },
  atlas = "PhantaStarterPacks1",
  loc_vars = function(self, info_queue, card)
    info_queue[#info_queue + 1] = G.P_SEALS["Red"]
  end
}

SMODS.Consumable {
  set = "phanta_StarterPack",
  key = "passionatepack",
  pos = { x = 3, y = 0 },
  cost = 8,
  config = { starter_cards = {
    { count = 2, suit = "Hearts" },
    { count = 1, edition = "e_polychrome", suit = "Hearts" },
    { count = 2, enhancement = "m_stone" } } },
  atlas = "PhantaStarterPacks1",
  loc_vars = function(self, info_queue, card)
    info_queue[#info_queue + 1] = G.P_CENTERS.e_polychrome
    info_queue[#info_queue + 1] = G.P_CENTERS.m_stone
  end
}

SMODS.Consumable {
  set = "phanta_StarterPack",
  key = "plentifulpack",
  pos = { x = 0, y = 1 },
  cost = 8,
  config = { starter_cards = {
    { count = 2, suit = "Clubs",         rank = "Jack" },
    { count = 1, enhancement = "m_steel" },
    { count = 1, enhancement = "m_gold" },
    { count = 1, enhancement = "m_glass" } } },
  atlas = "PhantaStarterPacks1",
  loc_vars = function(self, info_queue, card)
    info_queue[#info_queue + 1] = G.P_CENTERS.m_steel
    info_queue[#info_queue + 1] = G.P_CENTERS.m_gold
    info_queue[#info_queue + 1] = G.P_CENTERS.m_glass
  end
}

SMODS.Consumable {
  set = "phanta_StarterPack",
  key = "plazapack",
  pos = { x = 1, y = 1 },
  cost = 8,
  config = { starter_cards = {
    { count = 1, enhancement = "m_bonus", suit = "Clubs", rank = "Queen" },
    { count = 3, rank = "Face" } } },
  atlas = "PhantaStarterPacks1",
  loc_vars = function(self, info_queue, card)
    info_queue[#info_queue + 1] = G.P_CENTERS.m_glass
    info_queue[#info_queue + 1] = G.P_CENTERS.m_stone
  end
}

SMODS.Consumable {
  set = "phanta_StarterPack",
  key = "palacepack",
  pos = { x = 2, y = 1 },
  cost = 8,
  config = { starter_cards = {
    { count = 2, enhancement = "m_glass", suit = "Clubs", rank = "King" },
    { count = 3, enhancement = "m_stone", suit = "Clubs" } } },
  atlas = "PhantaStarterPacks1",
  loc_vars = function(self, info_queue, card)
    info_queue[#info_queue + 1] = G.P_CENTERS.m_glass
    info_queue[#info_queue + 1] = G.P_CENTERS.m_stone
  end
}

SMODS.Consumable {
  set = "phanta_StarterPack",
  key = "partypack",
  pos = { x = 3, y = 1 },
  cost = 8,
  config = { starter_cards = {
    { count = 4, suit = "Clubs" },
    { count = 1, edition = "e_holo", suit = "Clubs" } } },
  atlas = "PhantaStarterPacks1",
  loc_vars = function(self, info_queue, card)
    info_queue[#info_queue + 1] = G.P_CENTERS.e_holo
  end
}

SMODS.Consumable {
  set = "phanta_StarterPack",
  key = "pilfererpack",
  pos = { x = 0, y = 2 },
  cost = 8,
  config = { starter_cards = {
    { count = 2, enhancement = "m_mult", rank = "Jack", suit = "Diamonds" },
    { count = 1, seal = "Purple",        rank = "Jack" },
    { count = 1, rank = "Queen" } } },
  atlas = "PhantaStarterPacks1",
  loc_vars = function(self, info_queue, card)
    info_queue[#info_queue + 1] = G.P_CENTERS.m_mult
    info_queue[#info_queue + 1] = G.P_SEALS["Purple"]
  end
}

SMODS.Consumable {
  set = "phanta_StarterPack",
  key = "prettypack",
  pos = { x = 1, y = 2 },
  cost = 8,
  config = { starter_cards = {
    { count = 2, enhancement = "m_bonus", rank = "Queen", suit = "Diamonds" },
    { count = 1, seal = "Blue",           rank = "Queen" },
    { count = 1, rank = "Jack" } } },
  atlas = "PhantaStarterPacks1",
  loc_vars = function(self, info_queue, card)
    info_queue[#info_queue + 1] = G.P_CENTERS.m_bonus
    info_queue[#info_queue + 1] = G.P_SEALS["Blue"]
  end
}

SMODS.Consumable {
  set = "phanta_StarterPack",
  key = "privilegedpack",
  pos = { x = 2, y = 2 },
  cost = 8,
  config = { starter_cards = {
    { count = 2, enhancement = "m_gold", rank = "King", suit = "Diamonds" },
    { count = 3, enhancement = "m_glass" } } },
  atlas = "PhantaStarterPacks1",
  loc_vars = function(self, info_queue, card)
    info_queue[#info_queue + 1] = G.P_CENTERS.m_gold
    info_queue[#info_queue + 1] = G.P_CENTERS.m_glass
  end
}

SMODS.Consumable {
  set = "phanta_StarterPack",
  key = "pompouspack",
  pos = { x = 3, y = 2 },
  cost = 8,
  config = { starter_cards = {
    { count = 3, suit = "Diamonds" },
    { count = 2, seal = "Gold",    suit = "Diamonds" } } },
  atlas = "PhantaStarterPacks1",
  loc_vars = function(self, info_queue, card)
    info_queue[#info_queue + 1] = G.P_SEALS["Gold"]
  end
}

SMODS.Consumable {
  set = "phanta_StarterPack",
  key = "piratepack",
  pos = { x = 0, y = 3 },
  cost = 8,
  config = { starter_cards = {
    { count = 2, enhancement = "m_lucky", rank = "Jack", suit = "Spades" },
    { count = 1, enhancement = "m_gold",  rank = "Ace",  suit = "Diamonds" },
    { count = 1, enhancement = "m_steel", rank = "King", suit = "Spades" } } },
  atlas = "PhantaStarterPacks1",
  loc_vars = function(self, info_queue, card)
    info_queue[#info_queue + 1] = G.P_CENTERS.m_lucky
    info_queue[#info_queue + 1] = G.P_CENTERS.m_gold
    info_queue[#info_queue + 1] = G.P_CENTERS.m_steel
  end
}

SMODS.Consumable {
  set = "phanta_StarterPack",
  key = "punitivepack",
  pos = { x = 1, y = 3 },
  cost = 8,
  config = { starter_cards = {
    { count = 2, suit = "Spades", edition = "e_foil", rank = "Queen" },
    { count = 3 } } },
  atlas = "PhantaStarterPacks1",
  loc_vars = function(self, info_queue, card)
    info_queue[#info_queue + 1] = G.P_CENTERS.e_foil
  end
}

SMODS.Consumable {
  set = "phanta_StarterPack",
  key = "presidentpack",
  pos = { x = 2, y = 3 },
  cost = 8,
  config = { starter_cards = {
    { count = 2, suit = "Spades", rank = "King" },
    { count = 2, rank = "King" } } },
  atlas = "PhantaStarterPacks1"
}

SMODS.Consumable {
  set = "phanta_StarterPack",
  key = "pointypack",
  pos = { x = 3, y = 3 },
  cost = 8,
  config = { starter_cards = {
    { count = 4, suit = "Spades" },
    { count = 1, edition = "e_foil", suit = "Spades" } } },
  atlas = "PhantaStarterPacks1",
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

SMODS.Consumable {
  set = "phanta_StarterPack",
  key = "paranormalpack",
  pos = { x = 0, y = 0 },
  cost = 8,
  config = { starter_cards = {
    { count = 3, enhancement = "m_phanta_ghostcard" },
    { count = 1, seal = "phanta_ghostseal" }, } },
  atlas = "PhantaStarterPacks2",
  loc_vars = function(self, info_queue, card)
    info_queue[#info_queue + 1] = G.P_CENTERS.m_phanta_ghostcard
    info_queue[#info_queue + 1] = G.P_SEALS["phanta_ghostseal"]
  end
}

SMODS.Consumable {
  set = "phanta_StarterPack",
  key = "potmakerpack",
  pos = { x = 1, y = 0 },
  cost = 8,
  config = { starter_cards = {
    { count = 1, enhancement = "m_phanta_coppergratefresh", edition = "e_phanta_waxed" },
    { count = 3, enhancement = "m_phanta_coppergratefresh" } } },
  atlas = "PhantaStarterPacks2",
  loc_vars = function(self, info_queue, card)
    info_queue[#info_queue + 1] = G.P_CENTERS.e_phanta_waxed
    info_queue[#info_queue + 1] = G.P_CENTERS.m_phanta_coppergratefresh
  end
}

SMODS.Consumable {
  set = "phanta_StarterPack",
  key = "plinthmakerpack",
  pos = { x = 2, y = 0 },
  cost = 8,
  config = { starter_cards = { { count = 4, enhancement = "m_phanta_marblecard" } } },
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

  if context and context.starting_shop and Phanta.config["starter_pack_enabled"] and not G.GAME.PhantaStarterPacks.purchased_this_ante then
    local key = pseudorandom_element(G.P_CENTER_POOLS.phanta_StarterPack,
      pseudoseed('shopstarter' .. G.GAME.round_resets.ante)).key
    if G.GAME.PhantaStarterPacks.ante_pack ~= nil then
      key = G.GAME.PhantaStarterPacks.ante_pack
    end
    G.GAME.PhantaStarterPacks.ante_pack = key
    local card = SMODS.create_card { key = key, area = G.shop_booster, bypass_discovery_center = true, bypass_discovery_ui = true }
    card["shop_booster"] = true
    G.shop_booster:emplace(card)
    create_shop_card_ui(card)
  end
  return context_ref(context, return_table)
end

SMODS.Joker:take_ownership("j_hologram", {
  config = { extra = 0.25, extra_if_starters = 0.2, Xmult = 1 },
  loc_vars = function(self, info_queue, card)
    return { vars = { Phanta.config["starter_pack_enabled"] and card.ability.extra_if_starters or card.ability.extra, card.ability.Xmult } }
  end,
  calculate = function(self, card, context)
    if context.playing_card_added and not context.blueprint then
      card.ability.Xmult = card.ability.Xmult + #context.cards * (Phanta.config["starter_pack_enabled"] and card.ability.extra_if_starters or card.ability.extra)
      return { message = localize { type = 'variable', key = 'a_xmult', vars = { card.ability.Xmult } }, }
    end
    if context.joker_main then return { Xmult = card.ability.Xmult } end
  end
}, true)
