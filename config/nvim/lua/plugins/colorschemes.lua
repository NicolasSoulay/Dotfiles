return {
	"sainnhe/gruvbox-material",
	lazy = false,
	priority = 1000,
	config = function()
		vim.g.gruvbox_material_transparent_background = 2
		vim.cmd.colorscheme("gruvbox-material")
		vim.api.nvim_set_hl(0, "LazyNormal", { fg = "#d4be98", bg = "NONE" })
		vim.api.nvim_set_hl(0, "FloatBorder", { fg = "#d4be98", bg = "NONE" })
		vim.api.nvim_set_hl(0, "FloatTitle", { fg = "#d4be98", bg = "NONE" })
		vim.api.nvim_set_hl(0, "NormalFloat", { fg = "#d4be98", bg = "NONE" })
	end,
}
