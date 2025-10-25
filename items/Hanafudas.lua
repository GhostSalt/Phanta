local hanafuda_atlas = "PhantaHanafudas"
if next(SMODS.find_mod('HotPotato')) then hanafuda_atlas = "PhantaHanafudasWithHotPot" end

SMODS.ConsumableType {
  key = "phanta_Hanafuda",
  primary_colour = HEX("FB8536"),
  secondary_colour = HEX("DB534A"),
  collection_rows = { 4, 4, 4 },
  shop_rate = 0,
  cost = 3,
  default = "phanta_pine_chaff_a",
  can_stack = true,
  can_divide = true,
  in_pool = function()
    return Phanta.config["hanafuda_enabled"]
  end
}

SMODS.UndiscoveredSprite({
  key = "phanta_Hanafuda",
  atlas = hanafuda_atlas,
  path = "PhantaHanafudas.png",
  pos = { x = 0, y = 4 },
  px = 71,
  py = 95,
}):register()







SMODS.Consumable {
  set = "phanta_Hanafuda",
  key = "pine_chaff_a",
  pos = { x = 0, y = 2 },
  atlas = hanafuda_atlas,
  config = { phanta_chaff = true, extra = { tarots = 2 } },
  loc_vars = function(self, info_queue, card)
    return { vars = { card.ability.extra.tarots } }
  end,
  can_use = function(self, card)
    return count_consumables() < G.consumeables.config.card_limit or card.area == G.consumeables
  end,
  use = function(self, card, area, copier)
    for i = 1, math.min(card.ability.extra.tarots, G.consumeables.config.card_limit - count_consumables()) do
      G.E_MANAGER:add_event(Event({
        trigger = 'after',
        delay = 0.4,
        func = function()
          if count_consumables() < G.consumeables.config.card_limit then
            play_sound('timpani')
            local new_card = create_card('Tarot', G.consumeables, nil, nil, nil, nil, nil, 'pine_chaff_a')
            new_card:add_to_deck()
            G.consumeables:emplace(new_card)
            card:juice_up(0.3, 0.5)
          end
          return true
        end
      }))
    end
    delay(0.6)
  end
}

SMODS.Consumable {
  set = "phanta_Hanafuda",
  key = "pine_chaff_b",
  pos = { x = 0, y = 3 },
  atlas = hanafuda_atlas,
  config = { phanta_chaff = true, extra = { tarots = 2 } },
  loc_vars = function(self, info_queue, card)
    return { vars = { card.ability.extra.tarots } }
  end,
  can_use = function(self, card)
    return count_consumables() < G.consumeables.config.card_limit or card.area == G.consumeables
  end,
  use = function(self, card, area, copier)
    for i = 1, math.min(card.ability.extra.tarots, G.consumeables.config.card_limit - count_consumables()) do
      G.E_MANAGER:add_event(Event({
        trigger = 'after',
        delay = 0.4,
        func = function()
          if count_consumables() < G.consumeables.config.card_limit then
            play_sound('timpani')
            local new_card = create_card('Tarot', G.consumeables, nil, nil, nil, nil, nil, 'pine_chaff_b')
            new_card:add_to_deck()
            G.consumeables:emplace(new_card)
            card:juice_up(0.3, 0.5)
          end
          return true
        end
      }))
    end
    delay(0.6)
  end
}

