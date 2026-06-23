-- rust-analyzer: rustup component add rust-analyzer
---@type vim.lsp.Config
return {
    cmd = { "rust-analyzer" },
    filetypes = { "rust" },
    root_markers = { "Cargo.toml", "rust-project.json", ".git" },
}
