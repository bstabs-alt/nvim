-- systemd-lsp: cargo install systemd-lsp
---@type vim.lsp.Config
return {
    cmd = { "systemd-lsp" },
    filetypes = { "systemd" },
}
