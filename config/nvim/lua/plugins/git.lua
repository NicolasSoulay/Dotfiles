local keymap = vim.keymap.set
return {
	{
		"lewis6991/gitsigns.nvim",
		event = "BufEnter",
		cmd = "Gitsigns",
		config = function()
			local gitsigns = require("gitsigns")
			gitsigns.setup({
				watch_gitdir = {
					interval = 1000,
					follow_files = true,
				},
				attach_to_untracked = true,
				current_line_blame_formatter = "<author>, <author_time:%Y-%m-%d> - <summary>",
				current_line_blame_opts = {
					delay = 200,
				},
				update_debounce = 200,
				max_file_length = 40000,
				preview_config = {
					border = "rounded",
					style = "minimal",
					relative = "cursor",
					row = 0,
					col = 1,
				},
				on_attach = function(bufnr)
					keymap("n", "<Leader>gb", gitsigns.toggle_current_line_blame, { buffer = bufnr })
				end,
			})
		end,
	},
	{
		"sindrets/diffview.nvim",
		config = function()
			local diffview = require("diffview")
			local opts = { silent = true, buffer = true }

			diffview.setup({})

			keymap("n", "<leader>dv", ":DiffviewOpen<CR>", { desc = "Open diffview window" })
			keymap("n", "<leader>gh", ":DiffviewFileHistory %<CR>", { desc = "Open diffview file history for this buffer" })
			keymap("n", "<leader>gg", ":DiffviewFileHistory<CR>", { desc = "Open diffview file history" })

			-- Autocommands to invoke DiffviewClose when using q if the file name start with "diffview:"
			vim.api.nvim_create_autocmd("BufEnter", {
				pattern = "diffview:*/*",
				callback = function()
					keymap("n", "q", "<cmd>DiffviewClose<CR>", opts)
					keymap("n", "<S-l>", "<nop>", opts)
					keymap("n", "<S-h>", "<nop>", opts)
				end,
			})
		end,
	},
}
