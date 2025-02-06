return {
	"lukas-reineke/indent-blankline.nvim",
	main = "ibl",
	config = function()
		require("ibl").setup({
			exclude = {
				buftypes = { "terminal", "nofile" },
				filetypes = {
					"help",
					"startify",
					"dashboard",
					"lazy",
					"neogitstatus",
					"NvimTree",
					"Trouble",
					"text",
				},
			},
			indent = { char = "│" },
		})
	end,
}
