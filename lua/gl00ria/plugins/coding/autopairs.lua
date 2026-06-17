-- lazy loaded
vim.pack.add { 'https://github.com/windwp/nvim-autopairs' }

vim.api.nvim_create_autocmd('InsertEnter', {
  callback = function()
    local ok, autopairs = pcall(require, 'nvim-autopairs')
    if ok then
      autopairs.setup {}
    else
      vim.notify('Failed to load plugin [Nvim-autopairs@autopairs.lua]', vim.log.levels.ERROR)
    end
  end,
})
