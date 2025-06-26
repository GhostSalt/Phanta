SMODS.current_mod.optional_features = { cardareas = { unscored = true } }

SMODS.Atlas {
  key = "PhantaSleeves",
  path = "PhantaSleeves.png",
  px = 73,
  py = 95
}

CardSleeves.Sleeve {
  key = "stormcaught",
  name = "Stormcaught Sleeve",
  atlas = "PhantaSleeves",
  pos = { x = 0, y = 0 },
  unlocked = false,
  unlock_condition = { deck = "b_phanta_stormcaught", stake = "stake_white" },
  loc_vars = function(self)
    key = self.key
    if self.get_current_deck_key() == "b_phanta_stormcaught" then
      key = self.key .. "_alt"
    end
    return { key = key }
  end,
  calculate = function(self, sleeve, context)
    if self.get_current_deck_key() ~= "b_phanta_stormcaught" and context.context == 'eval' and G.GAME.last_blind and G.GAME.last_blind.boss then
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
    if self.get_current_deck_key() ~= "b_phanta_stormcaught" then
      G.E_MANAGER:add_event(Event({
        func = function()
          add_tag(Tag('tag_uncommon'))
          play_sound('generic1', 0.9 + math.random() * 0.1, 0.8)
          play_sound('holo1', 1.2 + math.random() * 0.1, 0.4)
          return true
        end
      }))
    end
  end
}

CardSleeves.Sleeve {
  key = "blurple",
  name = "Blurple Sleeve",
  atlas = "PhantaSleeves",
  pos = { x = 1, y = 0 },
  unlocked = false,
  unlock_condition = { deck = "b_phanta_blurple", stake = "stake_white" },
  calculate = function(self, sleeve, context)
    if context.setting_blind and count_consumables() < G.consumeables.config.card_limit then
      G.E_MANAGER:add_event(Event({
        delay = 0.3,
        blockable = false,
        func = function()
          play_sound('timpani')
          local new_card = create_card("Tarot_Planet", G.consumables, nil, nil, nil, nil, nil, 'blurplesleeve')
          new_card:add_to_deck()
          G.consumeables:emplace(new_card)
          return true
        end
      }))
    end
  end
}

CardSleeves.Sleeve {
  key = "azran",
  name = "Azran Sleeve",
  atlas = "PhantaSleeves",
  pos = { x = 2, y = 0 },
  unlocked = false,
  unlock_condition = { deck = "b_phanta_azran", stake = "stake_white" },
  loc_vars = function(self)
    key = self.key
    if self.get_current_deck_key() == "b_phanta_azran" then
      key = self.key .. "_alt"
      self.config = { spectral_rate = 2 }
    end
    return { key = key }
  end
}

CardSleeves.Sleeve {
  key = "badd",
  name = "Badd Sleeve",
  atlas = "PhantaSleeves",
  pos = { x = 3, y = 0 },
  unlocked = false,
  unlock_condition = { deck = "b_phanta_badd", stake = "stake_white" },
  loc_vars = function(self)
    key = self.key
    if self.get_current_deck_key() == "b_phanta_badd" then
      key = self.key .. "_alt"
    end
    return { key = key }
  end,
  calculate = function(self, back, context)
    if self.get_current_deck_key() ~= "b_phanta_badd" and G.GAME.current_round.hands_left == 0 and context.destroy_card and (context.cardarea == G.play or context.cardarea == "unscored") then
      return { remove = true }
    end

    if self.get_current_deck_key() == "b_phanta_badd" and context.discard and G.GAME.current_round.discards_used <= 0 and #context.full_hand == 1 then
      return { remove = true }
    end
  end
}

