require('vesper').setup {
  transparent = true,
  italics = { comments = false, keywords = true, functions = false, strings = false, variables = false },
  overrides = {
    FloatBorder = { fg = '#ffffff' },
    Keyword = { fg = '#7fbbb3', italic = true, bold = true },
    Operator = { fg = '#D5A9C9' },
    Attribute = { fg = '#A9D5CB' },
    Property = { fg = '#A9D5B5' },
    Identifier = { fg = '#A9D5B5' },
    ['@keyword'] = { fg = '#7fbbb3', italic = true, bold = true },
    ['@operator'] = { fg = '#D5A9C9' },
    ['@attribute'] = { fg = '#A9D5CB' },
    ['@property'] = { fg = '#A9D5B5' },
    ['@variable'] = { fg = '#A9D5B5' },
  },
}
vim.cmd.colorscheme 'vesper'

require('nvim-web-devicons').setup { color_icons = true, default = true, strict = true }
require('Comment').setup()
require('mini.ai').setup()

require('gitsigns').setup {
  on_attach = function(bufnr)
    local gitsigns = require 'gitsigns'
    local map = function(mode, keys, action, description)
      vim.keymap.set(mode, keys, action, { buffer = bufnr, desc = description })
    end
    map('n', '<leader>ghn', function() gitsigns.nav_hunk 'next' end, 'Next hunk')
    map('n', '<leader>ghN', function() gitsigns.nav_hunk 'prev' end, 'Previous hunk')
    map('n', '<leader>ghs', gitsigns.stage_hunk, 'Stage hunk')
    map('n', '<leader>ghr', gitsigns.reset_hunk, 'Reset hunk')
    map('n', '<leader>ghp', gitsigns.preview_hunk, 'Preview hunk')
    map('n', '<leader>ghb', function() gitsigns.blame_line { full = true } end, 'Blame line')
    map('n', '<leader>ghd', gitsigns.diffthis, 'Diff current file')
    map('v', '<leader>ghs', function() gitsigns.stage_hunk { vim.fn.line '.', vim.fn.line 'v' } end, 'Stage hunk')
    map('v', '<leader>ghr', function() gitsigns.reset_hunk { vim.fn.line '.', vim.fn.line 'v' } end, 'Reset hunk')
  end,
}

vim.g.lazygit_floating_window_use_plenary = 1
vim.g.lazygit_floating_window_scaling_factor = 0.9
vim.keymap.set('n', '<leader>gg', '<cmd>LazyGit<CR>', { desc = 'Open LazyGit' })

vim.g.undotree_SetFocusWhenToggle = 1
vim.keymap.set('n', '<leader>u', '<cmd>UndotreeToggle<CR>', { desc = 'Toggle undo tree' })

require('mini.statusline').setup {
  use_icons = true,
  content = {
    active = function()
      local mode, mode_hl = MiniStatusline.section_mode { trunc_width = 120 }
      local diagnostics = MiniStatusline.section_diagnostics { trunc_width = 75 }
      local filename = MiniStatusline.section_filename { trunc_width = 140 }
      local location = MiniStatusline.section_location { trunc_width = 75 }
      return MiniStatusline.combine_groups {
        { hl = mode_hl, strings = { mode } },
        { hl = 'MiniStatuslineDevinfo', strings = { diagnostics } },
        '%<',
        { hl = 'MiniStatuslineFilename', strings = { filename } },
        '%=',
        { hl = 'MiniStatuslineFileinfo', strings = { location } },
      }
    end,
  },
}

vim.api.nvim_set_hl(0, 'MiniStatuslineModeNormal', { fg = '#A9D5B5', bg = 'NONE', bold = true })
vim.api.nvim_set_hl(0, 'MiniStatuslineModeInsert', { fg = '#7fbbb3', bg = 'NONE', bold = true })
vim.api.nvim_set_hl(0, 'MiniStatuslineModeVisual', { fg = '#D5A9C9', bg = 'NONE', bold = true })
vim.api.nvim_set_hl(0, 'MiniStatuslineModeReplace', { fg = '#ff8080', bg = 'NONE', bold = true })
vim.api.nvim_set_hl(0, 'MiniStatuslineFilename', { fg = '#ffffff', bg = 'NONE' })
vim.api.nvim_set_hl(0, 'MiniStatuslineFileinfo', { fg = '#A9D5CB', bg = 'NONE' })
vim.api.nvim_set_hl(0, 'MiniStatuslineDevinfo', { fg = '#859289', bg = 'NONE' })
