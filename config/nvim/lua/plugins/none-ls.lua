local M = {
    "nvimtools/none-ls.nvim",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "nvimtools/none-ls-extras.nvim",
    }
}

function M.config()
    local null_ls = require "null-ls"

    local formatting = null_ls.builtins.formatting
    local diagnostics = null_ls.builtins.diagnostics
    local completion = null_ls.builtins.completion

    null_ls.setup {
        debug = false,
        sources = {
            formatting.stylua,
            formatting.prettierd,
            formatting.black,
            require("none-ls.code_actions.eslint"),
            formatting.phpcsfixer,
            diagnostics.twigcs,
            -- formatting.twig_cs_fixer,
        },
    }
end

return M
