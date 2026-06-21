vim.pack.add { 'https://github.com/rachartier/tiny-code-action.nvim' }
local lazy = require 'gl00ria.config.lazy'
lazy.on_event('BufReadPost', function()
  local ok, tiny_ca = pcall(require, 'tiny-code-action')
  if ok then
    tiny_ca.setup {
      event = 'LspAttach',

      -- The picker to use, "telescope", "snacks", "select", "buffer", "fzf-lua" are supported
      -- You can also set `picker = "<picker>"` without any opts.
      picker = 'snacks',
    }

    require('which-key').add {
      {
        '<leader>ca',
        mode = { 'x', 'n' },
        function() require('tiny-code-action').code_action() end,
        { noremap = true, silent = true },
        desc = 'Code Action',
        icon = '󰙵 ',
      },
    }
  else
    vim.notify('Failed to load plugin [tiny-code-action@tiny-code-action.lua]', vim.log.levels.ERROR)
  end
end, 'tiny_code_action')
