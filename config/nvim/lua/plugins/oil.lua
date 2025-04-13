return {
	"stevearc/oil.nvim",
	dependencies = {
		{ "nvim-tree/nvim-web-devicons" },
		{
			"FerretDetective/oil-git-signs.nvim",
			ft = "oil",
			---@module "oil_git_signs"
			---@type oil_git_signs.Config
			opts = {},
		},
	},
	config = function()
		local oil = require("oil")
		local keymap = vim.keymap.set

		oil.setup({
			float = {
				max_height = 30,
				max_width = 60,
			},
			delete_to_trash = true,
			skip_confirm_for_simple_edits = true,
			view_options = {
				show_hidden = true,
			},
			win_options = {
				signcolumn = "yes:2",
				statuscolumn = "",
			},
		})

		keymap("n", "-", "<CMD>Oil<CR>", { desc = "Open Oil.nvim in parent directory" })
		keymap("n", "<leader>e", "<CMD>Oil --float<CR>", { desc = "Open parent directory" })

		vim.api.nvim_create_autocmd({ "FileType" }, {
			pattern = "oil",
			callback = function()
				keymap("n", "<leader>e", ":close<CR>", { buffer = true, silent = true })
			end,
		})

		vim.api.nvim_create_autocmd("User", {
			pattern = "OilActionsPost",
			callback = function(event)
				if event.data.actions.type == "move" then
					Snacks.rename.on_rename_file(event.data.actions.src_url, event.data.actions.dest_url)
				end
			end,
		})
	end,
}
