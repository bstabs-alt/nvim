-- terraform-ls: https://github.com/hashicorp/terraform-ls/releases
---@type vim.lsp.Config
return {
    cmd = { "terraform-ls", "serve" },
    filetypes = { "terraform", "terraform-vars" },
    root_markers = { ".terraform", ".git" },
}
