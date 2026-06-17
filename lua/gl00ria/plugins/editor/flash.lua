--
-- Navigate your code with search labels, enhanced character motions and Treesitter integration
vim.pack.add { 'https://github.com/folke/flash.nvim' }

local ok, flash = pcall(require, 'flash')
if ok then
  flash.setup {
    opts = {
      labels = 'asdfghjklqwertyuiopzxcvbnm',
    },
  }
  vim.keymap.set({ 'n', 'x', 'o' }, 's', function() require('flash').jump() end, { desc = 'Flash  ' })
  vim.keymap.set({ 'n', 'x', 'o' }, 'S', function() require('flash').treesitter() end, { desc = 'Flash Treesitter   ' })
  vim.keymap.set({ 'o' }, 'r', function() require('flash').remote() end, { desc = 'Flash Remote   ' })
  vim.keymap.set({ 'o' }, 'R', function() require('flash').treesitter_search() end, { desc = 'Flash Treesitter Search   ' })
else
  vim.notify('Failed to load plugin [Flash@flash.lua]', vim.log.levels.ERROR)
end
