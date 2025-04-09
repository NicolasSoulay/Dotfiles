local last_ws = "home"
local wezterm = require("wezterm")
local loginfo = wezterm.log_info
local logerr = wezterm.log_error
local act = wezterm.action
local act_cb = wezterm.action_callback
local home = os.getenv("HOME")
local dotfiles = home .. "/Dotfiles/config"
local dev = home .. "/Dev"

return {
	sessionizer = function(window, pane)
        local workspaces = {}
		-- Default workspaces
		table.insert(workspaces, { label = "home", id = home })
		table.insert(workspaces, { label = "awesome", id = dotfiles .. "/awesome" })
		table.insert(workspaces, { label = "install", id = dotfiles .. "/../install" })
		table.insert(workspaces, { label = "nvim", id = dotfiles .. "/nvim" })
		table.insert(workspaces, { label = "scripts", id = home .. "/Dotfiles/bin" })
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
						if label == "nvim" then
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
	end,
	switcher = function(window, pane)
		if window:active_workspace() == "home" then
			window:perform_action(act.SwitchToWorkspace({ name = last_ws }), pane)
		else
			last_ws = window:active_workspace()
			window:perform_action(act.SwitchToWorkspace({ name = "home" }), pane)
		end
	end,
}
