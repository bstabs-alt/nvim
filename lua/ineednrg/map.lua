local map = vim.keymap.set
vim.g.mapleader = " "

--[[
-- Leader Mappings:
-- p = project
-- b = buffer
-- v = vim
-- g = global
--
-- Built-in Mappings:
-- ["n", "v"], "gc", "toggle comment"
-- ["n", "v"], "gcc", "toggle comment line"
-- "i", "<C-v>digit[u|U]", "unicode 4 and 8 bytes respectively"
-- "i", "<C-U>", "unicode input with ghostty"
--]]

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

map("i", "<C-c>", "<Esc>")
map("n", "U", "<c-r>")
map("n", "Q", "<nop>")
map("v", ">", ">gv", { desc = "> retain visual selection" })
map("v", "<", "<gv", { desc = "< retaun visual selection" })

map("n", "<leader><leader>", function() vim.cmd("so") end, { desc = "source" })
map("n", "<leader>pv", vim.cmd.Ex, { desc = "netrw" })

map({ "n", "t" }, "<leader>bb", ":b ", { desc = "switch buffer" })
map({ "n", "t" }, "<leader>bs", ":buffers ", { desc = "show buffers" })
map({ "n", "t" }, "<leader>bj", vim.cmd.bprevious, { desc = "prev buffer" })
map({ "n", "t" }, "<leader>bk", vim.cmd.bnext, { desc = "next buffer" })

map({ "n", "t" }, "<leader>bt", vim.cmd.tabnew, { desc = "new tab" })
map({ "n", "t" }, "<leader>bh", vim.cmd.tabprevious, { desc = "prev tab" })
map({ "n", "t" }, "<leader>bl", vim.cmd.tabnext, { desc = "next tab" })

map("n", "<leader>pf", ":find ", { desc = "builtin find" })
map("n", "<leader>ps", function()
    local q = vim.fn.input("grep > ")
    if q ~= "" then
        vim.cmd("silent grep " .. vim.fn.fnameescape(q))
    end
end, { desc = "builtin grep" })

map("n", "<leader>qf", function()
    for _, w in pairs(vim.fn.getwininfo()) do
        if w.quickfix == 1 then
            vim.cmd.cclose()
            return
        end
    end
    vim.cmd.copen()
end, { desc = "toggle quickfix" })

map("n", "<leader>qp", function()
    for _, w in pairs(vim.fn.getwininfo()) do
        if w.quickfix == 1 then vim.cmd.cprev() end
    end
end, { desc = "prev quickfix" })

map("n", "<leader>qn", function()
    for _, w in pairs(vim.fn.getwininfo()) do
        if w.quickfix == 1 then vim.cmd.cnext() end
    end
end, { desc = "next quickfix" })

map("n", "<leader>ll", function()
    for _, w in pairs(vim.fn.getwininfo()) do
        if w.quickfix == 1 then
            vim.cmd.cclose()
            return
        end
    end
    vim.cmd.copen()
end, { desc = "toggle loclist" })

map("n", "<leader>lp", function()
    for _, w in pairs(vim.fn.getwininfo()) do
        if w.quickfix == 1 then vim.cmd.lprev() end
    end
end, { desc = "prev loclist" })

map("n", "<leader>ln", function()
    for _, w in pairs(vim.fn.getwininfo()) do
        if w.loclist == 1 then vim.cmd.lnext() end
    end
end, { desc = "next loclist" })

map("n", "<leader>vi", function()
    -- This is a test once the builtin image api is available
    vim.ui.img.set(vim.fn.readblob(vim.api.nvim_buf_get_name(0)), {
        row = 5, col = 10, width = 100, height = 50, zindex = 50
    })
end, { desc = "render img" })

local notes = vim.fn.expand("~/notes/all-things-one-place")
map("n", "<leader>gv", "<cmd>edit" .. notes .. "/index.md<CR>:lcd %:p:h<CR>", { desc = "open notes" })

local surround_opts = {
    ["{"] = "}",
    ["["] = "]",
    ["("] = ")",
    ["<"] = ">",
}
map("v", "<leader>s", function()
    local start_pos = vim.fn.getpos(".")
    local end_pos = vim.fn.getpos("v")
    local text = vim.api.nvim_buf_get_text(0, start_pos[2] - 1, start_pos[3] - 1, end_pos[2] - 1, end_pos[3] - 1, {})

    local lhs = vim.fn.input("")
    local rhs = surround_opts[lhs] or ""
    if rhs == "" then return end
    text[1] = lhs .. text[1]
    text[#text] = text[#text] .. rhs

    vim.api.nvim_buf_set_text(0, start_pos[2] - 1, start_pos[3] - 1, end_pos[2] - 1, end_pos[3] - 1, text)
end, { desc = "surround selection" })

-- dsfds dsf sdf dsf sd
-- Windows terminal paste from clipboard
if vim.fn.has("wsl") == 1 then
    map("i", "<C-v>", "<C-r>+", { desc = "WinTerm Paste" })
end
