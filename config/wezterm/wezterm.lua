local wezterm = require("wezterm")
local config = wezterm.config_builder()

local act = wezterm.action
local act_cb = wezterm.action_callback
local loginfo = wezterm.log_info
local logerr = wezterm.log_error
local last_ws = "home"

-- General appearance, colors, fonts, etc.
config.font = wezterm.font({
	family = "JetBrains Mono",
	harfbuzz_features = { "calt=0", "clig=0", "liga=0" },
})
config.font_size = 12

config.color_scheme = "Gruvbox Material (Gogh)"
config.window_background_opacity = 1.00
-- config.window_background_opacity = 0.95
config.window_padding = {
	left = "10px",
	right = "10px",
	top = "5px",
	bottom = "0px",
}
config.window_decorations = "RESIZE"
config.window_close_confirmation = "NeverPrompt"
config.scrollback_lines = 3000
config.default_workspace = "home"
config.max_fps = 100
config.inactive_pane_hsb = {
	saturation = 0.8,
	brightness = 0.8,
}

config.unix_domains = {
	{
		name = "unix",
	},
}
-- config.default_gui_startup_args = { "connect", "unix" }

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
	-- Panes
	{
		key = "a",
		mods = "LEADER|CTRL",
		action = act.SendKey({ key = "a", mods = "CTRL" }),
	},
	{ key = "v", mods = "LEADER", action = act.SplitHorizontal({ domain = "CurrentPaneDomain" }) },
	{ key = "-", mods = "LEADER", action = act.SplitVertical({ domain = "CurrentPaneDomain" }) },
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
	{
		key = "s",
		mods = "LEADER",
		action = wezterm.action.ShowLauncherArgs({ flags = "FUZZY|WORKSPACES" }),
	},
	{
		key = "f",
		mods = "LEADER",
		action = act_cb(function(window, pane)
			local workspaces = {}
			local home = os.getenv("HOME")
			local dotfiles = home .. "/Dotfiles/config"
			local dev = home .. "/Dev"

			-- Default workspaces
			table.insert(workspaces, { label = "home", id = home })
			table.insert(workspaces, { label = "awesome", id = dotfiles .. "/awesome" })
			table.insert(workspaces, { label = "ncspot", id = home })
			table.insert(workspaces, { label = "nvim", id = dotfiles .. "/nvim" })
			table.insert(workspaces, { label = "scripts", id = home .. "/Dotfiles/bin" })
			table.insert(workspaces, { label = "starship", id = dotfiles .. "/starship" })
			table.insert(workspaces, { label = "wezterm", id = dotfiles .. "/wezterm" })

			-- Git workspaces
			local success, stdout, stderr = wezterm.run_child_process({
				"fdfind",
				"-HI",
				"^.git$",
				"--max-depth=4",
				"--prune",
				dev,
			})

			if not success then
				logerr("Failed to run fdfind: " .. stderr)
				return
			end

			for line in stdout:gmatch("([^\n]*)\n?") do
				local workspace = line:gsub("/.git.*$", "")
				local id = workspace
				local label = workspace:gsub(".*/", "")
				table.insert(workspaces, { label = tostring(label), id = tostring(id) })
			end

			window:perform_action(
				act.InputSelector({
					action = act_cb(function(inner_window, inner_pane, id, label)
						local args = {}
						last_ws = window:active_workspace()
						if not id and not label then
							loginfo("Cancelled")
						else
							if label == "ncspot" then
								args = { "ncspot" }
							end
							if label == "glow" then
								args = { "glow" }
							end
							if label == "mc" then
								args = { "mc" }
							end
							if label == "neovim" then
								args = { "nvim", "init.lua" }
							end
							if label == "awesome" then
								args = { "nvim", "rc.lua" }
							end
							if label == "wezterm" then
								args = { "nvim", "wezterm.lua" }
							end
							loginfo("Selected " .. label)
							inner_window:perform_action(
								act.SwitchToWorkspace({
									name = label,
									spawn = {
										label = "Workspace: " .. label,
										cwd = id,
										args = args,
									},
								}),
								inner_pane
							)
							inner_window:perform_action(act.SplitHorizontal())
						end
					end),
					fuzzy = true,
					title = "Select project",
					fuzzy_description = "Select session: ",
					choices = workspaces,
				}),
				pane
			)
		end),
	},
	{
		key = "w",
		mods = "LEADER",
		action = act.PromptInputLine({
			description = wezterm.format({
				{ Attribute = { Intensity = "Bold" } },
				{ Foreground = { AnsiColor = "Fuchsia" } },
				{ Text = "Enter name for new workspace" },
			}),
			action = act_cb(function(window, pane, line)
				if line then
					window:perform_action(
						act.SwitchToWorkspace({
							name = line,
						}),
						pane
					)
				end
			end),
		}),
	},
	{
		key = " ",
		mods = "LEADER",
		action = act_cb(function(window, pane)
			if window:active_workspace() == "home" then
				window:perform_action(act.SwitchToWorkspace({ name = last_ws }), pane)
			else
				last_ws = window:active_workspace()
				window:perform_action(act.SwitchToWorkspace({ name = "home" }), pane)
			end
		end),
	},
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
