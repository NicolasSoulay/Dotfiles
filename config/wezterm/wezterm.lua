local wezterm = require("wezterm")
local config = wezterm.config_builder()
local act = wezterm.action
local act_cb = wezterm.action_callback
local workspaces = require("workspaces")

-- General appearance, colors, fonts, etc.
config.font = wezterm.font({
	family = "JetBrains Mono",
	harfbuzz_features = { "calt=0", "clig=0", "liga=0" },
})
config.font_size = 12

config.color_scheme = "Gruvbox Material (Gogh)"
config.window_background_opacity = 1.00
config.window_padding = { left = "10px", right = "10px", top = "5px", bottom = "0px" }
config.window_decorations = "RESIZE"
config.window_close_confirmation = "NeverPrompt"
config.scrollback_lines = 3000
config.default_workspace = "home"
config.max_fps = 100

config.unix_domains = { { name = "unix" } }

-- Tab bar
config.use_fancy_tab_bar = false
config.tab_bar_at_bottom = true
config.status_update_interval = 1000
config.colors = {
	tab_bar = {
		background = "NONE",
		active_tab = {
			fg_color = "#D4be98",
			bg_color = "NONE",
		},
		inactive_tab = {
			fg_color = "#665c54",
			bg_color = "NONE",
		},
		inactive_tab_hover = {
			fg_color = "#D4be98",
			bg_color = "NONE",
			italic = true,
		},
		new_tab = {
			fg_color = "#665c54",
			bg_color = "NONE",
		},
		new_tab_hover = {
			fg_color = "#D4be98",
			bg_color = "NONE",
		},
	},
}
wezterm.on("update-status", function(window, pane)
	local status = window:active_workspace()
	local stat_color = "#ea6962"
	if window:leader_is_active() then
		status = "CMD"
		stat_color = "#e78a4e"
	end

	local basename = function(s)
		return string.gsub(s, "^/home/([^/]+)", "~")
	end

	-- Current working directory
	local cwd = pane:get_current_working_dir()
	if cwd == nil then
		cwd = " "
	else
		cwd = basename(cwd.file_path)
	end

	-- Left status (left of the tab line)
	window:set_left_status(wezterm.format({
		{ Text = " " },
		{ Foreground = { Color = stat_color } },
		{ Text = wezterm.nerdfonts.oct_table .. "  " .. status },
		{ Text = " | " },
		{ Foreground = { Color = "#e0af68" } },
		{ Text = wezterm.nerdfonts.oct_file_directory .. "  " .. cwd },
		{ Text = " | " },
		"ResetAttributes",
	}))
end)

-- Keybindings
config.leader = { key = "a", mods = "CTRL", timeout_milliseconds = 1000 }
config.keys = {
	{ key = "j", mods = "ALT", action = act.SendKey({ key = "DownArrow" }) },
	{ key = "k", mods = "ALT", action = act.SendKey({ key = "UpArrow" }) },
	{ key = "h", mods = "ALT", action = act.SendKey({ key = "LeftArrow" }) },
	{ key = "l", mods = "ALT", action = act.SendKey({ key = "RightArrow" }) },

	-- Panes
	{ key = "a", mods = "LEADER|CTRL", action = act.SendKey({ key = "a", mods = "CTRL" }) },
    { key = "v", mods = "LEADER", action = act.SplitHorizontal({ domain = "CurrentPaneDomain" }) },
    { key = "-", mods = "LEADER", action = act.SplitVertical({ domain = "CurrentPaneDomain" }) },
	{ key = "q", mods = "LEADER", action = act.CloseCurrentPane({ confirm = false }) },

	-- Tabs
	{ key = "t", mods = "LEADER", action = act.SpawnTab("CurrentPaneDomain") },
	{ key = "h", mods = "LEADER", action = act.ActivateTabRelative(-1) },
	{ key = "l", mods = "LEADER", action = act.ActivateTabRelative(1) },
	{ key = "m", mods = "LEADER", action = act.ActivateKeyTable({ name = "move_tab", one_shot = false }) },

	-- Workspaces
	{ key = "f", mods = "LEADER", action = act_cb(workspaces.sessionizer) },
	{ key = " ", mods = "LEADER", action = act_cb(workspaces.switcher) },
}

for i = 1, 9 do
	table.insert(config.keys, { key = tostring(i), mods = "LEADER", action = act.ActivateTab(i - 1) })
end

return config
