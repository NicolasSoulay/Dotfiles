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

-- {{{ Variable definitions
beautiful.init("~/.config/awesome/themes/default/theme.lua")

terminal = "wezterm"
editor = os.getenv("EDITOR") or "editor"
editor_cmd = terminal .. " -e " .. editor
file_manager_gui = "thunar"
web_browser = "firefox"

modkey = "Mod4"

awful.layout.layouts = {
	awful.layout.suit.tile.left,
}

-- Calendar widget
local calendar_widget = require("widgets.calendar")
local cw = calendar_widget({})

-- {{{ Wibar
-- Create a textclock widget
local mytextclock = wibox.widget.textclock("  %H:%M  ")
mytextclock:connect_signal("button::press", function(_, _, _, button)
	if button == 1 then
		cw.toggle()
	end
end)

local mysystray = wibox.widget.systray()

-- Volume control widget
local volume_widget = require("widgets.volume")
local myvolume = volume_widget({
	widget_type = "arc",
})

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
			wibox.container.margin(s.mytaglist, 8, 0, 0, 0),
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

	-- {
	-- 	rule_any = { type = { "normal", "dialog" } },
	-- 	properties = { titlebars_enabled = false },
	-- },

	{
		rule = { name = "Mozilla Firefox" },
		properties = { tag = "󰈹" },
	},

	{
		rule_any = { name = { "EVE Online Launcher" } },
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

	-- if c.floating then
	c.shape = gears.shape.rounded_rect
	-- end

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
end)
client.connect_signal("unfocus", function(c)
	c.border_color = beautiful.border_normal
end)
-- }}}

-- Autostart Applications
awful.spawn.with_shell("nitrogen --restore")
awful.spawn.with_shell("picom")
awful.spawn.with_shell("xrandr --output DisplayPort-2 --primary --mode 3440x1440 --rate 100")
