-- Full-featured Java LSP via nvim-jdtls (Eclipse JDT Language Server).
-- The per-buffer launch/config lives in ftplugin/java.lua; the jdtls server
-- itself is installed by Mason (it's in the `ensure_installed` list in init.lua).
return {
  'mfussenegger/nvim-jdtls',
  ft = 'java',
  dependencies = {
    'mason-org/mason.nvim',
  },
}
