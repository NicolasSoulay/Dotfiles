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

        -- Autocommands to invoke DiffviewClose when using q if the file name start with "diffview:"
        vim.api.nvim_create_autocmd("BufEnter", {
            pattern = "diffview:*/*",
            callback = function()
                vim.cmd([[
                    nnoremap <silent> <buffer> q :DiffviewClose<CR>
                    set nobuflisted
                ]])
                -- Disable buffer navigation while in diffview
                vim.keymap.set("n", "<S-l>", "", { silent = true })
                vim.keymap.set("n", "<S-h>", "", { silent = true })
            end,
        })
	end,
}
