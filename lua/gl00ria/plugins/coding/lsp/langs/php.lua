--
-- server installed @coding/lsp/mason.lua
-- LSPs:
-- https://github.com/neovim/nvim-lspconfig/blob/master/doc/configs.md#phpactor
-- https://github.com/neovim/nvim-lspconfig/blob/master/doc/configs.md#intelephense
--

vim.api.nvim_create_autocmd('FileType', {
  pattern = 'php',
  callback = function()
    vim.pack.add {
      -- adapters for both (pest & phpunit)
      'https://github.com/nvim-neotest/neotest',
      'https://github.com/V13Axel/neotest-pest',
      'https://github.com/olimorris/neotest-phpunit',
    }

    require('neotest').setup {
      ['neotest-phpunit'] = {
        root_ignore_files = { 'tests/Pest.php' },
      },
    }

    local servers = {
      intelephense = {
        -- diagnostics = {
        --   exclude = {
        --     ['*.php'] = { 'P1132' },
        --   },
        -- },
      },

      -- phpactor = {
      --   cmd = { 'phpactor', 'language-server' },
      --   root_markers = { '.git', 'composer.json', '.phpactor.json', '.phpactor.yml' },
      -- },
    }

    for name, server in pairs(servers) do
      vim.lsp.config(name, server)
      vim.lsp.enable(name)
    end
  end,
})
