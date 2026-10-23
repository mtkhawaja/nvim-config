# nvim-config

A lean, terminal-first Neovim setup for Java, Python and everything else. Native-first: Neovim 0.12's built-in
plugin manager, LSP, completion and treesitter, plus a few well-supported plugins.

Requires **Neovim >= 0.12**.

## What's in it

| Area | Tool |
| :--- | :--- |
| Plugin manager | built-in `vim.pack` (lockfile: `nvim-pack-lock.json`) |
| Fuzzy search | [fzf-lua](https://github.com/ibhagwan/fzf-lua) |
| File navigation | [oil.nvim](https://github.com/stevearc/oil.nvim) (edit directories as buffers) |
| LSP / completion | built-in `vim.lsp`, servers via [Mason](https://github.com/mason-org/mason.nvim) |
| Java | [nvim-jdtls](https://github.com/mfussenegger/nvim-jdtls) |
| Python | basedpyright + ruff |
| Syntax | treesitter (`main` branch) + textobjects |
| Git | gitsigns, fugitive |
| UI | catppuccin, native statusline, which-key |

## Install

```sh
git clone https://github.com/mtkhawaja/nvim-config ~/.config/nvim
nvim   # plugins install on first launch
```

Needs `git`, `ripgrep`, `fd`, `fzf`, `tree-sitter` (CLI), a C compiler, and JDK 21+ for Java. They are provisioned by
[dev-environment](https://github.com/mtkhawaja/dev-environment). Run `:checkhealth` if something is off.

## Keys (leader = `Space`)

| Keys | Action |
| :--- | :--- |
| `Ctrl-p` / `<leader>sf` | Find files |
| `<leader>sg` / `<leader>sw` | Grep / word under cursor |
| `<leader><space>` | Buffers |
| `<leader>/` | Fuzzy find in buffer |
| `<leader>ss` / `<leader>sS` | Document / workspace symbols |
| `-` | Open parent directory (Oil) |
| `<leader>fe` | Floating file explorer |
| `gd` `gr` `gI` | Definition, references, implementations |
| `grn` / `<leader>rn` | Rename symbol |
| `gra` / `<leader>ca` | Code action |
| `<leader>cf` | Format buffer (also on save; `:FormatToggle`) |
| `K` | Hover |
| `[d` `]d` / `<leader>e` | Diagnostics |
| `<leader>jo` `jv` `jc` `jm` | Java: organize imports, extract variable / constant / method |
| `]c` `[c` / `<leader>h…` | Git hunks |
| `<leader>tt` | Terminal split |
| `S-h` / `S-l` | Previous / next buffer |

`<leader>sk` searches every keymap; which-key shows the rest as you type.

## Updating

`:lua vim.pack.update()` reviews and applies plugin updates. Commit the changed `nvim-pack-lock.json`.

See [AGENTS.md](./AGENTS.md) for the layout and conventions, and [doc/troubleshooting.md](./doc/troubleshooting.md) for
debugging.
