return {
	"folke/snacks.nvim",
	lazy = false,
	priority = 1000,
	opts = {
		gitbrowse = { enabled = true },
		indent = { animate = { enabled = false } },
		lazygit = { enabled = true },
		picker = { enabled = true },
	},
	keys = {
		{ "<leader>ff", function() Snacks.picker.files() end, desc = "Find Files", },
		{ "<leader>fg", function() Snacks.picker.grep() end, desc = "Find Grep", },
		{ "<leader>fg", function() Snacks.picker.grep_word() end, mode = "x", desc = "Find Grep", },
		{ "<leader>fb", function() Snacks.picker.buffers() end, desc = "Find Buffers", },
		{ "<leader>or", function() Snacks.gitbrowse.open() end, desc = "Open github repo for current file", },
		{ "<leader>lg", function() Snacks.lazygit.open(opts) end, desc = "Open github repo for current file", },
	},
}
