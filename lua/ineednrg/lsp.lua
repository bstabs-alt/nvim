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

vim.diagnostic.config({
    float = {
        prefix = "",
        header = "",
        source = true,
        focusable = false,
    },
})
