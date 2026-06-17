-- lazy loading
--  automatically closing buffers after x minutes of inactivity
--
vim.pack.add { 'https://github.com/chrisgrieser/nvim-early-retirement' }

local ok, early_ret = pcall(require, 'early-retirement')
if ok then
  vim.api.nvim_create_autocmd({ 'BufReadPost' }, {
    once = true,
    callback = function()
      early_ret.setup {
        opts = {
          -- If a buffer has been inactive for this many minutes, close it.
          retirementAgeMins = 20,

          minimumBufferNum = 4,

          notificationOnAutoClose = false,
        },
      }
    end,
  })
else
  vim.notify('Failed to load plugin [Early-Retirement@early-retirement.lua]', vim.log.levels.ERROR)
end
