vim.pack.add { 'https://github.com/danymat/neogen' }
local lazy = require 'gl00ria.config.lazy'
lazy.on_event('BufReadPost', function()
  local ok, neogen = pcall(require, 'neogen')
  if ok then
    neogen.setup {
      -- snippet_engine = 'luasnip',
    }

    local wk_ok, wk = pcall(require, 'which-key')
    if wk_ok then
      local opts = { noremap = true, silent = true }
      wk.add {
        { '<Leader>Aa', function() require('neogen').generate() end, opts, desc = 'General', icon = '󰙆 ' },
        { '<Leader>Ac', function() require('neogen').generate { type = 'class' } end, opts, desc = 'Class', icon = ' ' },
        { '<Leader>Af', function() require('neogen').generate { type = 'func' } end, opts, desc = 'Function', icon = '󰊕 ' },
        { '<Leader>At', function() require('neogen').generate { type = 'type' } end, opts, desc = 'Type', icon = ' ' },
        { '<Leader>AF', function() require('neogen').generate { type = 'file' } end, opts, desc = 'File', icon = ' ' },
      }
    else
      vim.notify('Failed to load plugin [Which-key@annotation.lua]', vim.log.levels.ERROR)
    end
  else
    vim.notify('Failed to load plugin [Neogen@annotation.lua]', vim.log.levels.ERROR)
  end
end, 'annotation')
