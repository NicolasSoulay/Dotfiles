local gears = require("gears")
local awful = require("awful")
local wibox = require("wibox")
local beautiful = require("beautiful")
local naughty = require("naughty")
require("awful.autofocus")
require("awful.hotkeys_popup.keys")

-- Error handling
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

-- Sounds related functions
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

-- Variable definitions
beautiful.init("~/.config/awesome/themes/default/theme.lua")
TERMINAL = "wezterm"
EDITOR = os.getenv("EDITOR") or "editor"
EDITOR_CMD = TERMINAL .. " -e " .. EDITOR
FILE_MANAGER_GUI = "thunar"
WEB_BROWSER = "firefox"
MODKEY = "Mod4"

awful.layout.layouts = {
	awful.layout.suit.tile.right,
}

-- Wibar
local mytextclock = wibox.widget.textclock()
mytextclock.format=' %a %b %d | %H:%M'
local mysystray = wibox.widget.systray()
local myweather = require('widgets.weather')
local myvolume = require("widgets.volume")({
	widget_type = "arc",
})

awful.screen.connect_for_each_screen(function(s)
	-- Each screen has its own tag table.
	awful.tag({ "", "󰈹", "", "󰭹", "" }, s, awful.layout.layouts[1])

	-- Create a taglist widget
	s.mytaglist = awful.widget.taglist({
		screen = s,
		filter = awful.widget.taglist.filter.all,
		buttons = {
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
			end),
		},
	})

	s.mypromptbox = awful.widget.prompt()

	-- Create a tasklist widget
	s.mytasklist = awful.widget.tasklist({
		screen = s,
		filter = awful.widget.tasklist.filter.currenttags,
		buttons = {
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
			end),
		},
	})

	-- Create the wibox
	s.mywibox = awful.wibar({ position = beautiful.wibar_position, height = beautiful.wibar_heigth, screen = s })

	-- Add widgets to the wibox
	s.mywibox:setup({
		layout = wibox.layout.align.horizontal,
		{
			layout = wibox.layout.fixed.horizontal,
			spacing = 10,
			wibox.container.margin(s.mytaglist, 2, 15, 0, 0),
		},
		s.mytasklist,
		{
			layout = wibox.layout.fixed.horizontal,
			wibox.container.margin(mysystray, 10, 10, 0, 0),
			wibox.container.margin(myvolume, 0, 15, 0, 0),
			myweather,
			wibox.container.margin(mytextclock, 0, 10, 0, 0),
		},
	})
end)

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
			instance = { "copyq", "pinentry" },
			class = {
				"Arandr",
				"Blueman-manager",
				"Gpick",
				"Kruler",
				"MessageWin",
				"Sxiv",
				"Tor Browser",
				"Wpa_gui",
				"veromix",
				"xtightvncviewer",
			},
			name = { "Event Tester", "Thunar", "doublecmd", "Volume Control", "Shutter", "Friends List" },
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
local manage_width_factor = function(c)
	local t = awful.tag.selected(c.screen)
	local x = 0
	for _, cl in pairs(t:clients()) do
		if not (cl.floating or cl.fullscreen or cl.maximised) then
			x = x + 1
		end
	end
	if x > 1 then
		t.master_width_factor = 0.5
	else
		t.master_width_factor = beautiful.master_width_factor
	end
end

local manage_corners = function(c)
	if c.maximized or c.fullscreen then
		c.shape = gears.shape.rectangle
	else
		c.shape = gears.shape.rounded_rect
	end
end

local manage_border = function(c)
	local t = awful.tag.selected(c.screen)
	if #t:clients() > 1 then
		c.border_color = beautiful.border_focus
	else
		c.border_color = beautiful.border_normal
	end
end

client.connect_signal("manage", function(c)
	if not awesome.startup then
		awful.client.setslave(c)
	end

	manage_corners(c)

	if awesome.startup and not c.size_hints.user_position and not c.size_hints.program_position then
		-- Prevent clients from being unreachable after screen count changes.
		awful.placement.no_offscreen(c)
	end
end)

client.connect_signal("property::size", function(c)
	manage_corners(c)
end)

client.connect_signal("focus", function(c)
	manage_width_factor(c)
	manage_border(c)
end)

client.connect_signal("unfocus", function(c)
	c.border_color = beautiful.border_normal
end)

client.connect_signal("tagged", function(c)
	manage_width_factor(c)
end)

client.connect_signal("untagged", function(c)
	manage_width_factor(c)
end)

-- }}}

-- Autostart Applications
awful.spawn.with_shell("xrandr --output DisplayPort-2 --primary --mode 3440x1440 --rate 100")
awful.spawn.with_shell("nitrogen --restore")
SOUND.startup()
