local gears = require("gears")
local awful = require("awful")
require("awful.autofocus")
local wibox = require("wibox")
local beautiful = require("beautiful")
local naughty = require("naughty")
require("awful.hotkeys_popup.keys")

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
local sound_folder = "~/.config/awesome/themes/default/sounds/"
SOUND = {
	startup = function()
		awful.spawn.with_shell("paplay " .. sound_folder .. "startup.wav")
	end,
	notification = function()
		awful.spawn.with_shell("paplay " .. sound_folder .. "notification.wav")
	end,
	close = function()
		awful.spawn.with_shell("paplay " .. sound_folder .. "close.wav")
	end,
	navigation_left = function()
		awful.spawn.with_shell("paplay " .. sound_folder .. "navigation_left.wav")
	end,
	navigation_right = function()
		awful.spawn.with_shell("paplay " .. sound_folder .. "navigation_right.wav")
	end,
	screenshot = function()
		awful.spawn.with_shell("paplay " .. sound_folder .. "screenshot.wav")
	end,
	volume_change = function()
		awful.spawn.with_shell("paplay " .. sound_folder .. "volume_change.wav")
	end,
}

function naughty.config.notify_callback(args)
	SOUND.notification()
	return args
end

-- {{{ Variable definitions
beautiful.init("~/.config/awesome/themes/default/theme.lua")

TERMINAL = "wezterm"
EDITOR = os.getenv("EDITOR") or "editor"
EDITOR_CMD = TERMINAL .. " -e " .. EDITOR
FILE_MANAGER_GUI = "thunar"
WEB_BROWSER = "firefox"

MODKEY = "Mod4"

awful.layout.layouts = {
	awful.layout.suit.tile.left,
}

-- {{{ Wibar
local mytextclock = wibox.widget.textclock()
local mysystray = wibox.widget.systray()
local fs_widget = require("widgets.fs")
local myvolume = require("widgets.volume")({
	widget_type = "arc",
})

local taglist_buttons = gears.table.join(
	awful.button({}, 1, function(t)
		t:view_only()
	end),
	awful.button({}, 4, function(t)
		awful.tag.viewnext(t.screen)
		SOUND.navigation_right()
	end),
	awful.button({}, 5, function(t)
		awful.tag.viewprev(t.screen)
		SOUND.navigation_left()
	end)
)

local tasklist_buttons = gears.table.join(
	awful.button({}, 1, function(c)
		if c == client.focus then
			c.minimized = true
		else
			c:emit_signal("request::activate", "tasklist", { raise = true })
		end
	end),
	awful.button({}, 2, function(c)
		c:kill()
		SOUND.close()
	end)
)

awful.screen.connect_for_each_screen(function(s)
	-- Each screen has its own tag table.
	awful.tag({ "", "󰈹", "", "󰭹", "" }, s, awful.layout.layouts[1])

	-- Create a taglist widget
	s.mytaglist = awful.widget.taglist({
		screen = s,
		filter = awful.widget.taglist.filter.all,
		buttons = taglist_buttons,
	})

	-- Create a tasklist widget
	s.mytasklist = awful.widget.tasklist({
		screen = s,
		filter = awful.widget.tasklist.filter.currenttags,
		buttons = tasklist_buttons,
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
			wibox.container.margin(s.mytaglist, 8, 0, 0, 0),
			s.mytasklist,
		},
		{ -- Middle widget
			layout = wibox.layout.align.horizontal,
		},
		{ -- Right widgets
			layout = wibox.layout.fixed.horizontal,
			mytextclock,
			myvolume,
			fs_widget(),
			wibox.container.margin(mysystray, 0, 10, 0, 0),
		},
	})
end)
-- }}}

local clientbuttons = gears.table.join(
	awful.button({}, 1, function(c)
		c:emit_signal("request::activate", "mouse_click", { raise = true })
	end),
	awful.button({ MODKEY }, 1, function(c)
		c:emit_signal("request::activate", "mouse_click", { raise = true })
		awful.mouse.client.move(c)
	end),
	awful.button({ MODKEY }, 3, function(c)
		c:emit_signal("request::activate", "mouse_click", { raise = true })
		awful.mouse.client.resize(c)
	end),
	awful.button({ MODKEY }, 2, function(c)
		c:emit_signal("request::activate", "mouse_click", { raise = true })
		c:kill()
		SOUND.close()
	end)
)

-- Set keys
local globalkeys = require("keybinds.global")
root.keys(globalkeys)
local clientkeys = require("keybinds.client")
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

	{
		rule = { name = "Mozilla Firefox" },
		properties = { tag = "󰈹" },
	},

	{
		rule_any = { name = { "EVE Launcher" } },
		properties = { tag = "", floating = true },
	},

	{
		rule_any = { name = "Steam", "EVE" },
		properties = { tag = "", fullscreen = true },
	},
}
-- }}}

-- {{{ Signals
client.connect_signal("manage", function(c)
	if not awesome.startup then
		awful.client.setslave(c)
	end

	if c.maximized then
		c.shape = gears.shape.rectangle
	else
		c.shape = gears.shape.rounded_rect
	end

	if awesome.startup and not c.size_hints.user_position and not c.size_hints.program_position then
		-- Prevent clients from being unreachable after screen count changes.
		awful.placement.no_offscreen(c)
	end
end)

client.connect_signal("property::size", function(c)
	if c.maximized then
		c.shape = gears.shape.rectangle
	else
		c.shape = gears.shape.rounded_rect
	end
end)

client.connect_signal("focus", function(c)
	local t = awful.tag.selected(c.screen)
	if #t:clients() > 1 then
		c.border_color = beautiful.border_focus
	end
	local x = 0
	for _, cl in pairs(t:clients()) do
		if not cl.floating then
			x = x + 1
		end
	end
	if x > 1 then
		t.master_width_factor = 0.5
	end
end)

client.connect_signal("unfocus", function(c)
	c.border_color = beautiful.border_normal
end)

client.connect_signal("tagged", function(c)
	local t = awful.tag.selected(c.screen)
	local x = 0
	for _, cl in pairs(t:clients()) do
		if not cl.floating then
			x = x + 1
		end
	end
	if x > 1 then
		t.master_width_factor = 0.5
	end
end)

client.connect_signal("untagged", function(c)
	local t = awful.tag.selected(c.screen)
	if #t:clients() <= 1 then
		t.master_width_factor = beautiful.master_width_factor
	end
end)

-- }}}

-- Autostart Applications
awful.spawn.with_shell("xrandr --output DisplayPort-2 --primary --mode 3440x1440 --rate 100")
awful.spawn.with_shell("nitrogen --restore")
SOUND.startup()
