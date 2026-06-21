vim.pack.add { 'https://github.com/windwp/nvim-autopairs' }

local lazy = require 'gl00ria.config.lazy'
lazy.on_event('InsertEnter', function()
  local ok, autopairs = pcall(require, 'nvim-autopairs')
  if ok then
    autopairs.setup {}
  else
    vim.notify('Failed to load plugin [Nvim-autopairs@autopairs.lua]', vim.log.levels.ERROR)
  end
end, 'autopairs')
