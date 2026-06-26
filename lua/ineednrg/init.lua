require("ineednrg.remap")
require("ineednrg.set")
require("ineednrg.lsp")
require("ineednrg.plugins")

local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd
local usercmd = vim.api.nvim_create_user_command

local nrg_group = augroup('ineednrg', {})
local yank_group = augroup('HighlightYank', {})

vim.filetype.add({ extension = { templ = "templ" } })
vim.filetype.add({ extension = { tfstate = "json" } })

usercmd("GitBlameLine", function()
    local line_number = vim.fn.line(".") -- Get curr line numb. See :h line()
    local filename = vim.api.nvim_buf_get_name(0)
    print(vim.system({ "git", "blame", "-L", line_number .. ",+1", filename }):wait().stdout)
end, { desc = "Print the git blame for the current line" })

autocmd("UIEnter", {
    callback = function()
        vim.o.clipboard = "unnamed,unnamedplus"
    end,
})

-- Highlight when yanking (copying) text -- Try with `yap`
autocmd("TextYankPost", {
    group = yank_group,
    desc = "Highlight when yanking (copying) text",
    callback = function() vim.hl.on_yank() end,
})

-- vertical help - [:vert h <keyword>]
autocmd("FileType", {
    pattern = "help",
    callback = function()
        local w = vim.fn.winwidth(0)
        local h = vim.fn.winheight(0)
        if w >= h then
            vim.cmd [[wincmd L]] -- L key (Right)
        end
    end
})

if vim.fn.executable('fcitx5-remote') == 1 then
    Fcitx5state = vim.system({ "fcitx5-remote" }):wait().stdout:sub(1, 1)
    autocmd("InsertLeave", {
        desc = "Inactivate IME mode",
        pattern = "*",
        callback = function()
            Fcitx5state = vim.system({ "fcitx5-remote" }):wait().stdout:sub(1, 1)
            vim.system({ "fcitx5-remote", "-c" })
        end,
    })
    autocmd("InsertEnter", {
        desc = "Reactivate IME mode",
        pattern = "*",
        callback = function()
            print("InsertEnter: ", Fcitx5state)
            if Fcitx5state == "2" then
                vim.system({ "fcitx5-remote", "-o" })
            end
        end,
    })
end

autocmd("BufWritePre", {
    group = nrg_group,
    pattern = '*',
    command = [[%s/\s\+$//e]],
})

autocmd("QuickFixCmdPost", {
    group = nrg_group,
    pattern = { "grep", "grepadd" },
    command = "cwindow",
})

local _complete_set = vim.api.nvim__complete_set
---@diagnostic disable-next-line: duplicate-set-field
vim.api.nvim__complete_set = function(index, opts)
    local result = _complete_set(index, opts)
    if result and result.winid and vim.api.nvim_win_is_valid(result.winid) then
        ---@type vim.api.keyset.win_config
        local cfg = {
            border = vim.split(vim.o.winborder, ","),
            width = vim.api.nvim_win_get_width(result.winid) - 2,
        }
        cfg = vim.tbl_deep_extend("force", vim.api.nvim_win_get_config(result.winid), cfg)
        vim.api.nvim_win_set_config(result.winid, cfg)
    end
    return result
end

autocmd("LspAttach", {
    group = nrg_group,
    callback = function(ev)
        local client = assert(vim.lsp.get_client_by_id(ev.data.client_id))
        local buf = ev.buf
        --vim.keymap.set("n", "<leader>gd", vim.lsp.buf.definition, { desc = "vim.lsp.buf.definition" })
        --vim.keymap.set("n", "<leader>gD", vim.lsp.buf.declaration, { desc = "vim.lsp.buf.declaration" })
        --vim.keymap.set("n", "<leader>gf", vim.lsp.buf.format, { desc = "vim.lsp.buf.format" })
        --vim.keymap.set("n", "<leader>d", vim.diagnostic.open_float, { desc = "vim.lsp.buf.open_float" })
        --vim.keymap.set("n", "<leader>pw", vim.lsp.buf.workspace_symbol, { desc = "workspace symbol" })
        vim.keymap.set("n", "grh", function()
            vim.lsp.inlay_hint.enable(vim.lsp.inlay_hint.is_enabled())
        end, { desc = "toggle inlay hints" })
        vim.keymap.set("n", "grc", function()
            vim.lsp.inline_completion.enable(vim.lsp.inline_completion.is_enabled())
        end, { desc = "toggle inline completion" })
        vim.keymap.set("n", "grc", function()
            vim.lsp.codelens.enable(vim.lsp.codelens.is_enabled())
        end, { desc = "toggle codelens" })
        -- defaults
        --vim.keymap.set("n", "g0", vim.lsp.buf.document_symbol)
        --vim.keymap.set("i", "c-s", vim.lsp.buf.signature_help)
        --vim.keymap.set("n", "[d", vim.diagnostic.get_prev)
        --vim.keymap.set("n", "]d", vim.diagnostic.get_next)
        if client:supports_method("textDocument/completion") then
            vim.lsp.completion.enable(true, client.id, buf, {
                autotrigger = true,
                --convert = function(item) return { abbr = item.label:gsub('%b()', '') } end
            })
            vim.keymap.set("i", "<BS>", function()
                if vim.fn.pumvisible() == 1 then return "<BS><C-x><C-o>" end
                return "<BS>"
            end, { expr = true, noremap = true })
        end

        autocmd("LspProgress", {
            group = nrg_group,
            buffer = buf,
            callback = function(ev2)
                local val = ev2.data.params.value
                local status = vim.ui.progress_status()
                vim.api.nvim_echo({ { val.message or "done" } }, false, {
                    status = status,
                })
            end
        })

        if not client:supports_method("textDocument/willSaveWaitUntil")
            and client:supports_method("textDocument/formatting")
        then
            autocmd("BufWritePre", {
                group = nrg_group,
                buffer = buf,
                callback = function()
                    vim.lsp.buf.format({ bufnr = buf, id = client.id, timeout_ms = 1000 })
                end,
            })
        end
    end,
})

vim.g.netrw_banner = 0
vim.g.netrw_winsize = 25
