---@type vim.lsp.Config
return {
    cmd = { "lua-language-server" },
    filetypes = { "lua" },
    root_markers = { ".luarc.json", ".luarc.jsonc", ".luacheckrc", ".stylua.toml", "stylua.toml", "selene.toml", "selene.yml", ".git" },
    on_init = function(client, _)
        local root = client.root_dir or ""
        if root:find(vim.fn.stdpath("config"), 1, true) or root:find("/nvim", 1, true) then
            local settings = client.config.settings --- @type lspconfig.settings.lua_ls
            --settings.Lua.workspace.library = vim.api.nvim_get_runtime_file("lua", true)
            settings = vim.tbl_deep_extend('force', client.config.settings,
                { Lua = { workspace = { library = vim.api.nvim_get_runtime_file("lua", true) } } })
            client:notify("workspace/didChangeConfiguration", client.config.settings)
        end
    end,
    --- @type lspconfig.settings.lua_ls
    settings = {
        Lua = {
            runtime = { version = "LuaJIT" },
            diagnostics = { globals = { "vim" } },
            workspace = {
                library = {},
                checkThirdParty = false,
            },
            format = {
                enable = true,
                defaultConfig = {
                    indent_style = "space",
                    indent_size = "2",
                },
            },
        },
    },
}
