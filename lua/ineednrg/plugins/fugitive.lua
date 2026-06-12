return {
	src = "https://github.com/tpope/vim-fugitive",
    data = {
        setup = function()
vim.keymap.set("n", "<leader>gs", vim.cmd.Git, {desc = "fugitive.git"})
end
}
}
