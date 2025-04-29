return {
	{
		"windwp/nvim-autopairs",
		event = "InsertEnter",
		config = true,
	},
	{
		"FerretDetective/oil-git-signs.nvim",
		ft = "oil",
		---@module "oil_git_signs"
		---@type oil_git_signs.Config
		opts = {},
	},
	{
		"rachartier/tiny-inline-diagnostic.nvim",
		event = "VeryLazy",
		priority = 1000,
		config = function()
			require("tiny-inline-diagnostic").setup({
				preset = "powerline",
				options = {
					multilines = { enabled = true, always_show = true },
                    format = function(diagnostic)
                        if diagnostic.source == nil then
                            return diagnostic.message
                        else
                            return string.format("[%s] %s", diagnostic.source, diagnostic.message)
                        end
                    end,
				},
			})
			vim.diagnostic.config({ virtual_text = false }) -- Only if needed in your configuration, if you already have native LSP diagnostics
		end,
	},
	{
		"catgoose/nvim-colorizer.lua",
		event = "BufReadPre",
		opts = {},
	},
}
