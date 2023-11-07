local keymap = vim.keymap.set
local opts = { silent = true }

-- PLUGINS --
-- Nvim-tree
keymap("n", "<leader>e", "<cmd>NvimTreeToggle<CR>", opts)

-- Telescope
keymap("n", "<leader>ff", ":Telescope find_files<CR>", opts)
keymap("n", "<leader>fg", ":Telescope live_grep<CR>", opts)
keymap("n", "<leader>fb", ":Telescope buffers<CR>", opts)
keymap("n", "<leader>fp", ":Telescope projects<CR>", opts)

-- Treesitter Playground
keymap("n", "<leader>tsp", ":TSPlaygroundToggle<CR>", opts)

-- Comment
keymap("n", "<leader>/", "<cmd>lua require('Comment.api').toggle.linewise.current()<CR>", opts)
keymap("x", "<leader>/", "<esc><cmd>lua require('Comment.api').toggle.linewise(vim.fn.visualmode())<CR>", opts)

-- NORMAL --
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

-- Keep this window
keymap("n", "<Leader>o", "<C-w><C-o>", opts)

-- Replace all on current word and ask confirmation
keymap("n", "<Leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gcI<Left><Left><Left>]], opts)

-- Replace all on current word
keymap("n", "<Leader>S", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]], opts)

-- Split window vertical/horizontal
keymap("n", "<Leader>v", "<C-w>v", opts)
keymap("n", "<Leader>h", "<C-w>s", opts)

-- Stay in place when append line
keymap("n", "J", "mzJ`z", opts)

-- Make current file executable
keymap("n", "<leader>x", "<cmd>!chmod +x %<CR>", opts)

-- INSERT --
-- Press jk fast to enter
keymap("i", "jk", "<ESC>", opts)

-- VISUAL --
-- Stay in indent mode
keymap("v", "<", "<gv", opts)
keymap("v", ">", ">gv", opts)

-- Move block up/down
keymap("v", "J", ":m '>+1<CR>gv=gv", opts)
keymap("v", "K", ":m '<-2<CR>gv=gv", opts)

-- Paste and keep in buffer
-- keymap("x", "<leader>p", "\"_dP", opts)
