--
-- server installed @coding/lsp/mason.lua
--

local filetypes = { 'bash', 'sh', 'zsh' } -- explicitly add zsh if you want

vim.api.nvim_create_autocmd('FileType', {
  pattern = filetypes,
  callback = function()
    local servers = {
      bashls = {},
    }

    for name, server in pairs(servers) do
      vim.lsp.config(name, server)
      vim.lsp.enable(name)
    end
  end,
})
