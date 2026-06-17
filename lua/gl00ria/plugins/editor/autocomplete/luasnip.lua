-- NOTE: You can also specify plugin using a version range for its git tag.
--  See `:help vim.version.range()` for more info
vim.pack.add { { src = 'https://github.com/L3MON4D3/LuaSnip', version = vim.version.range '2.*' } }

local luasnip_ok, luasnip = pcall(require, 'luasnip')
if luasnip_ok then
  luasnip.setup {}
else
  vim.notify('Failed to load plugin [luasnip@luasnip.lua]', vim.log.levels.ERROR)
end

-- `friendly-snippets` contains a variety of premade snippets.
--    See the README about individual language/framework/plugin snippets:
--    https://github.com/rafamadriz/friendly-snippets
vim.pack.add { 'https://github.com/rafamadriz/friendly-snippets' }
require('luasnip.loaders.from_vscode').lazy_load()
-- https://github.com/rafamadriz/friendly-snippets/wiki
for ft, snip in pairs {
  typescript = 'tsdoc',
  javascript = 'jsdoc',
  lua = 'luadoc',
  python = 'pydoc',
  rust = 'rustdoc',
  cs = 'csharpdoc',
  java = 'javadoc',
  c = 'cdoc',
  cpp = 'cppdoc',
  php = 'phpdoc',
  kotlin = 'kdoc',
  ruby = 'rdoc',
  sh = 'shelldoc',
} do
  require('luasnip').filetype_extend(ft, { snip })
end
