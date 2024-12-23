return {
	"hrsh7th/nvim-cmp",
	event = "InsertEnter",
	dependencies = {
		{
			"hrsh7th/cmp-nvim-lsp",
			event = "InsertEnter",
		},
		{
			"hrsh7th/cmp-buffer",
			event = "InsertEnter",
		},
		{
			"hrsh7th/cmp-path",
			event = "InsertEnter",
		},
		{
			"hrsh7th/cmp-cmdline",
			event = "InsertEnter",
		},
		{
			"saadparwaiz1/cmp_luasnip",
			event = "InsertEnter",
		},
		{
			"L3MON4D3/LuaSnip",
			event = "InsertEnter",
			dependencies = {
				"rafamadriz/friendly-snippets",
			},
			config = function(_, opts)
				if opts then
					require("luasnip").config.setup(opts)
				end
				vim.tbl_map(function(type)
					require("luasnip.loaders.from_" .. type).lazy_load()
				end, { "vscode", "snipmate", "lua" })
				-- friendly-snippets - enable standardized comments snippets
				require("luasnip").filetype_extend("twig", { "html" })
				require("luasnip").filetype_extend("html", { "twig" })
				require("luasnip").filetype_extend("typescript", { "tsdoc" })
				require("luasnip").filetype_extend("javascript", { "jsdoc" })
				require("luasnip").filetype_extend("lua", { "luadoc" })
				require("luasnip").filetype_extend("python", { "pydoc" })
				require("luasnip").filetype_extend("rust", { "rustdoc" })
				require("luasnip").filetype_extend("cs", { "csharpdoc" })
				require("luasnip").filetype_extend("java", { "javadoc" })
				require("luasnip").filetype_extend("c", { "cdoc" })
				require("luasnip").filetype_extend("cpp", { "cppdoc" })
				require("luasnip").filetype_extend("php", { "phpdoc" })
				require("luasnip").filetype_extend("kotlin", { "kdoc" })
				require("luasnip").filetype_extend("ruby", { "rdoc" })
				require("luasnip").filetype_extend("sh", { "shelldoc" })
			end,
		},
		{
			"hrsh7th/cmp-nvim-lua",
		},
	},
	config = function()
		local cmp = require("cmp")
		local luasnip = require("luasnip")
		require("luasnip/loaders/from_vscode").lazy_load()

		vim.api.nvim_set_hl(0, "CmpItemKindTabnine", { fg = "#CA42F0" })

		local check_backspace = function()
			local col = vim.fn.col(".") - 1
			return col == 0 or vim.fn.getline("."):sub(col, col):match("%s")
		end

		local icons = require("core.icons")

		cmp.setup({
			snippet = {
				expand = function(args)
					luasnip.lsp_expand(args.body)
				end,
			},
			mapping = {
				["<C-j>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
				["<C-k>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
				["<C-y>"] = cmp.mapping(
					cmp.mapping.confirm({
						behavior = cmp.ConfirmBehavior.Insert,
						select = true,
					}),
					{ "i", "c" }
				),
			},
			formatting = {
				fields = { "kind", "abbr", "menu" },
				format = function(entry, vim_item)
					vim_item.kind = icons.kind[vim_item.kind]
					vim_item.menu = ({
						nvim_lsp = "",
						nvim_lua = "",
						luasnip = "",
						buffer = "",
						path = "",
					})[entry.source.name]

					if entry.source.name == "cmp_tabnine" then
						vim_item.kind = icons.misc.Robot
						vim_item.kind_hl_group = "CmpItemKindTabnine"
					end

					return vim_item
				end,
			},
			sources = {
				{ name = "nvim_lsp" },
				{ name = "luasnip" },
				{ name = "cmp_tabnine" },
				{ name = "nvim_lua" },
				{ name = "buffer" },
				{ name = "path" },
				{ name = "calc" },
			},
			-- confirm_opts = {
			-- 	behavior = cmp.ConfirmBehavior.Replace,
			-- 	select = false,
			-- },
			window = {
				completion = {
					border = "rounded",
					scrollbar = false,
				},
				documentation = {
					border = "rounded",
				},
			},
			-- experimental = {
			-- 	ghost_text = false,
			-- },
		})

		vim.keymap.set({ "i", "s" }, "<C-n>", function()
			if luasnip.expand_or_jumpable() then
				luasnip.expand_or_jump()
			end
		end, { silent = true })

		vim.keymap.set({ "i", "s" }, "<C-p>", function()
			if luasnip.jumpable(-1) then
				luasnip.jump(-1)
			end
		end, { silent = true })
	end,
}
