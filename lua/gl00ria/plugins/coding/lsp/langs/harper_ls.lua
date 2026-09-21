--
-- server installed @coding/lsp/mason.lua
--

local filetypes = { 'markdown', 'text', 'tex', 'typst' }
vim.api.nvim_create_autocmd('FileType', {
  pattern = filetypes,
  callback = function()
    local servers = {
      harper_ls = {
        cmd = { 'harper-ls', '--stdio' },
        settings = {
          ['harper-ls'] = {
            linters = {
              SentenceCapitalization = false,
              SpellCheck = false,
            },
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
