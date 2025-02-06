return {
    cmd = { 'phpactor', 'language-server' },
    filetypes = { 'php' },
    root_dir = function(pattern)
        local util = require 'lspconfig.util'
        local cwd = vim.loop.cwd()
        local root = util.root_pattern('composer.json', '.git', '.phpactor.json', '.phpactor.yml')(pattern)

        -- prefer cwd if root is a descendant
        return util.path.is_descendant(cwd, root) and cwd or root
    end,
    single_file_support = true,
}
