---@type vim.lsp.Config
return {
    cmd = { "lua-language-server" },
    filetypes = { "lua" },
    root_markers = {
        ".luarc.json", ".luarc.jsonc", ".luacheckrc",
        ".stylua.toml", "stylua.toml", "selene.toml", "selene.yml", ".git",
    },
    on_init = function(client)
        local root = client.root_dir or ""
        if root:find(vim.fn.stdpath("config"), 1, true) or root:find("/nvim", 1, true) then
            --- @type lspconfig.settings.lua_ls
            local settings = client.config.settings
            settings.Lua.workspace.library = vim.api.nvim_get_runtime_file("lua", true)
            client.config.settings = settings
            client:notify("workspace/didChangeConfiguration", { settings = client.config.settings })
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
