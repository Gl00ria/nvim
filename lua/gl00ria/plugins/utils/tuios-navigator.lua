vim.pack.add { 'https://github.com/Tim4c/tuios-nvim-navigator' }
local lazy = require 'gl00ria.config.lazy'
lazy.on_event('BufReadPost', function()
  local ok, tuios_nav = pcall(require, 'tuios-nvim-navigator')
  if ok then
    tuios_nav.setup {}
  else
    vim.notify('Failed to load plugin [tuios@tuios_navigator.lua]', vim.log.levels.ERROR)
  end
end, 'tuios_navigator')
