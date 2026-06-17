--
-- server installed @coding/lsp/mason.lua
--

local filetypes = { 'rust' }

vim.api.nvim_create_autocmd('FileType', {
  pattern = filetypes,
  callback = function()
    vim.pack.add {
      'https://github.com/Saecki/crates.nvim',
      {
        src = 'https://github.com/mrcjkb/rustaceanvim',
        -- To avoid being surprised by breaking changes,
        -- I recommend you set a version range
        version = vim.version.range '^9',
      },
    }

    -- require('rustaceanvim').setup {
    --   server = {
    --     -- on_attach = function(_, bufnr)
    --     --   vim.keymap.set('n', '<leader>cR', function() vim.cmd.RustLsp 'codeAction' end, { desc = 'Code Action', buffer = bufnr })
    --     --   vim.keymap.set('n', '<leader>dr', function() vim.cmd.RustLsp 'debuggables' end, { desc = 'Rust Debuggables', buffer = bufnr })
    --     -- end,
    --     default_settings = {
    --       -- rust-analyzer language server configuration
    --       ['rust-analyzer'] = {
    --         cargo = {
    --           allFeatures = true,
    --           loadOutDirsFromCheck = true,
    --           buildScripts = {
    --             enable = true,
    --           },
    --         },
    --         procMacro = {
    --           enable = true,
    --         },
    --         files = {
    --           exclude = {
    --             '.direnv',
    --             '.git',
    --             '.jj',
    --             '.github',
    --             '.gitlab',
    --             'bin',
    --             'node_modules',
    --             'target',
    --             'venv',
    --             '.venv',
    --           },
    --           -- Avoid Roots Scanned hanging, see https://github.com/rust-lang/rust-analyzer/issues/12613#issuecomment-2096386344
    --           watcher = 'client',
    --         },
    --       },
    --     },
    --   },
    -- }

    require('crates').setup {
      completion = {
        crates = {
          enabled = true,
        },
      },
      lsp = {
        enabled = true,
        actions = true,
        completion = true,
        hover = true,
      },
    }

    local servers = {
      bacon_ls = {
        enabled = true,
      },
      -- WARN:
      -- https://github.com/mrcjkb/rustaceanvim
      -- Do not call the nvim-lspconfig.rust_analyzer setup or set up the LSP client for rust-analyzer manually, as doing so may cause conflicts.
      rust_analyzer = { enabled = false },
    }

    for name, server in pairs(servers) do
      vim.lsp.config(name, server)
      vim.lsp.enable(name)
    end
  end,
})
