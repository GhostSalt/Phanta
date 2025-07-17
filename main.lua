SMODS.Atlas {
  key = "modicon",
  path = "PhantaIcon.png",
  px = 34,
  py = 34
}

G.C.PHANTA = {
  Zodiac = HEX("4E5779"),
  ZodiacAlt = HEX("5998ff"),
  Resource = HEX("AB8B59")
}

G.C.PHANTA.MISC_COLOURS = {
  COPPER_FRESH = HEX("904931"),
  COPPER_EXPOSED = HEX("A77762"),
  COPPER_WEATHERED = HEX("838A67"),
  COPPER_OXIDISED = HEX("4FAB90"),
  PHANTA = HEX("4d1575"),
}

local loc_colour_ref = loc_colour

function loc_colour(_c, default)
  if not G.ARGS.LOC_COLOURS then
    loc_colour_ref(_c, default)
  elseif not G.ARGS.LOC_COLOURS.phanta_colours then
    G.ARGS.LOC_COLOURS.phanta_colours = true

    local new_colors = {
      copper_fresh = G.C.COPPER_FRESH,
      copper_exposed = G.C.COPPER_EXPOSED,
      copper_weathered = G.C.COPPER_WEATHERED,
      copper_oxidised = G.C.COPPER_OXIDISED
    }

    for k, v in pairs(new_colors) do
      G.ARGS.LOC_COLOURS[k] = v
    end
  end

  return loc_colour_ref(_c, default)
end

function count_tarots()
  local tarot_counter = 0
  if G.consumeables then
    for _, card in pairs(G.consumeables.cards) do
      if card.ability.set == "Tarot" then
        tarot_counter = tarot_counter + 1
      end
    end
  end
  return tarot_counter
end

function count_planets()
  local planet_counter = 0
  if G.consumeables then
    for _, card in pairs(G.consumeables.cards) do
      if card.ability.set == "Planet" then
        planet_counter = planet_counter + 1
      end
    end
  end
  return planet_counter
end

function get_lowest(hand)
  local lowest = nil
  for k, v in ipairs(hand) do
    if not lowest or v:get_nominal() < lowest:get_nominal() then
      lowest = v
    end
  end
  if #hand > 0 then return { { lowest } } else return {} end
end