SMODS.Consumable {
  set = "phanta_Hanafuda",
  key = "pine_ribbon",
  pos = { x = 0, y = 1 },
  atlas = hanafuda_atlas,
  config = { phanta_ribbon = true, extra = { tarots = 1 } },
  loc_vars = function(self, info_queue, card)
    info_queue[#info_queue + 1] = G.P_CENTERS.e_negative
    return { vars = { card.ability.extra.tarots } }
  end,
  can_use = function(self, card)
    return true
  end,
  cost = 4,
  use = function(self, card, area, copier)
    for i = 1, card.ability.extra.tarots do
      G.E_MANAGER:add_event(Event({
        trigger = 'after',
        delay = 0.4,
        func = function()
          play_sound('timpani')
          local new_card = create_card('Tarot', G.consumeables, nil, nil, nil, nil, nil, 'pine_ribbon')
          new_card:set_edition({ negative = true })
          new_card:add_to_deck()
          G.consumeables:emplace(new_card)
          card:juice_up(0.3, 0.5)
          return true
        end
      }))
    end
    delay(0.6)
  end
}

SMODS.Consumable {
  set = "phanta_Hanafuda",
  key = "pine_crane",
  pos = { x = 0, y = 0 },
  atlas = hanafuda_atlas,
  config = { phanta_bright = true, extra = { tarots = 2 } },
  loc_vars = function(self, info_queue, card)
    info_queue[#info_queue + 1] = G.P_CENTERS.e_negative
    return { vars = { card.ability.extra.tarots } }
  end,
  can_use = function(self, card)
    return true
  end,
  cost = 6,
  use = function(self, card, area, copier)
    for i = 1, card.ability.extra.tarots do
      G.E_MANAGER:add_event(Event({
        trigger = 'after',
        delay = 0.4,
        func = function()
          play_sound('timpani')
          local new_card = create_card('Tarot', G.consumeables, nil, nil, nil, nil, nil, 'pine_crane')
          new_card:set_edition({ negative = true })
          new_card:add_to_deck()
          G.consumeables:emplace(new_card)
          card:juice_up(0.3, 0.5)
          return true
        end
      }))
    end
    delay(0.6)
  end
}



SMODS.Consumable {
  set = "phanta_Hanafuda",
  key = "plum_blossom_chaff_a",
  pos = { x = 1, y = 2 },
  atlas = hanafuda_atlas,
  config = { phanta_chaff = true, max_highlighted = 1, extra = { copies = 1 } },
  loc_vars = function(self, info_queue, card)
    return { vars = { card.ability.extra.copies } }
  end,
  use = function(self, card, area, copier)
    G.E_MANAGER:add_event(Event({
      func = function()
        local _first_dissolve = nil
        local new_cards = {}
        for i = 1, card.ability.extra.copies do
          G.playing_card = (G.playing_card and G.playing_card + 1) or 1
          local new_card = copy_card(G.hand.highlighted[1], nil, nil, G.playing_card)
          new_card:add_to_deck()
          G.deck.config.card_limit = G.deck.config.card_limit + 1
          table.insert(G.playing_cards, new_card)
          G.hand:emplace(new_card)
          new_card:start_materialize(nil, _first_dissolve)
          _first_dissolve = true
          new_cards[#new_cards + 1] = new_card
        end
        playing_card_joker_effects(new_cards)
        return true
      end
    }))
  end
}

SMODS.Consumable {
  set = "phanta_Hanafuda",
  key = "plum_blossom_chaff_b",
  pos = { x = 1, y = 3 },
  atlas = hanafuda_atlas,
  config = { phanta_chaff = true, max_highlighted = 1, extra = { copies = 1 } },
  loc_vars = function(self, info_queue, card)
    return { vars = { card.ability.extra.copies } }
  end,
  use = function(self, card, area, copier)
    G.E_MANAGER:add_event(Event({
      func = function()
        local _first_dissolve = nil
        local new_cards = {}
        for i = 1, card.ability.extra.copies do
          G.playing_card = (G.playing_card and G.playing_card + 1) or 1
          local new_card = copy_card(G.hand.highlighted[1], nil, nil, G.playing_card)
          new_card:add_to_deck()
          G.deck.config.card_limit = G.deck.config.card_limit + 1
          table.insert(G.playing_cards, new_card)
          G.hand:emplace(new_card)
          new_card:start_materialize(nil, _first_dissolve)
          _first_dissolve = true
          new_cards[#new_cards + 1] = new_card
        end
        playing_card_joker_effects(new_cards)
        return true
      end
    }))
  end
}

SMODS.Consumable {
  set = "phanta_Hanafuda",
  key = "plum_blossom_ribbon",
  pos = { x = 1, y = 1 },
  atlas = hanafuda_atlas,
  config = { phanta_ribbon = true, max_highlighted = 1, extra = { copies = 2 } },
  loc_vars = function(self, info_queue, card)
    return { vars = { card.ability.extra.copies } }
  end,
  use = function(self, card, area, copier)
    G.E_MANAGER:add_event(Event({
      func = function()
        local _first_dissolve = nil
        local new_cards = {}
        for i = 1, card.ability.extra.copies do
          G.playing_card = (G.playing_card and G.playing_card + 1) or 1
          local new_card = copy_card(G.hand.highlighted[1], nil, nil, G.playing_card)
          new_card:add_to_deck()
          G.deck.config.card_limit = G.deck.config.card_limit + 1
          table.insert(G.playing_cards, new_card)
          G.hand:emplace(new_card)
          new_card:start_materialize(nil, _first_dissolve)
          _first_dissolve = true
          new_cards[#new_cards + 1] = new_card
        end
        playing_card_joker_effects(new_cards)
        return true
      end
    }))
  end
}

SMODS.Consumable {
  set = "phanta_Hanafuda",
  key = "plum_blossom_bush_warbler",
  pos = { x = 1, y = 0 },
  atlas = hanafuda_atlas,
  config = { phanta_animal = true, max_highlighted = 1, extra = { copies = 3 } },
  loc_vars = function(self, info_queue, card)
    return { vars = { card.ability.extra.copies } }
  end,
  use = function(self, card, area, copier)
    G.E_MANAGER:add_event(Event({
      func = function()
        local _first_dissolve = nil
        local new_cards = {}
        for i = 1, card.ability.extra.copies do
          G.playing_card = (G.playing_card and G.playing_card + 1) or 1
          local new_card = copy_card(G.hand.highlighted[1], nil, nil, G.playing_card)
          new_card:add_to_deck()
          G.deck.config.card_limit = G.deck.config.card_limit + 1
          table.insert(G.playing_cards, new_card)
          G.hand:emplace(new_card)
          new_card:start_materialize(nil, _first_dissolve)
          _first_dissolve = true
          new_cards[#new_cards + 1] = new_card
        end
        playing_card_joker_effects(new_cards)
        return true
      end
    }))
  end
}



SMODS.Consumable {
  set = "phanta_Hanafuda",
  key = "cherry_blossom_chaff_a",
  pos = { x = 2, y = 2 },
  atlas = hanafuda_atlas,
  config = { phanta_chaff = true, extra = { hanafudas = 2 } },
  loc_vars = function(self, info_queue, card)
    return { vars = { card.ability.extra.hanafudas } }
  end,
  can_use = function(self, card)
    return count_consumables() < G.consumeables.config.card_limit or card.area == G.consumeables
  end,
  use = function(self, card, area, copier)
    for i = 1, math.min(card.ability.extra.hanafudas, G.consumeables.config.card_limit - count_consumables()) do
      G.E_MANAGER:add_event(Event({
        trigger = 'after',
        delay = 0.4,
        func = function()
          if count_consumables() < G.consumeables.config.card_limit then
            play_sound('timpani')
            local new_card = phanta_create_hanafuda_chaff("cherry_blossom_chaff_a")
            new_card:add_to_deck()
            G.consumeables:emplace(new_card)
            card:juice_up(0.3, 0.5)
          end
          return true
        end
      }))
    end
    delay(0.6)
  end
}

SMODS.Consumable {
  set = "phanta_Hanafuda",
  key = "cherry_blossom_chaff_b",
  pos = { x = 2, y = 3 },
  atlas = hanafuda_atlas,
  config = { phanta_chaff = true, extra = { hanafudas = 2 } },
  loc_vars = function(self, info_queue, card)
    return { vars = { card.ability.extra.hanafudas } }
  end,
  can_use = function(self, card)
    return count_consumables() < G.consumeables.config.card_limit or card.area == G.consumeables
  end,
  use = function(self, card, area, copier)
    for i = 1, math.min(card.ability.extra.hanafudas, G.consumeables.config.card_limit - count_consumables()) do
      G.E_MANAGER:add_event(Event({
        trigger = 'after',
        delay = 0.4,
        func = function()
          if count_consumables() < G.consumeables.config.card_limit then
            play_sound('timpani')
            local new_card = phanta_create_hanafuda_chaff("cherry_blossom_chaff_b")
            new_card:add_to_deck()
            G.consumeables:emplace(new_card)
            card:juice_up(0.3, 0.5)
          end
          return true
        end
      }))
    end
    delay(0.6)
  end
}

SMODS.Consumable {
  set = "phanta_Hanafuda",
  key = "cherry_blossom_ribbon",
  pos = { x = 2, y = 1 },
  atlas = hanafuda_atlas,
  config = { phanta_ribbon = true, extra = { hanafudas = 2 } },
  loc_vars = function(self, info_queue, card)
    return { vars = { card.ability.extra.hanafudas } }
  end,
  can_use = function(self, card)
    return count_consumables() < G.consumeables.config.card_limit or card.area == G.consumeables
  end,
  cost = 4,
  use = function(self, card, area, copier)
    for i = 1, math.min(card.ability.extra.hanafudas, G.consumeables.config.card_limit - count_consumables()) do
      G.E_MANAGER:add_event(Event({
        trigger = 'after',
        delay = 0.4,
        func = function()
          if count_consumables() < G.consumeables.config.card_limit then
            play_sound('timpani')
            local new_card = phanta_create_hanafuda_ribbon("cherry_blossom_ribbon")
            new_card:add_to_deck()
            G.consumeables:emplace(new_card)
            card:juice_up(0.3, 0.5)
          end
          return true
        end
      }))
    end
    delay(0.6)
  end
}

SMODS.Consumable {
  set = "phanta_Hanafuda",
  key = "cherry_blossom_flower_viewing_curtain",
  pos = { x = 2, y = 0 },
  atlas = hanafuda_atlas,
  config = { phanta_bright = true, extra = { hanafudas = 2 } },
  loc_vars = function(self, info_queue, card)
    return { vars = { card.ability.extra.hanafudas } }
  end,
  can_use = function(self, card)
    return count_consumables() < G.consumeables.config.card_limit or card.area == G.consumeables
  end,
  cost = 6,
  use = function(self, card, area, copier)
    for i = 1, math.min(card.ability.extra.hanafudas, G.consumeables.config.card_limit - count_consumables()) do
      G.E_MANAGER:add_event(Event({
        trigger = 'after',
        delay = 0.4,
        func = function()
          if count_consumables() < G.consumeables.config.card_limit then
            play_sound('timpani')
            local new_card = phanta_create_hanafuda_animal("cherry_blossom_flower_viewing_curtain")
            new_card:add_to_deck()
            G.consumeables:emplace(new_card)
            card:juice_up(0.3, 0.5)
          end
          return true
        end
      }))
    end
    delay(0.6)
  end
}



SMODS.Consumable {
  set = "phanta_Hanafuda",
  key = "wisteria_chaff_a",
  pos = { x = 3, y = 2 },
  atlas = hanafuda_atlas,
  config = { phanta_chaff = true, max_highlighted = 2 },
  loc_vars = function(self, info_queue, card)
    return { vars = { card.ability.max_highlighted } }
  end,
  use = function(self, card, area, copier)
    local destroyed_cards = {}
    for i = #G.hand.highlighted, 1, -1 do
      destroyed_cards[#destroyed_cards + 1] = G.hand.highlighted[i]
    end
    G.E_MANAGER:add_event(Event({
      trigger = 'after',
      delay = 0.4,
      func = function()
        play_sound('tarot1')
        card:juice_up(0.3, 0.5)
        return true
      end
    }))
    G.E_MANAGER:add_event(Event({
      trigger = 'after',
      delay = 0.2,
      func = function()
        for i = #G.hand.highlighted, 1, -1 do
          local card = G.hand.highlighted[i]
          if SMODS.shatters(card) then
            card:shatter()
          else
            card:start_dissolve(nil, i == #G.hand.highlighted)
          end
        end
        return true
      end
    }))
    delay(0.3)
    SMODS.calculate_context({ remove_playing_cards = true, removed = destroyed_cards })
  end
}

SMODS.Consumable {
  set = "phanta_Hanafuda",
  key = "wisteria_chaff_b",
  pos = { x = 3, y = 3 },
  atlas = hanafuda_atlas,
  config = { phanta_chaff = true, max_highlighted = 2 },
  loc_vars = function(self, info_queue, card)
    return { vars = { card.ability.max_highlighted } }
  end,
  use = function(self, card, area, copier)
    local destroyed_cards = {}
    for i = #G.hand.highlighted, 1, -1 do
      destroyed_cards[#destroyed_cards + 1] = G.hand.highlighted[i]
    end
    G.E_MANAGER:add_event(Event({
      trigger = 'after',
      delay = 0.4,
      func = function()
        play_sound('tarot1')
        card:juice_up(0.3, 0.5)
        return true
      end
    }))
    G.E_MANAGER:add_event(Event({
      trigger = 'after',
      delay = 0.2,
      func = function()
        for i = #G.hand.highlighted, 1, -1 do
          local card = G.hand.highlighted[i]
          if SMODS.shatters(card) then
            card:shatter()
          else
            card:start_dissolve(nil, i == #G.hand.highlighted)
          end
        end
        return true
      end
    }))
    delay(0.3)
    SMODS.calculate_context({ remove_playing_cards = true, removed = destroyed_cards })
  end
}

SMODS.Consumable {
  set = "phanta_Hanafuda",
  key = "wisteria_ribbon",
  pos = { x = 3, y = 1 },
  atlas = hanafuda_atlas,
  config = { phanta_ribbon = true, max_highlighted = 3 },
  loc_vars = function(self, info_queue, card)
    return { vars = { card.ability.max_highlighted } }
  end,
  cost = 4,
  use = function(self, card, area, copier)
    local destroyed_cards = {}
    for i = #G.hand.highlighted, 1, -1 do
      destroyed_cards[#destroyed_cards + 1] = G.hand.highlighted[i]
    end
    G.E_MANAGER:add_event(Event({
      trigger = 'after',
      delay = 0.4,
      func = function()
        play_sound('tarot1')
        card:juice_up(0.3, 0.5)
        return true
      end
    }))
    G.E_MANAGER:add_event(Event({
      trigger = 'after',
      delay = 0.2,
      func = function()
        for i = #G.hand.highlighted, 1, -1 do
          local card = G.hand.highlighted[i]
          if SMODS.shatters(card) then
            card:shatter()
          else
            card:start_dissolve(nil, i == #G.hand.highlighted)
          end
        end
        return true
      end
    }))
    delay(0.3)
    SMODS.calculate_context({ remove_playing_cards = true, removed = destroyed_cards })
  end
}

SMODS.Consumable {
  set = "phanta_Hanafuda",
  key = "wisteria_cuckoo",
  pos = { x = 3, y = 0 },
  atlas = hanafuda_atlas,
  config = { phanta_animal = true, max_highlighted = 5 },
  loc_vars = function(self, info_queue, card)
    return { vars = { card.ability.max_highlighted } }
  end,
  cost = 6,
  use = function(self, card, area, copier)
    local destroyed_cards = {}
    for i = #G.hand.highlighted, 1, -1 do
      destroyed_cards[#destroyed_cards + 1] = G.hand.highlighted[i]
    end
    G.E_MANAGER:add_event(Event({
      trigger = 'after',
      delay = 0.4,
      func = function()
        play_sound('tarot1')
        card:juice_up(0.3, 0.5)
        return true
      end
    }))
    G.E_MANAGER:add_event(Event({
      trigger = 'after',
      delay = 0.2,
      func = function()
        for i = #G.hand.highlighted, 1, -1 do
          local card = G.hand.highlighted[i]
          if SMODS.shatters(card) then
            card:shatter()
          else
            card:start_dissolve(nil, i == #G.hand.highlighted)
          end
        end
        return true
      end
    }))
    delay(0.3)
    SMODS.calculate_context({ remove_playing_cards = true, removed = destroyed_cards })
  end
}



SMODS.Consumable {
  set = "phanta_Hanafuda",
  key = "iris_chaff_a",
  pos = { x = 4, y = 2 },
  atlas = hanafuda_atlas,
  config = { phanta_chaff = true },
  can_use = function(self, card)
    return #G.jokers.cards < G.jokers.config.card_limit or card.area == G.jokers
  end,
  use = function(self, card, area, copier)
    G.E_MANAGER:add_event(Event({
      trigger = 'after',
      delay = 0.4,
      func = function()
        play_sound('timpani')
        local new_card = SMODS.create_card({ set = "Joker", area = G.jokers, key_append = "iris_chaff_a", rarity = 0.04 })
        new_card:add_to_deck()
        G.jokers:emplace(new_card)
        card:juice_up(0.3, 0.5)
        return true
      end
    }))
    delay(0.6)
  end
}

SMODS.Consumable {
  set = "phanta_Hanafuda",
  key = "iris_chaff_b",
  pos = { x = 4, y = 3 },
  atlas = hanafuda_atlas,
  config = { phanta_chaff = true },
  can_use = function(self, card)
    return #G.jokers.cards < G.jokers.config.card_limit or card.area == G.jokers
  end,
  use = function(self, card, area, copier)
    G.E_MANAGER:add_event(Event({
      trigger = 'after',
      delay = 0.4,
      func = function()
        play_sound('timpani')
        local new_card = SMODS.create_card({ set = "Joker", area = G.jokers, key_append = "iris_chaff_b", rarity = 0.04 })
        new_card:add_to_deck()
        G.jokers:emplace(new_card)
        card:juice_up(0.3, 0.5)
        return true
      end
    }))
    delay(0.6)
  end
}

SMODS.Consumable {
  set = "phanta_Hanafuda",
  key = "iris_ribbon",
  pos = { x = 4, y = 1 },
  atlas = hanafuda_atlas,
  config = { phanta_ribbon = true, extra = { lost_money = 5 } },
  loc_vars = function(self, info_queue, card)
    return { vars = { card.ability.extra.lost_money } }
  end,
  cost = 4,
  can_use = function(self, card)
    return (#G.jokers.cards < G.jokers.config.card_limit or card.area == G.jokers) and
        G.GAME.dollars - card.ability.extra.lost_money >= to_big(G.GAME.bankrupt_at)
  end,
  use = function(self, card, area, copier)
    G.E_MANAGER:add_event(Event({
      trigger = 'after',
      delay = 0.4,
      func = function()
        ease_dollars(-card.ability.extra.lost_money)
        play_sound('timpani')
        local new_card = SMODS.create_card({ set = "Joker", area = G.jokers, key_append = "iris_ribbon", rarity = 0.84 })
        new_card:add_to_deck()
        G.jokers:emplace(new_card)
        card:juice_up(0.3, 0.5)
        return true
      end
    }))
    delay(0.6)
  end
}

SMODS.Consumable {
  set = "phanta_Hanafuda",
  key = "iris_eight_plank_bridge",
  pos = { x = 4, y = 0 },
  atlas = hanafuda_atlas,
  config = { phanta_bright = true, extra = { lost_money = 10 } },
  loc_vars = function(self, info_queue, card)
    return { vars = { card.ability.extra.lost_money } }
  end,
  cost = 6,
  can_use = function(self, card)
    return (#G.jokers.cards < G.jokers.config.card_limit or card.area == G.jokers) and
        G.GAME.dollars - card.ability.extra.lost_money >= to_big(G.GAME.bankrupt_at)
  end,
  use = function(self, card, area, copier)
    G.E_MANAGER:add_event(Event({
      trigger = 'after',
      delay = 0.4,
      func = function()
        ease_dollars(-card.ability.extra.lost_money)
        play_sound('timpani')
        local new_card = SMODS.create_card({ set = "Joker", area = G.jokers, key_append = "iris_eight_plank_bridge", rarity = 0.994 })
        new_card:add_to_deck()
        G.jokers:emplace(new_card)
        card:juice_up(0.3, 0.5)
        return true
      end
    }))
    delay(0.6)
  end
}



SMODS.Consumable {
  set = "phanta_Hanafuda",
  key = "peony_chaff_a",
  pos = { x = 5, y = 2 },
  atlas = hanafuda_atlas,
  config = { phanta_chaff = true },
  can_use = function(self, card)
    return G.hand and G.hand.cards and next(G.hand.cards)
  end,
  use = function(self, card, area, copier)
    G.E_MANAGER:add_event(Event({
      func = function()
        play_sound('tarot1')
        card:juice_up(0.3, 0.5)
        return true
      end
    }))
    G.E_MANAGER:add_event(Event({
      trigger = 'after',
      delay = 0.1,
      func = function()
        local new_card = SMODS.create_card { set = "Base", area = G.hand, seal = SMODS.poll_seal({ key = "peony_chaff_a", guaranteed = true }) }
        G.hand:emplace(new_card)
        G.GAME.blind:debuff_card(new_card)
        G.hand:sort()
        playing_card_joker_effects({ new_card })
        save_run()
        return true
      end
    }))
    delay(0.5)
  end
}

SMODS.Consumable {
  set = "phanta_Hanafuda",
  key = "peony_chaff_b",
  pos = { x = 5, y = 3 },
  atlas = hanafuda_atlas,
  config = { phanta_chaff = true },
  can_use = function(self, card)
    return G.hand and G.hand.cards and next(G.hand.cards)
  end,
  use = function(self, card, area, copier)
    G.E_MANAGER:add_event(Event({
      func = function()
        play_sound('tarot1')
        card:juice_up(0.3, 0.5)
        return true
      end
    }))
    G.E_MANAGER:add_event(Event({
      trigger = 'after',
      delay = 0.1,
      func = function()
        local new_card = SMODS.create_card { set = "Base", area = G.hand, seal = SMODS.poll_seal({ key = "peony_chaff_b", guaranteed = true }) }
        G.hand:emplace(new_card)
        G.GAME.blind:debuff_card(new_card)
        G.hand:sort()
        playing_card_joker_effects({ new_card })
        save_run()
        return true
      end
    }))
    delay(0.5)
  end
}

SMODS.Consumable {
  set = "phanta_Hanafuda",
  key = "peony_ribbon",
  pos = { x = 5, y = 1 },
  atlas = hanafuda_atlas,
  config = { phanta_ribbon = true, max_highlighted = 1 },
  loc_vars = function(self, info_queue, card)
    return { vars = { card.ability.max_highlighted } }
  end,
  cost = 4,
  use = function(self, card, area, copier)
    local conv_card = G.hand.highlighted[1]
    G.E_MANAGER:add_event(Event({
      func = function()
        play_sound('tarot1')
        card:juice_up(0.3, 0.5)
        return true
      end
    }))

    G.E_MANAGER:add_event(Event({
      trigger = 'after',
      delay = 0.1,
      func = function()
        conv_card:set_seal(SMODS.poll_seal({ key = "peony_ribbon", guaranteed = true }), nil, true)
        return true
      end
    }))

    delay(0.5)
    G.E_MANAGER:add_event(Event({
      trigger = 'after',
      delay = 0.2,
      func = function()
        G.hand:unhighlight_all(); return true
      end
    }))
  end
}

SMODS.Consumable {
  set = "phanta_Hanafuda",
  key = "peony_butterflies",
  pos = { x = 5, y = 0 },
  atlas = hanafuda_atlas,
  config = { phanta_animal = true, max_highlighted = 2 },
  loc_vars = function(self, info_queue, card)
    return { vars = { card.ability.max_highlighted } }
  end,
  cost = 6,
  use = function(self, card, area, copier)
    G.E_MANAGER:add_event(Event({
      func = function()
        play_sound('tarot1')
        card:juice_up(0.3, 0.5)
        return true
      end
    }))

    for i = 1, #G.hand.highlighted do
      G.E_MANAGER:add_event(Event({
        trigger = 'after',
        delay = 0.2,
        func = function()
          G.hand.highlighted[i]:set_seal("Red", nil, true)
          return true
        end
      }))
    end

    delay(0.5)
    G.E_MANAGER:add_event(Event({
      trigger = 'after',
      delay = 0.2,
      func = function()
        G.hand:unhighlight_all(); return true
      end
    }))
  end
}



SMODS.Consumable {
  set = "phanta_Hanafuda",
  key = "bush_clover_chaff_a",
  pos = { x = 6, y = 2 },
  atlas = hanafuda_atlas,
  config = { phanta_chaff = true, max_highlighted = 1, extra = { rank_increase = 2 } },
  loc_vars = function(self, info_queue, card)
    return { vars = { card.ability.max_highlighted, card.ability.extra.rank_increase } }
  end,
  use = function(self, card, area, copier)
    G.E_MANAGER:add_event(Event({
      trigger = 'after',
      delay = 0.4,
      func = function()
        play_sound('tarot1')
        card:juice_up(0.3, 0.5)
        return true
      end
    }))
    for i = 1, #G.hand.highlighted do
      local percent = 1.15 - (i - 0.999) / (#G.hand.highlighted - 0.998) * 0.3
      G.E_MANAGER:add_event(Event({
        trigger = 'after',
        delay = 0.15,
        func = function()
          G.hand.highlighted[i]:flip(); play_sound('card1', percent); G.hand.highlighted[i]:juice_up(0.3, 0.3); return true
        end
      }))
    end
    delay(0.2)
    for i = 1, #G.hand.highlighted do
      G.E_MANAGER:add_event(Event({
        trigger = 'after',
        delay = 0.1,
        func = function()
          assert(SMODS.modify_rank(G.hand.highlighted[i], card.ability.extra.rank_increase))
          return true
        end
      }))
    end
    for i = 1, #G.hand.highlighted do
      local percent = 0.85 + (i - 0.999) / (#G.hand.highlighted - 0.998) * 0.3
      G.E_MANAGER:add_event(Event({
        trigger = 'after',
        delay = 0.15,
        func = function()
          G.hand.highlighted[i]:flip(); play_sound('tarot2', percent, 0.6); G.hand.highlighted[i]:juice_up(0.3, 0.3); return true
        end
      }))
    end
    G.E_MANAGER:add_event(Event({
      trigger = 'after',
      delay = 0.2,
      func = function()
        G.hand:unhighlight_all(); return true
      end
    }))
    delay(0.5)
  end
}

SMODS.Consumable {
  set = "phanta_Hanafuda",
  key = "bush_clover_chaff_b",
  pos = { x = 6, y = 3 },
  atlas = hanafuda_atlas,
  config = { phanta_chaff = true, max_highlighted = 1, extra = { rank_increase = 2 } },
  loc_vars = function(self, info_queue, card)
    return { vars = { card.ability.max_highlighted, card.ability.extra.rank_increase } }
  end,
  use = function(self, card, area, copier)
    G.E_MANAGER:add_event(Event({
      trigger = 'after',
      delay = 0.4,
      func = function()
        play_sound('tarot1')
        card:juice_up(0.3, 0.5)
        return true
      end
    }))
    for i = 1, #G.hand.highlighted do
      local percent = 1.15 - (i - 0.999) / (#G.hand.highlighted - 0.998) * 0.3
      G.E_MANAGER:add_event(Event({
        trigger = 'after',
        delay = 0.15,
        func = function()
          G.hand.highlighted[i]:flip(); play_sound('card1', percent); G.hand.highlighted[i]:juice_up(0.3, 0.3); return true
        end
      }))
    end
    delay(0.2)
    for i = 1, #G.hand.highlighted do
      G.E_MANAGER:add_event(Event({
        trigger = 'after',
        delay = 0.1,
        func = function()
          assert(SMODS.modify_rank(G.hand.highlighted[i], card.ability.extra.rank_increase))
          return true
        end
      }))
    end
    for i = 1, #G.hand.highlighted do
      local percent = 0.85 + (i - 0.999) / (#G.hand.highlighted - 0.998) * 0.3
      G.E_MANAGER:add_event(Event({
        trigger = 'after',
        delay = 0.15,
        func = function()
          G.hand.highlighted[i]:flip(); play_sound('tarot2', percent, 0.6); G.hand.highlighted[i]:juice_up(0.3, 0.3); return true
        end
      }))
    end
    G.E_MANAGER:add_event(Event({
      trigger = 'after',
      delay = 0.2,
      func = function()
        G.hand:unhighlight_all(); return true
      end
    }))
    delay(0.5)
  end
}

SMODS.Consumable {
  set = "phanta_Hanafuda",
  key = "bush_clover_ribbon",
  pos = { x = 6, y = 1 },
  atlas = hanafuda_atlas,
  config = { phanta_ribbon = true, max_highlighted = 2, extra = { rank_increase = 3 } },
  loc_vars = function(self, info_queue, card)
    return { vars = { card.ability.max_highlighted, card.ability.extra.rank_increase } }
  end,
  cost = 4,
  use = function(self, card, area, copier)
    G.E_MANAGER:add_event(Event({
      trigger = 'after',
      delay = 0.4,
      func = function()
        play_sound('tarot1')
        card:juice_up(0.3, 0.5)
        return true
      end
    }))
    for i = 1, #G.hand.highlighted do
      local percent = 1.15 - (i - 0.999) / (#G.hand.highlighted - 0.998) * 0.3
      G.E_MANAGER:add_event(Event({
        trigger = 'after',
        delay = 0.15,
        func = function()
          G.hand.highlighted[i]:flip(); play_sound('card1', percent); G.hand.highlighted[i]:juice_up(0.3, 0.3); return true
        end
      }))
    end
    delay(0.2)
    for i = 1, #G.hand.highlighted do
      G.E_MANAGER:add_event(Event({
        trigger = 'after',
        delay = 0.1,
        func = function()
          assert(SMODS.modify_rank(G.hand.highlighted[i], card.ability.extra.rank_increase))
          return true
        end
      }))
    end
    for i = 1, #G.hand.highlighted do
      local percent = 0.85 + (i - 0.999) / (#G.hand.highlighted - 0.998) * 0.3
      G.E_MANAGER:add_event(Event({
        trigger = 'after',
        delay = 0.15,
        func = function()
          G.hand.highlighted[i]:flip(); play_sound('tarot2', percent, 0.6); G.hand.highlighted[i]:juice_up(0.3, 0.3); return true
        end
      }))
    end
    G.E_MANAGER:add_event(Event({
      trigger = 'after',
      delay = 0.2,
      func = function()
        G.hand:unhighlight_all(); return true
      end
    }))
    delay(0.5)
  end
}

SMODS.Consumable {
  set = "phanta_Hanafuda",
  key = "bush_clover_boar",
  pos = { x = 6, y = 0 },
  atlas = hanafuda_atlas,
  config = { phanta_animal = true, max_highlighted = 3, extra = { rank_increase = 5 } },
  loc_vars = function(self, info_queue, card)
    return { vars = { card.ability.max_highlighted, card.ability.extra.rank_increase } }
  end,
  cost = 6,
  use = function(self, card, area, copier)
    G.E_MANAGER:add_event(Event({
      trigger = 'after',
      delay = 0.4,
      func = function()
        play_sound('tarot1')
        card:juice_up(0.3, 0.5)
        return true
      end
    }))
    for i = 1, #G.hand.highlighted do
      local percent = 1.15 - (i - 0.999) / (#G.hand.highlighted - 0.998) * 0.3
      G.E_MANAGER:add_event(Event({
        trigger = 'after',
        delay = 0.15,
        func = function()
          G.hand.highlighted[i]:flip(); play_sound('card1', percent); G.hand.highlighted[i]:juice_up(0.3, 0.3); return true
        end
      }))
    end
    delay(0.2)
    for i = 1, #G.hand.highlighted do
      G.E_MANAGER:add_event(Event({
        trigger = 'after',
        delay = 0.1,
        func = function()
          assert(SMODS.modify_rank(G.hand.highlighted[i], card.ability.extra.rank_increase))
          return true
        end
      }))
    end
    for i = 1, #G.hand.highlighted do
      local percent = 0.85 + (i - 0.999) / (#G.hand.highlighted - 0.998) * 0.3
      G.E_MANAGER:add_event(Event({
        trigger = 'after',
        delay = 0.15,
        func = function()
          G.hand.highlighted[i]:flip(); play_sound('tarot2', percent, 0.6); G.hand.highlighted[i]:juice_up(0.3, 0.3); return true
        end
      }))
    end
    G.E_MANAGER:add_event(Event({
      trigger = 'after',
      delay = 0.2,
      func = function()
        G.hand:unhighlight_all(); return true
      end
    }))
    delay(0.5)
  end
}




SMODS.Consumable {
  set = "phanta_Hanafuda",
  key = "suzuki_grass_chaff_a",
  pos = { x = 7, y = 2 },
  atlas = hanafuda_atlas,
  config = { phanta_chaff = true, extra = { odds = 4 } },
  loc_vars = function(self, info_queue, card)
    local num, denom = SMODS.get_probability_vars(card, 1, card.ability.extra.odds, "suzuki_grass_chaff_a")
    return { vars = { num, denom } }
  end,
  can_use = function(self, card)
    return G.jokers and G.jokers.cards and G.jokers.cards[1] and not G.jokers.cards[1].edition
  end,
  use = function(self, card, area, copier)
    if SMODS.pseudorandom_probability(card, 'suzuki_grass_chaff_a', 1, card.ability.extra.odds) then
      G.E_MANAGER:add_event(Event({
        trigger = 'after',
        delay = 0.4,
        func = function()
          local eligible_card = G.jokers.cards[1]
          eligible_card:set_edition(poll_edition('suzuki_grass_chaff_a', nil, true, true), true)
          check_for_unlock({ type = 'have_edition' })
          card:juice_up(0.3, 0.5)
          return true
        end
      }))
    else
      G.E_MANAGER:add_event(Event({
        trigger = 'after',
        delay = 0.4,
        func = function()
          attention_text({
            text = localize('k_nope_ex'),
            scale = 1.3,
            hold = 1.4,
            major = card,
            backdrop_colour = G.C.SECONDARY_SET.Tarot,
            align = 'cm',
            offset = { x = 0, y = 0 },
            silent = true
          })
          G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0.06 * G.SETTINGS.GAMESPEED,
            blockable = false,
            blocking = false,
            func = function()
              play_sound('tarot2', 0.76, 0.4); return true
            end
          }))
          play_sound('tarot2', 1, 0.4)
          card:juice_up(0.3, 0.5)
          return true
        end
      }))
    end
    delay(0.6)
  end
}

SMODS.Consumable {
  set = "phanta_Hanafuda",
  key = "suzuki_grass_chaff_b",
  pos = { x = 7, y = 3 },
  atlas = hanafuda_atlas,
  config = { phanta_chaff = true, extra = { odds = 4 } },
  loc_vars = function(self, info_queue, card)
    local num, denom = SMODS.get_probability_vars(card, 1, card.ability.extra.odds, "suzuki_grass_chaff_b")
    return { vars = { num, denom } }
  end,
  can_use = function(self, card)
    return G.jokers and G.jokers.cards and G.jokers.cards[1] and not G.jokers.cards[1].edition
  end,
  use = function(self, card, area, copier)
    if SMODS.pseudorandom_probability(card, 'suzuki_grass_chaff_b', 1, card.ability.extra.odds) then
      G.E_MANAGER:add_event(Event({
        trigger = 'after',
        delay = 0.4,
        func = function()
          local eligible_card = G.jokers.cards[1]
          eligible_card:set_edition(poll_edition('suzuki_grass_chaff_b', nil, true, true), true)
          check_for_unlock({ type = 'have_edition' })
          card:juice_up(0.3, 0.5)
          return true
        end
      }))
    else
      G.E_MANAGER:add_event(Event({
        trigger = 'after',
        delay = 0.4,
        func = function()
          attention_text({
            text = localize('k_nope_ex'),
            scale = 1.3,
            hold = 1.4,
            major = card,
            backdrop_colour = G.C.SECONDARY_SET.Tarot,
            align = 'cm',
            offset = { x = 0, y = 0 },
            silent = true
          })
          G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0.06 * G.SETTINGS.GAMESPEED,
            blockable = false,
            blocking = false,
            func = function()
              play_sound('tarot2', 0.76, 0.4); return true
            end
          }))
          play_sound('tarot2', 1, 0.4)
          card:juice_up(0.3, 0.5)
          return true
        end
      }))
    end
    delay(0.6)
  end
}

SMODS.Consumable {
  set = "phanta_Hanafuda",
  key = "suzuki_grass_geese",
  pos = { x = 7, y = 1 },
  atlas = hanafuda_atlas,
  config = { phanta_animal = true, extra = { odds = 2 } },
  loc_vars = function(self, info_queue, card)
    local num, denom = SMODS.get_probability_vars(card, 1, card.ability.extra.odds, "suzuki_grass_geese")
    return { vars = { num, denom } }
  end,
  can_use = function(self, card)
    return G.jokers and G.jokers.cards and G.jokers.cards[1] and not G.jokers.cards[1].edition
  end,
  cost = 4,
  use = function(self, card, area, copier)
    if SMODS.pseudorandom_probability(card, 'suzuki_grass_geese', 1, card.ability.extra.odds) then
      G.E_MANAGER:add_event(Event({
        trigger = 'after',
        delay = 0.4,
        func = function()
          local eligible_card = G.jokers.cards[1]
          eligible_card:set_edition(poll_edition('suzuki_grass_geese', nil, true, true), true)
          check_for_unlock({ type = 'have_edition' })
          card:juice_up(0.3, 0.5)
          return true
        end
      }))
    else
      G.E_MANAGER:add_event(Event({
        trigger = 'after',
        delay = 0.4,
        func = function()
          attention_text({
            text = localize('k_nope_ex'),
            scale = 1.3,
            hold = 1.4,
            major = card,
            backdrop_colour = G.C.SECONDARY_SET.Tarot,
            align = 'cm',
            offset = { x = 0, y = 0 },
            silent = true
          })
          G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0.06 * G.SETTINGS.GAMESPEED,
            blockable = false,
            blocking = false,
            func = function()
              play_sound('tarot2', 0.76, 0.4); return true
            end
          }))
          play_sound('tarot2', 1, 0.4)
          card:juice_up(0.3, 0.5)
          return true
        end
      }))
    end
    delay(0.6)
  end
}

SMODS.Consumable {
  set = "phanta_Hanafuda",
  key = "suzuki_grass_full_moon",
  pos = { x = 7, y = 0 },
  atlas = hanafuda_atlas,
  config = { phanta_bright = true, extra = { odds = 2 } },
  can_use = function(self, card)
    return G.jokers and G.jokers.cards and G.jokers.cards[1] and not G.jokers.cards[1].edition
  end,
  cost = 6,
  use = function(self, card, area, copier)
    G.E_MANAGER:add_event(Event({
      trigger = 'after',
      delay = 0.4,
      func = function()
        local eligible_card = G.jokers.cards[1]
        eligible_card:set_edition(poll_edition('suzuki_grass_geese', nil, true, true), true)
        check_for_unlock({ type = 'have_edition' })
        card:juice_up(0.3, 0.5)
        return true
      end
    }))
    delay(0.6)
  end
}



SMODS.Consumable {
  set = "phanta_Hanafuda",
  key = "chrysanthemum_chaff_a",
  pos = { x = 8, y = 2 },
  atlas = hanafuda_atlas,
  config = { phanta_chaff = true, max_highlighted = 2 },
  loc_vars = function(self, info_queue, card)
    return { vars = { card.ability.max_highlighted } }
  end,
  use = function(self, card, area, copier)
    G.E_MANAGER:add_event(Event({
      trigger = 'after',
      delay = 0.4,
      func = function()
        play_sound('tarot1')
        card:juice_up(0.3, 0.5)
        return true
      end
    }))
    for i = 1, #G.hand.highlighted do
      local percent = 1.15 - (i - 0.999) / (#G.hand.highlighted - 0.998) * 0.3
      G.E_MANAGER:add_event(Event({
        trigger = 'after',
        delay = 0.15,
        func = function()
          G.hand.highlighted[i]:flip(); play_sound('card1', percent); G.hand.highlighted[i]:juice_up(0.3, 0.3); return true
        end
      }))
    end
    delay(0.2)
    for i = 1, #G.hand.highlighted do
      G.E_MANAGER:add_event(Event({
        trigger = 'after',
        delay = 0.1,
        func = function()
          G.hand.highlighted[i]:set_ability(SMODS.poll_enhancement { guaranteed = true, key_append = "chrysanthemum_chaff_a" })
          return true
        end
      }))
    end
    for i = 1, #G.hand.highlighted do
      local percent = 0.85 + (i - 0.999) / (#G.hand.highlighted - 0.998) * 0.3
      G.E_MANAGER:add_event(Event({
        trigger = 'after',
        delay = 0.15,
        func = function()
          G.hand.highlighted[i]:flip(); play_sound('tarot2', percent, 0.6); G.hand.highlighted[i]:juice_up(0.3, 0.3); return true
        end
      }))
    end
    G.E_MANAGER:add_event(Event({
      trigger = 'after',
      delay = 0.2,
      func = function()
        G.hand:unhighlight_all(); return true
      end
    }))
    delay(0.5)
  end
}

SMODS.Consumable {
  set = "phanta_Hanafuda",
  key = "chrysanthemum_chaff_b",
  pos = { x = 8, y = 3 },
  atlas = hanafuda_atlas,
  config = { phanta_chaff = true, max_highlighted = 2 },
  loc_vars = function(self, info_queue, card)
    return { vars = { card.ability.max_highlighted } }
  end,
  use = function(self, card, area, copier)
    G.E_MANAGER:add_event(Event({
      trigger = 'after',
      delay = 0.4,
      func = function()
        play_sound('tarot1')
        card:juice_up(0.3, 0.5)
        return true
      end
    }))
    for i = 1, #G.hand.highlighted do
      local percent = 1.15 - (i - 0.999) / (#G.hand.highlighted - 0.998) * 0.3
      G.E_MANAGER:add_event(Event({
        trigger = 'after',
        delay = 0.15,
        func = function()
          G.hand.highlighted[i]:flip(); play_sound('card1', percent); G.hand.highlighted[i]:juice_up(0.3, 0.3); return true
        end
      }))
    end
    delay(0.2)
    for i = 1, #G.hand.highlighted do
      G.E_MANAGER:add_event(Event({
        trigger = 'after',
        delay = 0.1,
        func = function()
          G.hand.highlighted[i]:set_ability(SMODS.poll_enhancement { guaranteed = true, key_append = "chrysanthemum_chaff_b" })
          return true
        end
      }))
    end
    for i = 1, #G.hand.highlighted do
      local percent = 0.85 + (i - 0.999) / (#G.hand.highlighted - 0.998) * 0.3
      G.E_MANAGER:add_event(Event({
        trigger = 'after',
        delay = 0.15,
        func = function()
          G.hand.highlighted[i]:flip(); play_sound('tarot2', percent, 0.6); G.hand.highlighted[i]:juice_up(0.3, 0.3); return true
        end
      }))
    end
    G.E_MANAGER:add_event(Event({
      trigger = 'after',
      delay = 0.2,
      func = function()
        G.hand:unhighlight_all(); return true
      end
    }))
    delay(0.5)
  end
}

SMODS.Consumable {
  set = "phanta_Hanafuda",
  key = "chrysanthemum_ribbon",
  pos = { x = 8, y = 1 },
  atlas = hanafuda_atlas,
  config = { phanta_ribbon = true, max_highlighted = 3 },
  loc_vars = function(self, info_queue, card)
    return { vars = { card.ability.max_highlighted } }
  end,
  can_use = function(self, card)
    if not (G.hand and G.hand.highlighted and next(G.hand.highlighted) and #G.hand.highlighted <= card.ability.max_highlighted) then return false end
    local hand_sorted = G.hand.highlighted
    table.sort(hand_sorted, function(a, b) return a.T.x < b.T.x end)
    return hand_sorted and hand_sorted[#hand_sorted] and
        next(SMODS.get_enhancements(hand_sorted[#hand_sorted]))
  end,
  cost = 4,
  use = function(self, card, area, copier)
    local hand_sorted = G.hand.highlighted
    table.sort(hand_sorted, function(a, b) return a.T.x < b.T.x end)
    G.E_MANAGER:add_event(Event({
      trigger = 'after',
      delay = 0.4,
      func = function()
        play_sound('tarot1')
        card:juice_up(0.3, 0.5)
        return true
      end
    }))
    for i = 1, #hand_sorted - 1 do
      local percent = 1.15 - (i - 0.999) / (#hand_sorted - 1 - 0.998) * 0.3
      G.E_MANAGER:add_event(Event({
        trigger = 'after',
        delay = 0.15,
        func = function()
          hand_sorted[i]:flip(); play_sound('card1', percent); hand_sorted[i]:juice_up(0.3, 0.3); return true
        end
      }))
    end
    delay(0.2)
    for i = 1, #hand_sorted - 1 do
      G.E_MANAGER:add_event(Event({
        trigger = 'after',
        delay = 0.1,
        func = function()
          hand_sorted[i]:set_ability(G.P_CENTERS[hand_sorted[#hand_sorted].config.center.key]); return true
        end
      }))
    end
    for i = 1, #hand_sorted - 1 do
      local percent = 0.85 + (i - 0.999) / (#hand_sorted - 1 - 0.998) * 0.3
      G.E_MANAGER:add_event(Event({
        trigger = 'after',
        delay = 0.15,
        func = function()
          hand_sorted[i]:flip(); play_sound('tarot2', percent, 0.6); hand_sorted[i]:juice_up(0.3, 0.3); return true
        end
      }))
    end
    G.E_MANAGER:add_event(Event({
      trigger = 'after',
      delay = 0.2,
      func = function()
        G.hand:unhighlight_all(); return true
      end
    }))
    delay(0.5)
  end
}

SMODS.Consumable {
  set = "phanta_Hanafuda",
  key = "chrysanthemum_sake_cup",
  pos = { x = 8, y = 0 },
  atlas = hanafuda_atlas,
  config = { phanta_animal = true, max_highlighted = 5 },
  loc_vars = function(self, info_queue, card)
    return { vars = { card.ability.max_highlighted } }
  end,
  can_use = function(self, card)
    if not (G.hand and G.hand.highlighted and next(G.hand.highlighted) and #G.hand.highlighted <= card.ability.max_highlighted) then return false end
    local hand_sorted = G.hand.highlighted
    table.sort(hand_sorted, function(a, b) return a.T.x < b.T.x end)
    return hand_sorted and hand_sorted[#hand_sorted] and
        next(SMODS.get_enhancements(hand_sorted[#hand_sorted]))
  end,
  cost = 6,
  use = function(self, card, area, copier)
    local hand_sorted = G.hand.highlighted
    table.sort(hand_sorted, function(a, b) return a.T.x < b.T.x end)
    G.E_MANAGER:add_event(Event({
      trigger = 'after',
      delay = 0.4,
      func = function()
        play_sound('tarot1')
        card:juice_up(0.3, 0.5)
        return true
      end
    }))
    for i = 1, #hand_sorted - 1 do
      local percent = 1.15 - (i - 0.999) / (#hand_sorted - 1 - 0.998) * 0.3
      G.E_MANAGER:add_event(Event({
        trigger = 'after',
        delay = 0.15,
        func = function()
          hand_sorted[i]:flip(); play_sound('card1', percent); hand_sorted[i]:juice_up(0.3, 0.3); return true
        end
      }))
    end
    delay(0.2)
    for i = 1, #hand_sorted - 1 do
      G.E_MANAGER:add_event(Event({
        trigger = 'after',
        delay = 0.1,
        func = function()
          hand_sorted[i]:set_ability(G.P_CENTERS[hand_sorted[#hand_sorted].config.center.key]); return true
        end
      }))
    end
    for i = 1, #hand_sorted - 1 do
      local percent = 0.85 + (i - 0.999) / (#hand_sorted - 1 - 0.998) * 0.3
      G.E_MANAGER:add_event(Event({
        trigger = 'after',
        delay = 0.15,
        func = function()
          hand_sorted[i]:flip(); play_sound('tarot2', percent, 0.6); hand_sorted[i]:juice_up(0.3, 0.3); return true
        end
      }))
    end
    G.E_MANAGER:add_event(Event({
      trigger = 'after',
      delay = 0.2,
      func = function()
        G.hand:unhighlight_all(); return true
      end
    }))
    delay(0.5)
  end
}



SMODS.Consumable {
  set = "phanta_Hanafuda",
  key = "maple_chaff_a",
  pos = { x = 9, y = 2 },
  atlas = hanafuda_atlas,
  config = { phanta_chaff = true, extra = { money_cap = 20 } },
  loc_vars = function(self, info_queue, card)
    return { vars = { card.ability.extra.money_cap } }
  end,
  can_use = function(self, card)
    return true
  end,
  use = function(self, card, area, copier)
    G.E_MANAGER:add_event(Event({
      trigger = 'after',
      delay = 0.4,
      func = function()
        play_sound('timpani')
        card:juice_up(0.3, 0.5)
        ease_dollars(math.max(0, math.min(G.GAME.dollars, card.ability.extra.money_cap)), true)
        return true
      end
    }))
    delay(0.6)
  end
}

SMODS.Consumable {
  set = "phanta_Hanafuda",
  key = "maple_chaff_b",
  pos = { x = 9, y = 3 },
  atlas = hanafuda_atlas,
  config = { phanta_chaff = true, extra = { money_cap = 20 } },
  loc_vars = function(self, info_queue, card)
    return { vars = { card.ability.extra.money_cap } }
  end,
  can_use = function(self, card)
    return true
  end,
  use = function(self, card, area, copier)
    G.E_MANAGER:add_event(Event({
      trigger = 'after',
      delay = 0.4,
      func = function()
        play_sound('timpani')
        card:juice_up(0.3, 0.5)
        ease_dollars(math.max(0, math.min(G.GAME.dollars, card.ability.extra.money_cap)), true)
        return true
      end
    }))
    delay(0.6)
  end
}

SMODS.Consumable {
  set = "phanta_Hanafuda",
  key = "maple_ribbon",
  pos = { x = 9, y = 1 },
  atlas = hanafuda_atlas,
  config = { phanta_ribbon = true, extra = { money_cap = 30 } },
  loc_vars = function(self, info_queue, card)
    return { vars = { card.ability.extra.money_cap } }
  end,
  can_use = function(self, card)
    return true
  end,
  cost = 4,
  use = function(self, card, area, copier)
    G.E_MANAGER:add_event(Event({
      trigger = 'after',
      delay = 0.4,
      func = function()
        play_sound('timpani')
        card:juice_up(0.3, 0.5)
        ease_dollars(math.max(0, math.min(G.GAME.dollars, card.ability.extra.money_cap)), true)
        return true
      end
    }))
    delay(0.6)
  end
}

SMODS.Consumable {
  set = "phanta_Hanafuda",
  key = "maple_deer",
  pos = { x = 9, y = 0 },
  atlas = hanafuda_atlas,
  config = { phanta_animal = true, extra = { money_cap = 60 } },
  loc_vars = function(self, info_queue, card)
    return { vars = { card.ability.extra.money_cap } }
  end,
  can_use = function(self, card)
    return true
  end,
  cost = 6,
  use = function(self, card, area, copier)
    G.E_MANAGER:add_event(Event({
      trigger = 'after',
      delay = 0.4,
      func = function()
        play_sound('timpani')
        card:juice_up(0.3, 0.5)
        ease_dollars(math.max(0, math.min(G.GAME.dollars * 2, card.ability.extra.money_cap)), true)
        return true
      end
    }))
    delay(0.6)
  end
}



SMODS.Consumable {
  set = "phanta_Hanafuda",
  key = "willow_chaff",
  pos = { x = 10, y = 3 },
  atlas = hanafuda_atlas,
  config = { phanta_chaff = true, mod_conv = "m_wild", max_highlighted = 1 },
  loc_vars = function(self, info_queue, card)
    info_queue[#info_queue + 1] = G.P_CENTERS.m_wild
    return { vars = { card.ability.max_highlighted } }
  end
}

SMODS.Consumable {
  set = "phanta_Hanafuda",
  key = "willow_ribbon",
  pos = { x = 10, y = 2 },
  atlas = hanafuda_atlas,
  config = { phanta_ribbon = true, max_highlighted = 4 },
  loc_vars = function(self, info_queue, card)
    return { vars = { card.ability.max_highlighted } }
  end,
  cost = 4,
  use = function(self, card, area, copier)
    local hand_sorted = G.hand.highlighted
    table.sort(hand_sorted, function(a, b) return a.T.x < b.T.x end)
    G.E_MANAGER:add_event(Event({
      trigger = 'after',
      delay = 0.4,
      func = function()
        play_sound('tarot1')
        card:juice_up(0.3, 0.5)
        return true
      end
    }))
    for i = 1, #hand_sorted - 1 do
      local percent = 1.15 - (i - 0.999) / (#hand_sorted - 1 - 0.998) * 0.3
      G.E_MANAGER:add_event(Event({
        trigger = 'after',
        delay = 0.15,
        func = function()
          hand_sorted[i]:flip(); play_sound('card1', percent); hand_sorted[i]:juice_up(0.3, 0.3); return true
        end
      }))
    end
    delay(0.2)
    for i = 1, #hand_sorted - 1 do
      G.E_MANAGER:add_event(Event({
        trigger = 'after',
        delay = 0.1,
        func = function()
          hand_sorted[i]:change_suit(hand_sorted[#hand_sorted].ability.phanta_actual_suit
            or hand_sorted[#hand_sorted].base.suit); return true
        end
      }))
    end
    for i = 1, #hand_sorted - 1 do
      local percent = 0.85 + (i - 0.999) / (#hand_sorted - 1 - 0.998) * 0.3
      G.E_MANAGER:add_event(Event({
        trigger = 'after',
        delay = 0.15,
        func = function()
          hand_sorted[i]:flip(); play_sound('tarot2', percent, 0.6); hand_sorted[i]:juice_up(0.3, 0.3); return true
        end
      }))
    end
    G.E_MANAGER:add_event(Event({
      trigger = 'after',
      delay = 0.2,
      func = function()
        G.hand:unhighlight_all(); return true
      end
    }))
    delay(0.5)
  end
}

SMODS.Consumable {
  set = "phanta_Hanafuda",
  key = "willow_swallow",
  pos = { x = 10, y = 1 },
  atlas = hanafuda_atlas,
  config = { phanta_animal = true, max_highlighted = 4 },
  loc_vars = function(self, info_queue, card)
    return { vars = { card.ability.max_highlighted } }
  end,
  cost = 4,
  use = function(self, card, area, copier)
    local hand_sorted = G.hand.highlighted
    table.sort(hand_sorted, function(a, b) return a.T.x < b.T.x end)
    G.E_MANAGER:add_event(Event({
      trigger = 'after',
      delay = 0.4,
      func = function()
        play_sound('tarot1')
        card:juice_up(0.3, 0.5)
        return true
      end
    }))
    for i = 1, #hand_sorted - 1 do
      local percent = 1.15 - (i - 0.999) / (#hand_sorted - 1 - 0.998) * 0.3
      G.E_MANAGER:add_event(Event({
        trigger = 'after',
        delay = 0.15,
        func = function()
          hand_sorted[i]:flip(); play_sound('card1', percent); hand_sorted[i]:juice_up(0.3, 0.3); return true
        end
      }))
    end
    delay(0.2)
    for i = 1, #hand_sorted - 1 do
      G.E_MANAGER:add_event(Event({
        trigger = 'after',
        delay = 0.1,
        func = function()
          hand_sorted[i]:change_suit(hand_sorted[#hand_sorted].ability.phanta_actual_suit
            or hand_sorted[#hand_sorted].base.suit); return true
        end
      }))
    end
    for i = 1, #hand_sorted - 1 do
      local percent = 0.85 + (i - 0.999) / (#hand_sorted - 1 - 0.998) * 0.3
      G.E_MANAGER:add_event(Event({
        trigger = 'after',
        delay = 0.15,
        func = function()
          hand_sorted[i]:flip(); play_sound('tarot2', percent, 0.6); hand_sorted[i]:juice_up(0.3, 0.3); return true
        end
      }))
    end
    G.E_MANAGER:add_event(Event({
      trigger = 'after',
      delay = 0.2,
      func = function()
        G.hand:unhighlight_all(); return true
      end
    }))
    delay(0.5)
  end
}

SMODS.Consumable {
  set = "phanta_Hanafuda",
  key = "willow_rain_man",
  pos = { x = 10, y = 0 },
  atlas = hanafuda_atlas,
  config = { phanta_bright = true, max_highlighted = 5 },
  loc_vars = function(self, info_queue, card)
    return { vars = { card.ability.max_highlighted } }
  end,
  cost = 6,
  use = function(self, card, area, copier)
    local hand_sorted = G.hand.highlighted
    table.sort(hand_sorted, function(a, b) return a.T.x < b.T.x end)
    G.E_MANAGER:add_event(Event({
      trigger = 'after',
      delay = 0.4,
      func = function()
        play_sound('tarot1')
        card:juice_up(0.3, 0.5)
        return true
      end
    }))
    for i = 1, #hand_sorted - 1 do
      local percent = 1.15 - (i - 0.999) / (#hand_sorted - 1 - 0.998) * 0.3
      G.E_MANAGER:add_event(Event({
        trigger = 'after',
        delay = 0.15,
        func = function()
          hand_sorted[i]:flip(); play_sound('card1', percent); hand_sorted[i]:juice_up(0.3, 0.3); return true
        end
      }))
    end
    delay(0.2)
    for i = 1, #hand_sorted - 1 do
      G.E_MANAGER:add_event(Event({
        trigger = 'after',
        delay = 0.1,
        func = function()
          hand_sorted[i]:change_suit(hand_sorted[#hand_sorted].ability.phanta_actual_suit
            or hand_sorted[#hand_sorted].base.suit); return true
        end
      }))
    end
    for i = 1, #hand_sorted - 1 do
      local percent = 0.85 + (i - 0.999) / (#hand_sorted - 1 - 0.998) * 0.3
      G.E_MANAGER:add_event(Event({
        trigger = 'after',
        delay = 0.15,
        func = function()
          hand_sorted[i]:flip(); play_sound('tarot2', percent, 0.6); hand_sorted[i]:juice_up(0.3, 0.3); return true
        end
      }))
    end
    G.E_MANAGER:add_event(Event({
      trigger = 'after',
      delay = 0.2,
      func = function()
        G.hand:unhighlight_all(); return true
      end
    }))
    delay(0.5)
  end
}



SMODS.Consumable {
  set = "phanta_Hanafuda",
  key = "paulownia_chaff_a",
  pos = { x = 11, y = 2 },
  atlas = hanafuda_atlas,
  config = { phanta_chaff = true, extra = { sell_value = 1 } },
  loc_vars = function(self, info_queue, card)
    return { vars = { card.ability.extra.sell_value } }
  end,
  can_use = function(self, card)
    return G.jokers and G.jokers.cards and #G.jokers.cards > 0
  end,
  use = function(self, card, area, copier)
    G.E_MANAGER:add_event(Event({
      trigger = 'after',
      delay = 0.4,
      func = function()
        for k, v in ipairs(G.jokers.cards) do
          if v.set_cost then
            v.ability.extra_value = (v.ability.extra_value or 0) + card.ability.extra.sell_value
            v:set_cost()
            v:juice_up()
          end
        end
        attention_text({
          text = localize('k_val_up'),
          scale = 1,
          hold = 1.4,
          major = card,
          backdrop_colour = G.C.MONEY,
          align = 'cm',
          offset = { x = 0, y = 0 }
        })
        play_sound("timpani")
        card:juice_up(0.3, 0.5)
        return true
      end
    }))
    delay(0.6)
  end
}

SMODS.Consumable {
  set = "phanta_Hanafuda",
  key = "paulownia_chaff_b",
  pos = { x = 11, y = 3 },
  atlas = hanafuda_atlas,
  config = { phanta_chaff = true, extra = { sell_value = 1 } },
  loc_vars = function(self, info_queue, card)
    return { vars = { card.ability.extra.sell_value } }
  end,
  can_use = function(self, card)
    return G.jokers and G.jokers.cards and #G.jokers.cards > 0
  end,
  use = function(self, card, area, copier)
    G.E_MANAGER:add_event(Event({
      trigger = 'after',
      delay = 0.4,
      func = function()
        for k, v in ipairs(G.jokers.cards) do
          if v.set_cost then
            v.ability.extra_value = (v.ability.extra_value or 0) + card.ability.extra.sell_value
            v:set_cost()
            v:juice_up()
          end
        end
        attention_text({
          text = localize('k_val_up'),
          scale = 1,
          hold = 1.4,
          major = card,
          backdrop_colour = G.C.MONEY,
          align = 'cm',
          offset = { x = 0, y = 0 }
        })
        play_sound("timpani")
        card:juice_up(0.3, 0.5)
        return true
      end
    }))
    delay(0.6)
  end
}

SMODS.Consumable {
  set = "phanta_Hanafuda",
  key = "paulownia_chaff_yellow",
  pos = { x = 11, y = 1 },
  atlas = hanafuda_atlas,
  config = { phanta_chaff = true, extra = { sell_value = 2 } },
  loc_vars = function(self, info_queue, card)
    return { vars = { card.ability.extra.sell_value } }
  end,
  can_use = function(self, card)
    return G.jokers and G.jokers.cards and #G.jokers.cards > 0
  end,
  cost = 4,
  use = function(self, card, area, copier)
    G.E_MANAGER:add_event(Event({
      trigger = 'after',
      delay = 0.4,
      func = function()
        for k, v in ipairs(G.jokers.cards) do
          if v.set_cost then
            v.ability.extra_value = (v.ability.extra_value or 0) + card.ability.extra.sell_value
            v:set_cost()
            v:juice_up()
          end
        end
        attention_text({
          text = localize('k_val_up'),
          scale = 1,
          hold = 1.4,
          major = card,
          backdrop_colour = G.C.MONEY,
          align = 'cm',
          offset = { x = 0, y = 0 }
        })
        play_sound("timpani")
        card:juice_up(0.3, 0.5)
        return true
      end
    }))
    delay(0.6)
  end
}

SMODS.Consumable {
  set = "phanta_Hanafuda",
  key = "paulownia_phoenix",
  pos = { x = 11, y = 0 },
  atlas = hanafuda_atlas,
  config = { phanta_bright = true, extra = { sell_value = 5 } },
  loc_vars = function(self, info_queue, card)
    return { vars = { card.ability.extra.sell_value } }
  end,
  can_use = function(self, card)
    return G.jokers and G.jokers.cards and #G.jokers.cards > 0
  end,
  cost = 6,
  use = function(self, card, area, copier)
    G.E_MANAGER:add_event(Event({
      trigger = 'after',
      delay = 0.4,
      func = function()
        for k, v in ipairs(G.jokers.cards) do
          if v.set_cost then
            v.ability.extra_value = (v.ability.extra_value or 0) + card.ability.extra.sell_value
            v:set_cost()
            v:juice_up()
          end
        end
        attention_text({
          text = localize('k_val_up'),
          scale = 1,
          hold = 1.4,
          major = card,
          backdrop_colour = G.C.MONEY,
          align = 'cm',
          offset = { x = 0, y = 0 }
        })
        play_sound("timpani")
        card:juice_up(0.3, 0.5)
        return true
      end
    }))
    delay(0.6)
  end
}











function phanta_create_hanafuda_chaff(key, skip_materialise)
  local chaffs = {}
  for k, v in pairs(G.P_CENTERS) do
    if v.set == "phanta_Hanafuda" and v.config and v.config.phanta_chaff then chaffs[#chaffs + 1] = k end
  end

  return create_card('phanta_Hanafuda', G.consumeables, nil, nil, skip_materialise, nil,
  pseudorandom_element(chaffs, pseudoseed(key)),
    key)
end

function phanta_create_hanafuda_ribbon(key, skip_materialise)
  local ribbons = {}
  for k, v in pairs(G.P_CENTERS) do
    if v.set == "phanta_Hanafuda" and v.config and v.config.phanta_ribbon then ribbons[#ribbons + 1] = k end
  end

  return create_card('phanta_Hanafuda', G.consumeables, nil, nil, skip_materialise, nil,
    pseudorandom_element(ribbons, pseudoseed(key)), key)
end

function phanta_create_hanafuda_animal(key, skip_materialise)
  local animals = {}
  for k, v in pairs(G.P_CENTERS) do
    if v.set == "phanta_Hanafuda" and v.config and v.config.phanta_animal then animals[#animals + 1] = k end
  end

  return create_card('phanta_Hanafuda', G.consumeables, nil, nil, skip_materialise, nil,
    pseudorandom_element(animals, pseudoseed(key)), key)
end

function phanta_create_hanafuda_ribbon_animal(key, skip_materialise)
  if pseudorandom(key) >= 0.5 then
    return phanta_create_hanafuda_ribbon(key, skip_materialise)
  else
    return phanta_create_hanafuda_animal(key, skip_materialise)
  end
end

function phanta_create_hanafuda_bright(key, skip_materialise)
  local brights = {}
  for k, v in pairs(G.P_CENTERS) do
    if v.set == "phanta_Hanafuda" and v.config and v.config.phanta_bright then brights[#brights + 1] = k end
  end

  return create_card('phanta_Hanafuda', G.consumeables, nil, nil, skip_materialise, nil,
    pseudorandom_element(brights, pseudoseed(key)), key)
end
