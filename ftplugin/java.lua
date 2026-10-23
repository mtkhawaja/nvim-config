-- Java: nvim-jdtls starts (or attaches to) one Eclipse JDT language server per project.
-- jdtls itself is installed by Mason (see lua/config/lsp.lua). Requires a JDK 21+ on PATH or JAVA_HOME.

local ok, jdtls = pcall(require, 'jdtls')
if not ok then
  return
end

local jdtls_cmd = vim.fn.exepath 'jdtls'
if jdtls_cmd == '' then
  vim.notify('jdtls not found: run :Mason and install jdtls', vim.log.levels.WARN)
  return
end

local root_dir = vim.fs.root(0, { 'gradlew', 'mvnw', 'pom.xml', 'build.gradle', 'build.gradle.kts', 'settings.gradle', '.git' }) or vim.fn.getcwd()

-- One workspace per project so jdtls keeps separate indexes.
local workspace = vim.fn.stdpath 'cache' .. '/jdtls/workspace/' .. vim.fn.fnamemodify(root_dir, ':p:h:t')

jdtls.start_or_attach {
  name = 'jdtls',
  cmd = { jdtls_cmd, '-data', workspace },
  root_dir = root_dir,
  settings = {
    java = {
      signatureHelp = { enabled = true },
      completion = { favoriteStaticMembers = { 'org.junit.jupiter.api.Assertions.*', 'org.mockito.Mockito.*' } },
    },
  },
}

-- Refactorings that jdtls offers beyond plain code actions.
local function map(mode, lhs, rhs, desc)
  vim.keymap.set(mode, lhs, rhs, { buffer = 0, desc = 'Java: ' .. desc })
end

map('n', '<leader>jo', jdtls.organize_imports, 'Organize imports')
map('n', '<leader>jv', jdtls.extract_variable, 'Extract variable')
map('v', '<leader>jv', function()
  jdtls.extract_variable(true)
end, 'Extract variable')
map('n', '<leader>jc', jdtls.extract_constant, 'Extract constant')
map('v', '<leader>jc', function()
  jdtls.extract_constant(true)
end, 'Extract constant')
map('v', '<leader>jm', function()
  jdtls.extract_method(true)
end, 'Extract method')
