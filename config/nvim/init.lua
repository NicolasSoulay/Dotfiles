-- OPTIONS --
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

-- KEYMAPS --

local keymap = vim.keymap.set
local opts = { silent = true }

-- NORMAL --
-- Disable anoying stuff
keymap("n", "q:", "<nop>", opts)
keymap("n", "q", "<nop>", opts)

-- Better window navigation
keymap("n", "<C-h>", "<C-w>h", opts)
keymap("n", "<C-j>", "<C-w>j", opts)
keymap("n", "<C-k>", "<C-w>k", opts)
keymap("n", "<C-l>", "<C-w>l", opts)

-- Resize with arrows
keymap("n", "<C-Up>", ":resize -2<CR>", opts)
keymap("n", "<C-Down>", ":resize +2<CR>", opts)
keymap("n", "<C-Left>", ":vertical resize -2<CR>", opts)
keymap("n", "<C-Right>", ":vertical resize +2<CR>", opts)

-- Navigate buffers
keymap("n", "<S-l>", ":bnext<CR>", opts)
keymap("n", "<S-h>", ":bprevious<CR>", opts)

-- Close buffers
keymap("n", "<S-q>", ":bdelete<CR>", opts)

-- Close window
keymap("n", "<Leader>q", "<C-w>q", opts)

-- Replace all on current word and ask confirmation
keymap("n", "<Leader>S", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gcI<Left><Left><Left><Left>]], opts)

-- Replace all on current word
keymap("n", "<Leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]], opts)

-- Split window vertical/horizontal
keymap("n", "<Leader>v", "<C-w>v", opts)
keymap("n", "<Leader>h", "<C-w>s", opts)

-- Open terminal
keymap("n", "<Leader>\\", "<cmd>15split<CR><cmd>terminal<CR>:set filetype=terminal<CR>a", opts)
keymap("t", "<Leader>\\", "<cmd>bdelete!<CR>", opts)
keymap("t", "<Esc>", "<C-\\><C-n>", opts)

-- Stay in place when append line
keymap("n", "J", "mzJ`z", opts)

-- Make current file executable
keymap("n", "<Leader>x", "<cmd>!chmod +x %<CR>", opts)

-- Comment line
keymap("n", "<Leader>/", "gcc", {silent = true, remap = true})

-- INSERT --
-- Press jk fast to go back to normal mode
keymap("i", "jk", "<ESC>", opts)

-- VISUAL --
-- Stay in indent mode
keymap("v", "<", "<gv", opts)
keymap("v", ">", ">gv", opts)

-- Move block up/down
keymap("x", "J", ":m '>+1<CR><CR>gv=gv", opts)
keymap("x", "K", ":m '<-2<CR><CR>gv=gv", opts)

-- Comment selection
keymap("x", "<Leader>/", "gc", {silent = true, remap = true})

-- AUTOCOMMANDS --

-- Use q to close in specifics buffers
vim.api.nvim_create_autocmd({ "FileType" }, {
	pattern = {
		"netrw",
		"Jaq",
		"qf",
		"git",
		"help",
		"man",
		"lspinfo",
		"oil",
		"spectre_panel",
		"lir",
		"DressingSelect",
		"tsplayground",
		"terminal",
		"",
	},
	callback = function()
        keymap("n", "q", "<cmd>close<CR>", { silent = true, buffer = true })
        keymap("n", "<S-l>", "<nop>", { silent = true, buffer = true })
        keymap("n", "<S-h>", "<nop>", { silent = true, buffer = true })
	end,
})

-- Use esc or q to close terminal buffers
vim.api.nvim_create_autocmd({ "FileType" }, {
	pattern = {
		"terminal",
	},
	callback = function()
        keymap("n", "<Esc>", "<cmd>bdelete!<CR>", { silent = true, buffer = true })
        keymap("n", "q", "<cmd>bdelete!<CR>", { silent = true, buffer = true })
        keymap("n", "<Leader>\\", "<cmd>bdelete!<CR>", { silent = true, buffer = true })
        keymap("n", "<S-l>", "<nop>", { silent = true, buffer = true })
        keymap("n", "<S-h>", "<nop>", { silent = true, buffer = true })
	end,
})

-- briefly highlight yanked text
vim.api.nvim_create_autocmd({ "TextYankPost" }, {
	callback = function()
		vim.highlight.on_yank({ higroup = "Visual", timeout = 100 })
	end,
})

vim.api.nvim_create_autocmd({ "CursorHold" }, {
	callback = function()
		local status_ok, luasnip = pcall(require, "luasnip")
		if not status_ok then
			return
		end
		if luasnip.expand_or_jumpable() then
			-- ask maintainer for option to make this silent
			-- luasnip.unlink_current()
			vim.cmd([[silent! lua require("luasnip").unlink_current()]])
		end
	end,
})

-- Change directory to root of current project
vim.api.nvim_create_autocmd('BufEnter', {
    callback = function()
        -- Get directory path to start search from
        local path = vim.api.nvim_buf_get_name(0)
        -- If path is empty, return
        if path == '' then return end
        -- if path start with  oil:// then trim it
        if path:match("^oil://") then path = path:sub(7) end

        path = vim.fs.dirname(path)

        local root_file = vim.fs.find(
            {".git", "Makefile", "package.json"},
            { path = path, upward = true }
        )[1]
        if root_file == nil then return end
        local root = vim.fs.dirname(root_file)

        -- Set current directory
        vim.fn.chdir(root)
    end
})

-- LAZY --

-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
    local lazyrepo = "https://github.com/folke/lazy.nvim.git"
    local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
    if vim.v.shell_error ~= 0 then
        vim.api.nvim_echo({
            { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
            { out, "WarningMsg" },
            { "\nPress any key to exit..." },
        }, true, {})
        vim.fn.getchar()
        os.exit(1)
    end
end
vim.opt.rtp:prepend(lazypath)

-- Setup lazy.nvim
require("lazy").setup({
    spec = {
        -- import your plugins
        { import = "plugins" },
    },
    ui = {
        border = "rounded",
    },
    rocks = {
        enabled = false,
    }
})
