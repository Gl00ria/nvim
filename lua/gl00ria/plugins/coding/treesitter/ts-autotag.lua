vim.pack.add { 'https://github.com/windwp/nvim-ts-autotag' }
local lazy = require 'gl00ria.config.lazy'
lazy.on_event('BufReadPost', function()
  local ok, autotag = pcall(require, 'nvim-ts-autotag')
  if ok then
    autotag.setup {}
  else
    vim.notify('Failed to load plugin [TS-Autotag@ts-autotag.lua]', vim.log.levels.ERROR)
  end
end, 'ts_autotag')
