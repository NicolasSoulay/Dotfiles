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
				"twiggy_language_server",
				"yamlls",
				"emmet_language_server",
				"ts_ls",
				"glint",
				"bashls",
				"csharp_ls",
				"jsonls",
				"rust_analyzer",
				"clangd",
				"marksman",
			},
		})

		mason_tool_installer.setup({
			ensure_installed = {
				"cpplint",
				"prettierd",
				"stylua",
				"eslint_d",
				"phpstan",
				"php-cs-fixer",
				"twig-cs-fixer",
				"twigcs",
				"djlint",
				"clang-format",
			},
		})
	end,
}
