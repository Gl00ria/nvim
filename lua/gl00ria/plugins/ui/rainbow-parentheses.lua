vim.pack.add { 'https://github.com/hiphish/rainbow-delimiters.nvim' }
local lazy = require 'gl00ria.config.lazy'
lazy.on_event('BufReadPost', function()
  local ok, rainbow = pcall(require, 'rainbow-delimiters.setup')
  if ok then
    rainbow.setup {}
  else
    vim.notify('Failed to load plugin [rainbow-delimiters@rainbow-parentheses.lua]', vim.log.levels.ERROR)
  end
end, 'rainbow_delimiters')
