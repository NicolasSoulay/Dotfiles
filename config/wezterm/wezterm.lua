local wezterm = require("wezterm")
local config = wezterm.config_builder()

local act = wezterm.action
local act_cb = wezterm.action_callback
local loginfo = wezterm.log_info
local logerr = wezterm.log_error

-- General appearance, colors, fonts, etc.
config.font = wezterm.font({
	family = "JetBrains Mono",
	harfbuzz_features = { "calt=0", "clig=0", "liga=0" },
})

config.color_scheme = "Gruvbox Material (Gogh)"
-- config.window_background_opacity = 1.00
config.window_background_opacity = 0.95
config.window_padding = {
	left = "5px",
	right = "5px",
	top = "2px",
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
	if window:active_key_table() then
		status = window:active_key_table()
		stat_color = "#7daea3"
	end
	if window:leader_is_active() then
		status = "CMD"
		stat_color = "#e78a4e"
	end

	local basename = function(s)
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

-- Session manager
local sessionizer = {}
sessionizer.toggle = function(window, pane)
	local projects = {}
	local success, stdout, stderr = wezterm.run_child_process({
		"fdfind",
		"-HI",
		"^.git$",
		"--max-depth=4",
		"--prune",
		os.getenv("HOME") .. "/Dev",
	})

	if not success then
		logerr("Failed to run fd: " .. stderr)
		return
	end

	for line in stdout:gmatch("([^\n]*)\n?") do
		local project = line:gsub("/.git.*$", "")
		local id = project
		local label = project:gsub(".*/", "")
		table.insert(projects, { label = tostring(label), id = tostring(id) })
	end
	table.insert(projects, { label = "Main", id = os.getenv("HOME") })
	table.insert(projects, { label = "Wezterm", id = os.getenv("HOME") .. "/Dotfiles/config/wezterm" })
	table.insert(projects, { label = "AwesomeWM", id = os.getenv("HOME") .. "/Dotfiles/config/awesome" })
	table.insert(projects, { label = "Neovim", id = os.getenv("HOME") .. "/Dotfiles/config/nvim" })
	table.insert(projects, { label = "Starship", id = os.getenv("HOME") .. "/Dotfiles/config/starship" })
	table.insert(projects, { label = "Scripts", id = os.getenv("HOME") .. "/Dotfiles/bin" })

	window:perform_action(
		act.InputSelector({
			action = act_cb(function(win, _, id, label)
				if not id and not label then
					loginfo("Cancelled")
				else
					loginfo("Selected " .. label)
					win:perform_action(act.SwitchToWorkspace({ name = label, spawn = { cwd = id } }), pane)
				end
			end),
			fuzzy = true,
			title = "Select project",
			choices = projects,
		}),
		pane
	)
end

-- Keybindings
config.leader = { key = "a", mods = "CTRL", timeout_milliseconds = 1000 }
config.keys = {
	-- Panes
	{
		key = "a",
		mods = "LEADER|CTRL",
		action = act.SendKey({ key = "a", mods = "CTRL" }),
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

	-- workspaces
	{ key = "f", mods = "LEADER", action = act_cb(sessionizer.toggle) },
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
