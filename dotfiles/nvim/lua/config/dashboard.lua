local dashboard = require 'alpha.themes.dashboard'

dashboard.section.header.val = {
  [[ _   _ _____  _____   _____ __  __ ]],
  [[| \ | | ____|/ _ \ \ / /_ _|  \/  |]],
  [[|  \| |  _| | | | \ V / | || |\/| |]],
  [[| |\  | |___| |_| || |  | || |  | |]],
  [[|_| \_|_____|\___/ |_| |___|_|  |_|]],
}
dashboard.section.buttons.val = {
  dashboard.button('f', '[f] Find files', '<cmd>Telescope find_files<CR>'),
  dashboard.button('r', '[r] Recent files', '<cmd>Telescope oldfiles<CR>'),
  dashboard.button('s', '[s] Search text', '<cmd>Telescope live_grep<CR>'),
  dashboard.button('g', '[g] LazyGit', '<cmd>LazyGit<CR>'),
  dashboard.button('q', '[q] Quit', '<cmd>qa<CR>'),
}
dashboard.section.footer.val = '@brutum'

require('alpha').setup(dashboard.config)
vim.api.nvim_set_hl(0, 'AlphaHeader', { fg = '#7fbbb3', bold = true })
vim.api.nvim_set_hl(0, 'AlphaButtons', { fg = '#A9D5B5' })
vim.api.nvim_set_hl(0, 'AlphaFooter', { fg = '#859289', italic = true })
