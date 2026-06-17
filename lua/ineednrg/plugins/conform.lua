return {
    src = "https://github.com/stevearc/conform.nvim",
    data = {
        setup = function()
            require("conform").setup({
                format_on_save = {
                    timeout_ms = 500, --5000,
                    lsp_format = "fallback",
                },
                formatters_by_ft = {
                    bash = { "shfmt" },
                    c = { "clang-format" },
                    lua = { "stylua" },
                    go = { "gofmt" },
                },
            })

            vim.keymap.set("n", "<leader>f", function()
                require("conform").format({ bufnr = 0 })
            end, { desc = "conform format" })
        end
    }
}
