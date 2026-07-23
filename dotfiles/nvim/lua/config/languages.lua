require('mason').setup()
require('mason-tool-installer').setup {
  ensure_installed = {
    'biome', 'alejandra', 'css-lsp', 'docker-compose-language-service', 'dockerfile-language-server',
    'gopls', 'goimports', 'html-lsp', 'json-lsp', 'just-lsp', 'marksman', 'nil', 'ruff',
    'rust-analyzer', 'sqls', 'svelte-language-server', 'taplo', 'tailwindcss-language-server',
    'tree-sitter-cli', 'tsgo', 'yaml-language-server',
  },
}

local servers = {
  'biome', 'cssls', 'docker_compose_language_service', 'dockerls', 'gopls', 'html', 'jsonls',
  'just', 'marksman', 'nil_ls', 'ruff', 'rust_analyzer', 'sqls', 'svelte', 'taplo',
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

local telescope = require 'telescope.builtin'
vim.api.nvim_create_autocmd('LspAttach', {
  callback = function(event)
    local map = function(keys, action, description)
      vim.keymap.set('n', keys, action, { buffer = event.buf, desc = description })
    end
    map('gd', telescope.lsp_definitions, 'Go to definition')
    map('gi', telescope.lsp_implementations, 'Go to implementation')
    map('gr', telescope.lsp_references, 'Find references')
    map('K', vim.lsp.buf.hover, 'Hover documentation')
    map('<leader>gr', vim.lsp.buf.rename, 'Rename symbol')
    map('<leader>ca', vim.lsp.buf.code_action, 'Code actions')
  end,
})

require('conform').setup {
  format_on_save = { timeout_ms = 1000, lsp_format = 'never' },
  formatters_by_ft = {
    javascript = { 'biome' },
    javascriptreact = { 'biome' },
    go = { 'goimports' },
    typescript = { 'biome' },
    typescriptreact = { 'biome' },
    json = { 'biome' },
    jsonc = { 'biome' },
    nix = { 'alejandra' },
    python = { 'ruff_format' },
    rust = { 'rustfmt' },
    toml = { 'taplo' },
  },
}
vim.keymap.set({ 'n', 'v' }, '<leader>f', function() require('conform').format { async = true } end, { desc = 'Format buffer' })

require('nvim-treesitter').install {
  'css', 'csv', 'dockerfile', 'go', 'html', 'javascript', 'json', 'just', 'lua', 'make',
  'markdown', 'markdown_inline', 'nix', 'python', 'rust', 'sql', 'svelte', 'toml', 'tsx',
  'typescript', 'vim', 'vimdoc', 'yaml',
}
