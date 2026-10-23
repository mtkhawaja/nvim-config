-- Method separators (IntelliJ "Show method separators" equivalent).
--
-- Draws a thin horizontal rule above each top-level function/method using
-- Treesitter + extmark virtual lines. There is no built-in Neovim feature or
-- de-facto standard plugin for this, so we implement it directly. Cheap, no
-- dependencies beyond nvim-treesitter parsers (which the config already installs).

local M = {}

local ns = vim.api.nvim_create_namespace 'MethodSeparators'
local uv = vim.uv or vim.loop

-- Width of the separator line. Fixed (not window-relative) so it stays stable
-- across splits and resizes.
local SEP_WIDTH = 80

-- Treesitter node types that represent a function/method, per language. A
-- combined query would error on grammars missing a given node type, so we keep
-- a per-language list and query each type individually under pcall.
local fn_node_types = {
  lua = { 'function_declaration', 'function_definition' },
  python = { 'function_definition' },
  go = { 'function_declaration', 'method_declaration' },
  java = { 'method_declaration', 'constructor_declaration' },
  javascript = { 'function_declaration', 'method_definition' },
  typescript = { 'function_declaration', 'method_definition' },
  tsx = { 'function_declaration', 'method_definition' },
}

-- Walk up through any comment lines immediately above the function so the
-- separator sits above the doc comment, not between it and the function.
local function anchor_row(node)
  local row = node:start()
  local prev = node:prev_sibling()
  while prev and prev:type():match 'comment' do
    local _, _, prev_end = prev:end_()
    -- Only absorb the comment if it's adjacent (no blank line gap).
    if row - prev_end <= 1 then
      row = prev:start()
      prev = prev:prev_sibling()
    else
      break
    end
  end
  return row
end

local function draw(buf)
  if not vim.api.nvim_buf_is_loaded(buf) then
    return
  end
  vim.api.nvim_buf_clear_namespace(buf, ns, 0, -1)

  local types = fn_node_types[vim.bo[buf].filetype]
  if not types then
    return
  end

  local ok, parser = pcall(vim.treesitter.get_parser, buf)
  if not ok or not parser then
    return
  end
  local lang = parser:lang()
  local trees = parser:parse()
  if not trees then
    return
  end

  local sep = string.rep('─', SEP_WIDTH)
  local placed = {}

  for _, t in ipairs(types) do
    local ok_q, query = pcall(vim.treesitter.query.parse, lang, '(' .. t .. ') @f')
    if ok_q then
      for _, tree in ipairs(trees) do
        for _, node in query:iter_captures(tree:root(), buf, 0, -1) do
          local row = anchor_row(node)
          if row > 0 and not placed[row] then
            placed[row] = true
            pcall(vim.api.nvim_buf_set_extmark, buf, ns, row, 0, {
              virt_lines_above = true,
              virt_lines = { { { sep, 'MethodSeparator' } } },
            })
          end
        end
      end
    end
  end
end

-- Debounce redraws so fast typing doesn't re-parse on every keystroke.
local timers = {}
local function schedule(buf)
  if timers[buf] then
    timers[buf]:stop()
  end
  local timer = uv.new_timer()
  timers[buf] = timer
  timer:start(
    150,
    0,
    vim.schedule_wrap(function()
      if vim.api.nvim_buf_is_valid(buf) then
        draw(buf)
      end
    end)
  )
end

function M.setup()
  -- Dim by default; link to a comment-ish highlight. Override with your own
  -- `:highlight MethodSeparator ...` if you want it bolder.
  vim.api.nvim_set_hl(0, 'MethodSeparator', { link = 'NonText', default = true })

  local group = vim.api.nvim_create_augroup('MethodSeparators', { clear = true })
  vim.api.nvim_create_autocmd({ 'BufEnter', 'BufWritePost', 'TextChanged', 'InsertLeave' }, {
    group = group,
    callback = function(args)
      schedule(args.buf)
    end,
  })
end

return M
