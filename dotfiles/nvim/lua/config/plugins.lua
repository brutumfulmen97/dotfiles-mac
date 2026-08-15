local function gh(repo)
  return 'https://github.com/' .. repo
end

vim.pack.add {
  gh 'datsfilipe/vesper.nvim',
  gh 'nvim-lua/plenary.nvim',
  gh 'nvim-telescope/telescope.nvim',
  gh 'nvim-telescope/telescope-ui-select.nvim',
  { src = gh 'Saghen/blink.cmp', version = vim.version.range '1.*' },
  gh 'nvim-mini/mini.ai',
  gh 'nvim-mini/mini.statusline',
  gh 'nvim-tree/nvim-web-devicons',
  gh 'nvim-neo-tree/neo-tree.nvim',
  gh 'MunifTanjim/nui.nvim',
  gh 'numToStr/Comment.nvim',
  gh 'lewis6991/gitsigns.nvim',
  gh 'kdheepak/lazygit.nvim',
  gh 'goolord/alpha-nvim',
  gh 'mbbill/undotree',
  gh 'folke/which-key.nvim',
  gh 'neovim/nvim-lspconfig',
  gh 'mason-org/mason.nvim',
  gh 'WhoIsSethDaniel/mason-tool-installer.nvim',
  gh 'stevearc/conform.nvim',
  { src = gh 'nvim-treesitter/nvim-treesitter', version = 'main' },
}
