vim.pack.add { 'https://github.com/MagicDuck/grug-far.nvim' }
local lazy = require 'gl00ria.config.lazy'
lazy.on_event('BufReadPost', function()
  local ok, grug = pcall(require, 'grug-far')
  if ok then
    grug.setup {}

    local wk_ok, wk = pcall(require, 'which-key')
    if wk_ok then
      wk.add {
        {
          '<F2>',
          function()
            local ext = vim.bo.buftype == '' and vim.fn.expand '%:e'
            grug.open { transient = true, prefills = { filesFilter = ext and ext ~= '' and '*.' .. ext or nil } }
          end,
          mode = { 'n', 'v' },
          desc = 'Search and Replace',
          icon = ' ',
        },
      }
    else
      vim.notify('Failed to load plugin [Which-key@search-replace.lua]', vim.log.levels.ERROR)
    end
  else
    vim.notify('Failed to load plugin [Grug-Far@search-replace.lua]', vim.log.levels.ERROR)
  end
end, 'search_replace')
