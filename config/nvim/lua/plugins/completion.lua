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
        {
            "windwp/nvim-autopairs",
            config = function()
                require("nvim-autopairs").setup({
                    check_ts = true,
                    disable_filetype = { "TelescopePrompt", "spectre_panel" },
                })
            end,
        }
	},
	config = function()
		local cmp = require("cmp")
        local cmp_autopairs = require('nvim-autopairs.completion.cmp')
		local luasnip = require("luasnip")
        local icons = require("core.icons")
		require("luasnip/loaders/from_vscode").lazy_load()

        cmp.event:on(
          'confirm_done',
          cmp_autopairs.on_confirm_done()
        )

		cmp.setup({
			snippet = {
				expand = function(args)
					luasnip.lsp_expand(args.body)
				end,
			},
			mapping = {
				["<C-j>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
				["<C-k>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
				["<C-y>"] = cmp.mapping( cmp.mapping.confirm({ behavior = cmp.ConfirmBehavior.Insert, select = true, }), { "i", "c" }),
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
			window = {
				completion = {
					border = "rounded",
					scrollbar = false,
				},
				documentation = {
					border = "rounded",
				},
			},
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
