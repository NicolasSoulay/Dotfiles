local icons = require("core.icons")

vim.diagnostic.config({
	-- virtual_text = false,
	virtual_text = {
		prefix = icons.ui.Circle, -- Could be '●', '▎', 'x'
		source = true,
		severity = vim.diagnostic.severity.ERROR,
	},
	update_in_insert = false,
	severity_sort = true,
	float = {
		border = "rounded",
		source = true,
	},
	underline = {
		severity = vim.diagnostic.severity.ERROR,
	},
})

-- Diagnostics change the sign simbol in the gutter
local signs = {
	Error = icons.diagnostics.BoldError,
	Warn = icons.diagnostics.BoldWarning,
	Hint = icons.diagnostics.BoldHint,
	Info = icons.diagnostics.BoldInformation,
}
for type, icon in pairs(signs) do
	local hl = "DiagnosticSign" .. type
	vim.fn.sign_define(hl, { text = icon, texthl = "", linehl = "", numhl = "" })
end
