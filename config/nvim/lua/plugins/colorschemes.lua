return {
	"sainnhe/gruvbox-material",
	lazy = false,
	priority = 1000,
	config = function()
		vim.g.gruvbox_material_transparent_background = 2
		vim.cmd.colorscheme("gruvbox-material")
		vim.api.nvim_set_hl(0, "NvimTreeNormalFloat", { fg = "#d4be98", bg = "NONE" })
		vim.api.nvim_set_hl(0, "NvimTreeNormal", { fg = "#d4be98", bg = "NONE" })
		vim.api.nvim_set_hl(0, "NvimTreeEndOfBuffer", { fg = "#d4be98", bg = "NONE" })
		vim.api.nvim_set_hl(0, "FloatBorder", { fg = "#d4be98", bg = "NONE" })
	end,
}
