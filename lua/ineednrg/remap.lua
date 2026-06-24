vim.g.mapleader = " "

vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")
vim.keymap.set("t", "<Esc>", "<C-\\><C-n>") -- exit terminal mode

-- Map <A-j>, <A-k>, <A-h>, <A-l> to navigate between windows in any modes
vim.keymap.set({ "t", "i" }, "<A-h>", "<C-\\><C-n><C-w>h")
vim.keymap.set({ "t", "i" }, "<A-j>", "<C-\\><C-n><C-w>j")
vim.keymap.set({ "t", "i" }, "<A-k>", "<C-\\><C-n><C-w>k")
vim.keymap.set({ "t", "i" }, "<A-l>", "<C-\\><C-n><C-w>l")
vim.keymap.set({ "n" }, "<A-h>", "<C-w>h")
vim.keymap.set({ "n" }, "<A-j>", "<C-w>j")
vim.keymap.set({ "n" }, "<A-k>", "<C-w>k")
vim.keymap.set({ "n" }, "<A-l>", "<C-w>l")

vim.keymap.set("n", "<leader><leader>", function()
    vim.cmd("so")
end, { desc = "source" })

vim.keymap.set("i", "<C-c>", "<Esc>")
vim.keymap.set("n", "Q", "<nop>")

vim.keymap.set("n", "<leader>pv", vim.cmd.Ex, { desc = "netrw" })
vim.keymap.set("n", "<leader>pg", vim.cmd.Git, { desc = "git" })

vim.keymap.set("n", "<leader>pb", ":b ", { desc = "switch buffer" })
vim.keymap.set("n", "<leader>ph", vim.cmd.bprevious, { desc = "prev buffer" })
vim.keymap.set("n", "<leader>pl", vim.cmd.bnext, { desc = "next buffer" })

vim.keymap.set("n", "<leader>pf", ":find ", { desc = "builtin find" })

vim.keymap.set("n", "<leader>ps", function()
    local q = vim.fn.input("grep > ")
    if q ~= "" then vim.cmd("silent grep " .. vim.fn.fnameescape(q)) end
end, { desc = "builtin grep" })

vim.keymap.set("n", "<leader>pq", function()
    for _, w in pairs(vim.fn.getwininfo()) do
        if w.quickfix == 1 then
            vim.cmd.cclose()
            return
        end
    end
    vim.cmd.copen()
end, { desc = "toggle quickfix" })

-- <gc>: Toggle comment
-- <gcc>: Toggle comment line

-- Windows terminal paste from clipboard
vim.keymap.set("i", "<C-v>", "<C-r>+", { desc = "WinTerm Paste" })
