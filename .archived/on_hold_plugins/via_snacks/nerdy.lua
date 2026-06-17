--
-- search nerdfonts icons
--
vim.pack.add {
  'https://github.com/2KAbhishek/nerdy.nvim',
  'https://github.com/folke/snacks.nvim', -- dep
}
local ok, nerdy = pcall(require, 'nerdy')
if ok then
  nerdy.setup {}
else
  vim.notify('Failed to load plugin [nerdy@nerdy.lua]', vim.log.levels.ERROR)
end
