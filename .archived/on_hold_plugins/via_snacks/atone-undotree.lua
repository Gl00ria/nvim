-- Using Snacks.nvim
vim.pack.add { 'https://github.com/XXiaoA/atone.nvim' }

local ok, atone = pcall(require, 'atone')
if ok then
  atone.setup {}

  --TODO: which-key
  require('which-key').add {
    { '<F3>', '<cmd>Atone<cr>', desc = 'Toggle UndoTree 󰣜 ' },
  }
else
  vim.notify('Failed to load plugin [Atone@atone-undotree.lua]', vim.log.levels.ERROR)
end
