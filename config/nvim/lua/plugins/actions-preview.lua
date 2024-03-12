local M = {
    "aznhe21/actions-preview.nvim",
}

function M.config()
    vim.keymap.set({ "v", "n" }, "<leader>ca", require("actions-preview").code_actions)
end

return M
