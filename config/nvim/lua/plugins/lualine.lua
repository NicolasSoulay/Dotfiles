return {
	"nvim-lualine/lualine.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	config = function()
		local lualine = require("lualine")
		local colors = {
			fg1 = "#282828",
			color2 = "#32302f",
			fg2 = "#d4be98",
			color3 = "#32302f",
			color4 = "#7daea3",
			color5 = "#89b482",
			color6 = "#a9b665",
			color7 = "#d8a657",
			color8 = "#a89984",
			color9 = "#ea6962",
		}
		lualine.setup({
			options = {
				icons_enabled = true,
				theme = {
					normal = {
						a = { fg = colors.fg1, bg = colors.color4, gui = "bold" },
						b = { fg = colors.fg2, bg = colors.color2 },
						c = { fg = colors.fg2, bg = colors.fg1 },
					},
					command = { a = { fg = colors.fg1, bg = colors.color5, gui = "bold" } },
					inactive = { a = { fg = colors.fg2, bg = colors.color2 } },
					insert = { a = { fg = colors.fg1, bg = colors.color6, gui = "bold" } },
					replace = { a = { fg = colors.fg1, bg = colors.color7, gui = "bold" } },
					terminal = { a = { fg = colors.fg1, bg = colors.color8, gui = "bold" } },
					visual = { a = { fg = colors.fg1, bg = colors.color9, gui = "bold" } },
				},
				component_separators = { left = "", right = "" },
				section_separators = { left = "", right = "" },
				disabled_filetypes = {
					statusline = {},
					winbar = {},
				},
				ignore_focus = {},
				always_divide_middle = true,
				globalstatus = true,
				refresh = {
					statusline = 1000,
					tabline = 1000,
					winbar = 1000,
				},
			},
			sections = {
				lualine_a = { "mode" },
				lualine_b = { "branch", "diff", "diagnostics" },
				lualine_c = {
					"filename",
				},
				lualine_x = {
					"filetype",
					{
						function()
							local msg = "No Active Lsp"
							local buf_ft = vim.api.nvim_buf_get_option(0, "filetype")
							local clients = vim.lsp.get_active_clients()
							if next(clients) == nil then
								return msg
							end
							for _, client in ipairs(clients) do
								local filetypes = client.config.filetypes
								if filetypes and vim.fn.index(filetypes, buf_ft) ~= -1 then
									return client.name
								end
							end
							return msg
						end,
						icon = "",
					},
				},
				lualine_y = { "location" },
				lualine_z = {},
			},
			inactive_sections = {
				lualine_a = {},
				lualine_b = {},
				lualine_c = { "filename" },
				lualine_x = { "location" },
				lualine_y = {},
				lualine_z = {},
			},
			tabline = {},
			winbar = {
				lualine_a = {},
				lualine_b = {},
				lualine_c = { "%f" },
				lualine_x = {},
				lualine_y = {},
				lualine_z = {},
			},
			inactive_winbar = {
				lualine_a = {},
				lualine_b = {},
				lualine_c = { "%f" },
				lualine_x = {},
				lualine_y = {},
				lualine_z = {},
			},
			extensions = {},
		})
	end,
}
