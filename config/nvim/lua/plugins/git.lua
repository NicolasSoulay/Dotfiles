return {
    {
        "lewis6991/gitsigns.nvim",
        event = "BufEnter",
        cmd = "Gitsigns",
        config = function()
            local gitsigns = require("gitsigns")
            gitsigns.setup({
                watch_gitdir = {
                    interval = 1000,
                    follow_files = true,
                },
                attach_to_untracked = true,
                current_line_blame_formatter = "<author>, <author_time:%Y-%m-%d> - <summary>",
                current_line_blame_opts = {
                    delay = 200,
                },
                update_debounce = 200,
                max_file_length = 40000,
                preview_config = {
                    border = "rounded",
                    style = "minimal",
                    relative = "cursor",
                    row = 0,
                    col = 1,
                },
                on_attach = function(bufnr)
                    local keymap = vim.keymap.set
                    keymap("n", "<Leader>tb", gitsigns.toggle_current_line_blame, { buffer = bufnr })
                end
            })
        end,
    },
    {
        "sindrets/diffview.nvim",
        config = function()
            local diffview = require("diffview")
            local keymap = vim.keymap.set
            local opts = { silent = true, buffer = true }

            diffview.setup({
            })

            vim.keymap.set(
                "n",
                "<leader>dv",
                ":DiffviewOpen<CR>",
                { desc = "Open diffview window" }
            )
            vim.keymap.set(
                "n",
                "<leader>gh",
                ":DiffviewFileHistory %<CR>",
                { desc = "Open diffview file history for this buffer" }
            )
            vim.keymap.set(
                "n",
                "<leader>gg",
                ":DiffviewFileHistory<CR>",
                { desc = "Open diffview file history" }
            )

            -- Autocommands to invoke DiffviewClose when using q if the file name start with "diffview:"
            vim.api.nvim_create_autocmd("BufEnter", {
                pattern = "diffview:*/*",
                callback = function()
                    vim.cmd([[
                        nnoremap <silent> <buffer> q :DiffviewClose<CR>
                        set nobuflisted
                    ]])
                    -- Disable buffer navigation while in diffview
                    keymap("n", "<S-l>", "", opts)
                    keymap("n", "<S-h>", "", opts)
                end,
            })

        end,
    }
}
