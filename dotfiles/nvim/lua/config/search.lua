require('telescope').setup {
  defaults = {
    layout_strategy = 'horizontal',
    layout_config = {
      width = 0.9,
      height = 0.85,
      horizontal = { preview_width = 0.55 },
    },
    preview = { hide_on_startup = false },
    file_ignore_patterns = {
      '%.git/',
      'node_modules/',
      'target/',
      'dist/',
      'build/',
      '%.next/',
      'coverage/',
      '__pycache__/',
      '%.venv/',
      'venv/',
    },
    vimgrep_arguments = {
      'rg',
      '--color=never',
      '--no-heading',
      '--with-filename',
      '--line-number',
      '--column',
      '--smart-case',
      '--glob=!node_modules/**',
      '--glob=!target/**',
      '--glob=!dist/**',
      '--glob=!build/**',
      '--glob=!.next/**',
      '--glob=!coverage/**',
      '--glob=!__pycache__/**',
      '--glob=!.venv/**',
      '--glob=!venv/**',
    },
  },
  extensions = {
    ['ui-select'] = require('telescope.themes').get_dropdown {
      layout_config = { width = 0.7, height = 0.4 },
    },
  },
}
require('telescope').load_extension 'ui-select'

require('blink.cmp').setup {
  keymap = {
    preset = 'default',
    ['<C-space>'] = { 'show', 'show_documentation', 'hide_documentation' },
    ['<Up>'] = { 'select_prev', 'fallback' },
    ['<Down>'] = { 'select_next', 'fallback' },
    ['<CR>'] = { 'accept', 'fallback' },
  },
  completion = { menu = { auto_show = true } },
  sources = { default = { 'lsp', 'path', 'buffer' } },
  fuzzy = { implementation = 'lua' },
}

local telescope = require 'telescope.builtin'
vim.keymap.set('n', '<leader><leader>', telescope.find_files, { desc = 'Find files' })
vim.keymap.set('n', '<leader>,', telescope.oldfiles, { desc = 'Recent files' })
vim.keymap.set('n', '<leader>sg', telescope.live_grep, { desc = 'Search text' })
vim.keymap.set('n', '<leader>sd', telescope.diagnostics, { desc = 'Search diagnostics' })
