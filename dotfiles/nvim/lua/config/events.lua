local function start_treesitter(buffer)
  local language = vim.treesitter.language.get_lang(vim.bo[buffer].filetype)
  if language then pcall(vim.treesitter.start, buffer, language) end
end

vim.api.nvim_create_autocmd('FileType', {
  callback = function(args) start_treesitter(args.buf) end,
})
vim.api.nvim_create_autocmd('VimEnter', {
  callback = function()
    for _, buffer in ipairs(vim.api.nvim_list_bufs()) do
      if vim.api.nvim_buf_is_loaded(buffer) then start_treesitter(buffer) end
    end
  end,
})

vim.api.nvim_create_autocmd('TextYankPost', {
  callback = function() vim.hl.on_yank() end,
})
