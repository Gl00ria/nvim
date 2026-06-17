--
-- server installed @coding/lsp/mason.lua
--

vim.pack.add { 'https://github.com/mfussenegger/nvim-ansible' }

local servers = {
  ansiblels = {
    filetypes = { 'yaml.ansible' },
  },
}

for name, server in pairs(servers) do
  vim.lsp.config(name, server)
  vim.lsp.enable(name)
end
