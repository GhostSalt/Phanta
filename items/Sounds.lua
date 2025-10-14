SMODS.Sound({
  key = "diamondaxe",
  path = "phanta_diamondaxe.ogg",
  replace = true
})

SMODS.Sound({
  key = "teabag",
  path = "phanta_teabag.ogg",
  replace = true
})

SMODS.Sound({
  key = "xhands",
  path = "phanta_xhands.ogg",
  replace = true
})

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
  key = "lobotomy_die",
  path = "phanta_lobotomy_die.ogg",
  replace = true
})

SMODS.Sound({
  vol = 1,
  pitch = 1,
  key = "polargeist_music",
  path = "phanta_polargeist.ogg",
  select_music_track = function()
    if #SMODS.find_card('j_phanta_normalface') > 0 and not Phanta.config["custom_music_disabled"] then
      return 1e6
    end
    return false
  end
})

SMODS.Sound({
  key = "waxed_card",
  path = "phanta_waxed_card.ogg"
})

SMODS.Sound({
  key = "drilled_card",
  path = "phanta_drilled_card.ogg"
})

SMODS.Sound({
  key = "oxidised_break",
  path = "phanta_oxidised_break.ogg",
  replace = true
})

SMODS.Sound({
  vol = 1,
  key = "zodiac_pack_music",
  path = "phanta_zodiac_pack.ogg",
  select_music_track = function()
    if G.booster_pack and SMODS.OPENED_BOOSTER and
        (SMODS.OPENED_BOOSTER.config.center.key == 'p_phanta_zodiac_normal1'
          or SMODS.OPENED_BOOSTER.config.center.key == 'p_phanta_zodiac_normal2'
          or SMODS.OPENED_BOOSTER.config.center.key == 'p_phanta_zodiac_normal3'
          or SMODS.OPENED_BOOSTER.config.center.key == 'p_phanta_zodiac_normal4'
          or SMODS.OPENED_BOOSTER.config.center.key == 'p_phanta_zodiac_jumbo1'
          or SMODS.OPENED_BOOSTER.config.center.key == 'p_phanta_zodiac_jumbo2'
          or SMODS.OPENED_BOOSTER.config.center.key == 'p_phanta_zodiac_mega1'
          or SMODS.OPENED_BOOSTER.config.center.key == 'p_phanta_zodiac_mega2') then
      return true
    end
    return false
  end
})

SMODS.Sound({
  key = "tally_deck",
  path = "phanta_tally_deck.ogg",
  replace = true
})

SMODS.Sound({
  key = "charged_deck",
  path = "phanta_charged_deck.ogg"
})