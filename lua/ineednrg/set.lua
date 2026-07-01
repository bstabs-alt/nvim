vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.signcolumn = "yes"

vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.breakindent = true
vim.opt.wrap = true

vim.opt.list = true -- Show <tab> and trailing spaces.
vim.opt.listchars = { tab = "  ", trail = "·", nbsp = "␣" }

vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile = true

vim.opt.hlsearch = false
vim.opt.incsearch = true

vim.opt.updatetime = 100
vim.opt.timeoutlen = 500
vim.o.laststatus = 2
vim.opt.splitright = true
vim.opt.splitbelow = true
vim.o.splitkeep = "screen"

vim.opt.inccommand = "split" -- preview substitute
vim.opt.cursorline = true    -- Highlight the line where the cursor is on.
vim.opt.scrolloff = 8        -- Keep this many screen lines above/below the cursor.
vim.opt.confirm = true
vim.opt.isfname:append("@-@")

--local symbols = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" }
local symbols = { "🭽", "▔", "🭾", "▕", "🭿", "▁", "🭼", "▏" }
local border = table.concat(symbols, ',')
vim.o.winborder = border
vim.o.winblend = 0
vim.o.pumborder = border
vim.o.pumblend = 0
vim.o.pumheight = 8
vim.o.pummaxwidth = 60

vim.o.completeopt = "menu,menuone,noselect,popup,fuzzy,preview"
vim.o.complete = ""

vim.o.showtabline = 1
vim.o.showmode = false

vim.opt.path:append("**") -- :find searches recursively from cwd
vim.opt.wildmenu = true
vim.opt.wildmode = "longest:full,full"
vim.o.wildoptions = "fuzzy,pum,tagfile"
vim.opt.wildignore:append({ "*/.git/*", "*/node_modules/*", "*/target/*" })

if vim.fn.executable("rg") then
    vim.o.grepprg = "rg --vimgrep --smart-case"
    vim.o.grepformat = "%f:%l:%c:%m"
end

local icon = {
    vim = "",
    v = "",
    star = "𐫰",
    git = {
        branch = '⎇'
    },
    lsp = {
        default = "■",
        lua = "o",
    },
    gt = {
        s = "❭",
        m = "❯",
        l = "❱",
        x = "⇒",
    },
    lt = {
        s = "❬",
        m = "❮",
        l = "❰",
    },
}
local modes = {
    n = "NORMAL",
    i = "INSERT",
    v = "VISUAL",
    V = "V-LINE",
    [""] = "V-BLOCK", -- Visual Block
    c = "COMMAND",
    t = "TERMINAL",
    R = "REPLACE",
    r = "R-PENDING",
}

function _G.set_tabline()
    local line = { "%#TabLineFill# ", icon.vim, " %<" }
    local curr = vim.api.nvim_get_current_tabpage()
    for _, tab_id in ipairs(vim.api.nvim_list_tabpages()) do
        if not vim.api.nvim_tabpage_is_valid(tab_id) then break end

        local win_ids = vim.api.nvim_tabpage_list_wins(tab_id)
        for i = #win_ids, 1, -1 do
            if vim.api.nvim_win_get_config(win_ids[i]).relative ~= "" then
                table.remove(win_ids, i)
            end
        end

        local tab_num = tostring(vim.api.nvim_tabpage_get_number(tab_id))
        local tab = {
            (curr == tab_id and "%#Visual# " or " "),
            "%",
            tab_num,
            "T",
            tab_num,
            (#win_ids > 1 and "  " .. #win_ids or ""),
            " X ",
            "%T%#TabLineFill# "
        }
        for i = 1, #tab do
            line[#line + 1] = tab[i]
        end
    end
    line[#line + 1] = "%=%#TabLineSel#"
    return table.concat(line)
end

vim.o.showtabline = 2
vim.go.tabline = [[%!v:lua.set_tabline()]]

vim.o.winbar = "%#Visual# %t %#Normal#%=%#Visual# %{&filetype} "

_G.lsp_progress = {}

_G.set_lsp_progress = function(id, name, msg)
    _G.lsp_progress[id] = name .. " [" .. (msg or "A") .. "] "
end

_G.get_lsp_progress = function()
    return table.concat(vim.tbl_values(_G.lsp_progress), "")
end

_G.get_git_branch = function()
    local url = vim.system({ "git", "config", "get", "remote.origin.url" }):wait().stdout or ""
    local repo = string.match(url, "/(%a+).git")
    local branch = vim.system({ "git", "rev-parse", "--abbrev-ref", "HEAD" }):wait().stdout:gsub("\n$", "")
    if repo == "" then return branch end
    return string.format("%s/%s", repo, branch)
end

function _G.set_statusbar()
    return table.concat({
        "%#FloatShadow# ",
        icon.v,
        " ",
        modes[vim.api.nvim_get_mode().mode] or "",
        " %#Visual# ",
        icon.git.branch,
        " ",
        _G.get_git_branch(),
        " %#StatusLineNC#",
        "%< ",
        icon.gt.l,
        " ",
        vim.fn.fnamemodify(vim.fn.getcwd(0, 0), ":~"),
        " ",
        icon.gt.m,
        " %t",
        " %h%w%m%r",
        "%=",
        --(icon.lsp[vim.api.nvim_eval_statusline("%{&filetype}",{}).str ] or icon.lsp.default),
        _G.get_lsp_progress(),
        (_G.get_lsp_progress() ~= "" and icon.lt.l or ""),
        " %#Visual#",
        " %l:%-c%V ",
        "%#FloatShadow# ",
        icon.star,
        "  %p%% ",
        "%#StatusLine#",
    })
end

vim.o.statusline = [[%!v:lua.set_statusbar()]]
