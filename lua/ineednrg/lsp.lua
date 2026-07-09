vim.lsp.config("*", {
    capabilities = vim.lsp.protocol.make_client_capabilities(),
})

vim.g.zig_fmt_parse_errors = 0
vim.g.zig_fmt_autosave = 0

vim.lsp.enable({
    "bashls",
    "lua_ls",
    "gopls",
    "rust_analyzer",
    "systemd_lsp",
    "terraformls",
    "templ",
    "zls",
    --"helm","omnisharp","tailwindcss",
})

vim.api.nvim_create_autocmd("BufWritePre", {
    pattern = { "*.zig", "*.zon" },
    callback = function()
        vim.lsp.buf.format()
        --vim.lsp.buf.code_action({
        --    context = { only = { "source.fixAll" } },
        --    apply = true,
        --})
        --vim.lsp.buf.code_action({
        --    context = { only = { "source.organizeImports" } },
        --    apply = true,
        --})
    end,
})

local level = vim.diagnostic.severity
local signs = {
    [level.ERROR] = "E",
    [level.WARN] = "W",
    [level.INFO] = "I",
    [level.HINT] = "H",
}
local hl_map = {
    [level.ERROR] = "DiagnosticSignError",
    [level.WARN] = "DiagnosticSignWarn",
    [level.INFO] = "DiagnosticSignInfo",
    [level.HINT] = "DiagnosticSignHint",
}

vim.diagnostic.config({
    severity_sort = true,
    virtual_text = true,
    float = {
        prefix = "",
        header = "",
        source = true,
        focusable = false,
    },
    status = {
        format = function(severity_counts)
            local items = {}
            for severity in ipairs(vim.diagnostic.severity) do
                local count = severity_counts[severity] or 0
                if count > 0 then
                    table.insert(items, ("%%#%s#%s %s"):format(hl_map[severity], signs[severity], count))
                end
            end
            return table.concat(items, " ")
        end
    },

})
