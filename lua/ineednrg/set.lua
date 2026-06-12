vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.signcolumn = 'yes'

vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.breakindent = true

vim.opt.list = true -- Show <tab> and trailing spaces.
vim.opt.listchars = { tab = '  ', trail = '·', nbsp = '␣' }

vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile = true

vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.smartindent = true

vim.opt.hlsearch = false
vim.opt.incsearch = true

vim.opt.updatetime = 250
vim.opt.timeoutlen = 300
vim.opt.splitright = true
vim.opt.splitbelow = true

vim.opt.inccommand = 'split' -- preview substitute
vim.opt.cursorline = true -- Highlight the line where the cursor is on.
vim.opt.scrolloff = 10 -- Keep this many screen lines above/below the cursor.
vim.opt.confirm = true
