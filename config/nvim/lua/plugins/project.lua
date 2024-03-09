local M = {
    "ahmedkhalf/project.nvim",
    dependencies = {
        {
            "nvim-telescope/telescope.nvim",
            event = "Bufenter",
            cmd = { "Telescope" },
        },
    },
}

function M.config()
    local project = require "project_nvim"
    -- local nvim_tree = require "nvim-tree"
    local telescope = require "telescope"

    project.setup {

        -- detection_methods = { "lsp", "pattern" }, -- NOTE: lsp detection will get annoying with multiple langs in one project
        detection_methods = { "pattern" },

        -- patterns used to detect root dir, when **"pattern"** is in detection_methods
        patterns = { ".git", "Makefile", "package.json" },
    }
    -- nvim_tree.setup {
    --     sync_root_with_cwd = true,
    --     respect_buf_cwd = true,
    --     update_focused_file = {
    --         enable = true,
    --         update_root = true
    --     },
    -- }

    telescope.load_extension "projects"
end

return M
