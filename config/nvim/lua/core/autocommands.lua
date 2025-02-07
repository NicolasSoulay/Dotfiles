local keymap = vim.keymap.set

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
vim.api.nvim_create_autocmd("BufEnter", {
	callback = function()
		-- Get directory path to start search from
		local path = vim.api.nvim_buf_get_name(0)
		-- If path is empty, return
		if path == "" then
			return
		end
		-- if path start with  oil:// then trim it
		if path:match("^oil://") then
			path = path:sub(7)
		end

		path = vim.fs.dirname(path)

		local root_file = vim.fs.find({ ".git", "Makefile", "package.json" }, { path = path, upward = true })[1]
		if root_file == nil then
			return
		end
		local root = vim.fs.dirname(root_file)

		-- Set current directory
		vim.fn.chdir(root)
	end,
})
