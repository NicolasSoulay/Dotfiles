local M = {
    'nvim-telescope/telescope.nvim',
    version = '0.1.x',
    dependencies = {
        'nvim-lua/plenary.nvim',
        version = "0.1.x"
    },
    -- {
    --     'nvim-telescope/telescope-ui-select.nvim'
    -- },
    opts = {

    }
}

function M.config()
    local telescope = require "telescope"
    local actions = require "telescope.actions"

    telescope.setup {
        defaults = {

            prompt_prefix = " ",
            selection_caret = " ",
            path_display = { "smart" },
            mappings = {
                i = {
                    ["<esc>"] = actions.close,
                    ["<C-j>"] = actions.move_selection_next,
                    ["<C-k>"] = actions.move_selection_previous,
                },
            },
        },
        pickers = {
            buffers = {
                mappings = {
                    i = {
                        ["<c-d>"] = actions.delete_buffer + actions.move_to_top,
                    }
                }
            }
        },
        -- extensions = {
        --     ["ui-select"] = {
        --         require("telescope.themes").get_dropdown {
        --             -- even more opts
        --         }
        --     }
        -- }
    }
    -- telescope.load_extension "ui-select"
end

return M
