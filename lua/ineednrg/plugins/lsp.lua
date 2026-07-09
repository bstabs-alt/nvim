return {
    src = "https://github.com/neovim/nvim-lspconfig",
    data = {
        setup = function()
            vim.pack.add({
                'https://github.com/hrsh7th/cmp-nvim-lsp',
                'https://github.com/hrsh7th/cmp-buffer',
                'https://github.com/hrsh7th/cmp-path',
                'https://github.com/hrsh7th/cmp-cmdline',
                'https://github.com/hrsh7th/nvim-cmp',
                --For vsnip users.
                -- 'hrsh7th/cmp-vsnip'
                -- 'hrsh7th/vim-vsnip'
                --For luasnip users.
                -- 'L3MON4D3/LuaSnip'
                -- 'saadparwaiz1/cmp_luasnip'
                --For mini.snippets users.
                -- 'echasnovski/mini.snippets'
                -- 'abeldekat/cmp-mini-snippets'
                --For ultisnips users.
                -- 'SirVer/ultisnips'
                -- 'quangnguyen30192/cmp-nvim-ultisnips'
                --For snippy users.
                -- 'dcampos/nvim-snippy'
                -- 'dcampos/cmp-snippy'
            })

            vim.lsp.enable({
                -- npm install -g azure-pipelines-language-server
                "azure_pipelines_ls",
                -- dotnet tools install --global roslyn-language-server --prerelease
                "roslyn_ls",
                -- npm install -g @tailwindcss/language-server
                "tailwindcss"
            })

            local cmp = require("cmp")
            local capabilities = require("cmp_nvim_lsp").default_capabilities()
            vim.lsp.config("*", { capabilities = capabilities })

            cmp.setup({
                snippet = {},

            })
        end
    }
}
