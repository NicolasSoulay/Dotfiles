return {
	"https://github.com/RRethy/base16-nvim",
	config = function()
		local base16 = require("base16-colorscheme")

		base16.with_config({
			telescope = true,
			telescope_borders = true,
			indentblankline = true,
			notify = true,
			ts_rainbow = true,
			cmp = true,
			illuminate = true,
			lsp_semantic = true,
			mini_completion = true,
			dapui = true,
		})

		base16.setup({
			-- base00 = "#282828",
			base00 = "NONE",
			base01 = "#3c3836",
			base02 = "#504945",
			base03 = "#665c54",
			base04 = "#bdae93",
			base05 = "#d5c4a1",
			base06 = "#fbf1c7",
			base07 = "#D4be98",
			base08 = "#ea6962",
			base09 = "#d3869b",
			base0A = "#fabd2f",
			base0B = "#a9b665",
			base0C = "#89b482",
			base0D = "#7daea3",
			base0E = "#fe8019",
			base0F = "#e78a4e",
		})
	end,
}
