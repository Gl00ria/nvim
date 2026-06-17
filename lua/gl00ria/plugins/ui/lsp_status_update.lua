-- Snacks.nvim does it
-- status updates for LSP.
vim.pack.add { 'https://github.com/j-hui/fidget.nvim' }
local ok, fidget = pcall(require, 'fidget')
if ok then
  fidget.setup {}
else
  vim.notify('Failed to load plugin [fidget@lsp_status_update.lua]', vim.log.levels.ERROR)
end
