local M = {
    "nvim-treesitter/nvim-treesitter",
    version = "v0.9.x",
    build = function()
        require("nvim-treesitter.install").update({ with_sync = true })
    end,
}
function M.config()
  local treesitter = require "nvim-treesitter"
  local configs = require "nvim-treesitter.configs"

  configs.setup {
    ensure_installed = { "javascript", "c", "html", "bash", "cpp", "css", "comment", "gitignore", "git_config", "git_rebase", "json", "json5", "lua", "markdown", "markdown_inline", "php", "phpdoc", "rust", "scss", "sql", "tsx", "typescript", "twig", "vim", "vimdoc", "yaml", "toml", "slint", "regex", "python" },
    sync_install = false,
    auto_install = true,

    highlight = {
        enable = true,
	disable = { "" },
    },

    autopairs = {
        enable = true,
	disable = { "" },
    },

    indent = { 
	enable = true, 
	disable = { "" },
    },

    context_commentstring = {
      enable = true,
      enable_autocmd = false,
    },
  }
end

return { M }
