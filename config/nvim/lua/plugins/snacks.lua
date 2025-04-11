return {
	"folke/snacks.nvim",
	lazy = false,
	priority = 1000,
	opts = {
		indent = { animate = { enabled = false } },
		picker = { enabled = true },
        zen = { toggles = { dim = false } },
	},
	keys = {
		{ "<leader>ff", function() Snacks.picker.files() end, desc = "Find Files", },
		{ "<leader>fg", function() Snacks.picker.grep() end, desc = "Find Grep", },
		{ "<leader>fg", function() Snacks.picker.grep_word() end, mode = "x", desc = "Find Grep", },
		{ "<leader>fb", function() Snacks.picker.buffers() end, desc = "Find Buffers", },
        { "gd", function() Snacks.picker.lsp_definitions() end, desc = "Go to definition", },
        { "gD", function() Snacks.picker.lsp_declarations() end, desc = "Go to declaration", },
        { "gr", function() Snacks.picker.lsp_references() end, nowait = true, desc = "References" },
        { "gI", function() Snacks.picker.lsp_implementations() end, desc = "Goto Implementation" },
        { "gy", function() Snacks.picker.lsp_type_definitions() end, desc = "Goto T[y]pe Definition" },
        { "<leader>z",  function() Snacks.zen() end, desc = "Toggle Zen Mode" },
        { "<S-q>", function() Snacks.bufdelete() end, desc = "Close current buffer" },
        { "<leader>co", function() Snacks.bufdelete.other() end, desc = "Close current buffer" },
	},
}
