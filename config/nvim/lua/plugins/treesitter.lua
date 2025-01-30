return {
	"nvim-treesitter/nvim-treesitter",
	event = { "BufReadPost", "BufNewFile" },
	build = ":TSUpdate",
	dependencies = {
        {
            "windwp/nvim-ts-autotag",
            config = function()
                require("nvim-ts-autotag").setup()
            end,
        },
        {
            'MeanderingProgrammer/render-markdown.nvim',
            dependencies = { 'nvim-tree/nvim-web-devicons' },
            ---@module 'render-markdown'
            ---@type render.md.UserConfig
            opts = {},
        }
	},
	config = function()
		local configs = require("nvim-treesitter.configs")

		configs.setup({
			ensure_installed = {
				"javascript",
				"html",
				"bash",
				"css",
				"comment",
				"gitignore",
				"git_config",
				"git_rebase",
				"json",
				"json5",
				"lua",
				"markdown",
				"markdown_inline",
				"php",
				"phpdoc",
				"rust",
				"scss",
				"sql",
				"tsx",
				"typescript",
				"twig",
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
