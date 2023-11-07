local function gitBranch()
    local branch = vim.fn.system("git rev-parse --abbrev-ref HEAD 2>/dev/null | tr -d '\n'")
    if string.len(branch) > 0 then
        return branch
    else
        return ":"
    end
end

local clients_lsp = function ()
    local bufnr = vim.api.nvim_get_current_buf()
    local clients = vim.lsp.get_clients({buffer = bufnr})

    if next(clients) == nil then
        return ''
    end

    local c = {}

    for _, client in pairs(clients) do
        table.insert(c, client.name)
    end

    return  table.concat(c, '|')
end

local function statusline()
    local set_color_1 = "%#PmenuSel#"
    local branch = gitBranch()
    local set_color_2 = "%#LineNr#"
    local file_name = " %f"
    local modified = "%m"
    local align_right = "%="
    local filetype = " %y"
    local lsp_client = clients_lsp
    local line = "%l/%L"

    return string.format(
        "%s %s %s%s%s%s%s%s",
        set_color_1,
        branch,
        set_color_2,
        file_name,
        modified,
        align_right,
        filetype,
        line
    )
end

vim.opt.statusline = statusline()
