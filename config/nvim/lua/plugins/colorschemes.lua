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
			base01 = os.getenv("BASE16_01") or "#32302f",
			base02 = os.getenv("BASE16_02") or "#45403d",
			base03 = os.getenv("BASE16_03") or "#5a524c",
			base04 = os.getenv("BASE16_04") or "#7c6f64",
			base05 = os.getenv("BASE16_05") or "#928374",
			base06 = os.getenv("BASE16_06") or "#a89984",
			base07 = os.getenv("BASE16_07") or "#D4be98",
			base08 = os.getenv("BASE16_08") or "#ea6962",
			base09 = os.getenv("BASE16_09") or "#fe8019",
			base0A = os.getenv("BASE16_0A") or "#d3869b",
			base0B = os.getenv("BASE16_0B") or "#a9b665",
			base0C = os.getenv("BASE16_0C") or "#89b482",
			base0D = os.getenv("BASE16_0D") or "#7daea3",
			base0E = os.getenv("BASE16_0E") or "#fabd2f",
			base0F = os.getenv("BASE16_0F") or "#e78a4e",
		})
	end,
}
