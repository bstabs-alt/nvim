return {
    src = "neovim/nvim-lspconfig",
    data = {
        setup = function()
            vim.lsp.enable({
                "bashls",
                "copilot",
                --"csharp",
                "csskit",
                --"dartls",
                --"eslint",
                "luals",
                "lua_ls",
                "gopls",
                --"helm",
                --"omnisharp",
                --"roslyn_ls",
                "rust_analyzer",
                "systemd_lsp",
                --"tailwindcss",
                "templ",
                "zls",
            })

            require("conform").setup({ formatters_by_ft = {} })

            local cmp = require("cmp")
            local cmp_lsp = require("cmp_nvim_lsp")
            local capabilities = vim.tbl_deep_extend(
                "force",
                {},
                vim.lsp.protocol.make_client_capabilities(),
                cmp_lsp.default_capabilities()
            )

            require("fidget").setup({})
            require("mason").setup()
            require("mason-lspconfig").setup({
                ensure_installed = {
                    "bashls",
                    "lua_ls",
                    "gopls",
                    "systemd_lsp",
                    "vtsls",
                    "zls",
                },
            })

            vim.lsp.config("*", { capabilities = capabilities })
            vim.lsp.config("lua_ls", {
                capabilities = capabilities,
                settings = {
                    Lua = {
                        runtime = {
                            version = "LuaJIT",
                        },
                        diagnostics = {
                            globals = { "vim" },
                        },
                        workspace = {
                            library = {
                                vim.api.nvim_get_runtime_file("", true),
                                vim.fn.expand("$VIMRUNTIME/lua"),
                                vim.fn.expand("$XDG_CONFIG_HOME"),
                            },
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
            })
            vim.lsp.config("zls", {
                capabilities = capabilities,
                root_markers = { "zls.json", "build.zig", ".git" },
                settings = {
                    zls = {
                        enable_inlay_hints = true,
                        enable_snippets = true,
                        warn_style = true,
                    },
                },
            })
            vim.g.zig_fmt_parse_errors = 0
            vim.g.zig_fmt_autosave = 0

            local cmp_select = { behavior = cmp.SelectBehavior.Select }

            cmp.setup({
                sources = cmp.config.sources({
                    { name = "nvim_lsp" },
                }, {
                    { name = "buffer" },
                }),
                mapping = cmp.mapping.preset.insert({
                    ["<C-p>"] = cmp.mapping.select_prev_item(cmp_select),
                    ["<C-n>"] = cmp.mapping.select_next_item(cmp_select),
                    ["<C-y>"] = cmp.mapping.confirm({ select = true }),
                    ["<C-Space>"] = cmp.mapping.complete(),
                }),
            })

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
