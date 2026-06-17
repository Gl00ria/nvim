--
-- server installed @coding/lsp/mason.lua
-- https://github.com/neovim/nvim-lspconfig/blob/master/doc/configs.md#tsgo
-- https://github.com/neovim/nvim-lspconfig/blob/master/doc/configs.md#vtsls
--

local filetypes = { 'typescript', 'javascript', 'javascriptreact', 'typescriptreact', 'vue' }

vim.api.nvim_create_autocmd('FileType', {
  pattern = filetypes,
  callback = function()
    local servers = {
      -- PERF: newer & faster
      tsgo = {
        workspace_required = false,
        filetypes = filetypes,
        single_file_support = true,
        init_options = {
          preferences = {
            includeCompletionsForModuleExports = true,
            includeCompletionsForImportStatements = true,
          },
        },
        settings = {
          typescript = {
            inlayHints = {
              includeInlayParameterNameHints = 'all',
              includeInlayVariableTypeHints = true,
              includeInlayFunctionParameterTypeHints = true,
            },
          },
          javascript = {
            inlayHints = {
              includeInlayParameterNameHints = 'none',
              includeInlayVariableTypeHints = false,
              includeInlayFunctionParameterTypeHints = false,
            },
          },
        },
      },
      -- ts_ls = {
      --   workspace_required = false,
      --   filetypes = {
      --     'javascript',
      --     'javascriptreact',
      --     'typescript',
      --     'typescriptreact',
      --   },
      --   single_file_support = true,
      --   init_options = {
      --     preferences = {
      --       includeCompletionsForModuleExports = true,
      --       includeCompletionsForImportStatements = true,
      --     },
      --   },
      --   settings = {
      --     typescript = {
      --       inlayHints = {
      --         includeInlayParameterNameHints = 'all',
      --         includeInlayVariableTypeHints = true,
      --         includeInlayFunctionParameterTypeHints = true,
      --       },
      --     },
      --     javascript = {
      --       inlayHints = {
      --         includeInlayParameterNameHints = 'none',
      --         includeInlayVariableTypeHints = false,
      --         includeInlayFunctionParameterTypeHints = false,
      --       },
      --     },
      --   },
      -- },
      -- vtsls = {
      --   enabled = false,
      --   filetypes = { 'typescript', 'javascript', 'javascriptreact', 'typescriptreact', 'vue' },
      -- },

      --
      -- OpenAPI specifications
      -- Client SDKs
      -- Server stubs
      tsp_server = {},
    }

    for name, server in pairs(servers) do
      vim.lsp.config(name, server)
      vim.lsp.enable(name)
    end
  end,
})
