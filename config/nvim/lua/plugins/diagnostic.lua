return {
	"rachartier/tiny-inline-diagnostic.nvim",
	event = "VeryLazy", -- Or `LspAttach`
	priority = 1000, -- needs to be loaded in first
	config = function()
		local tiny_diagnostics = require("tiny-inline-diagnostic")
		local icons = require("core.icons")

		tiny_diagnostics.setup({
			preset = "powerline",
			options = {
				use_icons_from_diagnostic = true,
				multilines = {
					enabled = true,
					always_show = true,
				},
			},
			signs = {
				Error = icons.diagnostics.BoldError,
				Warn = icons.diagnostics.BoldWarning,
				Hint = icons.diagnostics.BoldHint,
				Info = icons.diagnostics.BoldInformation,
			},
		})
		vim.diagnostic.config({ virtual_text = false }) -- Only if needed in your configuration, if you already have native LSP diagnostics
	end,
}
