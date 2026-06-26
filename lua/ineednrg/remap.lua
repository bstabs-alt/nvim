vim.g.mapleader = " "

local map = vim.keymap.set

map("n", "<Esc>", "<cmd>nohlsearch<CR>")
map("t", "<Esc>", "<C-\\><C-n>") -- exit terminal mode

-- Map <A-j>, <A-k>, <A-h>, <A-l> to navigate between windows in any modes
map({ "t", "i" }, "<A-h>", "<C-\\><C-n><C-w>h")
map({ "t", "i" }, "<A-j>", "<C-\\><C-n><C-w>j")
map({ "t", "i" }, "<A-k>", "<C-\\><C-n><C-w>k")
map({ "t", "i" }, "<A-l>", "<C-\\><C-n><C-w>l")
map({ "n" }, "<A-h>", "<C-w>h")
map({ "n" }, "<A-j>", "<C-w>j")
map({ "n" }, "<A-k>", "<C-w>k")
map({ "n" }, "<A-l>", "<C-w>l")

map("n", "<leader><leader>", function() vim.cmd("so") end, { desc = "source" })

map("i", "<C-c>", "<Esc>")
map("n", "Q", "<nop>")

map("n", "<leader>pv", vim.cmd.Ex, { desc = "netrw" })
map("n", "<leader>pf", ":find ", { desc = "builtin find" })
map("n", "<leader>pb", ":b ", { desc = "switch buffer" })
map("n", "<leader>ph", vim.cmd.bprevious, { desc = "prev buffer" })
map("n", "<leader>pl", vim.cmd.bnext, { desc = "next buffer" })

map("n", "<leader>ps", function()
    local q = vim.fn.input("grep > ")
    if q ~= "" then vim.cmd("silent grep " .. vim.fn.fnameescape(q)) end
end, { desc = "builtin grep" })

map("n", "<leader>pq", function()
    for _, w in pairs(vim.fn.getwininfo()) do
        if w.quickfix == 1 then
            vim.cmd.cclose(); return
        end
    end
    vim.cmd.copen()
end, { desc = "toggle quickfix" })

map("n", "<leader>ri", function()
    vim.ui.img.set(vim.fn.readblob(vim.api.nvim_buf_get_name(0)),
        { row = 5, col = 10, width = 100, height = 50, zindex = 50 })
end, { desc = "render img" })
-- <gc>: Toggle comment
-- <gcc>: Toggle comment line

-- Windows terminal paste from clipboard
map("i", "<C-v>", "<C-r>+", { desc = "WinTerm Paste" })
