local M = {
    "williamboman/mason-lspconfig.nvim",
    dependencies = {
        "williamboman/mason.nvim",
    },
}


function M.config()
    local servers = {
        "lua_ls",
        "phpactor",
        "twiggy_language_server",
        "intelephense",
        "cssls",
        "eslint",
        "yamlls",
        "cssmodules_ls",
        "emmet_language_server",
        "html",
        "tsserver",
        "angularls",
        "bashls",
        "jsonls",
        "tailwindcss",
        "rust_analyzer",
        "clangd",
        "marksman",
    }

    require("mason").setup {
        ui = {
            border = "rounded",
        },
    }

    require("mason-lspconfig").setup {
        ensure_installed = servers,
    }
end

return M
