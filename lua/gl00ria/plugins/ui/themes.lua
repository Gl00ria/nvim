vim.pack.add {
  'https://github.com/folke/tokyonight.nvim',
  'https://github.com/ellisonleao/gruvbox.nvim',
  'https://github.com/sainnhe/gruvbox-material',
  'https://github.com/gbprod/nord.nvim',
  'https://github.com/neanias/everforest-nvim',
  'https://github.com/EmmanuelVernet/tokyoppuccin.nvim',
  {
    src = 'https://github.com/catppuccin/nvim',
    name = 'catppuccin',
  },
}
-- vim.cmd.colorscheme 'tokyonight-night'
-- vim.cmd.colorscheme 'catppuccin'
-- vim.cmd.colorscheme 'tokyoppuccin'
-- vim.cmd.colorscheme 'nord'
-- vim.cmd.colorscheme 'everforest'
vim.cmd.colorscheme 'gruvbox'
-- vim.cmd.colorscheme 'gruvbox-material'

vim.pack.add { 'https://github.com/xiyaowong/transparent.nvim' }
local lazy = require 'gl00ria.config.lazy'
lazy.on_event('BufReadPost', function()
  local ok, transparent = pcall(require, 'transparent')
  if ok then
    transparent.setup {}
    transparent.clear_prefix 'NeoTree'
  else
    vim.notify('Failed to load plugin [Transparent@themes.lua]', vim.log.levels.ERROR)
  end
end, 'transparent')
