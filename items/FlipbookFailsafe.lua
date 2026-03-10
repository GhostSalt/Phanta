-- This script was intended for making the mod work without Flipbook, but for now I think I'll just make it a dependency. Lots of things use it.






local mod_name = "Phanta"

--[[

Your localisation file must contain the following, or similar, under "dictionary":

flipbook_dontshowagain = "Don't show me this again",
flipbook_disabled_headsup_1 = "It is recommended that",
flipbook_disabled_headsup_2 = "you install/enable Flipbook",
flipbook_disabled_headsup_3 = "to allow this mod to display",
flipbook_disabled_headsup_4 = "its custom animations.",
flipbook_disabled_headsup_5 = "https://github.com/GhostSalt/Flipbook",

]]--

G.FUNCS.run_flipbook_failsafe_menu = function()
	G.SETTINGS.paused = true
	G.FUNCS.overlay_menu {
		definition = create_flipbook_failsafe_menu()
	}
end

function create_flipbook_failsafe_menu()
	local dontshowagain = create_toggle({
		label = localize("flipbook_dontshowagain"),
		active_colour = HEX("40c76d"),
		ref_table = G,
		ref_value = "flipbook_did_player_no_show_again",
		callback = function()
		end,
	})

	local t = create_UIBox_generic_options({
		contents = {
			{
				n = G.UIT.R,
				config = { align = "cm", padding = 0.1 },
				nodes = {
					{
						n = G.UIT.T,
						config = {
							align = "tm",
							text = mod_name,
							colour = G.C.UI.TEXT_LIGHT,
							scale = 1
						}
					}
				}
			},
			{
				n = G.UIT.R,
				config = { align = "cm", minw = 7, minh = 5, colour = G.C.BLACK, emboss = 0.05, r = 0.1 },
				nodes = {
					{
						n = G.UIT.C,
						config = { align = "cm" },
						nodes = {
							{
								n = G.UIT.R,
								config = { align = "cm" },
								nodes = {
									{
										n = G.UIT.T,
										config = {
											align = "cm",
											text = localize("flipbook_disabled_headsup_1"),
											colour = G.C.UI.TEXT_LIGHT,
											scale = 0.5
										}
									}
								}
							},
							{
								n = G.UIT.R,
								config = { align = "cm" },
								nodes = {
									{
										n = G.UIT.B,
										config = { align = "cm", w = 1, h = 0.5 },
										nodes = {}
									}
								}
							},
							{
								n = G.UIT.R,
								config = { align = "cm" },
								nodes = {
									{
										n = G.UIT.T,
										config = {
											align = "cm",
											text = localize("flipbook_disabled_headsup_2"),
											colour = G.C.UI.TEXT_LIGHT,
											scale = 0.5
										}
									}
								}
							},
							{
								n = G.UIT.R,
								config = { align = "cm" },
								nodes = {
									{
										n = G.UIT.B,
										config = { align = "cm", w = 1, h = 0.1 },
										nodes = {}
									}
								}
							},
							{
								n = G.UIT.R,
								config = { align = "cm" },
								nodes = {
									{
										n = G.UIT.T,
										config = {
											align = "cm",
											text = localize("flipbook_disabled_headsup_3"),
											colour = G.C.UI.TEXT_LIGHT,
											scale = 0.5
										}
									}
								}
							},
							{
								n = G.UIT.R,
								config = { align = "cm" },
								nodes = {
									{
										n = G.UIT.B,
										config = { align = "cm", w = 1, h = 0.1 },
										nodes = {}
									}
								}
							},
							{
								n = G.UIT.R,
								config = { align = "cm" },
								nodes = {
									{
										n = G.UIT.T,
										config = {
											align = "cm",
											text = localize("flipbook_disabled_headsup_4"),
											colour = G.C.UI.TEXT_LIGHT,
											scale = 0.5
										}
									}
								}
							},
							{
								n = G.UIT.R,
								config = { align = "cm" },
								nodes = {
									{
										n = G.UIT.B,
										config = { align = "cm", w = 1, h = 0.1 },
										nodes = {}
									}
								}
							},
							{
								n = G.UIT.R,
								config = { align = "cm" },
								nodes = {
									{
										n = G.UIT.T,
										config = {
											align = "cm",
											text = localize("flipbook_disabled_headsup_5"),
											colour = G.C.BLUE,
											scale = 0.5
										}
									}
								}
							}
						}
					}
				}
			},
			{
				n = G.UIT.R,
				config = { align = "cm" },
				nodes = {
					dontshowagain
				}
			}
		},
		back_label = localize("b_continue"),
		back_func = "exit_flipbook_failsafe_overlay_menu"
	})
	return t
end

