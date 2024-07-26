return {
	"stevearc/oil.nvim",
	dependencies = { { "nvim-tree/nvim-web-devicons" } },
	config = function()
		local oil = require("oil")

		oil.setup({
			float = {
				max_height = 20,
				max_width = 60,
			},
			delete_to_trash = true,
			skip_confirm_for_simple_edits = true,
		})
		vim.keymap.set("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" })
		vim.keymap.set("n", "<leader>-", "<CMD>Oil --float<CR>", { desc = "Open parent directory" })
	end,
}
