--
-- server installed @coding/lsp/mason.lua
-- https://github.com/neovim/nvim-lspconfig/blob/master/doc/configs.md#solargraph
-- https://github.com/neovim/nvim-lspconfig/blob/master/doc/configs.md#ruby_lsp
-- https://github.com/neovim/nvim-lspconfig/blob/master/doc/configs.md#standardrb
--
local filetypes = { 'ruby", "eruby"' }

vim.api.nvim_create_autocmd('FileType', {
  pattern = filetypes,
  callback = function()
    vim.pack.add {
      'https://github.com/suketa/nvim-dap-ruby',
      'https://github.com/olimorris/neotest-rspec',
    }
    require('dap-ruby').setup()

    local servers = {
      -- ruby_lsp = {},
      solargraph = {}, -- lsp

      -- If Solargraph and Rubocop are both enabled as an LSP,
      -- diagnostics will be duplicated because Solargraph
      -- already calls Rubocop if it is installed
      -- rubocop = {},

      -- Ruby Style Guide, with linter & automatic code fixer
      standardrb = {},
    }

    for name, server in pairs(servers) do
      vim.lsp.config(name, server)
      vim.lsp.enable(name)
    end
  end,
})
