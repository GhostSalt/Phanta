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
  config = { extra = { mult = 10 } },
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
    if not context.repetition and math.random() > 0.95 then
      local all_pitches = { { 1 }, { 1, 1, 1, 1, 0.5, 2 }, { 1, 1, 2 } }

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

SMODS.Joker {
  key = 'absentjoker',
  config = { extra = { mult = 15 } },
  loc_vars = function(self, info_queue, card)
    return { vars = { card.ability.extra.mult } }
  end,
  rarity = 1,
  atlas = 'Phanta2',
  pos = { x = 4, y = 1 },
  phanta_anim = { { x = 4, y = 1, t = 2 }, { x = 5, y = 1, t = 0.15 }, { x = 4, y = 1, t = 0.25 }, { x = 5, y = 1, t = 0.15 }, { x = 4, y = 1, t = 0.25 }, { x = 5, y = 1, t = 0.15 } },
  cost = 4,
  blueprint_compat = true,
  eternal_compat = true,
  perishable_compat = true,
  calculate = function(self, card, context)
    if context.joker_main and G.jokers.config.card_limit - #G.jokers.cards == 1 then
      return {
        mult = card.ability.extra
            .mult
      }
    end
  end
}

SMODS.Joker {
  key = 'fanta',
  rarity = 1,
  atlas = 'Phanta2',
  pos = { x = 3, y = 1 },
  cost = 4,
  loc_vars = function(self, info_queue, card)
    info_queue[#info_queue + 1] = G.P_SEALS["Gold"]
    return {
      main_end = { {
        n = G.UIT.C,
        config = { align = "bm", minh = 0.4 },
        nodes =
        { {
          n = G.UIT.C,
          config = { ref_table = self, align = "m", colour = G.hand and G.hand.cards and #G.hand.cards > 0 and G.C.GREEN or G.C.RED, r = 0.05, padding = 0.06 },
          nodes = { { n = G.UIT.T, config = { text = ' ' .. localize(G.hand and G.hand.cards and #G.hand.cards > 0 and 'phanta_active' or 'phanta_inactive') .. ' ', colour = G.C.UI.TEXT_LIGHT, scale = 0.32 * 0.9 } } }
        } }
      } }
    }
  end,
  blueprint_compat = true,
  eternal_compat = true,
  perishable_compat = true,
  calculate = function(self, card, context)
    if context.selling_self and G.hand and G.hand.cards and #G.hand.cards > 0 then
      local conv_card = pseudorandom_element(G.hand.cards, pseudoseed('fantacard'))
      G.E_MANAGER:add_event(Event({
        func = function()
          play_sound('tarot1')
          card:juice_up(0.3, 0.5)
          card_eval_status_text(context.blueprint_card or card, 'extra', nil, nil, nil,
            { message = localize("phanta_created_gold_seal"), colour = G.C.GOLD, card = card })
          return true
        end
      }))

      G.E_MANAGER:add_event(Event({
        trigger = 'after',
        delay = 0.1,
        func = function()
          conv_card:set_seal("Gold", nil, true)
          return true
        end
      }))
    end
  end
}

SMODS.Joker {
  key = 'heartbreak',
  config = { extra = { xmult = 1.5, odds = 2 } },
  rarity = 2,
  atlas = 'PhantaMiscAnims1',
  pos = { x = 0, y = 9 },
  phanta_anim = {
    { xrange = { first = 0, last = 11 }, yrange = { first = 9, last = 10 }, t = 0.1 },
    { xrange = { first = 0, last = 3 },  y = 11,                            t = 0.1 }
  },
  phanta_requires_aura = true,
  cost = 6,
  loc_vars = function(self, info_queue, card)
    return { vars = { card.ability.extra.xmult, (G.GAME.probabilities.normal or 1), card.ability.extra.odds } }
  end,
  blueprint_compat = true,
  eternal_compat = true,
  perishable_compat = true,
  calculate = function(self, card, context)
    if context.individual and context.cardarea == G.play and context.other_card:is_suit("Hearts") then
      return { xmult = card.ability.extra.xmult }
    end

    if context.destroy_card and context.cardarea == G.play and context.destroy_card:is_suit("Hearts")
        and pseudorandom('heartbreak') < G.GAME.probabilities.normal / card.ability.extra.odds then
      return { remove = true }
    end
  end
}

SMODS.Joker {
  key = 'distance',
  config = { extra = { chips = 250 } },
  rarity = 3,
  atlas = 'Phanta2',
  pos = { x = 2, y = 1 },
  cost = 7,
  loc_vars = function(self, info_queue, card)
    return { vars = { card.ability.extra.chips } }
  end,
  blueprint_compat = true,
  eternal_compat = true,
  perishable_compat = true,
  add_to_deck = function(self, card, from_debuff)
    change_shop_size(-1)
  end,
  remove_from_deck = function(self, card, from_debuff)
    change_shop_size(1)
  end,
  calculate = function(self, card, context)
    if context.joker_main then return { chips = card.ability.extra.chips } end
  end
}

SMODS.Joker {
  key = 'donpaolo',
  rarity = 2,
  atlas = 'PhantaLaytonAnims',
  pos = { x = 0, y = 2 },
  phanta_anim = {
    { x = 0, y = 2, t = 1.3 }, { x = 1, y = 2, t = 0.1 },
    { x = 0, y = 2, t = 2.7 }, { x = 1, y = 2, t = 0.1 },
    { x = 0, y = 2, t = 0.1 }, { x = 1, y = 2, t = 0.1 },
    { x = 0, y = 2, t = 2.1 }, { x = 1, y = 2, t = 0.1 },
    { x = 0, y = 2, t = 2.9 }, { x = 1, y = 2, t = 0.1 },
    { x = 2, y = 2, t = 0.1 }, { x = 3, y = 2, t = 0.1 }, { x = 4, y = 2, t = 0.8 },
    { x = 3, y = 2, t = 0.1 }, { x = 4, y = 2, t = 0.4 }, { x = 3, y = 2, t = 0.1 }, { x = 4, y = 2, t = 0.4 },
    { x = 3, y = 2, t = 0.1 }, { x = 2, y = 2, t = 0.1 }, { x = 1, y = 2, t = 0.1 },
  },
  phanta_requires_aura = true,
  cost = 6,
  blueprint_compat = false,
  eternal_compat = true,
  perishable_compat = true,
  calculate = function(self, card, context)
    if context.selling_card and context.card.config.center.set == "Tarot" and #G.hand.highlighted == 1 then
      G.E_MANAGER:add_event(Event({
        trigger = 'after',
        delay = 0.2,
        func = function()
          card:juice_up()
          SMODS.destroy_cards(G.hand.highlighted)
          return true
        end
      }))
    end
  end
}

SMODS.Joker {
  key = 'futureluke',
  rarity = 2,
  atlas = 'PhantaLaytonAnims',
  pos = { x = 0, y = 3 },
  phanta_anim = {
    { x = 0, y = 3, t = 1.5 }, { x = 1, y = 3, t = 0.1 },
    { x = 0, y = 3, t = 2.2 }, { x = 1, y = 3, t = 0.1 },
    { x = 0, y = 3, t = 0.4 }, { x = 1, y = 3, t = 0.1 },
    { x = 0, y = 3, t = 1.6 }, { x = 1, y = 3, t = 0.1 },
    { x = 0, y = 3, t = 2.5 },
    { x = 1, y = 3, t = 0.4 },
    { x = 2, y = 3, t = 0.1 }, { x = 1, y = 3, t = 0.2 },
    { x = 2, y = 3, t = 0.1 }, { x = 1, y = 3, t = 0.2 },
    { x = 2, y = 3, t = 0.1 }, { x = 1, y = 3, t = 0.3 },
  },
  phanta_requires_aura = true,
  cost = 6,
  blueprint_compat = false,
  eternal_compat = true,
  perishable_compat = true,
  calculate = function(self, card, context)
    if context.selling_card and context.card.config.center.set == "Planet" and #G.hand.highlighted == 1 then
      G.E_MANAGER:add_event(Event({
        trigger = 'after',
        delay = 0.2,
        func = function()
          card:juice_up()
          SMODS.destroy_cards(G.hand.highlighted)
          return true
        end
      }))
    end
  end
}

SMODS.Joker {
  key = 'barton',
  config = { extra = { mult = 50, requirement = 15 } },
  rarity = 2,
  atlas = 'PhantaLaytonAnims',
  pos = { x = 0, y = 4 },
  phanta_anim = {
    { x = 0, y = 4, t = 1.7 }, { x = 1, y = 4, t = 0.1 },
    { x = 0, y = 4, t = 0.1 }, { x = 1, y = 4, t = 0.1 },
    { x = 0, y = 4, t = 0.1 }, { x = 1, y = 4, t = 0.1 },
    { x = 0, y = 4, t = 1.9 }, { x = 1, y = 4, t = 0.1 },
    { x = 0, y = 4, t = 0.9 }, { x = 1, y = 4, t = 0.1 },
    { x = 0, y = 4, t = 0.3 }, { x = 2, y = 4, t = 0.1 }, { x = 0, y = 4, t = 0.1 }, { x = 2, y = 4, t = 0.1 }, { x = 0, y = 4, t = 0.3 }, { x = 1, y = 4, t = 0.1 }, { x = 0, y = 4, t = 0.4 },
    { x = 3, y = 4, t = 0.2 }, { x = 0, y = 4, t = 0.2 }, { x = 4, y = 4, t = 0.2 }, { x = 0, y = 4, t = 0.05 },
    { x = 3, y = 4, t = 0.2 }, { x = 0, y = 4, t = 0.2 }, { x = 4, y = 4, t = 0.2 }, { x = 0, y = 4, t = 0.05 },
    { x = 3, y = 4, t = 0.2 }, { x = 0, y = 4, t = 0.2 }, { x = 4, y = 4, t = 0.2 }, { x = 0, y = 4, t = 0.05 }
  },
  phanta_requires_aura = true,
  cost = 6,
  blueprint_compat = true,
  eternal_compat = true,
  perishable_compat = true,
  loc_vars = function(self, info_queue, card)
    return {
      vars = { card.ability.extra.mult, card.ability.extra.requirement, count_unique_tarots(),
        (next(SMODS.find_card("j_phanta_inspectorchelmey")) or count_unique_tarots() >= card.ability.extra.requirement) and
        localize("phanta_active") or localize("phanta_inactive") }
    }
  end,
  calculate = function(self, card, context)
    if context.joker_main then
      if next(SMODS.find_card("j_phanta_inspectorchelmey")) or count_unique_tarots() >= card.ability.extra.requirement then
        return { mult = card.ability.extra.mult }
      end
    end
  end
}

SMODS.Joker {
  key = 'inspectorchelmey',
  config = { extra = { xmult = 3, requirement = 9 } },
  rarity = 2,
  atlas = 'PhantaLaytonAnims',
  pos = { x = 0, y = 5 },
  phanta_anim = {
    { x = 0, y = 5, t = 1.2 }, { x = 1, y = 5, t = 0.1 },
    { x = 0, y = 5, t = 2.5 }, { x = 1, y = 5, t = 0.1 },
    { x = 0, y = 5, t = 0.1 }, { x = 1, y = 5, t = 0.1 },
    { x = 0, y = 5, t = 1.6 }, { x = 1, y = 5, t = 0.1 },
    { x = 2, y = 5, t = 2.1 }, { x = 3, y = 5, t = 0.1 },
    { x = 4, y = 5, t = 2.7 }, { x = 5, y = 5, t = 0.1 },
    { x = 4, y = 5, t = 0.9 }, { x = 5, y = 5, t = 0.1 },
    { x = 4, y = 5, t = 1.8 }, { x = 5, y = 5, t = 0.1 }, { x = 4, y = 5, t = 0.4 },
    { x = 3, y = 5, t = 0.1 }, { x = 1, y = 5, t = 0.3 },
  },
  phanta_requires_aura = true,
  cost = 6,
  blueprint_compat = true,
  eternal_compat = true,
  perishable_compat = true,
  loc_vars = function(self, info_queue, card)
    return {
      vars = { card.ability.extra.xmult, card.ability.extra.requirement, count_unique_planets(),
        (next(SMODS.find_card("j_phanta_barton")) or count_unique_planets() >= card.ability.extra.requirement) and
        localize("phanta_active") or localize("phanta_inactive") }
    }
  end,
  calculate = function(self, card, context)
    if context.joker_main then
      if next(SMODS.find_card("j_phanta_barton")) or count_unique_planets() >= card.ability.extra.requirement then
        return { xmult = card.ability.extra.xmult }
      end
    end
  end
}

SMODS.Joker {
  key = 'zeroii',
  config = { extra = { odds = 3 } },
  rarity = 2,
  atlas = 'Phanta2',
  pos = { x = 1, y = 1 },
  cost = 6,
  blueprint_compat = true,
  eternal_compat = true,
  perishable_compat = true,
  loc_vars = function(self, info_queue, card)
    return { vars = { (G.GAME.probabilities.normal or 1), card.ability.extra.odds } }
  end,
  calculate = function(self, card, context)
    if context.discard and G.GAME.current_round.discards_used <= 0 and pseudorandom('zeroii') < G.GAME.probabilities.normal / card.ability.extra.odds then
      return { remove = true }
    end
  end
}

--[[SMODS.Joker {
  key = 'snoinches',
  rarity = 2,
  atlas = 'Phanta2',
  pos = { x = 11, y = 1 },
  cost = 5,
  blueprint_compat = true,
  eternal_compat = true,
  perishable_compat = true,
  calculate = function(self, card, context)
    if context.after and G.play.cards and G.play.cards[1] then
      draw_card(G.play, G.hand, 90, 'up', true, G.play.cards[1])
      return { message = "Mrrrp", colour = G.C.GOLD, card = card }
    end
  end,
  set_badges = function(self, card, badges)
    badges[#badges + 1] = create_badge(localize('credit_bobisnotaperson'), G.C.PHANTA.MISC_COLOURS.PHANTA, G.C.WHITE, 1)
  end
}]] --

SMODS.Joker {
  key = 'clapperboard',
  rarity = 2,
  atlas = 'Phanta2',
  pos = { x = 4, y = 0 },
  cost = 6,
  blueprint_compat = false,
  eternal_compat = true,
  perishable_compat = true,
  in_pool = function()
    return #SMODS.find_card('v_retcon') == 0
  end
}

SMODS.Joker {
  key = 'agentboard',
  config = { extra = { money = 4 } },
  rarity = 2,
  atlas = 'Phanta2',
  pos = { x = 6, y = 1 },
  cost = 5,
  blueprint_compat = false,
  eternal_compat = true,
  perishable_compat = true,
  loc_vars = function(self, info_queue, card)
    return { vars = { card.ability.extra.money, card.ability.extra.money * count_settlements() } }
  end,
  calc_dollar_bonus = function(self, card)
    if count_settlements() > 0 then return card.ability.extra.money * count_settlements() end
  end
}

SMODS.Joker {
  key = 'birthdaycard',
  config = { extra = { added_xmult = 0.2, current_xmult = 1 } },
  loc_vars = function(self, info_queue, card)
    info_queue[#info_queue + 1] = G.P_CENTERS.e_phanta_waxed
    return { vars = { card.ability.extra.added_xmult, card.ability.extra.current_xmult } }
  end,
  rarity = 2,
  atlas = 'Phanta2',
  pos = { x = 5, y = 0 },
  cost = 5,
  blueprint_compat = true,
  eternal_compat = true,
  perishable_compat = true,
  calculate = function(self, card, context)
    if context.joker_main and card.ability.extra.current_xmult > 1 then
      return { xmult = card.ability.extra.current_xmult }
    end

    if context.remove_playing_cards and not context.blueprint then
      local waxed_cards = {}
      for i = 1, #context.removed do
        if context.removed[i].edition and context.removed[i].edition.key == 'e_phanta_waxed' then
          waxed_cards[#waxed_cards + 1] =
              context.removed[i].edition.key
        end
      end

      if #waxed_cards > 0 then
        card.ability.extra.current_xmult = card.ability.extra.current_xmult +
            (#waxed_cards * card.ability.extra.added_xmult)
        return { message = localize("k_upgrade_ex"), colour = G.C.FILTER, card = card }
      end
    end
  end
}

SMODS.Joker {
  key = 'plugsocket',
  config = { extra = { xmult = 0.25 } },
  loc_vars = function(self, info_queue, card)
    return { vars = { card.ability.extra.xmult, 1 + (#count_base_copper_grates() * card.ability.extra.xmult) } }
  end,
  rarity = 2,
  atlas = 'Phanta2',
  pos = { x = 3, y = 0 },
  cost = 6,
  blueprint_compat = true,
  eternal_compat = true,
  perishable_compat = true,
  calculate = function(self, card, context)
    if context.joker_main then
      local copper_grates = #count_base_copper_grates()
      if copper_grates > 0 then
        return { xmult = 1 + (copper_grates * card.ability.extra.xmult) }
      end
    end
  end
}

SMODS.Joker {
  key = 'neonjoker',
  config = { extra = { xmult = 3 } },
  rarity = 2,
  atlas = 'Phanta2',
  pos = { x = 10, y = 0 },
  phanta_anim = {
    { x = 10, y = 0, t = 0.9 }, { x = 11, y = 0, t = 0.1 },
    { x = 10, y = 0, t = 0.1 }, { x = 11, y = 0, t = 0.1 },
    { x = 10, y = 0, t = 0.5 }, { x = 11, y = 0, t = 0.1 },
    { x = 10, y = 0, t = 1.6 }, { x = 11, y = 0, t = 0.1 },
    { x = 10, y = 0, t = 0.4 }, { x = 11, y = 0, t = 0.1 },
    { x = 10, y = 0, t = 0.2 }, { x = 11, y = 0, t = 0.1 },
    { x = 10, y = 0, t = 1.1 }, { x = 11, y = 0, t = 0.1 },
    { x = 10, y = 0, t = 1.5 }, { x = 11, y = 0, t = 0.1 },
    { x = 10, y = 0, t = 0.5 }, { x = 11, y = 0, t = 0.1 },
    { x = 10, y = 0, t = 0.8 }, { x = 11, y = 0, t = 0.1 },
    { x = 10, y = 0, t = 0.1 }, { x = 11, y = 0, t = 0.1 },
    { x = 10, y = 0, t = 0.1 }, { x = 11, y = 0, t = 0.1 },
    { x = 10, y = 0, t = 1.4 }, { x = 11, y = 0, t = 0.1 },
    { x = 10, y = 0, t = 0.2 }, { x = 11, y = 0, t = 0.1 },
    { x = 10, y = 0, t = 1.3 }, { x = 11, y = 0, t = 0.1 }
  },
  cost = 6,
  loc_vars = function(self, info_queue, card)
    return { vars = { card.ability.extra.xmult } }
  end,
  blueprint_compat = true,
  eternal_compat = true,
  perishable_compat = true,
  calculate = function(self, card, context)
    if context.joker_main then
      local wilds = 0
      local counted_suits = {}
      for i = 1, #G.hand.cards do
        if not SMODS.has_any_suit(G.hand.cards[i]) then
          local is_new = true
          for j = 1, #counted_suits do
            if G.hand.cards[i].base.suit == counted_suits[j] then is_new = false end
          end
          if is_new then counted_suits[#counted_suits + 1] = G.hand.cards[i].base.suit end
        else
          wilds = wilds + 1
        end
      end

      if #counted_suits + wilds >= 4 then
        return { xmult = card.ability.extra.xmult }
      end
    end
  end
}

SMODS.Joker {
  key = 'technojoker',
  config = { extra = { xmult = 0.5 } },
  loc_vars = function(self, info_queue, card)
    return { vars = { card.ability.extra.xmult, 1 + (count_missing_ranks() * card.ability.extra.xmult) } }
  end,
  rarity = 3,
  atlas = 'Phanta2',
  pos = { x = 1, y = 0 },
  phanta_anim = { { x = 1, y = 0, t = 0.5 }, { x = 2, y = 0, t = 0.5 } },
  cost = 8,
  blueprint_compat = true,
  eternal_compat = true,
  perishable_compat = true,
  calculate = function(self, card, context)
    if context.joker_main then
      local missing_ranks = count_missing_ranks()
      if missing_ranks > 0 then
        return { xmult = 1 + (missing_ranks * card.ability.extra.xmult) }
      end
    end
  end
}
