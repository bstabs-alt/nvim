return {
    src = 'https://github.com/ibhagwan/fzf-lua',
    data = {
        setup = function()
            vim.pack.add({ "https://github.com/nvim-tree/nvim-web-devicons" })

            require('fzf-lua').setup({
                fzf_colors = true,
            })

            vim.keymap.set("n", "<leader>pf", FzfLua.files, { desc = "fzf files" })
            vim.keymap.set("n", "<leader>pg", FzfLua.grep, { desc = "fzf grep" })
        end
    }
}
