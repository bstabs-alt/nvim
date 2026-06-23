---@type vim.lsp.Config
return {
    cmd = { "zls" },
    filetypes = { "zig", "zir" },
    root_markers = { "zls.json", "build.zig", ".git" },
    --- @type lspconfig.settings.zls
    settings = {
        zls = {
            enable_inlay_hints = true,
            enable_snippets = true,
            warn_style = true,
        },
    },
}
