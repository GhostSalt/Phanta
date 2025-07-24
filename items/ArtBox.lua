SMODS.Atlas {
  key = "PhantaCollectables",
  path = "PhantaCollectables.png",
  px = 71,
  py = 95
}

SMODS.Atlas {
  key = "PhantaArtBoxAnims",
  path = "PhantaArtBoxAnims.png",
  px = 71,
  py = 95
}

local current_mod_cache = SMODS.current_mod

local ref = Game.main_menu
function Game:main_menu(change_context)
  ArtBox.add_collectible('m_phanta_ghostcard',
    { atlas = 'phanta_PhantaCollectables', pos = { x = 0, y = 0 }, soul_pos = { x = 1, y = 0 } })
  ArtBox.add_collectible('phanta_ghostseal',
    { atlas = 'phanta_PhantaCollectables', pos = { x = 2, y = 0 }, soul_pos = { x = 3, y = 0 } })
  ArtBox.add_collectible('m_phanta_coppergratefresh',
    { atlas = 'phanta_PhantaCollectables', pos = { x = 4, y = 0 }, soul_pos = { x = 5, y = 0 } })
  ArtBox.add_collectible('m_phanta_marblecard',
    { atlas = 'phanta_PhantaCollectables', pos = { x = 0, y = 1 }, soul_pos = { x = 1, y = 1 } })
  ArtBox.add_collectible('e_phanta_waxed',
    { atlas = 'phanta_PhantaCollectables', pos = { x = 2, y = 1 }, soul_pos = { x = 3, y = 1 }, shader = 'phanta_waxed' })

  --very jank
  SMODS.current_mod = current_mod_cache

  SMODS.Joker:take_ownership('j_artb_random', {
    atlas = 'PhantaArtBoxAnims',
    pos = { x = 0, y = 0 },
    pos_extra = { x = 6, y = 1 },
    phanta_anim = {
      { x = 0,                             y = 0, t = 4 },
      { xrange = { first = 1, last = 11 }, y = 0, t = 0.1 },
      { xrange = { first = 0, last = 5 },  y = 1, t = 0.1 }
    },
    phanta_anim_extra = {
      { xrange = { first = 6, last = 11 }, y = 1, t = 0.15 },
      { xrange = { first = 10, last = 7 }, y = 1, t = 0.15 },
    }
  }, true)

  SMODS.current_mod = nil

  ref(self, change_context)
end