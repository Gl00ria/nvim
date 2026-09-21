-- Copy file, line and selection references to the clipboard
vim.pack.add { 'https://github.com/7KiLL/copybara.nvim' }

local lazy = require 'gl00ria.config.lazy'
lazy.on_event('FileType', function()
  local ok, cpbara = pcall(require, 'copybara')
  if ok then
    cpbara.setup {}
  else
    vim.notify('Failed to load plugin [Copybara@copybara.lua]', vim.log.levels.ERROR)
  end
end, 'copybara')
