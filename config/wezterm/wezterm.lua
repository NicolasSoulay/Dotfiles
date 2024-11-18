local wezterm = require("wezterm")
local config = wezterm.config_builder()

local act = wezterm.action

-- General appearance, colors, fonts, etc.
config.color_scheme = "Gruvbox Material (Gogh)"
config.window_background_opacity = 0.95
config.window_decorations = "RESIZE"
config.window_padding = {
	left = "2px",
	right = "2px",
	top = "0px",
	bottom = "0px",
}
config.window_close_confirmation = "NeverPrompt"
config.scrollback_lines = 3000
config.default_workspace = "Main"
config.max_fps = 100
config.inactive_pane_hsb = {
	saturation = 0.6,
	brightness = 0.6,
}

-- Tab bar
config.use_fancy_tab_bar = false
config.tab_bar_at_bottom = true
config.status_update_interval = 1000
config.colors = {
	tab_bar = {
		background = "#282828",
		active_tab = {
			fg_color = "#D4be98",
			bg_color = "#282828",
		},
		inactive_tab = {
			fg_color = "#665c54",
			bg_color = "#282828",
		},
		inactive_tab_hover = {
			fg_color = "#D4be98",
			bg_color = "#282828",
			italic = true,
		},
		new_tab = {
			fg_color = "#665c54",
			bg_color = "#282828",
		},
		new_tab_hover = {
			fg_color = "#D4be98",
			bg_color = "#282828",
		},
	},
}
wezterm.on("update-status", function(window, pane)
	local status = window:active_workspace()
	local stat_color = "#ea6962"
	if window:active_key_table() then
		status = window:active_key_table()
		stat_color = "#7daea3"
	end
	if window:leader_is_active() then
		status = "CMD"
		stat_color = "#e78a4e"
	end

	-- local basename = function(s)
	-- 	return s:gsub("^/home/([^/]+)", "~")
	-- end

	local basename = function(s)
		-- Nothing a little regex can't fix
		return string.gsub(s, "^/home/([^/]+)", "~")
	end

	-- Current working directory
	local cwd = pane:get_current_working_dir()
	cwd = basename(cwd.file_path)

	-- Left status (left of the tab line)
	window:set_left_status(wezterm.format({
		{ Foreground = { Color = stat_color } },
		{ Text = " " },
		{ Text = wezterm.nerdfonts.oct_table .. "  " .. status },
		{ Text = " | " },
		{ Foreground = { Color = "#e0af68" } },
		{ Text = wezterm.nerdfonts.md_folder .. "  " .. cwd },
		"ResetAttributes",
	}))
end)

-- Keybindings
config.leader = { key = "a", mods = "CTRL", timeout_milliseconds = 1000 }
config.keys = {
	-- Panes
	{
		key = "a",
		mods = "LEADER|CTRL",
		action = wezterm.action.SendKey({ key = "a", mods = "CTRL" }),
	},
	{ key = "v", mods = "LEADER", action = act.SplitHorizontal({ domain = "CurrentPaneDomain" }) },
	{ key = "h", mods = "LEADER", action = act.SplitVertical({ domain = "CurrentPaneDomain" }) },
	{ key = "q", mods = "LEADER", action = act.CloseCurrentPane({ confirm = true }) },
	{ key = "h", mods = "LEADER", action = act.ActivatePaneDirection("Left") },
	{ key = "j", mods = "LEADER", action = act.ActivatePaneDirection("Down") },
	{ key = "k", mods = "LEADER", action = act.ActivatePaneDirection("Up") },
	{ key = "l", mods = "LEADER", action = act.ActivatePaneDirection("Right") },
	{
		key = "r",
		mods = "LEADER",
		action = act.ActivateKeyTable({ name = "resize_pane", one_shot = false }),
	},

	-- Tabs
	{ key = "t", mods = "LEADER", action = act.SpawnTab("CurrentPaneDomain") },
	{ key = "H", mods = "LEADER", action = act.ActivateTabRelative(-1) },
	{ key = "L", mods = "LEADER", action = act.ActivateTabRelative(1) },
	{ key = "e", mods = "LEADER", action = act.ShowTabNavigator },
	{ key = "m", mods = "LEADER", action = act.ActivateKeyTable({ name = "move_tab", one_shot = false }) },
}

for i = 1, 9 do
	table.insert(config.keys, {
		key = tostring(i),
		mods = "LEADER",
		action = act.ActivateTab(i - 1),
	})
end

config.key_tables = {
	resize_pane = {
		{ key = "h", action = act.AdjustPaneSize({ "Left", 1 }) },
		{ key = "j", action = act.AdjustPaneSize({ "Down", 1 }) },
		{ key = "k", action = act.AdjustPaneSize({ "Up", 1 }) },
		{ key = "l", action = act.AdjustPaneSize({ "Right", 1 }) },
		{ key = "Escape", action = "PopKeyTable" },
		{ key = "Enter", action = "PopKeyTable" },
	},
	move_tab = {
		{ key = "h", action = act.MoveTabRelative(-1) },
		{ key = "j", action = act.MoveTabRelative(-1) },
		{ key = "k", action = act.MoveTabRelative(1) },
		{ key = "l", action = act.MoveTabRelative(1) },
		{ key = "Escape", action = "PopKeyTable" },
		{ key = "Enter", action = "PopKeyTable" },
	},
}

return config
