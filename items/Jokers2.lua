SMODS.Atlas {
  key = "Phanta2",
  path = "PhantaJokers2.png",
  px = 71,
  py = 95
}

SMODS.Sound({
  key = "lobotomy_0",
  path = "phanta_lobotomy_0.ogg",
  replace = true
})

SMODS.Sound({
  key = "lobotomy_1",
  path = "phanta_lobotomy_1.ogg",
  replace = true
})

SMODS.Sound({
  key = "lobotomy_2",
  path = "phanta_lobotomy_2.ogg",
  replace = true
})

SMODS.Sound({
  vol = 1,
  pitch = 1,
  key = "polargeist_music",
  path = "phanta_polargeist.ogg",
  select_music_track = function()
    if #SMODS.find_card('j_phanta_normalface') > 0 then
      return 1e6
    end
    return false
  end
})

SMODS.Joker {
  key = 'normalface',
  config = { extra = { mult = 10, rate = 0.9 } },
  loc_vars = function(self, info_queue, card)
    return { vars = { card.ability.extra.mult } }
  end,
  rarity = 1,
  atlas = 'Phanta2',
  pos = { x = 0, y = 0 },
  cost = 4,
  blueprint_compat = true,
  eternal_compat = true,
  perishable_compat = true,
  calculate = function(self, card, context)
    if context.joker_main then return { mult = card.ability.extra.mult } end
    if not context.repetition
        and math.random() > card.ability.extra.rate then
      local all_pitches = {{ 1 }, { 1, 1, 1, 1, 0.5, 2 }, { 1, 1, 2 }}

      local sound = math.floor(math.random() * #all_pitches)
      sound = sound < #all_pitches and sound or 1
      local pitch = all_pitches[sound + 1][math.floor(math.random() * #all_pitches[sound + 1]) + 1]

      G.E_MANAGER:add_event(Event({
        func = function()
          G.E_MANAGER:add_event(Event({
            func = function()
              play_sound("phanta_lobotomy_" .. sound, pitch, 1)
              card_eval_status_text(card, 'extra', nil, nil, nil, { message = ":)", colour = G.C.GREEN })
              return true
            end
          }))
          return true
        end
      }))
    end
  end
}
