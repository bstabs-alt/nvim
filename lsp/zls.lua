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
            inlay_hints_hide_redundant_param_names = true,
            include_at_in_builtins = true,
            use_comptime_interpreter = true,
        },
    },
}
