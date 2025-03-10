return {
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
		signature = {
			enabled = true,
			window = {
				border = "rounded",
				show_documentation = false,
			},
		},
		sources = {
			default = { "lsp", "path", "snippets", "buffer" },
		},
		cmdline = {},
		completion = {
			accept = { auto_brackets = { enabled = true } },
			documentation = {
				auto_show = true,
				auto_show_delay_ms = 100,
				window = { border = "rounded" },
			},
			list = { selection = { preselect = false, auto_insert = false } },
			menu = {
				draw = { columns = { { "kind_icon", "label", "label_description", gap = 1 }, { "kind" } } },
			},
		},
	},
	opts_extend = { "sources.default" },
}
