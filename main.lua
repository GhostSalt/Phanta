G.Phanta = {}
G.Phanta.centers = {}
G.Phanta.profile_cost = 20 -- Eventually move this to be card-based, so the value can be modified.

G.C.PHANTA = {
  Zodiac = HEX("4E5779"),
  ZodiacAlt = HEX("5998ff"),
  Hanafuda = HEX("DB534A"),
  HanafudaAlt = HEX("FB8536")
}

G.C.PHANTA.MISC_COLOURS = {
  COPPER_FRESH = HEX("904931"),
  COPPER_EXPOSED = HEX("A77762"),
  COPPER_WEATHERED = HEX("838A67"),
  COPPER_OXIDISED = HEX("4FAB90"),
  PHANTA = HEX("4d1575"),
  PHANTA_MAIN_MENU_PRIMARY = HEX("4B96A0"),
  PHANTA_MAIN_MENU_SECONDARY = HEX("8FFCDB")
}

G.Phanta.thetrick_supported_planets = {
  "c_pluto",
  "c_mercury",
  "c_uranus",
  "c_venus",
  "c_saturn",
  "c_jupiter",
  "c_earth",
  "c_mars",
  "c_neptune",
  "c_planet_x",
  "c_ceres",
  "c_eris",
  "c_phanta_rubbish"
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
      copper_oxidised = G.C.COPPER_OXIDISED,
      perishable = G.C.PERISHABLE
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
    if (not lowest or v:get_nominal() < lowest:get_nominal()) and not SMODS.has_no_rank(v) then
      lowest = v
    end
  end
  if #hand > 0 then return { { lowest } } else return {} end
end

function count_prognosticators(card)
  return #SMODS.find_card("j_phanta_prognosticator") +
      (G.GAME.selected_sleeve == "sleeve_phanta_todayandtomorrow" and 1 or 0) +
      ((card and is_current_month(card) and 2 or 0) * #SMODS.find_card("j_phanta_calendar")) +
      (G.GAME and G.GAME.selected_back and G.GAME.selected_back and G.GAME.selected_back.effect and G.GAME.selected_back.effect.center.key == "b_phanta_todayandtomorrow" and 1 or 0)
end

function count_tricks(card)
  if #SMODS.find_card("j_phanta_thetrick") == 0 then return 0 end
  local supported_by_trick = false
  for _, v in ipairs(G.Phanta.thetrick_supported_planets) do
    if card.key == v or (card.config and card.config.center and card.config.center.key == v) then
      supported_by_trick = true; break
    end
  end
  return supported_by_trick and #SMODS.find_card("j_phanta_thetrick") or 0
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
  end
  return "small"
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

function count_consumables(args)
  if SMODS.find_mod('GSCatan') and args and args.ignore_catan then
    local count = 0
    for _, v in ipairs(G.consumeables.cards) do
      if v.config.center.set ~= "catan_Resource"
          and v.config.center.set ~= "catan_Building"
          and v.config.center.set ~= "catan_DevelopmentCard" then
        count = count + 1
      end
    end
    return count
  end

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
  if not card or (not card.month_range and (not card.config or not card.config.center or not card.config.center.month_range)) then return false end

  local card_range = card.month_range or card.config.center.month_range
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
    if is_current_month({ config = { center = j } }) then matches[#matches + 1] = { set = "phanta_Zodiac", config = { center = j } } end -- Cursed solution, but works.
  end
  if G.P_CENTER_POOLS.phanta_Birthstone then
    for i, j in pairs(G.P_CENTER_POOLS.phanta_Birthstone) do
      if is_current_month({ config = { center = j } }) then matches[#matches + 1] = { set = "phanta_Birthstone", config = { center = j } } end
    end
  end
  return matches
end

function get_names_from_zodiacs(cards)
  local names = {}
  for i = 1, #cards do
    names[#names + 1] = localize { type = 'name_text', set = cards[i].set, key = cards[i].config.center.key }
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

function is_boss_active()
  return G and G.GAME and G.GAME.blind and ((not G.GAME.blind.disabled) and (G.GAME.blind:get_type() == 'Boss'))
end

function count_missing_ranks()
  if not G.playing_cards then return 0 end
  local existing_ranks = {}
  for i, j in pairs(G.playing_cards) do
    if not SMODS.has_no_rank(j) then
      local is_valid = true
      for rank = 1, #existing_ranks do
        if j:get_id() == existing_ranks[rank] then is_valid = false end
      end
      if is_valid then existing_ranks[#existing_ranks + 1] = j:get_id() end
    end
  end

  if G.GAME and G.GAME.phanta_initial_ranks and #existing_ranks < #G.GAME.phanta_initial_ranks then
    return #G.GAME.phanta_initial_ranks - #existing_ranks
  end
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
  return G.GAME.selected_back.effect.center.key == "b_phanta_azran" or
      (G.GAME and G.GAME.selected_sleeve == "sleeve_phanta_azran")
end

function count_boosters()
  local boosters = {}
  for _, v in ipairs(G.shop_booster.cards) do
    if v.config and v.config.center and v.config.center.set == "Booster" then boosters[#boosters + 1] = v end
  end
  return boosters
end

function set_phanta_new2dsxl_streetpass(card, removed)
  local found = SMODS.find_card("j_phanta_new2dsxl")
  local count = 0
  for _, v in ipairs(found) do
    if v ~= card then
      count = count + 1
    end
  end
  if count < 1 + (removed and 1 or 0) then
    for _, v in ipairs(found) do
      if v.config and v.config.center and v.config.center.phanta_anim_current_state == "streetpass" then
        v:phanta_set_anim_state("streetpass off")
      end
    end
    if card and card.config and card.config.center and card.config.center.phanta_anim_current_state == "streetpass" then
      card:phanta_set_anim_state("streetpass off")
    end
  else
    for _, v in ipairs(found) do
      if v.config and v.config.center and v.config.center.phanta_anim_current_state ~= "streetpass" then
        v:phanta_set_anim_state("streetpass")
      end
    end
    if card and card.config and card.config.center and card.config.center.phanta_anim_current_state ~= "streetpass" then
      card:phanta_set_anim_state("streetpass")
    end
  end
end

function phanta_dougdimmadome_count_duplicates()
  if not G.playing_cards then return 0 end

  local tallies = {}
  for i, j in pairs(G.playing_cards) do
    if not SMODS.has_no_rank(j) and not SMODS.has_no_suit(j) then
      local id = j:get_id()
      if not tallies[id] then tallies[id] = {} end
      if SMODS.has_any_suit(j) then
        tallies[id].wilds = (tallies[id].wilds or 0) + 1
      else
        for k, v in pairs(SMODS.Suits) do
          if j:is_suit(k) then
            tallies[id][k] = (tallies[id][k] or 0) + 1
          end
        end
      end
    end
  end

  local largest = { count = 0 }
  for r, i in pairs(tallies) do
    for s, j in pairs(i) do
      if j + (i.wilds or 0) > largest.count then
        largest.rank = r
        largest.suit = s
        largest.count = j + (i.wilds or 0)
      end
    end
  end

  if largest.count < 1 then return 0 end
  return largest.count - 1
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

local allFiles = {
  ["none"] = {},
  ["items"] = {
    "Atlases",
    "Sounds",
    ------------------------------------
    "Blinds",
    "Boosters",
    "Decks",
    "Editions",
    "Enhancements",

    "Zodiacs",
    "Hanafudas",
    "StarterPacks",

    "Jokers1",
    "Jokers2",
    "Legendaries",
    "Misc",
    "Planets",
    "PlanetUpgrades",
    "PokerHands",
    "Seals",
    "Shaders",
    "Spectrals",
    "Stakes",
    "Stickers",
    "Suits",
    "Tags",
    "Tarots",
    "Unlocks",
    "Vouchers",

    "DeckJoker"
  }
}

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

if next(SMODS.find_mod('Bakery')) then assert(SMODS.load_file("items/Charms.lua"))() end
if next(SMODS.find_mod('partner')) then assert(SMODS.load_file("items/Partners.lua"))() end
if next(SMODS.find_mod('CardSleeves')) then assert(SMODS.load_file("items/Sleeves.lua"))() end
if next(SMODS.find_mod('artbox')) then assert(SMODS.load_file("items/ArtBox.lua"))() end
if next(SMODS.find_mod('entr')) then assert(SMODS.load_file("items/Entropy.lua"))() end
if JokerDisplay then
  assert(SMODS.load_file("items/JokerDisplayDefs1.lua"))()
  assert(SMODS.load_file("items/JokerDisplayDefs2.lua"))()
  assert(SMODS.load_file("items/JokerDisplayDefsLegendaries.lua"))()
end
local aura_enabled = next(SMODS.find_mod('Aura'))



--Then, order everything.
assert(SMODS.load_file("items/Ordering.lua"))()









function SMODS.Consumable:phanta_update_zodiac_level_anim()
  if not self.discovered and not (self.params and self.params.bypass_discovery_center) then
    return
  end
  local progs = count_prognosticators(self)
  local state = "0"
  if progs == 1 then state = "1" end
  if progs == 2 then state = "2" end
  if progs == 3 then state = "3" end
  if progs >= 4 then state = "4+" end

  if state ~= self.phanta_anim_extra_current_state then
    self:phanta_set_anim_extra_state(state)
  end
end

function phanta_update_planet_level_anim(center)
  if not center.discovered and not (center.params and center.params.bypass_discovery_center) then
    return
  end
  local tricks = count_tricks(center)
  local state = "0"
  if tricks == 1 then state = "1" end
  if tricks == 2 then state = "2" end
  if tricks == 3 then state = "3" end
  if tricks >= 4 then state = "4+" end

  if state ~= center.phanta_anim_extra_current_state then
    phanta_set_anim_extra_state(center, state)
  end
end

local game_start_run_ref = Game.start_run

function Game:start_run(args)
  game_start_run_ref(self, args)
  G.GAME.phanta_sleepy_rounds = 2
  phanta_assign_deck_joker()
  G.E_MANAGER:add_event(Event({
    func = function()
      if not G.playing_cards then return false end
      if G.GAME.phanta_initial_ranks then return true end

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

function SMODS.current_mod:calculate(context)
  if context.end_of_round and not context.repetition and not context.individual then
    if #G.deck.cards == 4 then
      check_for_unlock({ type = 'phanta_four_cards_remaining' })
    end
    for i, v in ipairs(G.jokers.cards) do
      if v.ability.phanta_sleepy then
        v.ability.sleepy_tally = v.ability.sleepy_tally - 1
        if v.ability.sleepy_tally > 0 then
          card_eval_status_text(v, 'extra', nil, nil, nil,
            {
              message = localize { type = 'variable', key = 'a_remaining', vars = { v.ability.sleepy_tally } },
              colour = G.C.FILTER,
              message_card = v
            })
        else
          v.ability.sleepy_tally = 0
          v:set_debuff(false)
          v.ability.phanta_sleepy = nil
          card_eval_status_text(v, 'extra', nil, nil, nil,
            {
              message = localize('phanta_sleepy_awake'),
              colour = G.C.FILTER,
              message_card = v
            })
        end
      end
    end
  end

  if context.ending_shop then
    G.GAME.current_shop_rerolls = 0
  end

  if context.remove_playing_cards then
    for _, v in ipairs(context.removed) do
      if SMODS.has_enhancement(v, "m_phanta_ghostcard") and v.seal == 'phanta_ghostseal' then
        check_for_unlock({ type = 'phanta_remove_double_ghost' })
      end
    end
  end

  if context.before then
    if G.play.cards then
      local text, disp_text = G.FUNCS.get_poker_hand_info(G.play.cards)
      if text == "phanta_junk" then
        for _, v in ipairs(context.scoring_hand) do
          if SMODS.has_enhancement(v, "m_steel") then
            check_for_unlock({ type = 'phanta_junk_scoring_steel' })
          end
        end
      end

      local counted_marbles = 0
      for _, v in ipairs(G.play.cards) do
        if SMODS.has_enhancement(v, "m_phanta_marblecard") then
          counted_marbles = counted_marbles + 1
        end
      end
      if counted_marbles >= 5 then check_for_unlock({ type = 'phanta_five_marbles' }) end

      local played_blue = false
      local held_blue = false
      for _, v in ipairs(G.play.cards) do
        if v.seal == "Blue" then
          played_blue = true; break
        end
      end
      for _, v in ipairs(G.hand.cards) do
        if v.seal == "Blue" then
          held_blue = true; break
        end
      end

      if played_blue and held_blue then check_for_unlock({ type = 'phanta_played_and_held_blue' }) end
    end

    if not G.GAME.phanta_number_of_unscored then G.GAME.phanta_number_of_unscored = 0 end
    G.GAME.phanta_number_of_unscored = G.GAME.phanta_number_of_unscored + (#G.play.cards - #context.scoring_hand)
  end

  if context.reroll_shop and G.GAME.current_shop_rerolls >= 10 then
    check_for_unlock({ type = 'phanta_ten_rerolls' })
  end
end

local igo = Game.init_game_object
function Game:init_game_object()
  local ret = igo(self)
  ret.current_round.train_station_card = { id = nil, value = nil }
  ret.current_round.fainfol_card = { suit = 'Spades' }
  ret.current_round.puzzle_card = { id = nil }
  ret.current_round.phanta_widget_suit = 'Clubs'
  ret.current_round.datacube_card = { id = nil, value = nil }
  return ret
end

local main_menu_ref = Game.main_menu
Game.main_menu = function(change_context)
  local ret = main_menu_ref(change_context)

  if Phanta.config["custom_title_screen"] then
    local SC_scale = 1.1 * (G.debug_splash_size_toggle and 0.8 or 1)
    G.SPLASH_LOGO_PHANTA_GHOST = Sprite(0, 0,
      13 * SC_scale,
      13 * SC_scale *
      (G.ASSET_ATLAS["phanta_PhantaTitleScreenGhost"].py / G.ASSET_ATLAS["phanta_PhantaTitleScreenGhost"].px),
      G.ASSET_ATLAS["phanta_PhantaTitleScreenGhost"], { x = 0, y = 0 }
    )
    G.SPLASH_LOGO_PHANTA_GHOST:set_alignment({
      major = G.title_top,
      type = 'cm',
      bond = 'Strong',
      offset = { x = 0, y = 0 }
    })
    G.SPLASH_LOGO_PHANTA_GHOST:define_draw_steps({ {
      shader = 'dissolve',
    } })

    G.SPLASH_LOGO_PHANTA_GHOST.dissolve_colours = { G.C.WHITE, G.C.WHITE }
    G.SPLASH_LOGO_PHANTA_GHOST.dissolve = 1

    G.E_MANAGER:add_event(Event({
      trigger = 'after',
      delay = change_context == 'splash' and 1.8 or change_context == 'game' and 2 or 0.5,
      blockable = false,
      blocking = false,
      func = (function()
        ease_value(G.SPLASH_LOGO_PHANTA_GHOST, 'dissolve', -1, nil, nil, nil,
          change_context == 'splash' and 2.3 or 0.9)
        G.VIBRATION = G.VIBRATION + 1.5
        return true
      end)
    }))
  end

  --[[G.SPLASH_BACK:define_draw_steps({ {
    shader = 'splash',
    send = {
      { name = 'time',       ref_table = G.TIMERS,  ref_value = 'REAL_SHADER' },
      { name = 'vort_speed', val = 0.4 },
      { name = 'colour_1',   ref_table = G.C.PHANTA.MISC_COLOURS, ref_value = 'PHANTA_MAIN_MENU_PRIMARY' },
      { name = 'colour_2',   ref_table = G.C.PHANTA.MISC_COLOURS, ref_value = 'PHANTA_MAIN_MENU_SECONDARY' },
    }
  } })]] --

  for k, v in pairs(G.P_CENTERS) do
    if v.set == "phanta_Zodiac" or v.set == "phanta_Birthstone" or v.set == "Planet" then
      if not v.atlas_extra then
        if v.set == "phanta_Zodiac" then
          v.atlas_extra = "phanta_PhantaZodiacUpgrades"
        elseif v.set == "phanta_Birthstone" then
          v.atlas_extra = "phanta_PhantaBirthstoneUpgrades"
        elseif v.set == "Planet" then
          v.atlas_extra = "phanta_PhantaPlanetUpgrades"
        end
      end
      v.phanta_anim_extra_states = {
        ["0"] = {
          anim = {
            { x = 0, y = 0, t = 1 } }
        },
        ["1"] = {
          anim = {
            { xrange = { first = 0, last = 3 }, y = 1, t = 0.1 },
            { xrange = { first = 2, last = 1 }, y = 1, t = 0.1 }
          }
        },
        ["2"] = {
          anim = {
            { xrange = { first = 0, last = 3 }, y = 2, t = 0.1 },
            { xrange = { first = 2, last = 1 }, y = 2, t = 0.1 }
          }
        },
        ["3"] = {
          anim = {
            { xrange = { first = 0, last = 3 }, y = 3, t = 0.1 },
            { xrange = { first = 2, last = 1 }, y = 3, t = 0.1 }
          }
        },
        ["4+"] = {
          anim = {
            { xrange = { first = 0, last = 3 }, y = 4, t = 0.1 },
            { xrange = { first = 2, last = 1 }, y = 4, t = 0.1 }
          }
        }
      }
      v.phanta_anim_extra_current_state = "0"
    end
  end

  return ret
end

function Card:phanta_set_anim_state(state)
  self.config.center.phanta_anim_current_state = state
  self.config.center.phanta_anim_t = 0
end

function Card:phanta_set_anim_extra_state(state)
  self.config.center.phanta_anim_extra_current_state = state
  self.config.center.phanta_anim_extra_t = 0
end

function SMODS.Center:phanta_set_anim_state(state)
  self.config.center.phanta_anim_current_state = state
  self.config.center.phanta_anim_t = 0
end

function SMODS.Center:phanta_set_anim_extra_state(state)
  self.phanta_anim_extra_current_state = state
  self.phanta_anim_extra_t = 0
end

function phanta_set_anim_state(center, state)
  center.config.center.phanta_anim_current_state = state
  center.config.center.phanta_anim_t = 0
end

function phanta_set_anim_extra_state(center, state)
  center.phanta_anim_extra_current_state = state
  center.phanta_anim_extra_t = 0
end

function SMODS.current_mod.reset_game_globals(run_start)
  G.GAME.current_round.fainfol_card = G.GAME.current_round.fainfol_card or 'Clubs'
  local valid_cards_fainfol = {}
  for i, j in ipairs(G.playing_cards) do
    if not SMODS.has_no_suit(j) and not j:is_suit(G.GAME.current_round.fainfol_card.suit) then
      valid_cards_fainfol[#valid_cards_fainfol + 1] = j
    end
  end
  if next(valid_cards_fainfol) then
    local chosen_card = pseudorandom_element(valid_cards_fainfol, pseudoseed('fainfol' .. G.GAME.round_resets.ante))
    G.GAME.current_round.fainfol_card.suit = chosen_card.base.suit
  end

  G.GAME.current_round.phanta_widget_suit = G.GAME.current_round.phanta_widget_suit or { suit = 'Spades' }
  local valid_cards_widget = {}
  for i, j in ipairs(G.playing_cards) do
    if not SMODS.has_no_suit(j) and not j:is_suit(G.GAME.current_round.phanta_widget_suit) then
      valid_cards_widget[#valid_cards_widget + 1] = j
    end
  end
  if next(valid_cards_widget) then
    local chosen_card = pseudorandom_element(valid_cards_widget, pseudoseed('widget' .. G.GAME.round_resets.ante))
    G.GAME.current_round.phanta_widget_suit = chosen_card.base.suit
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

  if not G.GAME.current_round.puzzle_card then G.GAME.current_round.puzzle_card = { id = 2 } end
  local valid_cards_puzzle = {}
  for i, j in ipairs(G.playing_cards) do
    if not SMODS.has_no_rank(j) then
      valid_cards_puzzle[#valid_cards_puzzle + 1] = j
    end
  end

  if (get_previous_blind() and get_previous_blind() == "boss") or not G.GAME.last_blind then
    if next(valid_cards_puzzle) then
      local chosen_card = pseudorandom_element(valid_cards_puzzle, pseudoseed('puzzle' .. G.GAME.round_resets.ante))
      G.GAME.current_round.puzzle_card = { id = chosen_card:get_id() }
    end
  end

  if not G.GAME.current_round.datacube_card then G.GAME.current_round.datacube_card = { id = 2, value = "2" } end
  local valid_cards_datacube = {}
  for i, j in ipairs(G.playing_cards) do
    if not SMODS.has_no_rank(j) then
      valid_cards_datacube[#valid_cards_datacube + 1] = j
    end
  end

  if next(valid_cards_datacube) then
    local chosen_card = pseudorandom_element(valid_cards_datacube, pseudoseed('datacube' .. G.GAME.round_resets.ante))
    G.GAME.current_round.datacube_card = { id = chosen_card:get_id(), value = chosen_card.base.value }
  end
end

if not Phanta then Phanta = {} end
Phanta.config = SMODS.current_mod.config

if Phanta.config["custom_title_screen"] then
  SMODS.Atlas {
    key = "balatro",
    path = "PhantaLogo.png",
    px = 333,
    py = 216,
    prefix_config = { key = false }
  }
end

local phantaConfigTab = function()
  phanta_nodes = {}
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
    label = localize("phanta_hanafuda_enabled"),
    active_colour = HEX("40c76d"),
    ref_table = Phanta.config,
    ref_value = "hanafuda_enabled",
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
  phanta_nodes[#phanta_nodes + 1] = create_toggle({
    label = localize("phanta_disable_animations"),
    active_colour = HEX("40c76d"),
    ref_table = Phanta.config,
    ref_value = "animations_disabled",
    callback = function()
    end,
  })
  phanta_nodes[#phanta_nodes + 1] = create_toggle({
    label = localize("phanta_disable_custom_music"),
    active_colour = HEX("40c76d"),
    ref_table = Phanta.config,
    ref_value = "custom_music_disabled",
    callback = function()
    end,
  })
  phanta_nodes[#phanta_nodes + 1] = create_toggle({
    label = localize("phanta_custom_title_screen"),
    active_colour = HEX("40c76d"),
    ref_table = Phanta.config,
    ref_value = "custom_title_screen",
    callback = function()
    end,
    info = { localize("phanta_requires_restart") }
  })
  phanta_nodes[#phanta_nodes + 1] = create_toggle({
    label = localize("phanta_copper_grate_expanded"),
    active_colour = HEX("40c76d"),
    ref_table = Phanta.config,
    ref_value = "copper_grate_expanded",
    callback = function()
    end,
  })
  phanta_nodes[#phanta_nodes + 1] = create_toggle({
    label = localize("phanta_dougdimmadome_disable_hat"),
    active_colour = HEX("40c76d"),
    ref_table = Phanta.config,
    ref_value = "dougdimmadome_disable_hat",
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





-- This DrawStep is courtesy of notmario.
SMODS.DrawStep {
  key = "doug_hat",
  order = -9,
  func = function(self)
    if not self:should_draw_base_shader() then return nil end
    if not (self.config.center.discovered or self.bypass_discovery_center) then return nil end
    if self.config.center.key ~= "j_phanta_dougdimmadome" then return nil end
    if Phanta.config["dougdimmadome_disable_hat"] then return nil end
    if not G.phanta_dougdimmadome_hat_sprite then
      G.phanta_dougdimmadome_hat_sprite = Sprite(
        0, 0, 71, 95, G.ASSET_ATLAS["phanta_Phanta2"], { x = 11, y = 3 }
      )
    end

    G.phanta_dougdimmadome_hat_sprite.role.draw_major = self
    for i = 0, 25 do
      local hoff = -1 - i * 0.4
      G.phanta_dougdimmadome_hat_sprite:draw_shader('dissolve', nil, nil, nil, self.children.center, 0, 0, 0, hoff)
    end
  end,
  conditions = { vortex = false, facing = "front" },
}

SMODS.DrawStep {
  key = 'extra',
  order = 21,
  func = function(self, layer)
    if not self.phanta_extra and self.config.center.pos_extra then
      local atlas = G.ASSET_ATLAS[self.config.center.atlas_extra or self.config.center.atlas]
      self.phanta_extra = Sprite(0, 0, atlas.px, atlas.py,
        atlas, self.config.center.pos_extra)
    end
    if self.phanta_extra then
      if self.config.center.discovered or (self.params and self.params.bypass_discovery_center) then
        self.phanta_extra:set_sprite_pos(self.config.center.pos_extra)
        self.phanta_extra.role.draw_major = self
        if (self.edition and self.edition.negative and (not self.delay_edition or self.delay_edition.negative)) or (self.ability.name == 'Antimatter' and (self.config.center.discovered or self.bypass_discovery_center)) then
          self.phanta_extra:draw_shader('negative', nil, self.ARGS.send_to_shader, nil, self.children.center)
        elseif not self:should_draw_base_shader() then
        elseif not self.greyed then
          self.phanta_extra:draw_shader('dissolve', nil, nil, nil, self.children.center)
        end

        if self.ability.name == 'Invisible Joker' and (self.config.center.discovered or self.bypass_discovery_center) then
          if self:should_draw_base_shader() then
            self.phanta_extra:draw_shader('voucher', nil, self.ARGS.send_to_shader, nil, self.children.center)
          end
        end

        local center = self.config.center
        if center.draw_extra and type(center.draw_extra) == 'function' then
          self.phanta_extra:draw_extra(self, layer)
        end

        local edition = self.delay_edition or self.edition
        if edition then
          for k, v in pairs(G.P_CENTER_POOLS.Edition) do
            if edition[v.key:sub(3)] and v.shader then
              if type(v.draw) == 'function' then
                v:draw(self, layer)
              else
                self.phanta_extra:draw_shader(v.shader, nil, self.ARGS.send_to_shader, nil, self.children.center)
              end
            end
          end
        end
        if (edition and edition.negative) or (self.ability.name == 'Antimatter' and (self.config.center.discovered or self.bypass_discovery_center)) then
          self.phanta_extra:draw_shader('negative_shine', nil, self.ARGS.send_to_shader, nil, self.children.center)
        end
      end
    end
  end,
  conditions = { vortex = false, facing = 'front' }
}

SMODS.DrawStep {
  key = 'extra2',
  order = 21.1,
  func = function(self, layer)
    if not self.phanta_extra2 and self.config.center.pos_extra2 then
      local atlas = G.ASSET_ATLAS[self.config.center.atlas_extra2 or self.config.center.atlas]
      self.phanta_extra2 = Sprite(0, 0, atlas.px, atlas.py,
        atlas, self.config.center.pos_extra2)
    end
    if self.phanta_extra2 then
      if self.config.center.discovered or (self.params and self.params.bypass_discovery_center) then
        self.phanta_extra2:set_sprite_pos(self.config.center.pos_extra2)
        self.phanta_extra2.role.draw_major = self
        if (self.edition and self.edition.negative and (not self.delay_edition or self.delay_edition.negative)) or (self.ability.name == 'Antimatter' and (self.config.center.discovered or self.bypass_discovery_center)) then
          self.phanta_extra2:draw_shader('negative', nil, self.ARGS.send_to_shader, nil, self.children.center)
        elseif not self:should_draw_base_shader() then
        elseif not self.greyed then
          self.phanta_extra2:draw_shader('dissolve', nil, nil, nil, self.children.center)
        end

        if self.ability.name == 'Invisible Joker' and (self.config.center.discovered or self.bypass_discovery_center) then
          if self:should_draw_base_shader() then
            self.phanta_extra2:draw_shader('voucher', nil, self.ARGS.send_to_shader, nil, self.children.center)
          end
        end

        local center = self.config.center
        if center.draw_extra2 and type(center.draw_extra) == 'function' then
          self.phanta_extra2:draw_extra2(self, layer)
        end

        local edition = self.delay_edition or self.edition
        if edition then
          for k, v in pairs(G.P_CENTER_POOLS.Edition) do
            if edition[v.key:sub(3)] and v.shader then
              if type(v.draw) == 'function' then
                v:draw(self, layer)
              else
                self.phanta_extra2:draw_shader(v.shader, nil, self.ARGS.send_to_shader, nil, self.children.center)
              end
            end
          end
        end
        if (edition and edition.negative) or (self.ability.name == 'Antimatter' and (self.config.center.discovered or self.bypass_discovery_center)) then
          self.phanta_extra2:draw_shader('negative_shine', nil, self.ARGS.send_to_shader, nil, self.children.center)
        end
      end
    end
  end,
  conditions = { vortex = false, facing = 'front' }
}


SMODS.DrawStep:take_ownership("back", {
  func = function(self)
    if self.children.back then
      local cback = self.params.galdur_back or (not self.params.viewed_back and G.GAME.selected_back) or
          (self.params.viewed_back and G.GAME.viewed_back)
      if not (cback and cback.effect.center.key == "b_phanta_retired") then
        local overlay = G.C.WHITE
        if self.area and self.area.config.type == 'deck' and self.rank > 3 then
          self.back_overlay = self.back_overlay or {}
          self.back_overlay[1] = 0.5 + ((#self.area.cards - self.rank) % 7) / 50
          self.back_overlay[2] = 0.5 + ((#self.area.cards - self.rank) % 7) / 50
          self.back_overlay[3] = 0.5 + ((#self.area.cards - self.rank) % 7) / 50
          self.back_overlay[4] = 1
          overlay = self.back_overlay
        end

        if self.area and self.area.config.type == 'deck' then
          self.children.back:draw(overlay)
        else
          self.children.back:draw_shader('dissolve')
        end
      end
    end
  end,
}, true)

-- Stolen from Hot Potato, which itself got this from TMD.
SMODS.DrawStep {
  key = 'deck_shader',
  order = 5,
  func = function(self)
    if self.children.back then
      local cback = self.params.galdur_back or (not self.params.viewed_back and G.GAME.selected_back) or
          (self.params.viewed_back and G.GAME.viewed_back)
      if cback then
        local shader = nil
        if cback.effect.center.phanta_deck_shader then shader = cback.effect.center.phanta_deck_shader end

        if (shader and (self.config.center.set ~= "Sleeve"))
            and ((self.area and not self.area.config.stake_select and not self.area.config.stake_chips) or not self.area) then
          local t = (self.area and self.area.config.type == "deck") or self.config.center.set == "Back"
          if t and not self.states.drag.is then self.ARGS.send_to_shader = { 1.0, self.ARGS.send_to_shader[2] } end

          self.children.back:draw_shader(shader, nil, self.ARGS.send_to_shader, t, self.children.center, 0, 0)
        end
      end
    end
  end,
  conditions = { vortex = false, facing = 'back' }
}


SMODS.DrawStep {
  key = 'shiny_soul',
  order = 61,
  func = function(self)
    if self.config.center.soul_pos and (self.config.center.discovered or self.bypass_discovery_center) and self.config.center.phanta_shiny_soul then
      local scale_mod = 0.07 + 0.02 * math.sin(1.8 * G.TIMERS.REAL) +
          0.00 * math.sin((G.TIMERS.REAL - math.floor(G.TIMERS.REAL)) * math.pi * 14) *
          (1 - (G.TIMERS.REAL - math.floor(G.TIMERS.REAL))) ^ 3
      local rotate_mod = 0.05 * math.sin(1.219 * G.TIMERS.REAL) +
          0.00 * math.sin((G.TIMERS.REAL) * math.pi * 5) * (1 - (G.TIMERS.REAL - math.floor(G.TIMERS.REAL))) ^ 2

      if self.children.floating_sprite then
        self.children.floating_sprite:draw_shader('booster', nil, self.ARGS.send_to_shader, nil, self.children.center,
          scale_mod, rotate_mod)
      end
    end
  end,
  conditions = { vortex = false, facing = 'front' }
}



local update_ref = Game.update
function Game:update(dt)
  if not G.GAME.phanta_zodiac_rate_cache then G.GAME.phanta_zodiac_rate_cache = 0 end
  if not G.GAME.phanta_birthstone_rate_cache then G.GAME.phanta_birthstone_rate_cache = 0 end

  if Phanta.config["zodiac_enabled"] then
    G.GAME.phanta_zodiac_rate = G.GAME.phanta_zodiac_rate_cache
    G.GAME.phanta_birthstone_rate = G.GAME.phanta_birthstone_rate_cache
  else
    G.GAME.phanta_birthstone_rate = 0
  end

  if not Phanta.config["animations_disabled"] then
    for k, v in pairs(G.P_CENTERS) do
      if not v.default_pos then v.default_pos = v.pos end
      if not v.default_pos_extra then v.default_pos_extra = v.pos_extra end
      if not v.default_pos_extra2 then v.default_pos_extra2 = v.pos_extra2 end

      if v.set == 'phanta_Zodiac' or v.set == 'phanta_Birthstone' then v:phanta_update_zodiac_level_anim() end
      if v.set == 'Planet' then phanta_update_planet_level_anim(v) end

      handle_phanta_anim(v, dt)
      handle_phanta_anim_extra(v, dt)
      handle_phanta_anim_extra2(v, dt)
    end
  else
    for k, v in pairs(G.P_CENTERS) do
      if not v.default_pos then v.default_pos = v.pos end
      if not v.default_pos_extra then v.default_pos_extra = v.pos_extra end
      if not v.default_pos_extra2 then v.default_pos_extra2 = v.pos_extra2 end
      v.pos = v.default_pos
      v.pos_extra = v.default_pos_extra
      v.pos_extra2 = v.default_pos_extra2
    end
  end

  return update_ref(self, dt)
end

function handle_phanta_anim(v, dt)
  if (v.phanta_anim_states or v.phanta_anim) and (not v.phanta_requires_aura or aura_enabled) then
    v.phanta_anim = format_phanta_anim(v.phanta_anim_states and v.phanta_anim_current_state and
      v.phanta_anim_states[v.phanta_anim_current_state] and v.phanta_anim_states[v.phanta_anim_current_state].anim or
      v.phanta_anim)
    if v.phanta_anim == nil then
      v.pos = v.default_pos
    else
      local loop = v.phanta_anim_states and v.phanta_anim_current_state and
          v.phanta_anim_states[v.phanta_anim_current_state] and v.phanta_anim_states[v.phanta_anim_current_state].loop
      if loop == nil then loop = true end
      if not v.phanta_anim_t then v.phanta_anim_t = 0 end
      if not v.phanta_anim.length then
        v.phanta_anim.length = 0
        for _, frame in ipairs(v.phanta_anim) do
          v.phanta_anim.length = v.phanta_anim.length + (frame.t or 0)
        end
      end
      v.phanta_anim_t = v.phanta_anim_t + dt
      if not loop and v.phanta_anim_t >= v.phanta_anim.length then
        local continuation = v.phanta_anim_states[v.phanta_anim_current_state].continuation
        if continuation then
          v.phanta_anim_current_state = continuation
          v.phanta_anim_t = 0
          handle_phanta_anim(v, dt)
          return
        else
          v.phanta_anim_t = v.phanta_anim.length
        end
      elseif loop then
        v.phanta_anim_t = v.phanta_anim_t % v.phanta_anim.length
      end
      local ix = 0
      local t_tally = 0
      for _, frame in ipairs(v.phanta_anim) do
        ix = ix + 1
        t_tally = t_tally + frame.t
        if t_tally > v.phanta_anim_t then break end
      end
      v.pos.x = v.phanta_anim[ix].x
      v.pos.y = v.phanta_anim[ix].y
    end
  end
end

function handle_phanta_anim_extra(v, dt)
  if (v.phanta_anim_extra_states or v.phanta_anim_extra) and (not v.phanta_requires_aura or aura_enabled) then
    v.phanta_anim_extra = format_phanta_anim(v.phanta_anim_extra_states and v.phanta_anim_extra_current_state and
      v.phanta_anim_extra_states[v.phanta_anim_extra_current_state] and
      v.phanta_anim_extra_states[v.phanta_anim_extra_current_state].anim or
      v.phanta_anim_extra)
    if v.phanta_anim_extra == nil then
      v.pos_extra = v.default_pos_extra
    else
      local loop = v.phanta_anim_extra_states and v.phanta_anim_extra_current_state and
          v.phanta_anim_extra_states[v.phanta_anim_extra_current_state] and
          v.phanta_anim_extra_states[v.phanta_anim_extra_current_state].loop
      if loop == nil then loop = true end
      if not v.phanta_anim_extra_t then v.phanta_anim_extra_t = 0 end
      if not v.phanta_anim_extra.length then
        v.phanta_anim_extra.length = 0
        for _, frame in ipairs(v.phanta_anim_extra) do
          v.phanta_anim_extra.length = v.phanta_anim_extra.length + (frame.t or 0)
        end
      end
      v.phanta_anim_extra_t = v.phanta_anim_extra_t + dt
      if not loop and v.phanta_anim_extra_t >= v.phanta_anim_extra.length then
        local continuation = v.phanta_anim_extra_states[v.phanta_anim_extra_current_state].continuation
        if continuation then
          v.phanta_anim_extra_current_state = continuation
          v.phanta_anim_extra_t = 0
          handle_phanta_anim_extra(v, dt)
        else
          v.phanta_anim_extra_t = v.phanta_anim_extra.length
        end
      elseif loop then
        v.phanta_anim_extra_t = v.phanta_anim_extra_t % v.phanta_anim_extra.length
      end
      local ix = 0
      local t_tally = 0
      for _, frame in ipairs(v.phanta_anim_extra) do
        ix = ix + 1
        t_tally = t_tally + frame.t
        if t_tally > v.phanta_anim_extra_t then break end
      end
      if not v.pos_extra then v.pos_extra = {} end
      v.pos_extra.x = v.phanta_anim_extra[ix].x
      v.pos_extra.y = v.phanta_anim_extra[ix].y
    end
  end
end

function handle_phanta_anim_extra2(v, dt)
  if (v.phanta_anim_extra2_states or v.phanta_anim_extra2) and (not v.phanta_requires_aura or aura_enabled) then
    v.phanta_anim_extra2 = format_phanta_anim(v.phanta_anim_extra2_states and v.phanta_anim_extra2_current_state and
      v.phanta_anim_extra2_states[v.phanta_anim_extra2_current_state] and
      v.phanta_anim_extra2_states[v.phanta_anim_extra2_current_state].anim or
      v.phanta_anim_extra2)
    if v.phanta_anim_extra2 == nil then
      v.pos_extra2 = v.default_pos_extra2
    else
      local loop = v.phanta_anim_extra2_states and v.phanta_anim_extra2_current_state and
          v.phanta_anim_extra2_states[v.phanta_anim_extra2_current_state] and
          v.phanta_anim_extra2_states[v.phanta_anim_extra2_current_state].loop
      if loop == nil then loop = true end
      if not v.phanta_anim_extra2_t then v.phanta_anim_extra2_t = 0 end
      if not v.phanta_anim_extra2.length then
        v.phanta_anim_extra2.length = 0
        for _, frame in ipairs(v.phanta_anim_extra2) do
          v.phanta_anim_extra2.length = v.phanta_anim_extra2.length + (frame.t or 0)
        end
      end
      v.phanta_anim_extra2_t = v.phanta_anim_extra2_t + dt
      if not loop and v.phanta_anim_extra2_t >= v.phanta_anim_extra2.length then
        local continuation = v.phanta_anim_extra2_states[v.phanta_anim_extra2_current_state].continuation
        if continuation then
          v.phanta_anim_extra2_current_state = continuation
          v.phanta_anim_extra2_t = 0
          handle_phanta_anim_extra2(v, dt)
        else
          v.phanta_anim_extra2_t = v.phanta_anim_extra2.length
        end
      elseif loop then
        v.phanta_anim_extra2_t = v.phanta_anim_extra2_t % v.phanta_anim_extra2.length
      end
      local ix = 0
      local t_tally = 0
      for _, frame in ipairs(v.phanta_anim_extra2) do
        ix = ix + 1
        t_tally = t_tally + frame.t
        if t_tally > v.phanta_anim_extra2_t then break end
      end
      if not v.pos_extra2 then v.pos_extra2 = {} end
      v.pos_extra2.x = v.phanta_anim_extra2[ix].x
      v.pos_extra2.y = v.phanta_anim_extra2[ix].y
    end
  end
end

function format_phanta_anim(anim)
  if not anim then return nil end
  local new_anim = {}
  for _, frame in ipairs(anim) do
    if frame and (frame.x or (frame.xrange and frame.xrange.first and frame.xrange.last)) and (frame.y or (frame.yrange and frame.yrange.first and frame.yrange.last)) then
      local firsty = frame.y or frame.yrange.first
      local lasty = frame.y or frame.yrange.last
      for y = firsty, lasty, firsty <= lasty and 1 or -1 do
        local firstx = frame.x or frame.xrange.first
        local lastx = frame.x or frame.xrange.last
        for x = firstx, lastx, firstx <= lastx and 1 or -1 do
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
