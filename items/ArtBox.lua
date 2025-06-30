SMODS.Atlas {
  key = "PhantaCollectables",
  path = "PhantaCollectables.png",
  px = 71,
  py = 95
}

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
    ref(self, change_context)
end
