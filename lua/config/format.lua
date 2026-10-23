-- Format on save through the attached LSP servers. `:FormatToggle` turns it off/on.
local enabled = true
-- lua_ls and ts_ls formatters disagree with stylua/prettier, so they are skipped.
local skip = { lua_ls = true, ts_ls = true }

vim.api.nvim_create_user_command('FormatToggle', function()
  enabled = not enabled
  vim.notify('Format on save: ' .. (enabled and 'on' or 'off'))
end, {})

vim.api.nvim_create_autocmd('BufWritePre', {
  group = vim.api.nvim_create_augroup('user-format', { clear = true }),
  callback = function(args)
    if not enabled then
      return
    end
    local function can_format(client)
      return not skip[client.name] and client:supports_method('textDocument/formatting', args.buf)
    end
    -- Stay quiet for buffers with no formatting server (plain text, etc.).
    if #vim.tbl_filter(can_format, vim.lsp.get_clients { bufnr = args.buf }) == 0 then
      return
    end
    vim.lsp.buf.format { bufnr = args.buf, timeout_ms = 2000, filter = can_format }
  end,
})
