-- File explorer sidebar (IDE-style file tree).
-- Toggle with `\`. Configured to work WITHOUT a Nerd Font (plain-text icons).
-- NOTE: `<leader>e` is already mapped to the diagnostic float, so the explorer
-- uses `\`. Change the `keys` lhs below if you'd prefer `<leader>e`.
return {
  'nvim-neo-tree/neo-tree.nvim',
  branch = 'v3.x',
  cmd = 'Neotree',
  keys = {
    { '\\', '<cmd>Neotree toggle<CR>', desc = 'Toggle file explorer (Neo-tree)' },
  },
  dependencies = {
    'nvim-lua/plenary.nvim',
    'MunifTanjim/nui.nvim',
    -- 'nvim-tree/nvim-web-devicons', -- add this (+ a Nerd Font) for file-type icons
  },
  opts = {
    close_if_last_window = true,
    enable_git_status = true,
    enable_diagnostics = true,
    default_component_configs = {
      indent = {
        with_markers = true,
        indent_marker = '│',
        last_indent_marker = '└',
        with_expanders = true,
        expander_collapsed = '+',
        expander_expanded = '-',
      },
      -- Plain-text icons (no Nerd Font required)
      icon = {
        folder_closed = '▸',
        folder_open = '▾',
        folder_empty = '▸',
        default = ' ',
      },
      modified = { symbol = '[+]' },
      -- `false` = render git state as plain text (e.g. `M`, `A`) instead of glyphs
      git_status = { symbols = false },
    },
    window = {
      position = 'left',
      width = 34,
    },
    filesystem = {
      follow_current_file = { enabled = true },
      use_libuv_file_watcher = true,
      filtered_items = {
        hide_dotfiles = false,
        hide_gitignored = true,
      },
    },
  },
}
