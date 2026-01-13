SMODS.Back {
  key = 'stormcaught',
  atlas = 'Decks',
  pos = { x = 0, y = 0 },
  calculate = function(self, back, context)
    if context.context == 'eval' and G.GAME.last_blind and (G.GAME.last_blind.boss or G.GAME.selected_sleeve == "sleeve_phanta_stormcaught") then
      G.E_MANAGER:add_event(Event({
        func = function()
          add_tag(Tag('tag_uncommon'))
          play_sound('generic1', 0.9 + math.random() * 0.1, 0.8)
          play_sound('holo1', 1.2 + math.random() * 0.1, 0.4)
          return true
        end
      }))
    end
  end,
  apply = function(self, back)
    G.E_MANAGER:add_event(Event({
      func = function()
        add_tag(Tag('tag_uncommon'))
        play_sound('generic1', 0.9 + math.random() * 0.1, 0.8)
        play_sound('holo1', 1.2 + math.random() * 0.1, 0.4)
        return true
      end
    }))
  end
}

SMODS.Back {
  key = 'blurple',
  atlas = 'Decks',
  pos = { x = 1, y = 0 },
  calculate = function(self, back, context)
    if context.setting_blind and count_consumables() < G.consumeables.config.card_limit then
      G.E_MANAGER:add_event(Event({
        delay = 0.3,
        blockable = false,
        func = function()
          play_sound('timpani')
          local new_card = create_card("Tarot_Planet", G.consumables, nil, nil, nil, nil, nil, 'blurpledeck')
          new_card:add_to_deck()
          G.consumeables:emplace(new_card)
          return true
        end
      }))
    end
  end
}

SMODS.Back {
  key = 'azran',
  atlas = 'Decks',
  pos = { x = 2, y = 0 }
}

SMODS.Back {
  key = 'badd',
  atlas = 'Decks',
  pos = { x = 3, y = 0 },
  calculate = function(self, back, context)
    if G.GAME.current_round.hands_left == 0 and context.destroy_card and (context.cardarea == G.play or context.cardarea == "unscored") then
      return { remove = true }
    end
  end
}

SMODS.Back {
  key = 'silver',
  atlas = 'Decks',
  pos = { x = 4, y = 0 },
  config = { extra = { given_money = 1, minus_hand_size = 1 } },
  loc_vars = function(self, info_queue, center)
    return { vars = { self.config.extra.given_money, self.config.extra.minus_hand_size } }
  end,
  apply = function(self, back)
    G.GAME.starting_params.hand_size = G.GAME.starting_params.hand_size - self.config.extra.minus_hand_size
  end,
  calculate = function(self, back, context)
    if context.individual and context.cardarea == "unscored" then
      return { dollars = self.config.extra.given_money, message_card = context.other_card }
    end
  end
}

