return {
    src = "https://github.com/neovim/nvim-lspconfig",
    data = {
        setup = function()
            vim.pack.add({
                'https://github.com/neovim/nvim-lspconfig',
                --    'https://github.com/hrsh7th/cmp-nvim-lsp',
                --    'https://github.com/hrsh7th/cmp-buffer',
                --    'https://github.com/hrsh7th/cmp-path',
                --    'https://github.com/hrsh7th/cmp-cmdline',
                --    'https://github.com/hrsh7th/nvim-cmp',
                'https://github.com/L3MON4D3/LuaSnip',
                -- 'saadparwaiz1/cmp_luasnip'
            })
            local luasnip = require("luasnip")

            --local cmp = require("cmp")
            --local capabilities = require("cmp_nvim_lsp").default_capabilities()
            --vim.lsp.config("*", { capabilities = capabilities })

            --cmp.setup({
            --    snippet = {},
            --})
        end
    }
}
