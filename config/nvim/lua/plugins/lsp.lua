local servers = {
	"lua_ls",
	"taplo",
	"phpactor",
	"twiggy_language_server",
	"yamlls",
	"emmet_language_server",
	"ts_ls",
	"bashls",
	"csharp_ls",
	"jsonls",
	"clangd",
	"marksman",
}

local tools = {
	"clang-format",
	"djlint",
    "eslint_d",
	"prettierd",
	"php-cs-fixer",
    "phpstan",
	"stylua",
	"twig-cs-fixer",
	"twigcs",
}

return {
	"neovim/nvim-lspconfig",
	event = { "BufReadPre", "BufNewFile" },
	dependencies = {
		{ "williamboman/mason.nvim", lazy = false, opts = { ui = { border = "rounded" } } },
		{ "williamboman/mason-lspconfig.nvim", opts = { ensure_installed = servers } },
		{ "WhoIsSethDaniel/mason-tool-installer.nvim", opts = { ensure_installed = tools } },
        { "folke/snacks.nvim" },
		{ "saghen/blink.cmp" },
	},
	config = function()
		local lspconfig = require("lspconfig")
		local capabilities = require("blink.cmp").get_lsp_capabilities()
		local signs = { ERROR = "", WARN = "", INFO = "", HINT = "󰌶" }

		local diagnostic_signs = {}
		for type, icon in pairs(signs) do
			diagnostic_signs[vim.diagnostic.severity[type]] = icon
		end
		vim.diagnostic.config({ signs = { text = diagnostic_signs } })

		for _, server in pairs(servers) do
			local opts = {
				on_attach = function(client, bufnr)
					local opts = { noremap = true, silent = true }
					local keymap = vim.api.nvim_buf_set_keymap

					keymap(bufnr, "n", "K", "<cmd>lua vim.lsp.buf.hover({border = 'rounded'})<CR>", opts)
					keymap(bufnr, "n", "<Leader>ca", "<cmd>lua vim.lsp.buf.code_action()<CR>", opts)
					keymap(bufnr, "n", "<Leader>rn", "<cmd>lua vim.lsp.buf.rename()<CR>", opts)

					if client and client:supports_method(vim.lsp.protocol.Methods.textDocument_inlayHint) then
						vim.lsp.inlay_hint.enable(true)
					end
				end,
				capabilities = capabilities,
			}

			local require_ok, settings = pcall(require, "lsp." .. server)
			if require_ok then
				opts = vim.tbl_deep_extend("force", settings, opts)
			end

			lspconfig[server].setup(opts)
		end
	end,
}
