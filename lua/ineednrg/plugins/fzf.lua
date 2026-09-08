return {
    src = 'https://github.com/ibhagwan/fzf-lua',
    data = {
        setup = function()
            vim.pack.add({ "https://github.com/nvim-tree/nvim-web-devicons" })
            local fzf = require('fzf-lua')
            fzf.setup({
                fzf_colors = true,
                fzf_opts = { ["--cycle"] = true },
                keymap = {
                    fzf = {
                        true,
                        -- Use <a-q> to select all items and add them to the quickfix list
                        ["alt-q"] = "select-all+accept",
                    },
                },
            })

            vim.keymap.set("n", "<leader>pf", FzfLua.files, { desc = "fzf files" })
            vim.keymap.set("n", "<C-p>", FzfLua.git_files, { desc = "fzf git" })
            vim.keymap.set("n", "<leader>ps", function()
                FzfLua.grep({ input_prompt = "grep > " })
            end, { desc = "fzf grep" })
            vim.keymap.set("n", "<leader>pb", FzfLua.buffers, { desc = "fzf buffers" })
            vim.keymap.set("n", "<leader>vh", FzfLua.helptags, { desc = "fzf help" })
        end
    }
}
