# Troubleshooting

- `:checkhealth` — overall status. Start with `vim.lsp`, `vim.treesitter`, `vim.pack` and `mason`.
- No syntax highlighting: parsers need the `tree-sitter` CLI and a C compiler. Install them, then `:TSUpdate`.
- No Java features: `:Mason` should list `jdtls`, and `java -version` must report 21 or newer.
- Server not attaching: `:LspInfo`-equivalent is `:checkhealth vim.lsp`; logs are at `:lua vim.print(vim.lsp.log.get_filename())`.
- Reset plugins: delete `~/.local/share/nvim/site/pack/core` and restart. The lockfile restores exact revisions.