function count_prognosticators(card)
  return #SMODS.find_card("j_phanta_prognosticator") +
      (G.GAME.selected_sleeve == "sleeve_phanta_todayandtomorrow" and 1 or 0) +
      ((is_current_month(card) and 2 or 0) * #SMODS.find_card("j_phanta_calendar")) +
      (G.GAME and G.GAME.selected_back and G.GAME.selected_back and G.GAME.selected_back.effect and G.GAME.selected_back.effect.center.key == "b_phanta_todayandtomorrow" and 1 or 0)
end

function count_lucky_cards()
  local lucky_counter = 0
  if G.playing_cards then
    for _, card in pairs(G.playing_cards) do
      if SMODS.has_enhancement(card, "m_lucky") then
        lucky_counter = lucky_counter + 1
      end
    end
  end
  return lucky_counter
end

function get_previous_blind()
  if G.GAME.last_blind then
    if G.GAME.last_blind.boss then
      return "boss"
    elseif G.GAME.last_blind.big then
      return "big"
    end
  else
    return "small"
  end
end

function count_common_jokers()
  if G.jokers then
    local counter = 0
    for i = 1, #G.jokers.cards do
      if G.jokers.cards[i].config.center.rarity == 1 then counter = counter + 1 end
    end
    return counter
  else
    return 0
  end
end

function count_consumables()
  if G.consumeables.get_total_count then
    return G.consumeables:get_total_count()
  else
    return #G.consumeables.cards + G.GAME.consumeable_buffer
  end
end

function find_consumable(key)
  local found = {}
  if G.consumeables then
    for _, card in pairs(G.consumeables.cards) do
      if card.config.center.key == key then
        found[#found + 1] = card
      end
    end
  end
  return found
end

function count_rank(rank)
  local cards = {}
  if G.playing_cards then
    for i = 1, #G.playing_cards do
      if not SMODS.has_no_rank(G.playing_cards[i]) and G.playing_cards[i]:get_id() == rank then
        cards[#cards + 1] = G.playing_cards[i]
      end
    end
  end
  return cards
end

function is_current_month(card)
  if not card or not card.config or not card.config.center or not card.config.center.month_range then return false end

  local card_range = card.config.center.month_range
  if card_range.first.month < 0 or card_range.first.month > 12 or card_range.first.day < 0 or card_range.first.day > 31 then return false end
  if card_range.last.month < 0 or card_range.last.month > 12 or card_range.last.day < 0 or card_range.last.day > 31 then return false end
  -- Technically, it's possible to have dates like the 31st of February be valid, but those should work fine anyway.

  local t = os.date("*t", os.time())

  -- Commenting because I need to think aloud, to grasp this. Also, hi!
  -- If the range doesn't wrap around (f <= l), then we can check if the date is <= l, AND >= f.
  -- If the range does wrap around (f > l), then we can check if the date is <= l, OR >= f.
  -- This works regardless of loopover. Examples:

  --  . . F - - a - - L . b .
  --  a comes after F, and before L, so it is in the range.
  --  b comes after F, but does not come before L, so it is not in the range.

  --  - a - L . . c . . F b -
  --  a does not come after F, but it does come before L, so it is in the range.
  --  b comes after F (and does not come before L, but irrelevant), so it is in the range.
  --  c does not come after F, and does not come before L, so it is not in the range.

  if orderify_date(card_range.first) <= orderify_date(card_range.last) then
    return orderify_date(t) >= orderify_date(card_range.first) and orderify_date(t) <= orderify_date(card_range.last)
  else
    return orderify_date(t) >= orderify_date(card_range.first) or orderify_date(t) <= orderify_date(card_range.last)
  end
end

function orderify_date(date) -- Used above, for convenience.
  return (date.month * 100) + date.day
end

function find_current_zodiacs()
  local matches = {}
  for i, j in pairs(G.P_CENTER_POOLS.phanta_Zodiac) do
    if is_current_month({ config = { center = j } }) then matches[#matches + 1] = { config = { center = j } } end -- Cursed solution, but works.
  end
  return matches
end

function get_names_from_zodiacs(cards)
  local names = {}
  for i = 1, #cards do
    names[#names + 1] = localize { type = 'name_text', set = 'phanta_Zodiac', key = cards[i].config.center.key }
  end
  return names
end

function count_steel_kings()
  local kings = {}
  if G.playing_cards then
    for i = 1, #G.playing_cards do
      if SMODS.has_enhancement(G.playing_cards[i], 'm_steel') and G.playing_cards[i]:get_id() == 13 then
        kings[#kings + 1] = G.playing_cards[i]
      end
    end
  end
  return kings
end

function is_blind_small()
  return G.GAME.blind and G.GAME.blind:get_type() == 'Small'
end

function is_blind_big()
  return G.GAME.blind and G.GAME.blind:get_type() == 'Big'
end

function is_blind_boss()
  return G.GAME.blind and G.GAME.blind:get_type() == 'Boss'
end

function count_missing_ranks()
  if not G.playing_cards then return 0 end
  local existing_ranks = {}
  for i, j in pairs(G.playing_cards) do
    local is_valid = true
    for rank = 1, #existing_ranks do
      if j:get_id() == existing_ranks[rank] then is_valid = false end
    end
    if is_valid then existing_ranks[#existing_ranks + 1] = j:get_id() end
  end

  if #existing_ranks < #G.GAME.phanta_initial_ranks then return #G.GAME.phanta_initial_ranks - #existing_ranks end
  return 0
end

function count_base_copper_grates()
  if not G.playing_cards then return {} end
  local grates = {}
  for i, j in pairs(G.playing_cards) do
    if (SMODS.has_enhancement(j, 'm_phanta_coppergratefresh')
          or SMODS.has_enhancement(j, 'm_phanta_coppergrateexposed')
          or SMODS.has_enhancement(j, 'm_phanta_coppergrateweathered')
          or SMODS.has_enhancement(j, 'm_phanta_coppergrateoxidised'))
        and not (j.edition and j.edition.key ~= nil) then
      grates[#grates + 1] = j
    end
  end

  return grates
end

function count_unique_tarots()
  local tarots_used = 0
  if G.GAME and G.GAME.consumeable_usage then
    for k, v in pairs(G.GAME.consumeable_usage) do if v.set == 'Tarot' then tarots_used = tarots_used + 1 end end
  end

  return tarots_used
end

function count_unique_planets()
  local planets_used = 0
  if G.GAME and G.GAME.consumeable_usage then
    for k, v in pairs(G.GAME.consumeable_usage) do if v.set == 'Planet' then planets_used = planets_used + 1 end end
  end

  return planets_used
end

function azran_active()
  return G.GAME.selected_back.effect.center.key == "b_phanta_azran" or (G.GAME and G.GAME.selected_sleeve == "sleeve_phanta_azran")
end

local ref1 = Card.start_dissolve
function Card:start_dissolve()
  if self.config and self.config.center and self.config.center.phanta_shatters then
    return self:shatter()
  else
    return ref1(self)
  end
end

local allFolders = { "none", "items" }

local allFiles = { ["none"] = {}, ["items"] = { "Jokers1", "Jokers2", "Legendaries", "Misc", "Catan", "StarterPack" } }

for i = 1, #allFolders do
  if allFolders[i] == "none" then
    for j = 1, #allFiles[allFolders[i]] do
      assert(SMODS.load_file(allFiles[allFolders[i]][j] .. ".lua"))()
    end
  else
    for j = 1, #allFiles[allFolders[i]] do
      assert(SMODS.load_file(allFolders[i] .. "/" .. allFiles[allFolders[i]][j] .. ".lua"))()
    end
  end
end

if next(SMODS.find_mod('Bakery')) then assert(SMODS.load_file("items/Charm.lua"))() end
if next(SMODS.find_mod('partner')) then assert(SMODS.load_file("items/Partners.lua"))() end
if next(SMODS.find_mod('CardSleeves')) then assert(SMODS.load_file("items/Sleeves.lua"))() end
if next(SMODS.find_mod('artbox')) then assert(SMODS.load_file("items/ArtBox.lua"))() end
local aura_enabled = next(SMODS.find_mod('Aura'))

local game_start_run_ref = Game.start_run

function Game:start_run(args)
  game_start_run_ref(self, args)
  G.E_MANAGER:add_event(Event({
    func = function()
      if not G.playing_cards then return false end
      local existing_ranks = {}
      for i, j in pairs(G.playing_cards) do
        local is_valid = true
        for _, rank in ipairs(existing_ranks) do
          if j:get_id() == rank then is_valid = false end
        end
        if is_valid then existing_ranks[#existing_ranks + 1] = j:get_id() end
      end
      G.GAME.phanta_initial_ranks = existing_ranks
      return true
    end
  }))
end

local cfbs = G.FUNCS.check_for_buy_space

G.FUNCS.check_for_buy_space = function(card)
  if card.config.center.set == "phanta_CatanResource" then return true end
  return cfbs(card)
end

local igo = Game.init_game_object
function Game:init_game_object()
  local ret = igo(self)
  ret.current_round.train_station_card = { id = nil, value = nil }
  ret.current_round.fainfol_card = { suit = 'Spades' }
  ret.current_round.puzzle_card = { id = nil }
  return ret
end

function SMODS.current_mod.reset_game_globals(run_start)
  G.GAME.current_round.fainfol_card = { suit = 'Spades' }
  local valid_cards = {}
  for i, j in ipairs(G.playing_cards) do
    if not SMODS.has_no_suit(j) then
      valid_cards[#valid_cards + 1] = j
    end
  end
  if valid_cards[1] then
    local chosen_card = pseudorandom_element(valid_cards, pseudoseed('fainfol' .. G.GAME.round_resets.ante))
    G.GAME.current_round.fainfol_card.suit = chosen_card.base.suit
  end
  if not G.GAME.current_round.train_station_card.id then
    G.GAME.current_round.train_station_card.id = 2
  elseif G.GAME.current_round.train_station_card.id == 14 then
    G.GAME.current_round.train_station_card.id = 2
  else
    G.GAME.current_round.train_station_card.id = G.GAME.current_round.train_station_card.id + 1
  end

  local value_table = { '2', '3', '4', '5', '6', '7', '8', '9', '10', 'Jack', 'Queen', 'King', 'Ace' }
  G.GAME.current_round.train_station_card.value = value_table[G.GAME.current_round.train_station_card.id - 1]

  if G.playing_cards then
    G.GAME.current_round.puzzle_card.id = pseudorandom_element(G.playing_cards,
      pseudoseed('puzzle' .. G.GAME.round_resets.ante)):get_id()
  else
    G.GAME.current_round.puzzle_card.id = 2
  end
end

if not Phanta then Phanta = {} end
Phanta.config = SMODS.current_mod.config

local phantaConfigTab = function()
  phanta_nodes = {
  }
  config = { n = G.UIT.R, config = { align = "tm", padding = 0 }, nodes = { { n = G.UIT.C, config = { align = "tm", padding = 0.05 }, nodes = {} } } }
  phanta_nodes[#phanta_nodes + 1] = config
  phanta_nodes[#phanta_nodes + 1] = create_toggle({
    label = localize("phanta_junk_enabled"),
    active_colour = HEX("40c76d"),
    ref_table = Phanta.config,
    ref_value = "junk_enabled",
    callback = function()
    end,
  })
  phanta_nodes[#phanta_nodes + 1] = create_toggle({
    label = localize("phanta_zodiac_enabled"),
    active_colour = HEX("40c76d"),
    ref_table = Phanta.config,
    ref_value = "zodiac_enabled",
    callback = function()
    end,
  })
  phanta_nodes[#phanta_nodes + 1] = create_toggle({
    label = localize("phanta_catan_enabled"),
    active_colour = HEX("40c76d"),
    ref_table = Phanta.config,
    ref_value = "catan_enabled",
    callback = function()
    end,
  })
  phanta_nodes[#phanta_nodes + 1] = create_toggle({
    label = localize("phanta_starter_pack_enabled"),
    active_colour = HEX("40c76d"),
    ref_table = Phanta.config,
    ref_value = "starter_pack_enabled",
    callback = function()
    end,
  })
  return {
    n = G.UIT.ROOT,
    config = {
      emboss = 0.05,
      minh = 6,
      r = 0.1,
      minw = 10,
      align = "cm",
      padding = 0.2,
      colour = G.C.BLACK,
    },
    nodes = phanta_nodes,
  }
end

local update_ref = Game.update
function Game:update(dt)
  if not G.GAME.phanta_zodiac_rate_cache then G.GAME.phanta_zodiac_rate_cache = 0 end
  if not G.GAME.phanta_catanresource_rate_cache then G.GAME.phanta_catanresource_rate_cache = 0 end
  if not G.GAME.phanta_catandevelopmentcard_rate_cache then G.GAME.phanta_catandevelopmentcard_rate_cache = 0 end
  if not G.GAME.phanta_catanbuilding_rate_cache then G.GAME.phanta_catanbuilding_rate_cache = 0 end

  if Phanta.config["zodiac_enabled"] then
    G.GAME.phanta_zodiac_rate = G.GAME.phanta_zodiac_rate_cache
  else
    G.GAME.phanta_zodiac_rate = 0
  end

  if Phanta.config["catan_enabled"] then
    G.GAME.phanta_catanresource_rate = G.GAME.phanta_catanresource_rate_cache
    G.GAME.phanta_catandevelopmentcard_rate = G.GAME.phanta_catandevelopmentcard_rate_cache
    G.GAME.phanta_catanbuilding_rate = G.GAME.phanta_catanbuilding_rate_cache
  else
    G.GAME.phanta_catanresource_rate = 0
    G.GAME.phanta_catandevelopmentcard_rate = 0
    G.GAME.phanta_catanbuilding_rate = 0
  end


  for k, v in pairs(G.P_CENTERS) do
    if v.phanta_anim and (not v.phanta_requires_aura or aura_enabled) then
      v.phanta_anim = format_phanta_anim(v.phanta_anim)
      if not v.phanta_anim.t then v.phanta_anim.t = 0 end
      if not v.phanta_anim.length then
        v.phanta_anim.length = 0
        for _, frame in ipairs(v.phanta_anim) do
          v.phanta_anim.length = v.phanta_anim.length + (frame.t or 0)
        end
      end
      v.phanta_anim.t = (v.phanta_anim.t + dt) % v.phanta_anim.length
      local ix = 0
      local t_tally = 0
      for _, frame in ipairs(v.phanta_anim) do
        ix = ix + 1
        t_tally = t_tally + frame.t
        if t_tally > v.phanta_anim.t then break end
      end
      v.pos.x = v.phanta_anim[ix].x
      v.pos.y = v.phanta_anim[ix].y
    end
  end


  return update_ref(self, dt)
end

function format_phanta_anim(anim)
  if not anim then return {} end
  local new_anim = {}
  for _, frame in ipairs(anim) do
    if frame and (frame.x or (frame.xrange and frame.xrange.first and frame.xrange.last)) and (frame.y or (frame.yrange and frame.yrange.first and frame.yrange.last)) then
      local firsty = frame.y or frame.yrange.first
      local lasty = frame.y or frame.yrange.last
      for y = firsty, lasty do
        local firstx = frame.x or frame.xrange.first
        local lastx = frame.x or frame.xrange.last
        for x = firstx, lastx do
          new_anim[#new_anim + 1] = { x = x, y = y, t = frame.t or 0 }
        end
      end
    end
  end
  new_anim.t = anim.t
  return new_anim
end

SMODS.current_mod.extra_tabs = function()
  return {
    {
      label = 'Credits',
      tab_definition_function = function()
        return {
          n = G.UIT.ROOT,
          config = {
            emboss = 0.05,
            minh = 6,
            r = 0.1,
            minw = 10,
            align = "cm",
            padding = 0.2,
            colour = G.C.BLACK,
          },
          nodes = {
            {
              n = G.UIT.C,
              config = { align = "cm" },
              nodes = {
                {
                  n = G.UIT.R,
                  config = { align = "cm", padding = 0.05 },
                  nodes = {
                    { n = G.UIT.T, config = { text = localize("phanta_credit_1"), colour = G.C.UI.TEXT_LIGHT, scale = 0.5 } } }
                },
                {
                  n = G.UIT.R,
                  config = { align = "cm", padding = 0.05 },
                  nodes = {
                    { n = G.UIT.T, config = { text = localize("phanta_credit_2"), colour = G.C.UI.TEXT_LIGHT, scale = 0.4 } } }
                },
                {
                  n = G.UIT.R,
                  config = { align = "cm", padding = 0.05 },
                  nodes = {
                    { n = G.UIT.T, config = { text = localize("phanta_credit_3"), colour = G.C.UI.TEXT_LIGHT, scale = 0.4 } } }
                }
              }
            }
          }
        }
      end,
    }
  }
end

SMODS.current_mod.config_tab = phantaConfigTab
