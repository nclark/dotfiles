--- @since 26.8.15
-- Local copy of yazi-rs/plugins full-border.yazi, drawing THICK (heavy)
-- borders instead of plain/rounded. Kept separate so `ya pkg upgrade`
-- doesn't overwrite it.

local function setup(_, opts)
	local kind = (opts and opts.type) or ui.Border.THICK
	local old_build = Tab.build

	Tab.build = function(self, ...)
		local c = self._chunks
		self._chunks = {
			c[1]:pad(ui.Pad.y(1)),
			c[2]:pad(ui.Pad.y(1)),
			c[3]:pad(ui.Pad.y(1)),
		}

		local style = th.mgr.border_style
		local inner = ui.Border(ui.Edge.ALL):area(c[2])
		inner:type(kind)
		local outer = ui.Border(ui.Edge.ALL):area(self._area)
		outer:type(kind)
		self._base = ya.list_merge(self._base or {}, {
			inner:style(style),
			outer:style(style):merge(),
		})

		old_build(self, ...)
	end
end

return { setup = setup }
