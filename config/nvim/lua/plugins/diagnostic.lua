return {
	"rachartier/tiny-inline-diagnostic.nvim",
	event = "VeryLazy",
	priority = 1000,
	config = function()
		local tiny_diagnostics = require("tiny-inline-diagnostic")

		tiny_diagnostics.setup({
			preset = "powerline",
			options = {
                use_icons_from_diagnostic = true,
				multilines = {
					enabled = true,
					always_show = true,
				},
			},
		})
		vim.diagnostic.config({ virtual_text = false }) -- Only if needed in your configuration, if you already have native LSP diagnostics
	end,
}
