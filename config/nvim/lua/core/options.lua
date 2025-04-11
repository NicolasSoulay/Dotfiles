vim.g.mapleader = " " -- map leader key to space
vim.opt.clipboard = "unnamedplus" -- allows neovim to access the system clipboard
vim.opt.completeopt = { "menuone", "noselect" } -- mostly just for cmp
vim.opt.conceallevel = 0 -- so that `` is visible in markdown files
vim.opt.nu = true -- line numbers
vim.opt.numberwidth = 4 -- minimal number of columns to use for the line number {default 4}
vim.opt.signcolumn = "yes" -- always show the sign column, otherwise it would shift the text each time
vim.opt.expandtab = true -- convert tabs to spaces
vim.opt.tabstop = 4 -- insert 4 spaces for a tab
vim.opt.softtabstop = 4 -- insert 4 spaces for a tab (when pressing <Tab>)
vim.opt.shiftwidth = 4 -- an auto command will indent/format the current line
vim.opt.showtabline = 1 -- always show the tabs
vim.opt.smartindent = true -- make indenting smarter again

vim.opt.wrap = false -- display lines as one long line
vim.opt.scrolloff = 8 -- minimal number of screen lines to keep above and below the cursor
vim.opt.sidescrolloff = 8 -- minimal number of screen columns to keep to the left and right of the cursor if wrap is `false`

vim.opt.mouse = "a" -- enable mouse mode
vim.opt.mousemoveevent = true -- mouse event highlight

vim.opt.pumheight = 10 -- pop up menu height

vim.opt.splitbelow = true -- force all horizontal splits to go below current window
vim.opt.splitright = true -- force all vertical splits to go to the right of current window
vim.opt.timeoutlen = 300 -- time to wait for a mapped sequence to complete (in milliseconds)
vim.opt.updatetime = 300 -- faster completion (4000ms default)

vim.g.loaded_netrw = 0 -- disable netrw
vim.g.loaded_netrwPlugin = 0 -- disable netrw

-- Set diagnostic signs
local signs = { ERROR = "", WARN = "", INFO = "", HINT = "󰌶" }
local diagnostic_signs = {}
for type, icon in pairs(signs) do
	diagnostic_signs[vim.diagnostic.severity[type]] = icon
end
vim.diagnostic.config({ signs = { text = diagnostic_signs } })

