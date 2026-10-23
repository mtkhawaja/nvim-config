-- Native LSP: server configs via vim.lsp.config(), enabled by mason-lspconfig, completion via vim.lsp.completion.
-- Neovim defaults already give: K hover, grn rename, gra code action, grr references, gri implementation,
-- grt type definition, gO document symbols, <C-s> signature help (insert), [d / ]d diagnostics.

local servers = {
  lua_ls = {
    settings = {
      Lua = {
        runtime = { version = 'LuaJIT' },
        workspace = { checkThirdParty = false, library = { vim.env.VIMRUNTIME, '${3rd}/luv/library' } },
        telemetry = { enable = false },
      },
    },
  },
  basedpyright = {},
  ruff = {},
  ts_ls = {},
  jsonls = {},
  yamlls = {},
  bashls = {},
  html = {},
  cssls = {},
  dockerls = {},
  marksman = {},
  taplo = {},
  lemminx = {},
  gopls = {},
}

for name, config in pairs(servers) do
  vim.lsp.config(name, config)
end

require('mason').setup()
require('mason-lspconfig').setup {
  -- jdtls is installed here but started by nvim-jdtls (ftplugin/java.lua), so it is not auto-enabled.
  ensure_installed = vim.list_extend(vim.tbl_keys(servers), { 'jdtls' }),
  automatic_enable = { exclude = { 'jdtls' } },
}

vim.diagnostic.config {
  severity_sort = true,
  virtual_text = { spacing = 2, source = 'if_many' },
  float = { source = true },
}

vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('user-lsp-attach', { clear = true }),
  callback = function(ev)
    local client = vim.lsp.get_client_by_id(ev.data.client_id)
    if not client then
      return
    end

    -- Let basedpyright own hover; ruff's would duplicate it.
    if client.name == 'ruff' then
      client.server_capabilities.hoverProvider = false
    end

    if client:supports_method 'textDocument/completion' then
      vim.lsp.completion.enable(true, client.id, ev.buf, { autotrigger = true })
    end

    local fzf = require 'fzf-lua'
    local function map(mode, lhs, rhs, desc)
      vim.keymap.set(mode, lhs, rhs, { buffer = ev.buf, desc = 'LSP: ' .. desc })
    end

    map('n', 'gd', fzf.lsp_definitions, 'Go to definition')
    map('n', 'gD', vim.lsp.buf.declaration, 'Go to declaration')
    map('n', 'gr', fzf.lsp_references, 'References')
    map('n', 'gI', fzf.lsp_implementations, 'Implementations')
    map('n', '<leader>D', fzf.lsp_typedefs, 'Type definition')
    map('n', '<leader>rn', vim.lsp.buf.rename, 'Rename symbol')
    map({ 'n', 'v' }, '<leader>ca', vim.lsp.buf.code_action, 'Code action')
    map('n', '<leader>ci', fzf.lsp_incoming_calls, 'Incoming calls')
    map('n', '<leader>co', fzf.lsp_outgoing_calls, 'Outgoing calls')
    map('n', '<leader>cf', function()
      vim.lsp.buf.format { async = true }
    end, 'Format buffer')
    map('n', '<leader>th', function()
      vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled { bufnr = ev.buf }, { bufnr = ev.buf })
    end, 'Toggle inlay hints')
  end,
})
