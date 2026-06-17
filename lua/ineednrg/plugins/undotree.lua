return {
    src = "https://github.com/mbbill/undotree",
    data = {
        setup = function()
            vim.keymap.set("n", "<leader>u", vim.cmd.UndotreeToggle, { desc = "undotree" })
        end
    }
}
