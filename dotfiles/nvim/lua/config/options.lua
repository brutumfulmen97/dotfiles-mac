vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

vim.o.number = true
vim.o.relativenumber = true
vim.o.mouse = 'a'
vim.o.clipboard = 'unnamedplus'
vim.o.undofile = true
vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.signcolumn = 'yes'
vim.o.updatetime = 250
vim.o.timeoutlen = 300
vim.o.cursorline = true
vim.o.scrolloff = 8
vim.o.termguicolors = true
vim.o.laststatus = 3
vim.o.showmode = false
vim.o.confirm = true
vim.o.hidden = false
vim.o.spell = true
vim.o.spelllang = 'en_us'
vim.o.splitright = true
vim.o.splitbelow = true
vim.o.expandtab = true
vim.o.tabstop = 2
vim.o.shiftwidth = 2
vim.o.softtabstop = 2
vim.cmd 'syntax enable'

local function set_default_indentation(buffer)
  local filename = vim.api.nvim_buf_get_name(buffer)
  if filename ~= '' and vim.fs.find('.editorconfig', { path = filename, upward = true, type = 'file' })[1] then return end
  vim.bo[buffer].expandtab = true
  vim.bo[buffer].tabstop = 2
  vim.bo[buffer].shiftwidth = 2
  vim.bo[buffer].softtabstop = 2
end

vim.api.nvim_create_autocmd('FileType', {
  callback = function(args) set_default_indentation(args.buf) end,
})
vim.api.nvim_create_autocmd('VimEnter', {
  callback = function()
    for _, buffer in ipairs(vim.api.nvim_list_bufs()) do
      if vim.api.nvim_buf_is_loaded(buffer) then set_default_indentation(buffer) end
    end
  end,
})

vim.diagnostic.config {
  severity_sort = true,
  underline = true,
  virtual_text = { spacing = 2, source = 'if_many' },
  signs = true,
  float = { border = 'rounded', source = 'if_many' },
}

local data_path = vim.fn.stdpath("data")
local spell_path = data_path .. "/spell"

if vim.fn.isdirectory(spell_path) == 0 then
  vim.fn.mkdir(spell_path, "p")
end

vim.opt.spellfile = spell_path .. "/en.utf-8.add"
