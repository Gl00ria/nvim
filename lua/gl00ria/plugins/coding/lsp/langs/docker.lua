--
-- server installed @coding/lsp/mason.lua
--

vim.api.nvim_create_autocmd('FileType', {
  pattern = { 'dockerfile' },
  callback = function()
    local servers = {
      dockerls = {},
      docker_compose_language_service = {},
    }

    for name, server in pairs(servers) do
      vim.lsp.config(name, server)
      vim.lsp.enable(name)
    end
  end,
})
