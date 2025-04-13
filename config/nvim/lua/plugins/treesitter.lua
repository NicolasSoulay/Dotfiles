return {
	"nvim-treesitter/nvim-treesitter",
	event = { "BufReadPost", "BufNewFile" },
	build = ":TSUpdate",
	config = function()
		require("nvim-treesitter.configs").setup({
			ensure_installed = {
				"lua",
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
