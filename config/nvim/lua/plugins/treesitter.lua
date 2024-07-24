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
        }
	},
	config = function()
		local treesitter = require("nvim-treesitter")
		local configs = require("nvim-treesitter.configs")
		local commentstring = require("ts_context_commentstring")

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
			sync_install = false,
			auto_install = true,

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
		commentstring.setup({
			enable_autocmd = false,
			languages = {
				typescript = "// %s",
			},
		})
	end,
}
