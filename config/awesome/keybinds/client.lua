local awful = require("awful")
local gears = require("gears")
local sound_folder = "~/.config/awesome/themes/default/sounds/"

local navigation_left = function()
	awful.spawn.with_shell("paplay " .. sound_folder .. "navigation_left.wav")
end
local navigation_right = function()
	awful.spawn.with_shell("paplay " .. sound_folder .. "navigation_right.wav")
end
local close = function()
	awful.spawn.with_shell("paplay " .. sound_folder .. "close.wav")
end

local clientkeys = gears.table.join(
	awful.key({ modkey, "Control" }, "f", function(c)
		c.fullscreen = not c.fullscreen
		c:raise()
	end, { description = "toggle fullscreen", group = "client" }),

	awful.key({ modkey, "Control" }, "m", function(c)
		c.maximized = not c.maximized
		c:raise()
	end, { description = "(un)maximize", group = "client" }),

	awful.key({ modkey, "Shift" }, "c", function(c)
		c:kill()
		close()
	end, { description = "close", group = "client" }),

	awful.key( { modkey, "Control" }, "space",
		awful.client.floating.toggle,
		{ description = "toggle floating", group = "client" }
	),

	awful.key({ modkey, "Control", "Mod1" }, "l", function()
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
		navigation_right()
	end, { description = "move focused client to next tag and view tag", group = "client" }),

	awful.key({ modkey, "Control", "Mod1" }, "h", function()
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
		navigation_left()
	end, { description = "move focused client to previous tag and view tag", group = "client" })
)

return clientkeys
