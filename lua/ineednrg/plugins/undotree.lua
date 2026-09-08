return {
    packadd = "nvim.undotree",
    data = {
        setup = function()
            vim.keymap.set("n", "<leader>u", vim.cmd.Undotree, { desc = "undotree" })
        end
    }
}
