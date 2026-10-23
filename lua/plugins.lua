-- Plugins, managed by native `vim.pack` (`:help vim.pack`).
-- Revisions are pinned in nvim-pack-lock.json (commit it). Update with `:lua vim.pack.update()`.

local function gh(repo)
  return 'https://github.com/' .. repo
end

-- nvim-treesitter compiles parsers; refresh them whenever the plugin is installed or updated.
vim.api.nvim_create_autocmd('PackChanged', {
  callback = function(ev)
    local data = ev.data
    if data.spec.name == 'nvim-treesitter' and (data.kind == 'install' or data.kind == 'update') then
      if not data.active then
        vim.cmd.packadd 'nvim-treesitter'
      end
      vim.cmd 'TSUpdate'
    end
  end,
})

vim.pack.add {
  { src = gh 'catppuccin/nvim', name = 'catppuccin' },

  gh 'ibhagwan/fzf-lua',
  gh 'stevearc/oil.nvim',
  gh 'folke/which-key.nvim',

  gh 'lewis6991/gitsigns.nvim',
  gh 'tpope/vim-fugitive',
  gh 'tpope/vim-rhubarb',
  gh 'tpope/vim-sleuth',

  { src = gh 'nvim-treesitter/nvim-treesitter', version = 'main' },
  { src = gh 'nvim-treesitter/nvim-treesitter-textobjects', version = 'main' },

  gh 'neovim/nvim-lspconfig',
  gh 'mason-org/mason.nvim',
  gh 'mason-org/mason-lspconfig.nvim',
  gh 'mfussenegger/nvim-jdtls',
}
