return {
	"sindrets/diffview.nvim",
	config = function()
		local diffview = require("diffview")
		diffview.setup({
        })

		vim.keymap.set(
            "n",
            "<leader>dv",
            ":DiffviewOpen<CR>",
            { desc = "Open diffview window" }
        )
		vim.keymap.set(
			"n",
			"<leader>gh",
			":DiffviewFileHistory %<CR>",
			{ desc = "Open diffview file history window for this buffer" }
		)
		vim.keymap.set(
			"n",
			"<leader>gg",
			":DiffviewFileHistory<CR>",
			{ desc = "Open diffview file history window for this buffer" }
		)
	end,
}
