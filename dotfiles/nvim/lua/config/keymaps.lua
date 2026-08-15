local function dismiss_ui()
  pcall(function() require('which-key').dismiss() end)
  for _, window in ipairs(vim.api.nvim_list_wins()) do
    if vim.api.nvim_win_is_valid(window) then
      local ok, config = pcall(vim.api.nvim_win_get_config, window)
      if ok and config.relative ~= '' then pcall(vim.api.nvim_win_close, window, false) end
    end
  end
  vim.cmd 'nohlsearch'
end

vim.keymap.set('n', '<Esc>', dismiss_ui, { desc = 'Dismiss UI' })
vim.keymap.set('i', '<Esc>', function()
  vim.cmd 'stopinsert'
  dismiss_ui()
end, { desc = 'Dismiss UI' })
vim.keymap.set({ 'n', 'x' }, 'x', '"_x', { desc = 'Delete without yanking' })
vim.keymap.set({ 'n', 'x' }, 'X', '"_X', { desc = 'Delete without yanking' })
vim.keymap.set('n', '[d', function() vim.diagnostic.jump { count = -1, float = true } end, { desc = 'Previous diagnostic' })
vim.keymap.set('n', ']d', function() vim.diagnostic.jump { count = 1, float = true } end, { desc = 'Next diagnostic' })
vim.keymap.set('n', 'ge', function() vim.diagnostic.open_float(nil, { scope = 'cursor', focus = false }) end, { desc = 'Show diagnostic details' })
vim.keymap.set('n', '<leader>sa', 'zg', { desc = 'Add word to dictionary' })
vim.keymap.set('n', '<leader>e', '<cmd>Neotree toggle filesystem right<CR>', { desc = 'Toggle file explorer' })
