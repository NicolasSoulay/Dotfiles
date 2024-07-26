return {
	"ThePrimeagen/harpoon",
	branch = "harpoon2",
	dependencies = {
		{ "nvim-lua/plenary.nvim" },
		{ "nvim-telescope/telescope.nvim" },
	},
	config = function()
		local harpoon = require("harpoon")

		harpoon.setup({})

		vim.keymap.set("n", "<leader>a", function()
			harpoon:list():add()
		end, { desc = "Add the current file and position to harpoon list" })
		vim.keymap.set("n", "<leader>fh", function()
			harpoon.ui:toggle_quick_menu(harpoon:list())
		end, { desc = "Open harpoon window" })

		vim.keymap.set("n", "<a-h>", function()
			harpoon:list(harpoon:list():select(1))
		end, { desc = "Switch to the first element in harpoon list" })
		vim.keymap.set("n", "<a-j>", function()
			harpoon:list(harpoon:list():select(2))
		end, { desc = "Switch to the second element in harpoon list" })
		vim.keymap.set("n", "<a-k>", function()
			harpoon:list(harpoon:list():select(3))
		end, { desc = "Switch to the third element in harpoon list" })
		vim.keymap.set("n", "<a-l>", function()
			harpoon:list(harpoon:list():select(4))
		end, { desc = "Switch to the fourth element in harpoon list" })
	end,
}
