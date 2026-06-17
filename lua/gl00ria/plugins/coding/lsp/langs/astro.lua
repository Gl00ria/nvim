--
-- server installed @coding/lsp/mason.lua
--

vim.api.nvim_create_autocmd('FileType', {
  pattern = { 'astro' },
  callback = function()
    local servers = {
      astro = {
        filetypes = { 'astro' },
        init_options = {
          typescript = {
            tsdk = vim.fn.stdpath 'data' .. '/mason/packages/typescript-language-server/node_modules/typescript/lib',
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
