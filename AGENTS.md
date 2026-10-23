# AGENTS.md

Personal Neovim config. Requires Neovim >= 0.12. Native-first: built-in `vim.pack`, `vim.lsp`, completion and
treesitter, with a small set of well-supported plugins on top. Do not add plugins that duplicate a built-in feature.

## Layout

- `init.lua` — leader keys, then loads `lua/plugins.lua` and each `lua/config/*` module in order.
- `lua/plugins.lua` — the plugin list (`vim.pack.add`). Revisions are locked in `nvim-pack-lock.json`; commit it.
- `lua/config/*.lua` — one concern per file: options, keymaps, autocmds, ui, picker (fzf-lua), files (oil), git, treesitter, lsp, format.
- `ftplugin/java.lua` — starts jdtls via nvim-jdtls (Mason installs the server).

## Conventions

- Lua style is enforced by StyLua (`.stylua.toml`): 2 spaces, single quotes, no parens on single string/table calls.
- Add an LSP server by adding it to `servers` in `lua/config/lsp.lua`; Mason installs and enables it.
- Add a plugin to `lua/plugins.lua`, configure it in the matching `lua/config/` module (or a new one listed in `init.lua`).
- Every keymap gets a `desc`. Leader groups are declared in `lua/config/keymaps.lua` for which-key.
- Native LSP defaults are kept (`grn`, `gra`, `grr`, `gri`, `grt`, `gO`, `K`); extra maps live in the `LspAttach` autocmd.

## Verify

Never test against the real `~/.local/share/nvim`. Use an isolated profile:

```sh
S=$(mktemp -d)
mkdir -p $S/config && ln -s "$PWD" $S/config/nvim
export XDG_CONFIG_HOME=$S/config XDG_DATA_HOME=$S/data XDG_STATE_HOME=$S/state XDG_CACHE_HOME=$S/cache
nvim --headless +'checkhealth vim.lsp vim.treesitter' +'w! /dev/stdout' +qa
stylua --check .
```

## External tools

Neovim needs these on PATH: `git`, `rg`, `fd`, `fzf`, `tree-sitter` (CLI), a C compiler, and a JDK 21+ for jdtls.
They are provisioned by `mtkhawaja/dev-environment`; add new tool requirements there, not by hand.

This repo is a git submodule of `mtkhawaja/dotfiles` (`nvim/.config/nvim`, branch `main`). After pushing here, bump the
submodule pointer in dotfiles.
