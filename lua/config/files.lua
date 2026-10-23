-- oil.nvim: edit the filesystem like a buffer. `-` opens the parent directory of the current file.
require('oil').setup {
  default_file_explorer = true,
  skip_confirm_for_simple_edits = true,
  view_options = { show_hidden = true },
  float = { padding = 2 },
}

vim.keymap.set('n', '-', '<cmd>Oil<cr>', { desc = 'Parent directory (Oil)' })
vim.keymap.set('n', '<leader>fe', '<cmd>Oil --float<cr>', { desc = 'File explorer (float)' })
