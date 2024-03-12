local M = {
    'goolord/alpha-nvim',
    event = "VimEnter",
    dependencies = { 'nvim-tree/nvim-web-devicons' }
}

function M.config()
    local alpha = require "alpha"
    local dashboard = require "alpha.themes.dashboard"
    local icons = require "core.icons"
    dashboard.section.header.val = {
        [[                    ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀       ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣰          ]],
        [[                    ⠀⠀⠀⠀⠀⠀⠀⠀⠀       ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣀⣤⣶⣿⡏          ]],
        [[                    ⠀⠀⠀       ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣀⣀⣤⣶⣾⣿⣿⣿⣿⠟⠀          ]],
        [[                          ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⣠⣴⡶⣟⣿⣿⣾⡿⣿⣿⣿⣿⠟⠁⠀⠀          ]],
        [[                           ⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⣴⣾⣾⣯⣿⣿⣿⣿⣿⣿⡿⠟⠉⠁⠀⠀⠀⠀⠀          ]],
        [[                            ⠀⠀⠀⠀⠀⠀⠀⣤⣾⣿⣿⣿⣿⣿⢿⣷⣿⡿⠋⠀⠀⠀⠀⠀⠀⠀       ⠀⠀   ]],
        [[                             ⠀⠀⠀⠀⠀⣸⣿⣿⣿⣿⣿⢟⣷⣿⣿⡿⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀          ]],
        [[                              ⠀⠀⢀⢠⣿⣿⣿⣯⠾⣥⣿⣿⣿⡿⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀      ⠀    ]],
        [[                          ⠀⠀⠀⠀⠀⡄⣜⣿⣿⡿⣷⣿⣾⣿⣿⡿⠋⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀          ]],
        [[                          ⠀⠀⠀⠀⢀⢻⣿⣿⣿⣿⣥⣾⣿⠟⠋⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀          ]],
        [[                          ⠀⠀⠀⠀⠀⢻⣿⣟⣿⣿⡿⠋⠁⣴⠖⠛⠉⠉⠉⠥⣌⠉⠉⠙⠒⢦⡀⠀⠀⠀          ]],
        [[                          ⠀⠀⠀⠀⠀⠀⡾⡾⠹⠙⠉⠀⠀⠙⠒⠒⠲⠖⠒⠙⠁⠀⠀⣀⣠⡴⠟⠀⠀⠀          ]],
        [[                          ⣀⡤⠤⠤⠤⣸⣿⠇⠒⠒⠒⠒⠒⠒⠒⠚⠛⠛⠙⠋⠋⠉⠉⠉⠀⠀⠀⠀⠀⠀          ]],
        [[                          ⠿⢤⣤⣤⣠⣿⠃⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀          ]],
    }
    dashboard.section.buttons.val = {
        dashboard.button("f", icons.ui.Files .. " Find file", ":Telescope find_files <CR>"),
        dashboard.button("e", icons.ui.NewFile .. " New file", ":ene <BAR> startinsert <CR>"),
        dashboard.button("p", icons.git.Repo .. " Find project",
            ":lua require('telescope').extensions.projects.projects()<CR>"),
        dashboard.button("r", icons.ui.History .. " Recent files", ":Telescope oldfiles <CR>"),
        dashboard.button("t", icons.ui.Text .. " Find text", ":Telescope live_grep <CR>"),
        dashboard.button("c", icons.ui.Gear .. " Config", ":e $MYVIMRC <CR>"),
        dashboard.button("q", icons.ui.SignOut .. " Quit", ":qa<CR>"),
    }
    local function footer()
        return ""
    end

    dashboard.section.footer.val = footer()

    dashboard.section.footer.opts.hl = "Type"
    dashboard.section.header.opts.hl = "Include"
    dashboard.section.buttons.opts.hl = "Keyword"

    dashboard.opts.opts.noautocmd = true
    alpha.setup(dashboard.opts)
end

return M
