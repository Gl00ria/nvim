vim.pack.add { 'https://github.com/hedyhli/outline.nvim' }
local ok, outline = pcall(require, 'outline')
if ok then
  outline.setup {}

  local wk_ok, wk = pcall(require, 'which-key')
  if wk_ok then
    wk.add {
      { '<F6>', '<cmd>Outline<cr>', desc = 'Toggle Outline', icon = ' ' },
    }
  else
    vim.notify('Failed to load plugin [Which-key@yazi.lua]', vim.log.levels.ERROR)
  end
else
  vim.notify('Failed to load plugin [outline@outline.lua]', vim.log.levels.ERROR)
end
