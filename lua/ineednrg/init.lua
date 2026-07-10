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

usercmd("RunZig", function()
    local filename = vim.api.nvim_buf_get_name(0)
    print(vim.system({ "zig", "run", filename }):wait().stdout)
end, { desc = "Run code" })

usercmd("LspCompletionInfo", function(args)
    local pos_params = vim.lsp.util.make_position_params(0, "utf-8")
    vim.lsp.buf_request(0, 'textDocument/completion', pos_params, function(_, result)
        vim.fn.setreg(args.reg or "*", vim.inspect(result))
    end)
end, { desc = "Get LSP completion info for the current buffer" })

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
    group = nrg_group,
    pattern = "help",
    callback = function()
        local w = vim.fn.winwidth(0)
        local h = vim.fn.winheight(0)
        -- L key (Right)
        if w >= h then vim.cmd [[wincmd L]] end
    end
})

if vim.fn.executable('fcitx5-remote') == 1 then
    Fcitx5state = vim.system({ "fcitx5-remote" }):wait().stdout:sub(1, 1)
    autocmd("InsertLeave", {
        group = nrg_group,
        desc = "Inactivate IME mode",
        pattern = "*",
        callback = function()
            Fcitx5state = vim.system({ "fcitx5-remote" }):wait().stdout:sub(1, 1)
            vim.system({ "fcitx5-remote", "-c" })
        end,
    })
    autocmd("InsertEnter", {
        group = nrg_group,
        desc = "Reactivate IME mode",
        pattern = "*",
        callback = function()
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

local function set_floating_win_cfg(winid)
    if winid and vim.api.nvim_win_is_valid(winid) then
        vim.api.nvim_win_set_config(winid, {
            border = vim.split(vim.o.winborder, ",") or "rounded",
            width = math.min(60, vim.api.nvim_win_get_width(winid)),
            height = math.min(15, vim.api.nvim_win_text_height(winid, {}).all),
            style = "minimal",
        })
    end
end

-- Add border to first completion item without having to add a delay on CompleteChanged
local complete_set = vim.api.nvim__complete_set
---@diagnostic disable-next-line: duplicate-set-field
vim.api.nvim__complete_set = function(index, opts)
    local item = complete_set(index, opts)
    if item then
        set_floating_win_cfg(item.winid)
    end
    return item
end

autocmd("CompleteChanged", {
    group = nrg_group,
    callback = function()
        local info = vim.fn.complete_info({ "selected" })
        set_floating_win_cfg(info.preview_winid)
    end
})

autocmd("LspAttach", {
    group = nrg_group,
    callback = function(ev)
        local client = assert(vim.lsp.get_client_by_id(ev.data.client_id))
        local buf = ev.buf
        -- defaults
        --vim.keymap.set("n", "g0", vim.lsp.buf.document_symbol)
        --vim.keymap.set("i", "c-s", vim.lsp.buf.signature_help)
        --vim.keymap.set("n", "[d", vim.diagnostic.get_prev)
        --vim.keymap.set("n", "]d", vim.diagnostic.get_next)
        vim.keymap.set("n", "<leader>gd", vim.lsp.buf.definition, { desc = "vim.lsp.buf.definition" })
        --vim.keymap.set("n", "<leader>gD", vim.lsp.buf.declaration, { desc = "vim.lsp.buf.declaration" })
        vim.keymap.set("n", "grf", vim.lsp.buf.format, { desc = "vim.lsp.buf.format" })
        vim.keymap.set("n", "<leader>d", vim.diagnostic.open_float, { desc = "vim.lsp.buf.open_float" })
        --vim.keymap.set("n", "<leader>pw", vim.lsp.buf.workspace_symbol, { desc = "workspace symbol" })

        vim.keymap.set("n", "glh", function()
            vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
        end, { desc = "toggle inlay hints", buf = buf })

        vim.keymap.set("n", "glc", function()
            vim.lsp.codelens.enable(not vim.lsp.codelens.is_enabled())
        end, { desc = "toggle codelens", buf = buf })

        vim.keymap.set("n", "gli", function()
            vim.lsp.inline_completion.enable(not vim.lsp.inline_completion.is_enabled())
        end, { expr = true, desc = "inline completion" })

        vim.keymap.set("i", "<Tab>", function()
            if not vim.lsp.inline_completion.get() then
                return "<Tab>"
            end
        end, { expr = true, desc = "inline completion" })

        if client:supports_method("textDocument/completion") then
            vim.lsp.completion.enable(true, client.id, buf, {
                autotrigger = true,
                --convert = function(item) return { abbr = item.label:gsub('%b()', '') } end
            })

            vim.keymap.set("i", "<BS>", function()
                if vim.fn.pumvisible() == 1 then
                    return "<BS><C-x><C-o>"
                end
                return "<BS>"
            end, { expr = true, noremap = true })
        end

        autocmd("LspProgress", {
            group = nrg_group,
            buffer = buf,
            callback = function(args)
                local val = args.data.params.value
                _G.set_lsp_progress(args.data.client_id, client.name, val.message)
                vim.cmd("redrawstatus")
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
