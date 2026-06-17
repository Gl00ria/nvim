--
-- server installed @coding/lsp/mason.lua
-- https://github.com/neovim/nvim-lspconfig/blob/master/doc/configs.md#neocmake
--

vim.api.nvim_create_autocmd('FileType', {
  pattern = { 'cmake' },
  callback = function()
    vim.pack.add { 'https://github.com/Civitasv/cmake-tools.nvim' }

    local capabilities = vim.lsp.protocol.make_client_capabilities()
    capabilities.textDocument.completion.completionItem.snippetSupport = true

    local servers = {
      neocmake = {
        cmd = { 'neocmakelsp', 'stdio' },
        filetypes = { 'cmake' },
        root_markers = { '.neocmake.toml', '.git', 'build', 'cmake' },
        capabilities = capabilities,
      },
      -- cmake = {
      --   cmd = { 'cmake-language-server' },
      --   filetypes = { 'cmake' },
      --   init_options = { buildDirectory = 'build' },
      --   root_markers = { 'CMakePresets.json', 'CTestConfig.cmake', '.git', 'build', 'cmake' },
      -- },
    }

    for name, server in pairs(servers) do
      vim.lsp.config(name, server)
      vim.lsp.enable(name)
    end
  end,
})
