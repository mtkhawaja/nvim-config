-- VS Code-style tab bar: one tab per open buffer, with LSP diagnostics.
-- Cycle with `[b` / `]b`. Configured to work WITHOUT a Nerd Font (no file icons).
return {
  'akinsho/bufferline.nvim',
  event = 'VeryLazy',
  keys = {
    { '[b', '<cmd>BufferLineCyclePrev<CR>', desc = 'Previous buffer' },
    { ']b', '<cmd>BufferLineCycleNext<CR>', desc = 'Next buffer' },
    { '<leader>bp', '<cmd>BufferLinePick<CR>', desc = '[B]uffer [P]ick' },
    { '<leader>bd', '<cmd>bdelete<CR>', desc = '[B]uffer [D]elete' },
  },
  opts = {
    options = {
      mode = 'buffers',
      diagnostics = 'nvim_lsp',
      -- No Nerd Font: turn off file-type/close glyphs
      show_buffer_icons = false,
      show_buffer_close_icons = false,
      show_close_icon = false,
      separator_style = 'thin',
      indicator = { style = 'underline' },
      modified_icon = '●',
      left_trunc_marker = '<',
      right_trunc_marker = '>',
      always_show_bufferline = true,
      -- Make room for the Neo-tree sidebar instead of overlapping it
      offsets = {
        { filetype = 'neo-tree', text = 'File Explorer', text_align = 'left', separator = true },
      },
      diagnostics_indicator = function(count, level)
        local s = level:match 'error' and 'E' or 'W'
        return ' ' .. s .. count
      end,
    },
  },
}