CardSleeves.Sleeve {
  key = "silver",
  name = "Silver Sleeve",
  atlas = "PhantaSleeves",
  pos = { x = 4, y = 0 },
  unlocked = false,
  unlock_condition = { deck = "b_phanta_silver", stake = "stake_white" },
  loc_vars = function(self)
    if self.get_current_deck_key() == "b_phanta_silver" then
      key = self.key .. "_alt"
      self.config = { extra = { plus_hand_size = 1 } }
      return { key = key, vars = { self.config.extra.plus_hand_size } }
    else
      key = self.key
      self.config = { extra = { given_money = 1, minus_hand_size = 1 } }
      return { key = key, vars = { self.config.extra.given_money, self.config.extra.minus_hand_size } }
    end
  end,
  apply = function(self, back)
    if self.config.extra.minus_hand_size then
      G.GAME.starting_params.hand_size = G.GAME.starting_params.hand_size + self.config.extra.minus_hand_size
    end
    if self.config.extra.plus_hand_size then
      G.GAME.starting_params.hand_size = G.GAME.starting_params.hand_size + self.config.extra.plus_hand_size
    end
  end,
  calculate = function(self, back, context)
    if self.get_current_deck_key() ~= "b_phanta_silver" and context.individual and context.cardarea == "unscored" then
      SMODS.calculate_effect({ dollars = self.config.extra.given_money }, context.other_card)
    end
  end
}

