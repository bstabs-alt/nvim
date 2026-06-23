-- bash-language-server: npm i -g bash-language-server
---@type vim.lsp.Config
return {
    cmd = { "bash-language-server", "start" },
    filetypes = { "bash", "sh" },
    root_markers = { ".git" },
}
