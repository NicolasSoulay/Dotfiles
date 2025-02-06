return {
	"lukas-reineke/indent-blankline.nvim",
	event = "VeryLazy",
	config = function()
		local indent = require("indent_blankline")

		indent.setup({
			buftype_exclude = { "terminal", "nofile" },
			filetype_exclude = {
				"help",
				"startify",
				"dashboard",
				"lazy",
				"neogitstatus",
				"NvimTree",
				"Trouble",
				"text",
			},
			show_trailing_blankline_indent = false,
			show_first_indent_level = true,
			use_treesitter = true,
			show_current_context = true,
		})
	end,
}
