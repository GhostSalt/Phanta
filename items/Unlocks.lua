local set_ability_ref = Card.set_ability
function Card:set_ability(center, initial, display_sprites)
  set_ability_ref(self, center, initial, display_sprites)
  if SMODS.has_enhancement(self, "m_phanta_ghostcard") and self.seal == 'phanta_ghostseal' and self.playing_card then
    check_for_unlock({ type = 'phanta_double_ghost' })
  end
end

local set_seal_ref = Card.set_seal
function Card:set_seal(_seal, silent, immediate)
  set_seal_ref(self, _seal, silent, immediate)
  if SMODS.has_enhancement(self, "m_phanta_ghostcard") and self.seal == 'phanta_ghostseal' and self.playing_card then
    check_for_unlock({ type = 'phanta_double_ghost' })
  end
end

local add_to_deck_ref = Card.add_to_deck
function Card:add_to_deck(from_debuff)
  add_to_deck_ref(self, from_debuff)
  if SMODS.has_enhancement(self, "m_phanta_ghostcard") and self.seal == 'phanta_ghostseal' and self.playing_card then
    check_for_unlock({ type = 'phanta_double_ghost' })
  end

  if count_tarots() + (self.ability.set == "Tarot" and 1 or 0) >= 5 then
    check_for_unlock({ type = 'phanta_five_tarots' })
  end
end

local use_consumeable_ref = Card.use_consumeable
function Card:use_consumeable(area, copier)
  use_consumeable_ref(self, area, copier)
  if self.config.center.key == "c_death" then
    for _, v in ipairs(G.consumeables.cards) do
      if v.config.center.key == "c_death" then
        check_for_unlock({ type = 'phanta_double_death' })
      end
    end
  end

  if self.config.center.key == "c_sun" then
    for _, v in ipairs(G.consumeables.cards) do
      if v.config.center.key == "c_sun" then
        check_for_unlock({ type = 'phanta_double_sun' })
      end
    end
  end
end
