return {
	"stevearc/conform.nvim",
	event = {
		"BufReadPre",
		"BufNewFile",
	},
	config = function()
		local conform = require("conform")

		conform.setup({
			formatters_by_ft = {
				cpp = { "clang-format" },
				css = { "prettierd" },
				html = { "prettierd" },
				-- javascript = { "prettierd" },
				-- javascriptreact = { "prettierd" },
				json = { "prettierd" },
				lua = { "stylua" },
				markdown = { "prettierd" },
				php = { "php_cs_fixer" },
				twig = { "twig-cs-fixer", "djlint" },
				-- typescript = { "prettierd" },
				-- typescriptreact = { "prettierd" },
				yaml = { "prettierd" },
			},
			-- format_on_save = {
			-- 	lsp_fallback = true,
			-- 	async = false,
			-- 	timeout_ms = 500,
			-- },
		})

		vim.keymap.set({ "n", "v" }, "<leader>mp", function()
			conform.format({
				lsp_fallback = true,
				async = false,
				timeout_ms = 5000,
			})
		end, { desc = "Format file or range (in visual mode)" })
	end,
}
