return {
  "nvim-tree/nvim-tree.lua",
  version = "*",
  lazy = false,
  dependencies = {
    "nvim-tree/nvim-web-devicons",
  },
  config = function()
    local gheight = vim.api.nvim_list_uis()[1].height
    local gwidth = vim.api.nvim_list_uis()[1].width
    require("nvim-tree").setup {
        renderer = {
            icons = {
                glyphs = {
                    default = "",
                    symlink = "",
                    folder = {
                        arrow_open = "",
                        arrow_closed = "",
                        default = "",
                        open = "",
                        empty = "",
                        empty_open = "",
                        symlink = "",
                        symlink_open = "",
                    },
                    git = {
                        unstaged = "",
                        staged = "S",
                        unmerged = "",
                        renamed = "➜",
                        untracked = "U",
                        deleted = "",
                        ignored = "◌",
                    },
                },
            },
        },
        diagnostics = {
            enable = true,
            show_on_dirs = true,
            icons = {
                hint = "󰌵",
                info = "",
                warning = "",
                error = "",
            },
        },
        view = {
            width = 30,
            -- height = 30,
            float = {
                enable = true,
                open_win_config = {
                    relative = "editor",
                    border = "rounded",
                    width = 90,
                    height = 30,
                    row = (gheight - 30) * 0.5,
                    col = (gwidth - 90) * 0.5,                
                }
            }
        }
    }
  end,
}
