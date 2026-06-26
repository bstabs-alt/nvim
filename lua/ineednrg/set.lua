vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.signcolumn = "yes"

vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.breakindent = true
vim.opt.wrap = false

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

vim.o.completeopt = "menu,menuone,noselect,popup,fuzzy"
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
