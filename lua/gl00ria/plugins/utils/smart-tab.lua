vim.pack.add { 'https://github.com/boltlessengineer/smart-tab.nvim' }

local ok, smart = pcall(require, 'smart-tab')
if ok then
  smart.setup {
    -- default options:
    -- list of tree-sitter node types to filter
    skips = { 'string_content' },
    -- default mapping, set `false` if you don't want automatic mapping
    mapping = false,
    -- mapping = false,
    -- filetypes to exclude
    exclude_filetypes = {},
  }
  vim.keymap.set('i', '<c-t>', require('smart-tab').smart_tab)
else
  vim.notify('Failed to load plugin [Smart-tab@smart-tab.lua]', vim.log.levels.ERROR)
end
