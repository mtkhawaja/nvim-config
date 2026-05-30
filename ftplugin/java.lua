-- Java buffer bootstrap for nvim-jdtls.
-- Runs for every Java file; starts (or attaches to) a jdtls language server.
-- jdtls is installed via Mason; see lua/custom/plugins/jdtls.lua and init.lua.

local ok, jdtls = pcall(require, 'jdtls')
if not ok then
  -- nvim-jdtls not installed yet (e.g. first launch before :Lazy sync finishes)
  return
end

-- Locate the Mason-installed jdtls launcher (Mason adds its bin dir to PATH).
local jdtls_cmd = vim.fn.exepath 'jdtls'
if jdtls_cmd == '' then
  vim.notify('jdtls not found — install it with :Mason (or wait for ensure_installed)', vim.log.levels.WARN)
  return
end

-- Detect the project root; fall back to the current working directory.
local root_dir = vim.fs.root(0, { 'gradlew', 'mvnw', 'pom.xml', 'build.gradle', 'settings.gradle', '.git' })
  or vim.fn.getcwd()

-- One workspace per project so jdtls keeps separate indexes.
local workspace = vim.fn.stdpath 'cache' .. '/jdtls/workspace/' .. vim.fn.fnamemodify(root_dir, ':p:h:t')

-- Share the same completion capabilities as the rest of the LSP setup.
local capabilities = vim.lsp.protocol.make_client_capabilities()
local ok_cmp, cmp_lsp = pcall(require, 'cmp_nvim_lsp')
if ok_cmp then
  capabilities = cmp_lsp.default_capabilities(capabilities)
end

jdtls.start_or_attach {
  name = 'jdtls',
  cmd = { jdtls_cmd, '-data', workspace },
  root_dir = root_dir,
  capabilities = capabilities,
  settings = { java = {} },
  init_options = { bundles = {} },
}
