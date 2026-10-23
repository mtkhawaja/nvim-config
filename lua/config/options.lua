local o = vim.o

o.number = true
o.relativenumber = true
o.signcolumn = 'yes'
o.cursorline = true
o.scrolloff = 8
o.termguicolors = true
o.winborder = 'rounded'

o.mouse = 'a'
o.clipboard = 'unnamedplus'
o.undofile = true
o.updatetime = 250
o.timeoutlen = 300

o.expandtab = true
o.tabstop = 4
o.shiftwidth = 4
o.breakindent = true

o.ignorecase = true
o.smartcase = true
o.hlsearch = false
o.inccommand = 'split'

o.splitright = true
o.splitbelow = true

-- Show whitespace like an IDE: leading/trailing spaces, tabs, non-breaking spaces.
o.list = true
vim.opt.listchars = { tab = '→ ', trail = '·', nbsp = '␣', lead = '·' }

-- Native completion popup (fed by LSP, see config/lsp.lua). `fuzzy` ranks matches fuzzily.
vim.opt.completeopt = { 'menu', 'menuone', 'noselect', 'popup', 'fuzzy' }
