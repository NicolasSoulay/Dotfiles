return {
	"williamboman/mason-lspconfig.nvim",
	dependencies = {
		"williamboman/mason.nvim",
		"WhoIsSethDaniel/mason-tool-installer.nvim",
	},
	config = function()
		local mason = require("mason")
		local mason_lsp_config = require("mason-lspconfig")
		local mason_tool_installer = require("mason-tool-installer")

		mason.setup({
			ui = {
				border = "rounded",
			},
		})
		mason_lsp_config.setup({
			ensure_installed = {
				"lua_ls",
				"phpactor",
				"intelephense",
				"twiggy_language_server",
				"cssls",
				"eslint",
				"yamlls",
				"cssmodules_ls",
				"emmet_language_server",
				"html",
				"tsserver",
				"angularls",
				"bashls",
				"jsonls",
				"tailwindcss",
				"rust_analyzer",
				"clangd",
				"marksman",
			},
		})

		mason_tool_installer.setup({
			ensure_installed = {
				"prettierd",
				"stylua",
				"eslint_d",
				"phpstan",
				"php-cs-fixer",
				"twig-cs-fixer",
				"twigcs",
				"djlint",
			},
		})
	end,
}
