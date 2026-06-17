--
-- server installed @coding/lsp/mason.lua
--

local filetypes = { 'go', 'gomod', 'gowork', 'gotmpl' }
vim.api.nvim_create_autocmd('FileType', {
  pattern = filetypes,
  callback = function()
    local servers = {
      gopls = {
        settings = {
          gopls = {
            analyses = {
              unusedparams = true,
            },
            staticcheck = true,
            gofumpt = true,
          },
        },
      },
    }

    for name, server in pairs(servers) do
      vim.lsp.config(name, server)
      vim.lsp.enable(name)
    end
  end,
})
