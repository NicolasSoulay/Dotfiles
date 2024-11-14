-- If LuaRocks is installed, make sure that packages installed through it are
-- found (e.g. lgi). If LuaRocks is not installed, do nothing.
pcall(require, "luarocks.loader")

local gears = require("gears")
local awful = require("awful")
require("awful.autofocus")
local wibox = require("wibox")
local beautiful = require("beautiful")
local naughty = require("naughty")
local hotkeys_popup = require("awful.hotkeys_popup")
require("awful.hotkeys_popup.keys")

-- Load Debian menu entries
local debian = require("debian.menu")
local has_fdo, freedesktop = pcall(require, "freedesktop")

-- {{{ Error handling
if awesome.startup_errors then
	naughty.notify({
		preset = naughty.config.presets.critical,
		title = "Oops, there were errors during startup!",
		text = awesome.startup_errors,
	})
end

-- Handle runtime errors after startup
do
	local in_error = false
	awesome.connect_signal("debug::error", function(err)
		-- Make sure we don't go into an endless error loop
		if in_error then
			return
		end
		in_error = true

		naughty.notify({
			preset = naughty.config.presets.critical,
			title = "Oops, an error happened!",
			text = tostring(err),
		})
		in_error = false
	end)
end
-- }}}

-- {{{ Variable definitions
beautiful.init("~/.config/awesome/themes/default/theme.lua")

terminal = "kitty"
editor = os.getenv("EDITOR") or "editor"
editor_cmd = terminal .. " -e " .. editor
file_manager_gui = "thunar"
mail_client = "thunderbird"
web_browser = "firefox"

modkey = "Mod4"

awful.layout.layouts = {
	awful.layout.suit.tile.left,
}

-- {{{ Menu
local menu_terminal = { "open terminal", terminal }
if has_fdo then
	mymainmenu = freedesktop.menu.build({
		before = { menu_awesome },
		after = { menu_terminal },
	})
else
	mymainmenu = awful.menu({
		items = {
			menu_awesome,
			{ "Debian", debian.menu.Debian_menu.Debian },
			menu_terminal,
		},
	})
end

mylauncher = awful.widget.launcher({
	image = beautiful.awesome_icon,
	menu = mymainmenu,
})

-- }}}

-- Calendar widget
local calendar_widget = require("widgets.calendar")
local cw = calendar_widget({})

-- {{{ Wibar
-- Create a textclock widget
mytextclock = wibox.widget.textclock("  %H:%M  ")
mytextclock:connect_signal("button::press", function(_, _, _, button)
	if button == 1 then
		cw.toggle()
	end
end)

local mysystray = wibox.widget.systray()

-- Volume control widget
volume_widget = require("widgets.volume")
local myvolume = volume_widget({
	widget_type = "arc",
})

-- Create a wibox for each screen and add it
local taglist_buttons = gears.table.join(
	awful.button({}, 1, function(t)
		t:view_only()
	end),
	awful.button({ modkey }, 1, function(t)
		if client.focus then
			client.focus:move_to_tag(t)
		end
	end),
	awful.button({}, 3, awful.tag.viewtoggle),
	awful.button({ modkey }, 3, function(t)
		if client.focus then
			client.focus:toggle_tag(t)
		end
	end),
	awful.button({}, 4, function(t)
		awful.tag.viewnext(t.screen)
	end),
	awful.button({}, 5, function(t)
		awful.tag.viewprev(t.screen)
	end)
)

awful.screen.connect_for_each_screen(function(s)
	-- Each screen has its own tag table.
	awful.tag({ "", "󰈹", "", "", "󰭹", "", "", "" }, s, awful.layout.layouts[1])

	-- Create a taglist widget
	s.mytaglist = awful.widget.taglist({
		screen = s,
		filter = awful.widget.taglist.filter.all,
		buttons = taglist_buttons,
	})

	-- Create a tasklist widget
	s.mytasklist = awful.widget.tasklist({
		screen = s,
		filter = awful.widget.tasklist.filter.focused,
	})

	-- Create the wibox
	s.mywibox = awful.wibar({ position = "bottom", height = 30, screen = s })

	-- Add widgets to the wibox
	s.mywibox:setup({
		layout = wibox.layout.align.horizontal,
		expand = "none",
		{ -- Left widgets
			layout = wibox.layout.fixed.horizontal,
			spacing = 10,
			wibox.container.margin(mylauncher, 8, 0, 3, 3),
			s.mytaglist,
			s.mytasklist,
		},
		-- { -- Middle widget
		-- 	layout = wibox.layout.align.horizontal,
		mytextclock,
		-- },
		{ -- Right widgets
			layout = wibox.layout.fixed.horizontal,
			mysystray,
			wibox.container.margin(myvolume, 0, 10, 0, 0),
		},
	})
end)
-- }}}

-- {{{ Mouse bindings
root.buttons(gears.table.join(awful.button({}, 4, awful.tag.viewnext), awful.button({}, 5, awful.tag.viewprev)))
-- }}}

-- {{{ Key bindings
-- globalkeys = gears.table.join(
-- 	awful.key({ modkey }, "s", hotkeys_popup.show_help, { description = "show help", group = "awesome" }),
--
-- 	awful.key({ modkey, "Control" }, "Left", function()
-- 		awful.tag.viewprev()
-- 	end, { description = "view previous", group = "tag" }),
--
--     awful.key({ modkey, "Control" }, "h", function()
-- 		awful.tag.viewprev()
-- 	end, { description = "view previous", group = "tag" }),
--
--     awful.key({ modkey, "Control" }, "Right", function()
-- 		awful.tag.viewnext()
-- 	end, { description = "view next", group = "tag" }),
--
--     awful.key({ modkey, "Control" }, "l", function()
-- 		awful.tag.viewnext()
-- 	end, { description = "view next", group = "tag" }),
--
-- 	awful.key({ modkey }, "=", function()
-- 		volume_widget:inc(5)
-- 	end, { description = "volume up", group = "awesome" }),
--
--     awful.key({ modkey }, "-", function()
-- 		volume_widget:dec(5)
-- 	end, { description = "volume down", group = "awesome" }),
--
-- 	awful.key({ modkey }, "l", function()
-- 		awful.client.focus.byidx(1)
-- 	end, { description = "focus next by index", group = "client" }),
--
--     awful.key({ modkey }, "h", function()
-- 		awful.client.focus.byidx(-1)
-- 	end, { description = "focus previous by index", group = "client" }),
--
--     awful.key({ modkey }, "w", function()
-- 		mymainmenu:show()
-- 	end, { description = "show main menu", group = "awesome" }),
--
-- 	-- Layout manipulation
-- 	awful.key({ modkey, "Mod1" }, "l", function()
-- 		awful.screen.focus_relative(1)
-- 	end, { description = "focus the next screen", group = "screen" }),
--
--     awful.key({ modkey, "Mod1" }, "Right", function()
-- 		awful.screen.focus_relative(1)
-- 	end, { description = "focus the next screen", group = "screen" }),
--
--     awful.key({ modkey, "Mod1" }, "h", function()
-- 		awful.screen.focus_relative(-1)
-- 	end, { description = "focus the previous screen", group = "screen" }),
--
--     awful.key({ modkey, "Mod1" }, "Left", function()
-- 		awful.screen.focus_relative(-1)
-- 	end, { description = "focus the previous screen", group = "screen" }),
--
-- 	-- Standard program
-- 	awful.key({ modkey }, "Return", function()
-- 		awful.spawn(terminal)
-- 	end, { description = "open a terminal", group = "launcher" }),
--
--     awful.key({ modkey, "Control" }, "r", awesome.restart, { description = "reload awesome", group = "awesome" }),
--
--     awful.key({ modkey, "Shift" }, "q", awesome.quit, { description = "quit awesome", group = "awesome" }),
--
--     awful.key({ modkey }, "Left", function()
-- 		awful.tag.incmwfact(0.05)
-- 	end, { description = "increase master width factor", group = "layout" }),
--
--     awful.key({ modkey }, "Right", function()
-- 		awful.tag.incmwfact(-0.05)
-- 	end, { description = "decrease master width factor", group = "layout" }),
--
-- 	awful.key({ modkey }, "r", function()
-- 		awful.util.spawn("rofi -show run")
-- 	end, { description = "run rofi", group = "launcher" }),
--
-- 	-- Rofi window
-- 	awful.key({ "Mod1" }, "Tab", function()
-- 		awful.util.spawn("rofi -show window")
-- 	end, { description = "run rofi window", group = "launcher" }),
--
-- 	-- Gui file manager
-- 	awful.key({ modkey }, "f", function()
-- 		awful.util.spawn(file_manager_gui)
-- 	end, { description = "open gui file manager", group = "launcher" }),
--
-- 	-- tmux sessionizer
-- 	awful.key({ modkey }, "t", function()
-- 		awful.util.spawn(terminal .. " -e tmux-sessionizer")
-- 	end, { description = "open tmux-sessionizer", group = "launcher" }),
--
-- 	-- Browser
-- 	awful.key({ modkey }, "b", function()
-- 		awful.util.spawn(web_browser)
-- 	end, { description = "open your web browser", group = "launcher" }),
-- )

-- clientkeys = gears.table.join(
-- 	awful.key({ modkey, "Control" }, "f", function(c)
-- 		c.fullscreen = not c.fullscreen
-- 		c:raise()
-- 	end, { description = "toggle fullscreen", group = "client" }),
--
-- 	awful.key({ modkey, "Shift" }, "c", function(c)
-- 		c:kill()
-- 	end, { description = "close", group = "client" }),
--
-- 	awful.key(
-- 		{ modkey, "Control" },
-- 		"space",
-- 		awful.client.floating.toggle,
-- 		{ description = "toggle floating", group = "client" }
-- 	),
--
-- 	awful.key({ modkey, "Control", "Mod1" }, "Right", function()
-- 		local screen = awful.screen.focused()
-- 		local t = screen.selected_tag
-- 		if t then
-- 			local idx = t.index + 1
-- 			if idx > #screen.tags then
-- 				idx = 1
-- 			end
-- 			if client.focus then
-- 				client.focus:move_to_tag(screen.tags[idx])
-- 				screen.tags[idx]:view_only()
-- 			end
-- 		end
-- 	end, { description = "move focused client to next tag and view tag", group = "client" }),
--
-- 	awful.key({ modkey, "Control", "Mod1" }, "Left", function()
-- 		local screen = awful.screen.focused()
-- 		local t = screen.selected_tag
-- 		if t then
-- 			local idx = t.index - 1
-- 			if idx == 0 then
-- 				idx = #screen.tags
-- 			end
-- 			if client.focus then
-- 				client.focus:move_to_tag(screen.tags[idx])
-- 				screen.tags[idx]:view_only()
-- 			end
-- 		end
-- 	end, { description = "move focused client to previous tag and view tag", group = "client" }),
--
-- 	awful.key({ modkey, "Control", "Mod1" }, "l", function()
-- 		local screen = awful.screen.focused()
-- 		local t = screen.selected_tag
-- 		if t then
-- 			local idx = t.index + 1
-- 			if idx > #screen.tags then
-- 				idx = 1
-- 			end
-- 			if client.focus then
-- 				client.focus:move_to_tag(screen.tags[idx])
-- 				screen.tags[idx]:view_only()
-- 			end
-- 		end
-- 	end, { description = "move focused client to next tag and view tag", group = "client" }),
--
-- 	awful.key({ modkey, "Control", "Mod1" }, "h", function()
-- 		local screen = awful.screen.focused()
-- 		local t = screen.selected_tag
-- 		if t then
-- 			local idx = t.index - 1
-- 			if idx == 0 then
-- 				idx = #screen.tags
-- 			end
-- 			if client.focus then
-- 				client.focus:move_to_tag(screen.tags[idx])
-- 				screen.tags[idx]:view_only()
-- 			end
-- 		end
-- 	end, { description = "move focused client to previous tag and view tag", group = "client" })
-- )

-- Bind all key numbers to tags.
-- Be careful: we use keycodes to make it work on any keyboard layout.
-- This should map on the top row of your keyboard, usually 1 to 9.
-- for i = 1, 9 do
-- 	globalkeys = gears.table.join(
-- 		globalkeys,
-- 		-- View tag only.
-- 		awful.key({ modkey }, "#" .. i + 9, function()
-- 			local screen = awful.screen.focused()
-- 			local tag = screen.tags[i]
-- 			if tag then
-- 				tag:view_only()
-- 			end
-- 		end, { description = "view tag #" .. i, group = "tag" }),
--
-- 		-- Move client to tag.
-- 		awful.key({ modkey, "Mod1", "Control" }, "#" .. i + 9, function()
-- 			if client.focus then
-- 				local tag = client.focus.screen.tags[i]
-- 				if tag then
-- 					client.focus:move_to_tag(tag)
-- 				end
-- 			end
-- 		end, { description = "move focused client to tag #" .. i, group = "tag" })
-- 	)
-- end

clientbuttons = gears.table.join(
	awful.button({}, 1, function(c)
		c:emit_signal("request::activate", "mouse_click", { raise = true })
	end),
	awful.button({ modkey }, 1, function(c)
		c:emit_signal("request::activate", "mouse_click", { raise = true })
		awful.mouse.client.move(c)
	end),
	awful.button({ modkey }, 3, function(c)
		c:emit_signal("request::activate", "mouse_click", { raise = true })
		awful.mouse.client.resize(c)
	end),
	awful.button({ modkey }, 2, function(c)
		c:emit_signal("request::activate", "mouse_click", { raise = true })
		c:kill()
	end)
)

-- Set keys
local globalkeys = require("keybinds.global")
local clientkeys = require("keybinds.client")
root.keys(globalkeys)
-- }}}

-- {{{ Rules
-- Rules to apply to new clients (through the "manage" signal).
awful.rules.rules = {
	-- All clients will match this rule.
	{
		rule = {},
		properties = {
			border_width = beautiful.border_width,
			border_color = beautiful.border_normal,
			focus = awful.client.focus.filter,
			raise = true,
			keys = clientkeys,
			buttons = clientbuttons,
			screen = awful.screen.preferred,
			placement = awful.placement.no_overlap + awful.placement.no_offscreen,
		},
	},

	-- Floating clients.
	{
		rule_any = {
			instance = {
				"DTA", -- Firefox addon DownThemAll.
				"copyq", -- Includes session name in class.
				"pinentry",
			},
			class = {
				"Arandr",
				"Blueman-manager",
				"Gpick",
				"Kruler",
				"MessageWin", -- kalarm.
				"Sxiv",
				"Tor Browser", -- Needs a fixed window size to avoid fingerprinting by screen size.
				"Wpa_gui",
				"veromix",
				"xtightvncviewer",
			},

			-- Note that the name property shown in xprop might be set slightly after creation of the client
			-- and the name shown there might not match defined rules here.
			name = {
				"Event Tester", -- xev.
				"Thunar",
				"doublecmd",
				"Volume Control",
				"Shutter",
			},
			role = {
				"AlarmWindow", -- Thunderbird's calendar.
				"ConfigManager", -- Thunderbird's about:config.
				"pop-up", -- e.g. Google Chrome's (detached) Developer Tools.
			},
		},
		properties = { floating = true },
	},

	-- Add titlebars to normal clients and dialogs
	{
		rule_any = { type = { "normal", "dialog" } },
		properties = { titlebars_enabled = false },
	},

	{
		rule = { class = "Mozilla Firefox" },
		properties = { tag = "󰈹" },
	},

	{
		rule = { name = "Steam" },
		properties = { tag = "", floating = true },
	},

	{
		rule = { name = "EVE Online Launcher" },
		properties = { tag = "", floating = true },
	},

	{
		rule = { name = "EVE" },
		properties = { tag = "", fullscreen = true },
	},

	{
		rule = { name = "Discord" },
		properties = { tag = "󰭹" },
	},

	{
		rule = { name = "Teams" },
		properties = { tag = "󰭹" },
	},

	{
		rule = { name = "Mozilla Thunderbird" },
		properties = { tag = "" },
	},
}
-- }}}

-- {{{ Signals
-- Signal function to execute when a new client appears.
client.connect_signal("manage", function(c)
	-- Set the windows at the slave,
	-- i.e. put it at the end of others instead of setting it master.
	if not awesome.startup then
		awful.client.setslave(c)
	end

	if c.floating then
		c.shape = gears.shape.rounded_rect
	end

	if awesome.startup and not c.size_hints.user_position and not c.size_hints.program_position then
		-- Prevent clients from being unreachable after screen count changes.
		awful.placement.no_offscreen(c)
	end
end)

client.connect_signal("property::size", function(c)
	if c.floating then
		c.shape = gears.shape.rounded_rect
	end
	if not c.floating then
		c.shape = gears.shape.rectangle
	end
end)

client.connect_signal("focus", function(c)
	c.border_color = beautiful.border_focus
end)
client.connect_signal("unfocus", function(c)
	c.border_color = beautiful.border_normal
end)
-- }}}

-- Autostart Applications
awful.spawn.with_shell("nitrogen --restore")
awful.spawn.with_shell("picom")
awful.spawn.with_shell("xrandr --output DisplayPort-2 --primary --mode 3440x1440 --rate 100")
