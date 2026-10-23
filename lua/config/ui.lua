require('catppuccin').setup { flavour = 'mocha' }
vim.cmd.colorscheme 'catppuccin'

-- Native statusline: mode, branch, file, diagnostics on the left; word count and position on the right.
local mode_names = { n = 'NORMAL', i = 'INSERT', v = 'VISUAL', V = 'V-LINE', ['\22'] = 'V-BLOCK', c = 'COMMAND', R = 'REPLACE', t = 'TERMINAL' }
local prose = { markdown = true, text = true, tex = true, rst = true, gitcommit = true }

local M = {}

function M.render()
  local parts = { ' ' .. (mode_names[vim.fn.mode()] or vim.fn.mode()) .. ' ' }

  local branch = vim.b.gitsigns_head
  if branch and branch ~= '' then
    parts[#parts + 1] = ' ' .. branch
  end
  parts[#parts + 1] = ' %f%m%r'

  local counts = vim.diagnostic.count(0)
  local sev = vim.diagnostic.severity
  for _, s in ipairs { { sev.ERROR, 'E' }, { sev.WARN, 'W' } } do
    if counts[s[1]] then
      parts[#parts + 1] = ' ' .. s[2] .. counts[s[1]]
    end
  end

  parts[#parts + 1] = '%='
  if prose[vim.bo.filetype] then
    local wc = vim.fn.wordcount()
    parts[#parts + 1] = (wc.visual_words or wc.words) .. ' words  '
  end
  parts[#parts + 1] = '%y  %l:%c  %p%% '
  return table.concat(parts)
end

_G.StatusLine = M
vim.o.statusline = '%!v:lua.StatusLine.render()'

return M
