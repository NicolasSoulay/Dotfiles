local keymap = vim.keymap.set
return {
	{
		"folke/snacks.nvim",
		lazy = false,
		priority = 1000,
		opts = {
			gitbrowse = { enabled = true },
			indent = { animate = { enabled = false } },
			lazygit = { enabled = true },
			picker = { enabled = true },
		},
		keys = {
			{
				"<leader>ff",
				function()
					Snacks.picker.files()
				end,
				desc = "Find Files",
			},
			{
				"<leader>fg",
				function()
					Snacks.picker.grep()
				end,
				desc = "Find Grep",
			},
			{
				"<leader>fg",
				function()
					Snacks.picker.grep_word()
				end,
				mode = "x",
				desc = "Find Grep",
			},
			{
				"<leader>fb",
				function()
					Snacks.picker.buffers()
				end,
				desc = "Find Buffers",
			},
			{
				"<leader>or",
				function()
					Snacks.gitbrowse.open()
				end,
				desc = "Open github repo for current file",
			},
			{
				"<leader>lg",
				function()
					Snacks.lazygit.open(opts)
				end,
				desc = "Open github repo for current file",
			},
		},
	},
	{
		"windwp/nvim-autopairs",
		event = "InsertEnter",
		config = true,
	},
	{
		"ThePrimeagen/harpoon",
		branch = "harpoon2",
		dependencies = { "nvim-lua/plenary.nvim" },
		config = function()
			local harpoon = require("harpoon")
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
	},
	{
		"stevearc/oil.nvim",
		dependencies = { { "nvim-tree/nvim-web-devicons" } },
		config = function()
			local oil = require("oil")

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
			})

			keymap("n", "-", "<CMD>Oil<CR>", { desc = "Open Oil.nvim in parent directory" })
			keymap("n", "<leader>e", "<CMD>Oil --float<CR>", { desc = "Open parent directory" })

			vim.api.nvim_create_autocmd({ "FileType" }, {
				pattern = "oil",
				callback = function()
					keymap("n", "<leader>e", ":close<CR>", { buffer = true, silent = true })
				end,
			})
		end,
	},
	{
		"rachartier/tiny-inline-diagnostic.nvim",
		event = "VeryLazy",
		priority = 1000,
		config = function()
			require("tiny-inline-diagnostic").setup({
				preset = "powerline",
				options = {
					use_icons_from_diagnostic = true,
					multilines = {
						enabled = true,
						always_show = true,
					},
				},
			})
			vim.diagnostic.config({ virtual_text = false }) -- Only if needed in your configuration, if you already have native LSP diagnostics
		end,
	},
	{
		"catgoose/nvim-colorizer.lua",
		event = "BufReadPre",
		opts = {},
	},
	{
		"akinsho/toggleterm.nvim",
		event = "VeryLazy",
		config = function()
			local status_ok, toggleterm = pcall(require, "toggleterm")
			if not status_ok then
				return
			end
			toggleterm.setup({
				size = 20,
				open_mapping = [[<Leader>\]],
				hide_numbers = true,
				shade_terminals = true,
				shading_factor = 2,
				start_in_insert = true,
				insert_mappings = false,
				persist_size = true,
				direction = "float",
				close_on_exit = true,
				shell = vim.o.shell,
				float_opts = {
					border = "curved",
				},
			})
			function _G.set_terminal_keymaps()
				local opts = { noremap = true }
				vim.api.nvim_buf_set_keymap(0, "t", "<C-h>", [[<C-\><C-n><C-W>h]], opts)
				vim.api.nvim_buf_set_keymap(0, "t", "<C-j>", [[<C-\><C-n><C-W>j]], opts)
				vim.api.nvim_buf_set_keymap(0, "t", "<C-k>", [[<C-\><C-n><C-W>k]], opts)
				vim.api.nvim_buf_set_keymap(0, "t", "<C-l>", [[<C-\><C-n><C-W>l]], opts)
			end
			vim.cmd("autocmd! TermOpen term://* lua set_terminal_keymaps()")
		end,
	},
}
