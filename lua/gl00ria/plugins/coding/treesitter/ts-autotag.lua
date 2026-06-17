vim.pack.add { 'https://github.com/windwp/nvim-ts-autotag' }

local ok, autotag = pcall(require, 'nvim-ts-autotag')
if ok then
  autotag.setup {}
else
  vim.notify('Failed to load plugin [TS-Autotag@ts-autotag.lua]', vim.log.levels.ERROR)
end
