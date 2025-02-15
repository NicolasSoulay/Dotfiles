local servers = {
	"lua_ls",
	"phpactor",
	"twiggy_language_server",
	"yamlls",
	"emmet_language_server",
	"ts_ls",
	"bashls",
	"csharp_ls",
	"jsonls",
	"rust_analyzer",
	"clangd",
	"marksman",
}

local tools = {
    "clang-format",
    "djlint",
    "prettierd",
	"php-cs-fixer",
    "stylua",
	"twig-cs-fixer",
}

return {
	"neovim/nvim-lspconfig",
	event = { "BufReadPre", "BufNewFile" },
	dependencies = {
		{ "williamboman/mason.nvim", lazy = false, opts = { ui = { border = "rounded" } } },
		{ "williamboman/mason-lspconfig.nvim", opts = { ensure_installed = servers } },
		{ "WhoIsSethDaniel/mason-tool-installer.nvim", opts = { ensure_installed = tools } },
		{
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
		},
		{
			"saghen/blink.cmp",
			dependencies = "rafamadriz/friendly-snippets",
			version = "*",
			opts = {
				keymap = {
					preset = "default",
					["<C-k>"] = { "select_prev", "fallback" },
					["<C-j>"] = { "select_next", "fallback" },
				},
				appearance = {
					nerd_font_variant = "mono",
				},
				signature = { enabled = true },
				sources = {
					default = { "lsp", "path", "snippets", "buffer" },
					cmdline = {},
				},
				completion = {
					accept = { auto_brackets = { enabled = true } },
					documentation = { window = { border = "single" } },
					menu = {
						draw = { columns = { { "kind_icon", "label", "label_description", gap = 1 }, { "kind" } } },
					},
					list = { selection = { preselect = false, auto_insert = false } },
				},
			},
			opts_extend = { "sources.default" },
		},
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

					keymap(bufnr, "n", "gD", "<cmd>lua require('snacks').picker.lsp_declarations()<CR>", opts)
					keymap(bufnr, "n", "gd", "<cmd>lua require('snacks').picker.lsp_definitions()<CR>", opts)
					keymap(bufnr, "n", "gI", "<cmd>lua require('snacks').picker.lsp_implementations()<CR>", opts)
					keymap(bufnr, "n", "gr", "<cmd>lua require('snacks').picker.lsp_references()<CR>", opts)
					keymap(bufnr, "n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", opts)
					keymap(bufnr, "n", "<Leader>ca", "<cmd>lua vim.lsp.buf.code_action()<CR>", opts)

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
