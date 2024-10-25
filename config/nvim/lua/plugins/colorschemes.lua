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
			base00 = os.getenv("BASE16_00") or "#282828",
			base01 = os.getenv("BASE16_01") or "#3c3836",
			base02 = os.getenv("BASE16_02") or "#504945",
			base03 = os.getenv("BASE16_03") or "#665c54",
			base04 = os.getenv("BASE16_04") or "#bdae93",
			base05 = os.getenv("BASE16_05") or "#d5c4a1",
			base06 = os.getenv("BASE16_06") or "#fbf1c7",
			base07 = os.getenv("BASE16_07") or "#D4BE98",
			base08 = os.getenv("BASE16_08") or "#ea6962",
			base09 = os.getenv("BASE16_09") or "#d3869b",
			base0A = os.getenv("BASE16_0A") or "#fabd2f",
			base0B = os.getenv("BASE16_0B") or "#a9b665",
			base0C = os.getenv("BASE16_0C") or "#89b482",
			base0D = os.getenv("BASE16_0D") or "#7daea3",
			base0E = os.getenv("BASE16_0E") or "#fe8019",
			base0F = os.getenv("BASE16_0F") or "#e78a4e",
		})
	end,
}
