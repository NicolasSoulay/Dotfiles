return {
	settings = {
		Lua = {
			format = {
				enable = false,
			},
			diagnostics = {
				globals = {
					"vim",
					"spec",
					"awesome",
					"client",
					"awful",
					"screen",
					"tag",
					"root",
				},
			},
			runtime = {
				version = "LuaJIT",
				special = {
					spec = "require",
				},
			},
			workspace = {
				checkThirdParty = false,
				library = vim.tbl_deep_extend("force", vim.api.nvim_get_runtime_file("", true), {
					"/usr/share/awesome/lib",
					"/usr/share/lua",
					"${3rd}/luv/library",
					"${3rd}/busted/library",
				}),
			},
			hint = {
				enable = false,
				arrayIndex = "Disable", -- "Enable" | "Auto" | "Disable"
				await = true,
				paramName = "Disable", -- "All" | "Literal" | "Disable"
				paramType = true,
				semicolon = "All", -- "All" | "SameLine" | "Disable"
				setType = false,
			},
			telemetry = {
				enable = false,
			},
		},
	},
}
