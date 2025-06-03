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
  COPPER_OXIDISED = HEX("4FAB90")
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

function count_prognosticators()
  return #SMODS.find_card("j_phanta_prognosticator") +
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
  if G.consumeables.get_total_count then return G.consumeables:get_total_count()
  else return #G.consumeables.cards + G.GAME.consumeable_buffer end
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

local ref1 = Card.start_dissolve
function Card:start_dissolve()
  if self.config and self.config.center and self.config.center.phanta_shatters then
    return self:shatter()
  else
    return ref1(self)
  end
end

local allFolders = { "none", "items" }

local allFiles = { ["none"] = {}, ["items"] = { "Jokers1", "Misc", "Partners", "Catan" } }

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
