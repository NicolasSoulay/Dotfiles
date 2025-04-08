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
}
