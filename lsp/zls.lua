---@type vim.lsp.Config
return {
    cmd = { "zls" },
    filetypes = { "zig", "zir" },
    root_markers = { "zls.json", "build.zig", ".git" },
    --- @type lspconfig.settings.zls
    settings = {
        zls = {
            path = "/home/ineednrg/vendor/zls/zig-out/bin/",
            enable_autofix = true,
            enable_import_embedfile_argument_completions = true,
            enable_inlay_hints = true,
            warn_style = true,
            inlay_hints_hide_redundant_param_names = true,
            inlay_hints_hide_redundant_param_names_last_token = true,
            include_at_in_builtins = true,
            use_comptime_interpreter = true,
        },
    },
}
