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
