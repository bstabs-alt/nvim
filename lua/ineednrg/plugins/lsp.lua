return {
    src = "neovim/nvim-lspconfig",
    data = {
        setup = function()
            vim.pack.add({
                "https://github.com/neovim/nvim-lspconfig"
                --"https://github.com/j-hui/fidget.nvim",
                --"https://github.com/hrsh7th/nvim-cmp",
                --"https://github.com/hrsh7th/cmp-nvim-lsp",
                --"https://github.com/hrsh7th/cmp-buffer",
                --"https://github.com/hrsh7th/cmp-path",
                --"https://github.com/hrsh7th/cmp-cmdline",
                --"https://github.com/hrsh7th/cmp-nvim-lua",
                --"https://github.com/L3MON4D3/LuaSnip",
                --"https://github.com/saadparwaiz1/cmp_luasnip",
            })

            vim.lsp.enable({
                "bashls",
                "copilot",
                "csskit",
                "lua_ls",
                "gopls",
                --"helm",
                --"omnisharp",
                --"roslyn_ls",
                "rust_analyzer",
                "systemd_lsp",
                --"tailwindcss",
                "terraformls",
                "templ",
                "zls",
            })

            --require("fidget").setup({})

            --local cmp = require("cmp")
            --local cmp_lsp = require("cmp_nvim_lsp")
            -- --- @type vim.lsp.Capability
            local capabilities = vim.tbl_deep_extend(
                "force",
                {},
                vim.lsp.protocol.make_client_capabilities(),
                {} --cmp_lsp.default_capabilities()
            )
            vim.lsp.config("*", { capabilities = capabilities })

            --- @type vim.lsp.Config
            local lua_config = {
                -- --- @type vim.lsp.Capability
                capabilities = capabilities,
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
            vim.lsp.config("lua_ls", lua_config)

            --- @type vim.lsp.Config
            local zls_config = {
                capabilities = capabilities,
                root_markers = { "zls.json", "build.zig", ".git" },
                --- @type lspconfig.settings.zls
                settings = {
                    zls = {
                        enable_inlay_hints = true,
                        enable_snippets = true,
                        warn_style = true,
                    },
                },
            }
            vim.lsp.config("zls", zls_config)
            vim.g.zig_fmt_parse_errors = 0
            vim.g.zig_fmt_autosave = 0

            --local cmp_select = { behavior = cmp.SelectBehavior.Select }

            --cmp.setup({
            --    snippet = {
            --        expand = function(args)
            --            require("luasnip").lsp_expand(args.body)
            --        end,
            --    },
            --    window = {
            --        completion = cmp.config.window.bordered(),
            --        documentation = cmp.config.window.bordered(),
            --    },
            --    sources = cmp.config.sources({
            --        { name = "copilot", group_index = 2 },
            --        { name = "nvim_lsp" },
            --        { name = "path" },
            --        { name = "luasnip" },
            --    }, {
            --        { name = "buffer" },
            --    }),
            --    mapping = cmp.mapping.preset.insert({
            --        ["<C-p>"] = cmp.mapping.select_prev_item(cmp_select),
            --        ["<C-n>"] = cmp.mapping.select_next_item(cmp_select),
            --        ["<C-y>"] = cmp.mapping.confirm({ select = true }),
            --        ["<C-Space>"] = cmp.mapping.complete(),
            --    }),
            --})

            --cmp.setup.cmdline(":", {
            --    mapping = cmp.mapping.preset.cmdline(),
            --    sources = cmp.config.sources({
            --        { name = "path" },
            --    }, {
            --        { name = "cmdline" },
            --    }),
            --    matching = { disallow_symbol_nonprefix_matching = false },
            --})

            vim.diagnostic.config({
                float = {
                    prefix = "",
                    header = "",
                    style = "minimal",
                    border = "rounded",
                    source = true,
                    focusable = false,
                },
            })
        end,
    },
}
