--
-- server installed @coding/lsp/mason.lua
-- https://github.com/neovim/nvim-lspconfig/blob/master/doc/configs.md#omnisharp
--

local filetypes = { 'cs', 'vb' }

vim.api.nvim_create_autocmd('FileType', {
  pattern = filetypes,
  callback = function()
    vim.pack.add {
      'https://github.com/Hoffs/omnisharp-extended-lsp.nvim',
      'https://github.com/Nsidorenco/neotest-vstest',
    }

    local servers = {
      fsautocomplete = {},
      omnisharp = {
        filetypes = filetypes,
        handlers = {
          ['textDocument/definition'] = function(...) return require('omnisharp_extended').handler(...) end,
        },
        keys = {
          {
            'gd',
            function() require('omnisharp_extended').lsp_definitions() end,
            desc = 'Goto Definition',
          },
        },
        enable_roslyn_analyzers = true,
        organize_imports_on_format = true,
        enable_import_completion = true,
      },
    }

    for name, server in pairs(servers) do
      vim.lsp.config(name, server)
      vim.lsp.enable(name)
    end
  end,
})
