require('gitsigns').setup {
  on_attach = function(bufnr)
    local gs = require 'gitsigns'
    local function map(mode, lhs, rhs, desc)
      vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, desc = desc })
    end

    map('n', ']c', function()
      if vim.wo.diff then
        vim.cmd.normal { ']c', bang = true }
      else
        gs.nav_hunk 'next'
      end
    end, 'Next hunk')
    map('n', '[c', function()
      if vim.wo.diff then
        vim.cmd.normal { '[c', bang = true }
      else
        gs.nav_hunk 'prev'
      end
    end, 'Previous hunk')

    map('n', '<leader>hs', gs.stage_hunk, 'Stage hunk')
    map('n', '<leader>hr', gs.reset_hunk, 'Reset hunk')
    map('v', '<leader>hs', function()
      gs.stage_hunk { vim.fn.line '.', vim.fn.line 'v' }
    end, 'Stage selected lines')
    map('v', '<leader>hr', function()
      gs.reset_hunk { vim.fn.line '.', vim.fn.line 'v' }
    end, 'Reset selected lines')
    map('n', '<leader>hS', gs.stage_buffer, 'Stage buffer')
    map('n', '<leader>hR', gs.reset_buffer, 'Reset buffer')
    map('n', '<leader>hp', gs.preview_hunk, 'Preview hunk')
    map('n', '<leader>hb', function()
      gs.blame_line { full = true }
    end, 'Blame line')
    map('n', '<leader>hd', gs.diffthis, 'Diff against index')
    map('n', '<leader>tb', gs.toggle_current_line_blame, 'Toggle line blame')
    map({ 'o', 'x' }, 'ih', '<cmd>Gitsigns select_hunk<cr>', 'Select hunk')
  end,
}
