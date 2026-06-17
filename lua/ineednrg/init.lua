require("ineednrg.remap")
require("ineednrg.set")
require("ineednrg.plugins")

local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

local nrg_group = augroup('ineednrg', {})
local yank_group = augroup('HighlightYank', {})

vim.api.nvim_create_user_command("GitBlameLine", function()
    local line_number = vim.fn.line(".") -- Get curr line numb. See :h line()
    local filename = vim.api.nvim_buf_get_name(0)
    print(vim.system({ "git", "blame", "-L", line_number .. ",+1", filename }):wait().stdout)
end, { desc = "Print the git blame for the current line" })

--vim.cmd("packadd! nohlsearch")

vim.filetype.add({ extension = { templ = "templ" } })

autocmd("UIEnter", {
    callback = function() vim.o.clipboard = "unnamedplus" end,
})

-- Highlight when yanking (copying) text -- Try with `yap`
autocmd("TextYankPost", {
    group = yank_group,
    desc = "Highlight when yanking (copying) text",
    callback = function() vim.hl.on_yank() end,
})

-- vertical help - [:vert h <keyword>]
--autocmd("FileType", {})

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

autocmd("LspAttach", {
    group = nrg_group,
    callback = function(ev)
        local client = assert(vim.lsp.get_client_by_id(ev.data.client_id))
        if client:supports_method("textDocument/implementation") then
            vim.keymap.set("n", "gd", vim.lsp.buf.definition)
            vim.keymap.set("n", "gD", vim.lsp.buf.declaration)
            vim.keymap.set("n", "gf", vim.lsp.buf.format)
            -- Some defaults
            --vim.keymap.set("n", "gra", vim.lsp.buf.code_action)
            --vim.keymap.set("n", "gri", vim.lsp.buf.implementation)
            --vim.keymap.set("n", "grn", vim.lsp.buf.rename)
            --vim.keymap.set("n", "grr", vim.lsp.buf.references)
            --vim.keymap.set("n", "grt", vim.lsp.buf.type_definition)
            --vim.keymap.set("n", "grx", vim.lsp.codelens.run)
            --vim.keymap.set("n", "g0", vim.lsp.buf.document_symbol)
            --vim.keymap.set("i", "c-s", vim.lsp.buf.signature_help)
        end

        vim.cmd [[set completeopt+=menuone,noselect,popup]]
        vim.lsp.completion.enable(true, client.id, ev.buf, {
            autotrigger = true,
            convert = function(item)
                return { abbr = item.label:gsub('%b()', '') }
            end
        })

        if not client:supports_method("textDocument/willSaveWaitUntil")
            and client:supports_method("textDocument/formatting")
        then
            autocmd("BufWritePre", {
                group = nrg_group,
                buffer = ev.buf,
                callback = function()
                    vim.lsp.buf.format({ bufnr = ev.buf, id = client.id, timeout_ms = 1000 })
                end,
            })
        end
    end,
})

vim.g.netrw_banner = 0
vim.g.netrw_winsize = 25
