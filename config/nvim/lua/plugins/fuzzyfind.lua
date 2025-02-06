return {
    "folke/snacks.nvim",
    opts = { picker = {} },
    keys = {
        { "<leader>ff", function() Snacks.picker.smart() end, desc = "Find Files" },
        { "<leader>fg", function() Snacks.picker.grep() end, desc = "Find Grep" },
        { "<leader>fg", function() Snacks.picker.grep_word() end, mode = "x", desc = "Find Grep" },
        { "<leader>fb", function() Snacks.picker.buffers() end, desc = "Find Buffers" },
    },
}
