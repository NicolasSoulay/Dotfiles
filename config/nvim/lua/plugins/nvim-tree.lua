return {
    "nvim-tree/nvim-tree.lua",
    -- version = "*",
    lazy = false,
    dependencies = {
        "nvim-tree/nvim-web-devicons",
    },
    config = function()
        local gheight = vim.api.nvim_list_uis()[1].height
        local gwidth = vim.api.nvim_list_uis()[1].width
        local icons = require "core.icons"
        require("nvim-tree").setup {
            renderer = {
                add_trailing = false,
                group_empty = false,
                highlight_git = false,
                full_name = false,
                highlight_opened_files = "none",
                root_folder_label = ":t",
                indent_width = 2,
                indent_markers = {
                    enable = false,
                    inline_arrows = true,
                    icons = {
                        corner = "└",
                        edge = "│",
                        item = "│",
                        none = " ",
                    },
                },
                icons = {
                    git_placement = "before",
                    padding = " ",
                    symlink_arrow = " ➛ ",
                    glyphs = {
                        default = icons.ui.Text,
                        symlink = icons.ui.FileSymlink,
                        bookmark = icons.ui.BookMark,
                        folder = {
                            arrow_closed = icons.ui.ChevronRight,
                            arrow_open = icons.ui.ChevronShortDown,
                            default = icons.ui.Folder,
                            open = icons.ui.FolderOpen,
                            empty = icons.ui.EmptyFolder,
                            empty_open = icons.ui.EmptyFolderOpen,
                            symlink = icons.ui.FolderSymlink,
                            symlink_open = icons.ui.FolderOpen,
                        },
                        git = {
                            unstaged = icons.git.FileUnstaged,
                            staged = icons.git.FileStaged,
                            unmerged = icons.git.FileUnmerged,
                            renamed = icons.git.FileRenamed,
                            untracked = icons.git.FileUntracked,
                            deleted = icons.git.FileDeleted,
                            ignored = icons.git.FileIgnored,
                        },
                    },
                },
                special_files = { "Cargo.toml", "Makefile", "README.md", "readme.md" },
                symlink_destination = true,
            },
            update_focused_file = {
                enable = true,
                debounce_delay = 15,
                update_root = true,
                ignore_list = {},
            },

            diagnostics = {
                enable = true,
                show_on_dirs = false,
                show_on_open_dirs = true,
                debounce_delay = 50,
                severity = {
                    min = vim.diagnostic.severity.HINT,
                    max = vim.diagnostic.severity.ERROR,
                },
                icons = {
                    hint = icons.diagnostics.BoldHint,
                    info = icons.diagnostics.BoldInformation,
                    warning = icons.diagnostics.BoldWarning,
                    error = icons.diagnostics.BoldError,
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
