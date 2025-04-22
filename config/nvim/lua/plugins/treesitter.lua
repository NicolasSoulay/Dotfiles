return {
	"nvim-treesitter/nvim-treesitter",
	event = { "BufReadPost", "BufNewFile" },
	build = ":TSUpdate",
	config = function()
		require("nvim-treesitter.configs").setup({
			ensure_installed = {
                "bash",
                "c",
                "cmake",
                "comment",
                "cpp",
				"lua",
                "make",
                "regex",
				"rust",
                "toml",
				"vim",
				"vimdoc",
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
