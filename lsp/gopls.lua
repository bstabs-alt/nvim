-- gopls: go install golang.org/x/tools/gopls@latest
---@type vim.lsp.Config
return {
    cmd = { "gopls" },
    filetypes = { "go", "gomod", "gowork", "gotmpl" },
    root_markers = { "go.work", "go.mod", ".git" },
}
