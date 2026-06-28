vim.pack.add { 'https://github.com/asgerviggo/nvim-blame-line' }

local wk_ok, wk = pcall(require, 'which-key')
if wk_ok then
  wk.add {
    { mode = { 'n' }, '<leader>g?', '<cmd>ToggleBlameLine<cr>', desc = 'Toggle Git Blame', icon = ' ' },
  }
else
  vim.notify('Failed to load plugin [Which-key@git/blame.lua]', vim.log.levels.ERROR)
end

vim.api.nvim_create_autocmd('BufEnter', {
  callback = function() vim.cmd 'EnableBlameLine' end,
})
