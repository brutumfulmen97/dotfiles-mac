vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')
vim.keymap.set({ 'n', 'x' }, 'x', '"_x', { desc = 'Delete without yanking' })
vim.keymap.set({ 'n', 'x' }, 'X', '"_X', { desc = 'Delete without yanking' })
vim.keymap.set('n', '[d', function() vim.diagnostic.jump { count = -1, float = true } end, { desc = 'Previous diagnostic' })
vim.keymap.set('n', ']d', function() vim.diagnostic.jump { count = 1, float = true } end, { desc = 'Next diagnostic' })

local diagnostic_float
vim.keymap.set('n', 'gh', function()
  if diagnostic_float and vim.api.nvim_win_is_valid(diagnostic_float) then
    vim.api.nvim_win_close(diagnostic_float, true)
    diagnostic_float = nil
    return
  end
  local _, win = vim.diagnostic.open_float(nil, { scope = 'cursor', focus = false })
  diagnostic_float = win
end, { desc = 'Toggle diagnostic details' })

vim.keymap.set('n', '<leader>sa', 'zg', { desc = 'Add word to dictionary' })
vim.keymap.set('n', '<leader>e', '<cmd>Explore<CR>', { desc = 'Explore files' })
