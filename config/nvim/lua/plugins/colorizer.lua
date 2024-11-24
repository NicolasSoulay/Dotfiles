return {
	"NvChad/nvim-colorizer.lua",
	event = { "BufReadPost", "BufNewFile" },
	config = function()
		require("colorizer").setup({
			filetypes = {
				"typescript",
				"typescriptreact",
				"javascript",
				"javascriptreact",
				"css",
				"scss",
				"html",
				"astro",
				"lua",
			},
			user_default_options = {
				names = false,
				rgb_fn = true,
				hsl_fn = true,
				tailwind = "both",
			},
			buftypes = {},
		})
	end,
}
