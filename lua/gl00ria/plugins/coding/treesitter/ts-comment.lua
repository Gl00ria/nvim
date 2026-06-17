-- enhance nvim's native comments
vim.pack.add { 'https://github.com/folke/ts-comments.nvim' }

vim.api.nvim_create_autocmd({ 'BufReadPost' }, {
  callback = function()
    local ok, ts_commetns = pcall(require, 'ts-comments')
    if ok then
      ts_commetns.setup {}
    else
      vim.notify('Failed to load plugin [TS-comments@ts-comments.lua]', vim.log.levels.ERROR)
    end
  end,
})
