vim.g.mapleader = " "

vim.opt.nu = true
vim.opt.numberwidth = 2                         -- minimal number of columns to use for the line number {default 4}

vim.opt.expandtab = true
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.showtabline = 0

vim.opt.smartindent = true


vim.opt.termguicolors = true

vim.opt.wrap = false
vim.opt.scrolloff = 8
vim.opt.sidescrolloff = 8                       -- minimal number of screen columns to keep to the left and right of the cursor if wrap is `false`

vim.opt.mouse = "a"
vim.opt.mousemoveevent = true

vim.opt.pumheight = 10

vim.opt.splitbelow = true                       -- force all horizontal splits to go below current window
vim.opt.splitright = true                       -- force all vertical splits to go to the right of current window
vim.opt.timeoutlen = 300                        -- time to wait for a mapped sequence to complete (in milliseconds)
vim.opt.updatetime = 300                        -- faster completion (4000ms default)

vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
