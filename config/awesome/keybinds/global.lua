local awful = require("awful")
local gears = require("gears")
local hotkeys_popup = require("awful.hotkeys_popup")

local globalkeys = gears.table.join(
	awful.key({ modkey }, "s", hotkeys_popup.show_help, { description = "show help", group = "awesome" }),

	awful.key({ modkey, "Control" }, "h", function()
		awful.tag.viewprev()
	end, { description = "view previous", group = "tag" }),

	awful.key({ modkey, "Control" }, "l", function()
		awful.tag.viewnext()
	end, { description = "view next", group = "tag" }),

	-- awful.key({ modkey }, "=", function()
	-- 	volume_widget:inc(5)
	-- end, { description = "volume up", group = "awesome" }),
	--
	-- awful.key({ modkey }, "-", function()
	-- 	volume_widget:dec(5)
	-- end, { description = "volume down", group = "awesome" }),

	awful.key({ modkey }, "l", function()
		awful.client.focus.byidx(1)
	end, { description = "focus next by index", group = "client" }),

	awful.key({ modkey }, "h", function()
		awful.client.focus.byidx(-1)
	end, { description = "focus previous by index", group = "client" }),

	-- Layout manipulation
	awful.key({ modkey, "Mod1" }, "l", function()
		awful.screen.focus_relative(1)
	end, { description = "focus the next screen", group = "screen" }),

	awful.key({ modkey, "Mod1" }, "h", function()
		awful.screen.focus_relative(-1)
	end, { description = "focus the previous screen", group = "screen" }),

	-- Standard program
	awful.key({ modkey }, "Return", function()
		awful.spawn(terminal)
	end, { description = "open a terminal", group = "launcher" }),

	awful.key({ modkey, "Control" }, "r", awesome.restart, { description = "reload awesome", group = "awesome" }),

	awful.key({ modkey, "Shift" }, "q", awesome.quit, { description = "quit awesome", group = "awesome" }),

	awful.key({ modkey }, "Left", function()
		awful.tag.incmwfact(0.05)
	end, { description = "increase master width factor", group = "layout" }),

	awful.key({ modkey }, "Right", function()
		awful.tag.incmwfact(-0.05)
	end, { description = "decrease master width factor", group = "layout" }),

	awful.key({ modkey }, "r", function()
		awful.util.spawn("rofi -modi drun -show drun -show-icons -no-click-to-exit")
	end, { description = "run rofi", group = "launcher" }),

	-- Rofi window
	awful.key({ "Mod1" }, "Tab", function()
		awful.util.spawn("rofi -show window")
	end, { description = "run rofi window", group = "launcher" }),

	-- Gui file manager
	awful.key({ modkey }, "f", function()
		awful.util.spawn(file_manager_gui)
	end, { description = "open gui file manager", group = "launcher" }),

	-- wezterm mux
	awful.key({ modkey }, "t", function()
		awful.util.spawn( "wezterm connect unix")
	end, { description = "open wezterm mux", group = "launcher" }),

	-- Browser
	awful.key({ modkey }, "b", function()
		awful.util.spawn(web_browser)
	end, { description = "open your web browser", group = "launcher" })
)

for i = 1, 9 do
	globalkeys = gears.table.join(
		globalkeys,
		-- View tag only.
		awful.key({ modkey }, "#" .. i + 9, function()
			local screen = awful.screen.focused()
			local tag = screen.tags[i]
			if tag then
				tag:view_only()
			end
		end, { description = "view tag #" .. i, group = "tag" }),

		-- Move client to tag.
		awful.key({ modkey, "Mod1", "Control" }, "#" .. i + 9, function()
			if client.focus then
				local tag = client.focus.screen.tags[i]
				if tag then
					client.focus:move_to_tag(tag)
				end
			end
		end, { description = "move focused client to tag #" .. i, group = "tag" })
	)
end

return globalkeys