CardSleeves.Sleeve {
  key = "tally",
  name = "Tally Sleeve",
  atlas = "PhantaSleeves",
  pos = { x = 0, y = 1 },
  unlocked = false,
  unlock_condition = { deck = "b_phanta_tally", stake = "stake_white" },
  loc_vars = function(self)
    if self.get_current_deck_key() ~= "b_phanta_tally" then
      key = self.key
      self.config = { extra = { given_joker_slots = 1, triggered = false } }
      return { key = key, vars = { self.config.extra.given_joker_slots, self.config.extra.triggered } }
    else
      key = self.key .. "_alt"
      return { key = key }
    end
  end,
  calculate = function(self, back, context)
    if self.get_current_deck_key() ~= "b_phanta_tally" and context.setting_blind and G.GAME.blind:get_type() == "Small" and G.GAME.round_resets.ante == 5 and not self.config.extra.triggered then
      G.jokers.config.card_limit = G.jokers.config.card_limit + 1
      self.config.extra.triggered = true
      local destructable_jokers = {}
      for i = 1, #G.jokers.cards do
        if not G.jokers.cards[i].ability.eternal and not G.jokers.cards[i].getting_sliced then
          destructable_jokers[#destructable_jokers + 1] =
              G.jokers.cards[i]
        end
      end
      local joker_to_destroy = #destructable_jokers > 0 and
          pseudorandom_element(destructable_jokers, pseudoseed('tallydeck')) or nil

      if joker_to_destroy and not (context.blueprint_card or self).getting_sliced then
        joker_to_destroy.getting_sliced = true
        G.E_MANAGER:add_event(Event({
          func = function()
            play_sound("phanta_tally_deck", 1, 0.75)
            joker_to_destroy:start_dissolve({ G.C.RED }, nil, 1.6)
            return true
          end
        }))
      end
    end
  end
}

CardSleeves.Sleeve {
  key = "trickster",
  name = "Trickster Sleeve",
  atlas = "PhantaSleeves",
  pos = { x = 1, y = 1 },
  unlocked = false,
  unlock_condition = { deck = "b_phanta_trickster", stake = "stake_white" },
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

CardSleeves.Sleeve {
  key = "barrier",
  name = "Barrier Sleeve",
  atlas = "PhantaSleeves",
  pos = { x = 2, y = 1 },
  unlocked = false,
  unlock_condition = { deck = "b_phanta_barrier", stake = "stake_white" },
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

CardSleeves.Sleeve {
  key = "poltergeist",
  name = "Poltergeist Sleeve",
  atlas = "PhantaSleeves",
  pos = { x = 3, y = 1 },
  unlocked = false,
  unlock_condition = { deck = "b_phanta_poltergeist", stake = "stake_white" },
  config = { extra = { plus_hand_size = 2 } },
  loc_vars = function(self)
    if self.get_current_deck_key() == "b_phanta_poltergeist" then
      key = self.key .. "_alt"
    else
      key = self.key
    end
    return { key = key, vars = { self.config.extra.plus_hand_size } }
  end,
  apply = function(self, back)
    G.GAME.starting_params.hand_size = G.GAME.starting_params.hand_size + self.config.extra.plus_hand_size
  end,
  calculate = function(self, back, context)
    if self.get_current_deck_key() ~= "b_phanta_poltergeist" and context.stay_flipped then
      local back_cards = 0
      for i = 1, #G.hand.cards do if G.hand.cards[i].facing == 'back' then back_cards = back_cards + 1 end end

      if back_cards < self.config.extra.plus_hand_size then
        return { stay_flipped = true }
      end
    end
  end
}

CardSleeves.Sleeve {
  key = "hivis",
  name = "Hi-Vis Sleeve",
  atlas = "PhantaSleeves",
  pos = { x = 4, y = 1 },
  unlocked = false,
  unlock_condition = { deck = "b_phanta_hivis", stake = "stake_white" },
  config = { vouchers = { 'v_directors_cut' } },
  loc_vars = function(self, info_queue, card)
    if self.get_current_deck_key() == "b_phanta_hivis" then
      key = self.key .. "_alt"
      self.config = { vouchers = { 'v_retcon' } }
    else
      key = self.key
      self.config = { vouchers = { 'v_directors_cut' } }
    end
    return { key = key, vars = { localize({ type = 'name_text', set = 'Voucher', key = self.config.vouchers[1] }) } }
  end
}

CardSleeves.Sleeve {
  key = "crate",
  name = "Crate Sleeve",
  atlas = "PhantaSleeves",
  pos = { x = 0, y = 2 },
  unlocked = false,
  unlock_condition = { deck = "b_phanta_crate", stake = "stake_white" },
  config = { extra = { added_slots = 2 } },
  loc_vars = function(self, info_queue, card)
    return { vars = { self.config.extra.added_slots } }
  end,
  apply = function(self, back)
    G.GAME.starting_params.consumable_slots = G.GAME.starting_params.consumable_slots + self.config.extra.added_slots
  end
}

CardSleeves.Sleeve {
  key = "todayandtomorrow",
  name = "Today & Tomorrow Sleeve",
  atlas = "PhantaSleeves",
  pos = { x = 1, y = 2 },
  unlocked = false,
  unlock_condition = { deck = "b_phanta_todayandtomorrow", stake = "stake_white" }
}

CardSleeves.Sleeve {
  key = "spectrum",
  name = "Spectrum Sleeve",
  atlas = "PhantaSleeves",
  pos = { x = 2, y = 2 },
  unlocked = false,
  unlock_condition = { deck = "b_phanta_spectrum", stake = "stake_white" },
  loc_vars = function(self, info_queue, card)
    if self.get_current_deck_key() == "b_phanta_spectrum" then
      key = self.key .. "_alt"
      self.config = { discards = 1, dollars = 10, joker_slot = 1, extra_hand_bonus = 2, extra_discard_bonus = 1, no_interest = true, extra = { added_shop_slots = 1 } }
      return { key = key }
    else
      key = self.key
      self.config = { discards = 1, dollars = 10, joker_slot = 1, extra_hand_bonus = 2, extra_discard_bonus = 1, no_interest = true, extra = { removed_shop_slots = 1 } }
      return { key = key, vars = { self.config.extra.removed_shop_slots } }
    end
  end,
  apply = function(self, back)
    if self.config.extra.added_shop_slots then
      G.GAME.starting_params.boosters_in_shop = G.GAME.starting_params.boosters_in_shop + self.config.extra.added_shop_slots
    else
      G.GAME.starting_params.discards = G.GAME.starting_params.discards + self.config.discards
      G.GAME.starting_params.dollars.array[1] = G.GAME.starting_params.dollars.array[1] + self.config.dollars
      G.GAME.starting_params.joker_slots = G.GAME.starting_params.joker_slots + self.config.joker_slot
      G.GAME.modifiers.no_interest = self.config.no_interest
      G.GAME.modifiers.money_per_hand = self.config.extra_hand_bonus
      G.GAME.modifiers.money_per_discard = self.config.extra_discard_bonus
      G.GAME.starting_params.boosters_in_shop = G.GAME.starting_params.boosters_in_shop - self.config.extra.removed_shop_slots
    end
  end
}