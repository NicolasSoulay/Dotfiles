return {
	"ThePrimeagen/harpoon",
	branch = "harpoon2",
	dependencies = { "nvim-lua/plenary.nvim" },
	config = function()
		local harpoon = require("harpoon")
		local keymap = vim.keymap.set
		harpoon.setup({})

		keymap("n", "<leader>a", function()
			harpoon:list():add()
		end, { desc = "Add the current file and position to harpoon list" })
		keymap("n", "<leader>fh", function()
			harpoon.ui:toggle_quick_menu(harpoon:list())
		end, { desc = "Open harpoon window" })
		keymap("n", "<leader>1", function()
			harpoon:list(harpoon:list():select(1))
		end, { desc = "Switch to the first element in harpoon list" })
		keymap("n", "<leader>2", function()
			harpoon:list(harpoon:list():select(2))
		end, { desc = "Switch to the second element in harpoon list" })
		keymap("n", "<leader>3", function()
			harpoon:list(harpoon:list():select(3))
		end, { desc = "Switch to the third element in harpoon list" })
		keymap("n", "<leader>4", function()
			harpoon:list(harpoon:list():select(4))
		end, { desc = "Switch to the fourth element in harpoon list" })
	end,
}
