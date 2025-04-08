return {
	"folke/snacks.nvim",
	lazy = false,
	priority = 1000,
	opts = {
		indent = { animate = { enabled = false } },
		picker = { enabled = true },
	},
	keys = {
		{ "<leader>ff", function() Snacks.picker.files() end, desc = "Find Files", },
		{ "<leader>fg", function() Snacks.picker.grep() end, desc = "Find Grep", },
		{ "<leader>fg", function() Snacks.picker.grep_word() end, mode = "x", desc = "Find Grep", },
		{ "<leader>fb", function() Snacks.picker.buffers() end, desc = "Find Buffers", },
	},
}
