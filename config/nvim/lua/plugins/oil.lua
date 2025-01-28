return {
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

		vim.keymap.set("n", "-", "<CMD>Oil<CR>", { desc = "Open Oil.nvim in parent directory" })
		vim.keymap.set("n", "<leader>e", "<CMD>Oil --float<CR>", { desc = "Open parent directory" })

        vim.api.nvim_create_autocmd({ "FileType" }, {
            pattern = "oil",
            callback = function()
                vim.cmd([[
                  nnoremap <silent> <buffer> <leader>e :close<CR>
                  set nobuflisted
                ]])
            end,
        })
	end,
}
