vim.pack.add {
  'https://github.com/mason-org/mason.nvim',
  'https://github.com/mason-org/mason-lspconfig.nvim',
  'https://github.com/WhoIsSethDaniel/mason-tool-installer.nvim',
}

local ok, mason = pcall(require, 'mason')
if ok then
  mason.setup {
    automatic_enable = {
      exclude = { 'luau_lsp' },
    },
  }
else
  vim.notify('Failed to load plugin [Mason@mason.lua]', vim.log.levels.ERROR)
end

local ensure_installed = {
  'lua-language-server',
  'stylua',

  'bash-language-server',
  'shfmt',

  -- php LSPs
  'intelephense',
  'phpcs',
  'php-cs-fixer', -- used @coding/conform.lua
  'phpcs', -- linter used @coding/lint.lua
  -- 'phpactor',

  'clangd',
  'codelldb', -- c/c++ debugger

  -- dotnet/c#
  'csharpier',
  'netcoredbg',
  'fantomas',

  'json-lsp',

  -- 'sqlfluff',
  'sqlfmt', -- linter, formatter

  -- toml
  'taplo',

  'markdownlint-cli2',
  'markdown-toc',

  -- go
  'goimports',
  'gofumpt',
  'gomodifytags',
  'impl',
  'golangci-lint',
  'delve',
  'gopls',

  'hadolint', -- linter docker

  'cmakelang',
  'cmakelint',
  'neocmakelsp',
  -- 'cmake-language-server',

  -- python
  'black', -- formatter

  'ansible-lint',

  'prettierd', -- list of ft to format available @conform.lua

  -- vue
  -- https://github.com/vuejs/language-tools/wiki/Neovim
  'vue-language-server',

  -- NOTE: both servers (pyright & basedpyright) are good
  -- pyright: stable
  -- basedpyright: modern
  -- python
  'pyright',
  -- 'basedpyright',
  'ruff',

  'yaml-language-server',

  -- Ruby
  'solargraph', -- lsp
  'rubocop', -- formater
  'erb-formatter',
  'erb-lint',

  -- Rust
  'rust-analyzer',
  'bacon-ls',

  -- JS
  'emmet-language-server',
  'emmet-ls',

  -- typescript
  'typescript-language-server',
  -- 'ts_ls',
  -- 'vtsls',
  'tsgo',
  'tsp-server',

  -- css
  'tailwindcss-language-server',
  'css-lsp',
  'astro-language-server',
}

require('mason-tool-installer').setup { ensure_installed = ensure_installed }
