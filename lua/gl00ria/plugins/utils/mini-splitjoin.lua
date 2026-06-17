vim.pack.add { 'https://github.com/nvim-mini/mini.splitjoin' }
local ok, mini_split = pcall(require, 'mini.splitjoin')
if ok then
  mini_split.setup {
    {
      -- Module mappings. Use `''` (empty string) to disable one.
      mappings = {
        toggle = 'gS',
        split = '',
        join = '',
      },
    },
  }

  local wk_ok, wk = pcall(require, 'which-key')
  if wk_ok then
    wk.add {
      { 'gS', mode = { 'x' }, desc = 'Split & Join', icon = '󰃻 ' },
    }
  else
    vim.notify('Failed to load plugin [Which-key@mini-splitjoin.lua]', vim.log.levels.ERROR)
  end
else
  vim.notify('Failed to load plugin [Mini-Splitjoin@mini-splitjoin.lua]', vim.log.levels.ERROR)
end
