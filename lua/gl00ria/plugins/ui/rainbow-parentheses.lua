vim.pack.add { 'https://github.com/hiphish/rainbow-delimiters.nvim' }

local ok, rainbow = pcall(require, 'rainbow-delimiters.setup')
if ok then
  rainbow.setup {}
else
  vim.notify('Failed to load plugin [rainbow-delimiters@rainbow-parentheses.lua]', vim.log.levels.ERROR)
end
