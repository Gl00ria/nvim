--
-- server installed @coding/lsp/mason.lua
--

local filetypes = { 'markdown', 'markdown.mdx' }

vim.api.nvim_create_autocmd('FileType', {
  pattern = filetypes,
  callback = function()
    local servers = {
      marksman = {},
    }

    for name, server in pairs(servers) do
      vim.lsp.config(name, server)
      vim.lsp.enable(name)
    end
  end,
})
