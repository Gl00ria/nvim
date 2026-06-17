-- Handled via snacks
vim.pack.add { 'https://github.com/nvim-mini/mini.bufremove' }
local ok, mini_buff = pcall(require, 'mini.bufremove')
if ok then
  mini_buff.setup {}

  require('which-key').add {
    { 'Q', function() require('mini.bufremove').delete(0, false) end, desc = 'Close Current Buffer', icon = '󰅛 ' },
  }
else
  vim.notify('Failed to load plugin [Mini-Buffremove@Mini-buffremove.lua]', vim.log.levels.ERROR)
end
