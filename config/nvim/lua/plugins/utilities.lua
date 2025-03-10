return {
	{
		"windwp/nvim-autopairs",
		event = "InsertEnter",
		config = true,
	},
        {
        "FerretDetective/oil-git-signs.nvim",
        ft = "oil",
        ---@module "oil_git_signs"
        ---@type oil_git_signs.Config
        opts = {},
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
