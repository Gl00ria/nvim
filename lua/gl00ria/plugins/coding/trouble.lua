vim.pack.add { 'https://github.com/folke/trouble.nvim' }

local lazy = require 'gl00ria.config.lazy'
lazy.on_event('BufReadPost', function()
  local ok, trouble = pcall(require, 'trouble')
  if ok then
  trouble.setup {
    defaults = {
      keys = {
        ['?'] = 'help',
        r = 'refresh',
        R = 'toggle_refresh',
        q = 'close',
        o = 'jump_close',
        ['<esc>'] = 'cancel',
        ['<cr>'] = 'jump',
        ['<2-leftmouse>'] = 'jump',
        ['<c-s>'] = 'jump_split',
        ['<c-v>'] = 'jump_vsplit',
        -- go down to next item (accepts count)
        -- j = "next",
        ['}'] = 'next',
        [']]'] = 'next',
        -- go up to prev item (accepts count)
        -- k = "prev",
        ['{'] = 'prev',
        ['[['] = 'prev',
        dd = 'delete',
        d = { action = 'delete', mode = 'v' },
        i = 'inspect',
        p = 'preview',
        P = 'toggle_preview',
        zo = 'fold_open',
        zO = 'fold_open_recursive',
        zc = 'fold_close',
        zC = 'fold_close_recursive',
        za = 'fold_toggle',
        zA = 'fold_toggle_recursive',
        zm = 'fold_more',
        zM = 'fold_close_all',
        zr = 'fold_reduce',
        zR = 'fold_open_all',
        zx = 'fold_update',
        zX = 'fold_update_all',
        zn = 'fold_disable',
        zN = 'fold_enable',
        zi = 'fold_toggle_enable',
        gb = { -- example of a custom action that toggles the active view filter
          action = function(view) view:filter({ buf = 0 }, { toggle = true }) end,
          desc = 'Toggle Current Buffer Filter',
        },
        s = { -- example of a custom action that toggles the severity
          action = function(view)
            local f = view:get_filter 'severity'
            local severity = ((f and f.filter.severity or 0) + 1) % 5
            view:filter({ severity = severity }, {
              id = 'severity',
              template = '{hl:Title}Filter:{hl} {severity}',
              del = severity == 0,
            })
          end,
          desc = 'Toggle Severity Filter',
        },
      },
    },
  }

  local wk_ok, wk = pcall(require, 'which-key')
  if wk_ok then
    wk.add {
      {
        'gd',
        '<cmd>Trouble lsp toggle focus=false win.position=right<cr>',
        desc = 'LSP Definitions / references / ... (Trouble)',
        icon = '󱥽 ',
      },
      {
        '<F4>',
        '<cmd>Trouble diagnostics toggle filter.buf=0<cr>',
        desc = 'Buffer Diagnostics (Trouble)',
      },
      {
        '<F5>',
        '<cmd>Trouble diagnostics toggle<cr>',
        desc = 'Workspace Diagnostics (Trouble)',
      },
      {
        '<leader>cy',
        '<cmd>Trouble symbols toggle focus=false<cr>',
        desc = 'Symbols (Trouble)',
        icon = ' ',
      },
      -- {
      --   '<leader>tl',
      --   '<cmd>Trouble loclist toggle<cr>',
      --   desc = 'Location List (Trouble)',
      --   icon = ' ',
      -- },
      -- {
      --   '<leader>tq',
      --   '<cmd>Trouble qflist toggle<cr>',
      --   desc = 'Quickfix List (Trouble)',
      --   icon = '󱄟 ',
      -- },
    }
  else
    vim.notify('Failed to load plugin [Which-key@trouble.lua]', vim.log.levels.ERROR)
  end
  else
    vim.notify('Failed to load plugin [Trouble@trouble.lua]', vim.log.levels.ERROR)
  end
end, 'trouble')