G.FUNCS.exit_flipbook_failsafe_overlay_menu = function()
	if not G.OVERLAY_MENU then return end

	G.CONTROLLER.locks.frame_set = true
	G.CONTROLLER.locks.frame = true
	G.CONTROLLER:mod_cursor_context_layer(-1000)
	G.OVERLAY_MENU:remove()
	G.OVERLAY_MENU = nil
	G.VIEWING_DECK = nil
	G.SETTINGS.paused = false

	G:save_settings()

	G.flipbook_has_seen_failsafe_this_session = true
	G.PROFILES[G.SETTINGS.profile].flipbook_has_seen_failsafe_headsup = G.flipbook_did_player_no_show_again
	G:save_settings()
end

local main_menu_ref = Game.main_menu
Game.main_menu = function(change_context)
	local ret = main_menu_ref(change_context)

	if not G.flipbook_has_seen_failsafe_this_session
		and not G.PROFILES[G.SETTINGS.profile].flipbook_has_seen_failsafe_headsup then
		G.FUNCS.run_flipbook_failsafe_menu()
	end

	return ret
end







function Card:flipbook_set_anim_state(state, dont_reset_t) return end
function Card:flipbook_set_anim_extra_state(state, layer, dont_reset_t) return end
function SMODS.Center:flipbook_set_anim_state(state, dont_reset_t) return end
function SMODS.Center:flipbook_set_anim_extra_state(state, layer, dont_reset_t) return end
function flipbook_set_anim_state(center, state, dont_reset_t) return end
function flipbook_set_anim_extra_state(center, state, layer, dont_reset_t) return end

SMODS.DrawStep {
  key = 'extra',
  order = 21,
  func = function(self, layer)
    if not self.flipbook_extra and self.config.center.flipbook_pos_extra then
      self.flipbook_extra = {}
      local fpe = self.config.center.flipbook_pos_extra
      if fpe.x and fpe.y then -- flipbook_pos_extra = { x = ?, y = ?, atlas = "ExampleAtlas" }
        local atlas = G.ASSET_ATLAS[fpe.atlas or self.config.center.atlas]
        self.flipbook_extra.extra = Sprite(0, 0, atlas.px, atlas.py, atlas, { x = fpe.x, y = fpe.y })
      else -- flipbook_pos_extra = { example = { x = ?, y = ? }, example2 = { x = ?, y = ?, atlas = "ExampleAtlas" } }
        for k, v in pairs(fpe) do
          local atlas = G.ASSET_ATLAS[v and v.atlas or self.config.center.atlas]
          self.flipbook_extra[k] = Sprite(0, 0, atlas.px, atlas.py, atlas, get_pos_from_flipbook_table(v))
        end
      end
    end
    if self.flipbook_extra then
      if self.config.center.discovered or (self.params and self.params.bypass_discovery_center) then
        local fpe = self.config.center.flipbook_pos_extra
        if fpe.x and fpe.y then
          fpe = { extra = self.config.center.flipbook_pos_extra }
        end
        for k, v in pairs(fpe) do
          self.flipbook_extra[k]:set_sprite_pos(get_pos_from_flipbook_table(v))
          self.flipbook_extra[k].role.draw_major = self
          if (self.edition and self.edition.negative and (not self.delay_edition or self.delay_edition.negative)) or (self.ability.name == 'Antimatter' and (self.config.center.discovered or self.bypass_discovery_center)) then
            self.flipbook_extra[k]:draw_shader('negative', nil, self.ARGS.send_to_shader, nil, self.children.center)
          elseif not self:should_draw_base_shader() then
          elseif not self.greyed then
            self.flipbook_extra[k]:draw_shader('dissolve', nil, nil, nil, self.children.center)
          end

          if self.ability.name == 'Invisible Joker' and (self.config.center.discovered or self.bypass_discovery_center) then
            if self:should_draw_base_shader() then
              self.flipbook_extra[k]:draw_shader('voucher', nil, self.ARGS.send_to_shader, nil, self.children.center)
            end
          end

          local center = self.config.center
          if center.flipbook_draw_extra and type(center.flipbook_draw_extra) == "function" then
            center:flipbook_draw_extra(self, layer)
          end
          if center.flipbook_draw_extra and type(center.flipbook_draw_extra) == "table"
              and center.flipbook_draw_extra[k] and type(center.flipbook_draw_extra[k]) == "function" then
            (center.flipbook_draw_extra[k])(self, layer)
          end

          local edition = self.delay_edition or self.edition
          if edition then
            for kk, vv in pairs(G.P_CENTER_POOLS.Edition) do
              if edition[vv.key:sub(3)] and vv.shader then
                if type(v.draw) == 'function' then
                  vv:draw(self, layer)
                else
                  self.flipbook_extra[k]:draw_shader(vv.shader, nil, self.ARGS.send_to_shader, nil, self.children.center)
                end
              end
            end
          end
          if (edition and edition.negative) or (self.ability.name == 'Antimatter' and (self.config.center.discovered or self.bypass_discovery_center)) then
            self.flipbook_extra[k]:draw_shader('negative_shine', nil, self.ARGS.send_to_shader, nil, self.children.center)
          end
        end
      end
    end
  end,
  conditions = { vortex = false, facing = 'front' }
}