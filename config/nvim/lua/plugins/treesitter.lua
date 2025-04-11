return {
	"nvim-treesitter/nvim-treesitter",
	event = { "BufReadPost", "BufNewFile" },
	build = ":TSUpdate",
	config = function()
		local configs = require("nvim-treesitter.configs")

		configs.setup({
			ensure_installed = {
				"bash",
				"comment",
				"gitignore",
				"git_config",
				"git_rebase",
				"lua",
				"markdown",
				"markdown_inline",
				"rust",
				"vim",
				"vimdoc",
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