SMODS.Back {
  key = 'tally',
  atlas = 'Decks',
  pos = { x = 0, y = 1 },
  config = { extra = { given_joker_slots = 1, triggered = false } },
  loc_vars = function(self, info_queue, center)
    return { vars = { self.config.extra.given_joker_slots } }
  end,
  calculate = function(self, back, context)
    if context.setting_blind and G.GAME.blind:get_type() == "Small" and G.GAME.round_resets.ante == 5 and not self.config.extra.triggered then
      G.jokers.config.card_limit = G.jokers.config.card_limit + 1
      self.config.extra.triggered = true

      local destructable_jokers = {}
      for i = 1, #G.jokers.cards do
        if not G.jokers.cards[i].ability.eternal and not G.jokers.cards[i].getting_sliced then
          destructable_jokers[#destructable_jokers + 1] = G.jokers.cards[i]
        end
      end
      local joker_to_destroy = #destructable_jokers > 0 and
          pseudorandom_element(destructable_jokers, pseudoseed('tallydeck')) or nil

      if joker_to_destroy and not (context.blueprint_card or self).getting_sliced then
        joker_to_destroy.getting_sliced = true
        G.E_MANAGER:add_event(Event({
          func = function()
            play_sound("phanta_tally_deck", 1, 0.5)
            joker_to_destroy:start_dissolve({ G.C.RED }, nil, 1.6)
            return true
          end
        }))
      end
    end
  end
}

SMODS.Back {
  key = 'trickster',
  atlas = 'Decks',
  pos = { x = 1, y = 1 },
  calculate = function(self, back, context)
    if context.playing_card_added then
      for i = 1, #context.cards do
        G.E_MANAGER:add_event(Event({
          func = function()
            G.E_MANAGER:add_event(Event({
              delay = 0.3,
              blockable = false,
              func = function()
                if count_consumables() < G.consumeables.config.card_limit then
                  play_sound('timpani')
                  local new_card = create_card("Tarot", G.consumables, nil, nil, nil, nil, 'c_hanged_man')
                  new_card:add_to_deck()
                  G.consumeables:emplace(new_card)
                end
                return true
              end
            }))

            return true
          end
        }))
      end
    end
  end
}

SMODS.Back {
  key = 'barrier',
  atlas = 'Decks',
  pos = { x = 2, y = 1 },
  calculate = function(self, back, context)
    if context.skipping_booster then
      if not G.GAME.barrier_extra_hand_size then
        G.GAME.barrier_extra_hand_size = 1
      else
        G.GAME.barrier_extra_hand_size = G.GAME.barrier_extra_hand_size + 1
      end

      G.hand:change_size(1)
    end

    if context.end_of_round and G.GAME.barrier_extra_hand_size and G.GAME.barrier_extra_hand_size > 0 then
      G.hand:change_size(-G.GAME.barrier_extra_hand_size)
      G.GAME.barrier_extra_hand_size = 0
    end
  end
}

SMODS.Back {
  key = 'poltergeist',
  atlas = 'Decks',
  pos = { x = 3, y = 1 },
  config = { extra = { plus_hand_size = 2 } },
  loc_vars = function(self, info_queue, center)
    return { vars = { self.config.extra.plus_hand_size } }
  end,
  apply = function(self, back)
    G.GAME.starting_params.hand_size = G.GAME.starting_params.hand_size + self.config.extra.plus_hand_size
  end,
  calculate = function(self, back, context)
    if context.stay_flipped then
      local back_cards = 0
      for i = 1, #G.hand.cards do if G.hand.cards[i].facing == 'back' then back_cards = back_cards + 1 end end

      if back_cards < (G.GAME.selected_sleeve == "sleeve_phanta_poltergeist" and 2 or 1) * self.config.extra.plus_hand_size then
        return { stay_flipped = true }
      end
    end
  end
}

SMODS.Back {
  key = 'invisible',
  atlas = 'Decks',
  pos = { x = 4, y = 3 },
  apply = function(self, back)
    G.E_MANAGER:add_event(Event({
      func = function()
        for i = 1, #G.playing_cards do
          if G.playing_cards[i]:get_id() == 14 and G.playing_cards[i]:is_suit("Spades") then
            G.playing_cards[i]:set_seal("phanta_ghostseal", true, true)
          end
        end
        return true
      end,
    }))
  end
}

SMODS.Back {
  key = 'hivis',
  atlas = 'Decks',
  pos = { x = 4, y = 1 },
  config = { vouchers = { 'v_directors_cut' } },
  loc_vars = function(self, info_queue, card)
    return { vars = { localize({ type = 'name_text', set = 'Voucher', key = self.config.vouchers[1] }) } }
  end
}

SMODS.Back {
  key = 'crate',
  atlas = 'Decks',
  pos = { x = 0, y = 2 },
  config = { extra = { added_slots = 2 } },
  loc_vars = function(self, info_queue, card)
    return { vars = { self.config.extra.added_slots } }
  end,
  apply = function(self, back)
    G.GAME.starting_params.consumable_slots = G.GAME.starting_params.consumable_slots + self.config.extra.added_slots
  end
}

SMODS.Back {
  key = 'todayandtomorrow',
  atlas = 'Decks',
  pos = { x = 1, y = 2 }
}

SMODS.Back {
  key = 'gildedseven',
  atlas = 'Decks',
  pos = { x = 0, y = 4 },
  apply = function(self, back)
    G.E_MANAGER:add_event(Event({
      func = function()
        for i = 1, #G.playing_cards do
          if G.playing_cards[i]:get_id() == 7 then
            G.playing_cards[i]:set_ability(G.P_CENTERS["m_gold"])
          end
        end
        return true
      end,
    }))
  end
}

SMODS.Back {
  key = 'hazel',
  atlas = 'Decks',
  pos = { x = 2, y = 2 }
}

local get_new_boss_ref = get_new_boss

function get_new_boss()
  if G.GAME and G.GAME.selected_back and G.GAME.selected_back and G.GAME.selected_back.effect and G.GAME.selected_back.effect.center.key == "b_phanta_hazel" then
    return "bl_final_acorn"
  else
    return get_new_boss_ref()
  end
end

SMODS.Back {
  key = 'thebel',
  atlas = 'Decks',
  pos = { x = 4, y = 4 },
  phanta_deck_shader = "booster",
  apply = function(self, back)
    delay(0.4)
    G.E_MANAGER:add_event(Event({
      func = function()
        SMODS.add_card({ key = "c_moon", edition = "e_negative" })
        SMODS.add_card({ key = "c_justice", edition = "e_negative" })
        SMODS.add_card({ key = "c_death", edition = "e_negative" })
        return true
      end
    }))
  end
}

SMODS.Back {
  key = 'rebel',
  atlas = 'Decks',
  pos = { x = 0, y = 5 },
  calculate = function(self, back, context)
    if context.individual and context.cardarea == G.play and context.other_card:get_id() == 14 and context.other_card:is_suit("Hearts") and count_consumables() < G.consumeables.config.card_limit then
      return {
        extra = {
          focus = context.other_card,
          message = localize('k_plus_tarot'),
          func = function()
            G.E_MANAGER:add_event(Event({
              trigger = 'before',
              delay = 0.0,
              func = function()
                play_sound("timpani")
                local new_card = SMODS.add_card({ set = "Tarot", key_append = "rebeldeck" })
                return true
              end
            }))
          end
        },
        colour = G.C.PURPLE,
        card = context.other_card
      }
    end
  end
}

SMODS.Back {
  key = 'retired',
  atlas = 'Decks',
  pos = { x = 1, y = 4 },
  phanta_deck_shader = "phanta_drilled",
  apply = function(self, back)
    G.E_MANAGER:add_event(Event({
      func = function()
        for i = 1, #G.playing_cards do
          if G.playing_cards[i]:get_id() == 14 then
            G.playing_cards[i]:set_edition("e_phanta_drilled", true, true)
          end
        end
        return true
      end,
    }))
  end
}

SMODS.Back {
  key = 'bee',
  atlas = 'Decks',
  pos = { x = 2, y = 4 },
  phanta_deck_shader = "phanta_waxed",
  apply = function(self, back)
    G.E_MANAGER:add_event(Event({
      func = function()
        for i = 1, #G.playing_cards do
          if G.playing_cards[i]:is_face() then
            G.playing_cards[i]:set_edition("e_phanta_waxed", true, true)
          end
        end
        return true
      end,
    }))
  end
}

SMODS.Back {
  key = 'spectrum',
  atlas = 'Decks',
  pos = { x = 3, y = 2 },
  config = { discards = 1, dollars = 10, joker_slot = 1, extra_hand_bonus = 2, extra_discard_bonus = 1, no_interest = true, extra = { removed_shop_slots = 1 } },
  loc_vars = function(self, info_queue, card)
    return { vars = { self.config.extra.removed_shop_slots } }
  end,
  apply = function(self, back)
    G.GAME.starting_params.boosters_in_shop = G.GAME.starting_params.boosters_in_shop -
        self.config.extra.removed_shop_slots
  end
}



SMODS.Back {
  key = 'bloodred',
  atlas = 'Decks',
  pos = { x = 4, y = 2 },
  config = { extra = { discards = 3 } },
  loc_vars = function(self, info_queue, card)
    return { vars = { self.config.extra.discards } }
  end,
  calculate = function(self, back, context)
    if context.setting_blind and is_blind_boss() then
      G.E_MANAGER:add_event(Event({
        func = function()
          ease_discard(self.config.extra.discards)
          play_sound('phanta_charged_deck', 1, 0.75)
          return true
        end
      }))
    end
  end
}

SMODS.Back {
  key = 'deepblue',
  atlas = 'Decks',
  pos = { x = 0, y = 3 },
  config = { extra = { hands = 3 } },
  loc_vars = function(self, info_queue, card)
    return { vars = { self.config.extra.hands } }
  end,
  calculate = function(self, back, context)
    if context.setting_blind and is_blind_boss() then
      G.E_MANAGER:add_event(Event({
        func = function()
          ease_hands_played(self.config.extra.hands)
          play_sound('phanta_charged_deck', 1, 0.75)
          return true
        end
      }))
    end
  end
}

SMODS.Back {
  key = 'canaryyellow',
  atlas = 'Decks',
  pos = { x = 1, y = 3 },
  apply = function(self, back)
    G.E_MANAGER:add_event(Event({
      func = function()
        if G.jokers then
          local edition = G.GAME and G.GAME.selected_sleeve == "sleeve_phanta_canaryyellow" and "e_negative" or nil
          local no_edition = G.GAME and G.GAME.selected_sleeve == "sleeve_phanta_canaryyellow" and nil or true
          local card = SMODS.create_card({
            set = "Joker",
            area = G.jokers,
            key = "j_mail",
            no_edition = no_edition,
            edition =
                edition
          })
          card:add_to_deck()
          card:start_materialize()
          if G.GAME and G.GAME.selected_sleeve == "sleeve_phanta_canaryyellow" and "e_negative" then
            card:set_eternal(true)
          end
          G.jokers:emplace(card)
          return true
        end
      end
    }))
  end
}

SMODS.Back {
  key = 'meangreen',
  atlas = 'Decks',
  pos = { x = 2, y = 3 },
  config = { extra_hand_bonus = 0, extra = { extra_interest = 1 } },
  loc_vars = function(self, info_queue, card)
    return { vars = { self.config.extra.extra_interest + 1, self.config.extra_hand_bonus } }
  end,
  apply = function(self, back)
    G.GAME.interest_amount = G.GAME.interest_amount + self.config.extra.extra_interest
  end
}

SMODS.Back {
  key = 'pitchblack',
  atlas = 'Decks',
  pos = { x = 3, y = 3 },
  config = { vouchers = { 'v_overstock_norm' } },
  loc_vars = function(self, info_queue, card)
    return { vars = { localize({ type = 'name_text', set = 'Voucher', key = self.config.vouchers[1] }) } }
  end
}
