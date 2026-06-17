vim.pack.add { 'https://github.com/rcarriga/nvim-notify' }

local ok, notify = pcall(require, 'notify')
if ok then
  notify.setup {}
else
  vim.notify('Failed to load plugin [Nvim-Notify@vim-notify.lua]', vim.log.levels.ERROR)
end
