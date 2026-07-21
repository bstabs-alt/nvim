-- Installed via cargo
---@type vim.lsp.Config
return {
    cmd = { "asm-lsp" },
    filetypes = { "asm", "s", "S", "vmasm" },
    root_markers = { ".asm-lsp.toml", ".git" },
    ---@type lspconfig.settings.asm_lsp
    settings = {
        asm_lsp = {
        },
    },
}
