local awful = require("awful")
local gears = require("gears")

local clientkeys = gears.table.join(
	awful.key({ MODKEY, "Control" }, "f", function(c)
		c.fullscreen = not c.fullscreen
		c:raise()
	end, { description = "toggle fullscreen", group = "client" }),

	awful.key({ MODKEY, "Control" }, "m", function(c)
		c.maximized = not c.maximized
		c:raise()
	end, { description = "(un)maximize", group = "client" }),

	awful.key({ MODKEY, "Shift" }, "c", function(c)
		c:kill()
		SOUND.close()
	end, { description = "close", group = "client" }),

	awful.key(
		{ MODKEY, "Control" },
		"space",
		awful.client.floating.toggle,
		{ description = "toggle floating", group = "client" }
	),

	awful.key({ MODKEY, "Control", "Mod1" }, "l", function()
		local screen = awful.screen.focused()
		local t = screen.selected_tag
		if t then
			local idx = t.index + 1
			if idx > #screen.tags then
				idx = 1
			end
			if client.focus then
				client.focus:move_to_tag(screen.tags[idx])
				screen.tags[idx]:view_only()
			end
		end
		SOUND.navigation_right()
	end, { description = "move focused client to next tag and view tag", group = "client" }),

	awful.key({ MODKEY, "Control", "Mod1" }, "h", function()
		local screen = awful.screen.focused()
		local t = screen.selected_tag
		if t then
			local idx = t.index - 1
			if idx == 0 then
				idx = #screen.tags
			end
			if client.focus then
				client.focus:move_to_tag(screen.tags[idx])
				screen.tags[idx]:view_only()
			end
		end
		SOUND.navigation_left()
	end, { description = "move focused client to previous tag and view tag", group = "client" })
)

return clientkeys
