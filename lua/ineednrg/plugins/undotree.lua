return {
    packadd = "nvim.undotree",
    data = {
        setup = function()
            vim.keymap.set("n", "<leader>bu", vim.cmd.Undotree, { desc = "undotree" })
        end
    }
}
