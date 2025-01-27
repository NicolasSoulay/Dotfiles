return {
	"nvim-telescope/telescope.nvim",
	dependencies = {
		{ "nvim-lua/plenary.nvim" },
		{ "nvim-telescope/telescope-fzf-native.nvim", build = "make", lazy = true },
	},
	config = function()
		local icons = require("core.icons")
		local actions = require("telescope.actions")
		local telescope = require("telescope")

		telescope.setup({
			defaults = {
				prompt_prefix = icons.ui.Telescope .. " ",
				selection_caret = icons.ui.Forward .. " ",
				entry_prefix = "   ",
				initial_mode = "insert",
				selection_strategy = "reset",
				path_display = { "smart" },
				color_devicons = true,
				vimgrep_arguments = {
					"rg",
					"--color=never",
					"--no-heading",
					"--with-filename",
					"--line-number",
					"--column",
					"--smart-case",
					"--hidden",
					"--glob=!.git/",
				},

				mappings = {
					i = {
						["<C-n>"] = actions.cycle_history_next,
						["<C-p>"] = actions.cycle_history_prev,

						["<C-j>"] = actions.move_selection_next,
						["<C-k>"] = actions.move_selection_previous,
					},
					n = {
						["<esc>"] = actions.close,
						["j"] = actions.move_selection_next,
						["k"] = actions.move_selection_previous,
						["q"] = actions.close,
					},
				},
			},
			pickers = {
				buffers = {
					theme = "dropdown",
					previewer = false,
					initial_mode = "normal",
					mappings = {
						i = {
							["<C-d>"] = actions.delete_buffer,
						},
						n = {
							["dd"] = actions.delete_buffer,
						},
					},
				},
			},
			extensions = {
				fzf = {
					fuzzy = true, -- false will only do exact matching
					override_generic_sorter = true, -- override the generic sorter
					override_file_sorter = true, -- override the file sorter
					case_mode = "smart_case", -- or "ignore_case" or "respect_case"
				},
			},
		})

		local builtin = require("telescope.builtin")

		vim.keymap.set(
            "n",
            "<leader>ff",
            builtin.find_files,
            { desc = "Find file in current working directory" }
        )
		vim.keymap.set(
            "n",
            "<leader>fg",
            builtin.live_grep,
            { desc = "Search for word in current working directory" }
        )
		vim.keymap.set(
			"v",
			"<leader>fg",
			builtin.grep_string,
			{ desc = "Search for selected word in current working directory" }
		)
		vim.keymap.set(
			"n",
			"<leader>fb",
			":Telescope buffers<CR>",
			{ desc = "Search for all currently open buffer in this session" }
		)
		vim.keymap.set(
			"n",
			"<leader>gb",
			builtin.git_branches,
			{ desc = "Search for git branches on current working directory" }
		)
	end,
}
