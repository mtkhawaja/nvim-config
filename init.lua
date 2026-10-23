-- Neovim config. Requires Neovim >= 0.12 (native vim.pack, LSP config and completion).
-- Layout: lua/plugins.lua lists plugins; lua/config/* configures one concern each.

vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

require 'plugins'

for _, mod in ipairs { 'options', 'keymaps', 'autocmds', 'ui', 'picker', 'files', 'git', 'treesitter', 'lsp', 'format' } do
  require('config.' .. mod)
end

require('config.method_separators').setup()
