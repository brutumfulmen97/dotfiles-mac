require('mason').setup()
require('mason-tool-installer').setup {
  ensure_installed = {
    'biome', 'alejandra', 'css-lsp', 'docker-compose-language-service', 'dockerfile-language-server',
    'gopls', 'goimports', 'html-lsp', 'json-lsp', 'just-lsp', 'marksman', 'nil', 'ruff',
    'rust-analyzer', 'sqls', 'svelte-language-server', 'taplo', 'tailwindcss-language-server',
    'tree-sitter-cli', 'yaml-language-server',
  },
}

local servers = {
  'biome', 'cssls', 'docker_compose_language_service', 'dockerls', 'eslint', 'gopls', 'html', 'jsonls',
  'just', 'marksman', 'nil_ls', 'oxlint', 'ruff', 'rust_analyzer', 'sqls', 'svelte', 'taplo',
  'tailwindcss', 'yamlls',
}
for _, server in ipairs(servers) do
  vim.lsp.config(server, {})
end

vim.lsp.config('tsgo', {
  cmd = function(dispatchers, config)
    local root = config.root_dir or vim.fn.getcwd()
    local effect_tsgo = vim.fs.joinpath(root, 'node_modules', '.bin', 'effect-tsgo')
    local command = vim.fn.executable(effect_tsgo) == 1 and effect_tsgo or 'tsgo'
    return vim.lsp.rpc.start({ command, '--lsp', '--stdio' }, dispatchers)
  end,
})
vim.list_extend(servers, { 'tsgo' })
vim.lsp.enable(servers)

local function javascript_formatters(bufnr)
  local filename = vim.api.nvim_buf_get_name(bufnr)
  if vim.fs.find({ 'biome.json', 'biome.jsonc', '.biome.json', '.biome.jsonc' }, { path = filename, upward = true, type = 'file' })[1] then
    return { 'biome' }
  end
  if vim.fs.find({ '.prettierrc', '.prettierrc.json', '.prettierrc.yaml', '.prettierrc.yml', '.prettierrc.js', '.prettierrc.cjs', '.prettierrc.mjs', 'prettier.config.js', 'prettier.config.cjs', 'prettier.config.mjs', 'prettier.config.ts' }, { path = filename, upward = true, type = 'file' })[1] then
    return { 'prettier' }
  end
  if vim.fs.find({ '.oxfmtrc.json', '.oxfmtrc.jsonc', 'oxfmt.config.ts' }, { path = filename, upward = true, type = 'file' })[1] then
    return { 'oxfmt' }
  end
  return { 'biome' }
end

local telescope = require 'telescope.builtin'
vim.keymap.set('n', 'gd', telescope.lsp_definitions, { desc = 'Go to definition' })
vim.keymap.set('n', 'gi', telescope.lsp_implementations, { desc = 'Go to implementation' })
vim.keymap.set('n', 'gr', telescope.lsp_references, { desc = 'Find references' })
vim.keymap.set('n', 'K', vim.lsp.buf.hover, { desc = 'Hover documentation' })
vim.keymap.set('n', 'gh', vim.lsp.buf.hover, { desc = 'Hover documentation' })
vim.keymap.set('n', '<leader>gr', vim.lsp.buf.rename, { desc = 'Rename symbol' })
vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, { desc = 'Code actions' })

require('conform').setup {
  format_on_save = { timeout_ms = 1000, lsp_format = 'never' },
  formatters_by_ft = {
    javascript = javascript_formatters,
    javascriptreact = javascript_formatters,
    go = { 'goimports' },
    typescript = javascript_formatters,
    typescriptreact = javascript_formatters,
    json = { 'biome' },
    jsonc = { 'biome' },
    nix = { 'alejandra' },
    python = { 'ruff_format' },
    rust = { 'rustfmt' },
    toml = { 'taplo' },
  },
}
vim.keymap.set({ 'n', 'v' }, '<leader>f', function() require('conform').format { async = true } end, { desc = 'Format buffer' })

local parsers = {
  'css', 'csv', 'dockerfile', 'go', 'html', 'javascript', 'json', 'just', 'lua', 'make',
  'markdown', 'markdown_inline', 'nix', 'python', 'rust', 'sql', 'svelte', 'toml', 'tsx',
  'typescript', 'vim', 'vimdoc', 'yaml',
}
require('nvim-treesitter').install(parsers):await(function()
  for _, buffer in ipairs(vim.api.nvim_list_bufs()) do
    if vim.api.nvim_buf_is_loaded(buffer) then
      local language = vim.treesitter.language.get_lang(vim.bo[buffer].filetype)
      if language then pcall(vim.treesitter.start, buffer, language) end
    end
  end
end)
