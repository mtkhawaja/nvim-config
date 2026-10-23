-- nvim-treesitter (main branch): installs parsers; highlighting/indent use Neovim's built-in treesitter.
-- Parsers are compiled locally and need the `tree-sitter` CLI and a C compiler on PATH.
local parsers = {
  'bash', 'css', 'dockerfile', 'go', 'html', 'java', 'javascript', 'json', 'lua', 'markdown', 'markdown_inline',
  'python', 'toml', 'tsx', 'typescript', 'vim', 'vimdoc', 'xml', 'yaml',
}

if vim.fn.executable 'tree-sitter' == 1 then
  require('nvim-treesitter').install(parsers)
else
  vim.notify('tree-sitter CLI not found: parsers will not be installed (brew install tree-sitter-cli)', vim.log.levels.WARN)
end

vim.api.nvim_create_autocmd('FileType', {
  group = vim.api.nvim_create_augroup('user-treesitter', { clear = true }),
  callback = function(args)
    -- Errors when no parser exists for the filetype, so guard it.
    if pcall(vim.treesitter.start, args.buf) then
      vim.bo[args.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
    end
  end,
})

-- Text objects: af/if function, ac/ic class, aa/ia parameter; ]m [m ]] [[ to move.
require('nvim-treesitter-textobjects').setup { select = { lookahead = true }, move = { set_jumps = true } }

local select = require 'nvim-treesitter-textobjects.select'
local move = require 'nvim-treesitter-textobjects.move'
local swap = require 'nvim-treesitter-textobjects.swap'

for lhs, query in pairs { aa = '@parameter.outer', ia = '@parameter.inner', af = '@function.outer', ['if'] = '@function.inner', ac = '@class.outer', ic = '@class.inner' } do
  vim.keymap.set({ 'x', 'o' }, lhs, function()
    select.select_textobject(query, 'textobjects')
  end, { desc = 'Select ' .. query })
end

local moves = {
  { ']m', 'goto_next_start', '@function.outer' },
  { ']M', 'goto_next_end', '@function.outer' },
  { '[m', 'goto_previous_start', '@function.outer' },
  { '[M', 'goto_previous_end', '@function.outer' },
  { ']]', 'goto_next_start', '@class.outer' },
  { '[[', 'goto_previous_start', '@class.outer' },
}
for _, m in ipairs(moves) do
  vim.keymap.set({ 'n', 'x', 'o' }, m[1], function()
    move[m[2]](m[3], 'textobjects')
  end, { desc = m[2]:gsub('_', ' ') .. ' ' .. m[3] })
end

vim.keymap.set('n', '<leader>a', function()
  swap.swap_next '@parameter.inner'
end, { desc = 'Swap parameter with next' })
vim.keymap.set('n', '<leader>A', function()
  swap.swap_previous '@parameter.inner'
end, { desc = 'Swap parameter with previous' })
