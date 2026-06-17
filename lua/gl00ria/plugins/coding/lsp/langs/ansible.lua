--
-- set filetype=yaml.ansible
--
local filetypes = { 'yaml.ansible' }

vim.api.nvim_create_autocmd('FileType', {
  pattern = filetypes,
  callback = function()
    local servers = {
      ansiblels = {},
    }

    for name, server in pairs(servers) do
      vim.lsp.config(name, server)
      vim.lsp.enable(name)
    end
  end,
})
