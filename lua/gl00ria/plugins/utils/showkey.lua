-- shows keystorckes as you type
vim.pack.add { 'https://github.com/nvzone/showkeys' }

local ok, showkeys = pcall(require, 'showkeys')
if ok then
  showkeys.setup {
    winopts = {
      border = 'rounded',
    },
    timeout = 1,
    maxkeys = 5,
    -- bottom-left, bottom-right, bottom-center, top-left, top-right, top-center
    position = 'bottom-left',
  }
else
  vim.notify('Failed to load plugin [showkeys@showkeys.lua]', vim.log.levels.ERROR)
end
