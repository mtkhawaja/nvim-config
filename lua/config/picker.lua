local fzf = require 'fzf-lua'
fzf.setup { 'default-title', winopts = { preview = { layout = 'flex' } } }
fzf.register_ui_select()

local map = vim.keymap.set

map('n', '<leader><space>', fzf.buffers, { desc = 'Buffers' })
map('n', '<leader>?', fzf.oldfiles, { desc = 'Recent files' })
map('n', '<leader>/', fzf.blines, { desc = 'Fuzzy find in buffer' })
map('n', '<C-p>', fzf.files, { desc = 'Files' })

map('n', '<leader>sf', fzf.files, { desc = 'Files' })
map('n', '<leader>sg', fzf.live_grep_native, { desc = 'Grep' })
map('n', '<leader>sw', fzf.grep_cword, { desc = 'Word under cursor' })
map('v', '<leader>sw', fzf.grep_visual, { desc = 'Selection' })
map('n', '<leader>sd', fzf.diagnostics_workspace, { desc = 'Diagnostics' })
map('n', '<leader>sh', fzf.helptags, { desc = 'Help' })
map('n', '<leader>sk', fzf.keymaps, { desc = 'Keymaps' })
map('n', '<leader>sr', fzf.resume, { desc = 'Resume last search' })
map('n', '<leader>ss', fzf.lsp_document_symbols, { desc = 'Document symbols' })
map('n', '<leader>sS', fzf.lsp_live_workspace_symbols, { desc = 'Workspace symbols' })
map('n', '<leader>gf', fzf.git_files, { desc = 'Git files' })
map('n', '<leader>gc', fzf.git_commits, { desc = 'Git commits' })
map('n', '<leader>gs', fzf.git_status, { desc = 'Git status' })
