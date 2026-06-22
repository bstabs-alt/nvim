return {
    src = 'https://github.com/ibhagwan/fzf-lua',
    data = {
        setup = function()
            require('fzf-lua').setup { fzf_colors = true }
            vim.keymap.set("n", "<leader>pf", FzfLua.files, { desc = "fzf files" })
        end
    }
}
