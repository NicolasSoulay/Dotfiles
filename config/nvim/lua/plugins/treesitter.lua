return {
	"nvim-treesitter/nvim-treesitter",
	event = { "BufReadPost", "BufNewFile" },
	build = ":TSUpdate",
	dependencies = {
		{
			"windwp/nvim-ts-autotag",
			opts = {},
		},
		{
			"MeanderingProgrammer/render-markdown.nvim",
			dependencies = { "nvim-tree/nvim-web-devicons" },
			---@module 'render-markdown'
			---@type render.md.UserConfig
			opts = { latex = { enabled = false } },
		},
	},
	config = function()
		local configs = require("nvim-treesitter.configs")

		configs.setup({
			ensure_installed = {
				"bash",
				"comment",
				"gitignore",
				"git_config",
				"git_rebase",
				"json",
				"json5",
				"lua",
				"markdown",
				"markdown_inline",
				"rust",
				"vim",
				"vimdoc",
				"yaml",
				"toml",
				"regex",
			},
			ignore_install = {},
			sync_install = false,
			auto_install = true,
			modules = {},
			highlight = {
				enable = true,
				disable = { "" },
			},
			autopairs = {
				enable = true,
				disable = { "" },
			},
			indent = {
				enable = true,
				disable = { "" },
			},
		})
	end,
}
