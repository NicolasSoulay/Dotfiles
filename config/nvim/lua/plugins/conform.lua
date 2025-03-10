return {
	"stevearc/conform.nvim",
	config = function()
		require("conform").setup({
			formatters_by_ft = {
				cpp = { "clang-format" },
				css = { "prettierd" },
				html = { "prettierd" },
				json = { "prettierd" },
				lua = { "stylua" },
				markdown = { "prettierd" },
				php = { "php_cs_fixer" },
				twig = { "twig-cs-fixer", "djlint" },
				yaml = { "prettierd" },
			},
		})
		vim.keymap.set({ "n", "v" }, "<leader>mp", function()
			require("conform").format({
				lsp_fallback = true,
				async = false,
				timeout_ms = 5000,
			})
		end, { desc = "Format file or range (in visual mode)" })
	end,
}
