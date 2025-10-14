SMODS.Voucher {
  key = "tabloid",
  pos = { x = 0, y = 0 },
  draw = function(self, card, layer)
    if self.discovered or card.params.bypass_discovery_center then
      card.children.center:draw_shader('booster', nil, card.ARGS.send_to_shader)
    end
  end,
  cost = 10,
  atlas = "PhantaVouchers",
  redeem = function(self, card)
    G.P_CENTERS["c_star"].in_pool = function() return false end
    G.P_CENTERS["c_moon"].in_pool = function() return false end
    G.P_CENTERS["c_sun"].in_pool = function() return false end
    G.P_CENTERS["c_world"].in_pool = function() return false end
  end
}

SMODS.Voucher {
  key = "broadcast",
  pos = { x = 1, y = 0 },
  draw = function(self, card, layer)
    if self.discovered or card.params.bypass_discovery_center then
      card.children.center:draw_shader('booster', nil, card.ARGS.send_to_shader)
    end
  end,
  cost = 10,
  atlas = "PhantaVouchers",
  requires = { 'v_phanta_tabloid' },
  redeem = function(self, card)
    G.P_CENTERS["c_hex"].in_pool = function() return false end
    G.P_CENTERS["c_ankh"].in_pool = function() return false end
    G.P_CENTERS["c_ouija"].in_pool = function() return false end
    G.P_CENTERS["c_sigil"].in_pool = function() return false end
  end
}