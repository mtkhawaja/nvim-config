-- Integrated terminal toggled with <C-\> (works from normal and terminal mode).
-- A lightweight in-editor shell; no Nerd Font required.
return {
  'akinsho/toggleterm.nvim',
  version = '*',
  cmd = { 'ToggleTerm', 'TermExec' },
  keys = {
    { [[<c-\>]], '<cmd>ToggleTerm<CR>', mode = 'n', desc = 'Toggle terminal' },
  },
  opts = {
    -- Also binds the toggle inside terminal mode, so the same key closes it
    open_mapping = [[<c-\>]],
    direction = 'float',
    float_opts = { border = 'curved' },
    shade_terminals = true,
  },
}
