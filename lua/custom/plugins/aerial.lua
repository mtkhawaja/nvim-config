-- Symbols outline / "structure" panel (functions, classes, etc.).
-- Toggle with <leader>o. `nerd_font = false` uses plain symbols (no Nerd Font).
-- NOTE: <leader>a is already a Treesitter swap mapping, so the outline uses <leader>o.
return {
  'stevearc/aerial.nvim',
  cmd = { 'AerialToggle', 'AerialOpen', 'AerialNavToggle' },
  keys = {
    { '<leader>o', '<cmd>AerialToggle!<CR>', desc = 'Symbols [O]utline' },
  },
  dependencies = {
    'nvim-treesitter/nvim-treesitter',
  },
  opts = {
    nerd_font = false,
    attach_mode = 'global',
    backends = { 'treesitter', 'lsp', 'markdown', 'man' },
    layout = { default_direction = 'right', min_width = 28 },
    show_guides = true,
  },
}
