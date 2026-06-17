--
-- server installed @coding/lsp/mason.lua
-- https://github.com/neovim/nvim-lspconfig/blob/master/lsp/pyright.lua#L25
--

vim.api.nvim_create_autocmd('FileType', {
  pattern = 'python',
  callback = function()
    vim.pack.add { 'https://github.com/nvim-neotest/neotest-python' }

    -- NOTE: both servers (pyright & basedpyright) are good
    -- pyright: stable
    -- basedpyright: modern
    --
    local servers = {
      pyright = {
        cmd = { 'pyright-langserver', '--stdio' },
        filetypes = { 'python' },
        root_markers = {
          'pyrightconfig.json',
          'pyproject.toml',
          'setup.py',
          'setup.cfg',
          'requirements.txt',
          'Pipfile',
          '.git',
        },
        settings = {
          python = {
            analysis = {
              autoSearchPaths = true,
              useLibraryCodeForTypes = true,
              diagnosticMode = 'openFilesOnly',
            },
          },
        },
      },

      -- linter & formatter
      ruff = {
        cmd_env = { RUFF_TRACE = 'messages' },
        init_options = {
          settings = {
            logLevel = 'error',
          },
        },
      },

      -- basedpyright = {
      --   analysis = {
      --     autoSearchPaths = true,
      --     diagnosticMode = 'openFilesOnly',
      --   },
      -- },
    }

    for name, server in pairs(servers) do
      vim.lsp.config(name, server)
      vim.lsp.enable(name)
    end
  end,
})
