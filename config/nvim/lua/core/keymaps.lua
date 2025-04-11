local keymap = vim.keymap.set
local opts = { silent = true }

-- Disable anoying stuff
keymap("n", "q:", "<nop>", opts)
keymap("n", "q", "<nop>", opts)
keymap("v", "q:", "<nop>", opts)
keymap("v", "q", "<nop>", opts)

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

-- Close window
keymap("n", "<Leader>q", "<C-w>q", opts)

-- Replace all on current word and ask confirmation
keymap("n", "<Leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gcI<Left><Left><Left><Left>]], opts)

-- Replace all on current word
keymap("n", "<Leader>S", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]], opts)

-- Split window vertical/horizontal
keymap("n", "<Leader>v", "<C-w>v", opts)
keymap("n", "<Leader>h", "<C-w>s", opts)

-- Stay in place when append line
keymap("n", "J", "mzJ`z", opts)

-- Make current file executable
keymap("n", "<Leader>x", "<cmd>!chmod +x %<CR>", opts)

-- Comment line
keymap("n", "<Leader>/", "gcc", { silent = true, remap = true })

-- Press jk fast to go back to normal mode
keymap("i", "jk", "<ESC>", opts)

-- Stay in indent mode
keymap("v", "<", "<gv", opts)
keymap("v", ">", ">gv", opts)

-- Move block up/down
keymap("x", "J", ":m '>+1<CR><CR>gv=gv", opts)
keymap("x", "K", ":m '<-2<CR><CR>gv=gv", opts)

-- Comment selection
keymap("x", "<Leader>/", "gc", { silent = true, remap = true })
