vim.pack.add { 'https://github.com/echasnovski/mini.diff' }

local ok, mini_d = pcall(require, 'mini.diff')
if ok then
  vim.api.nvim_create_autocmd({ 'BufReadPost' }, {
    once = true,
    callback = function()
      mini_d.setup {
        opts = {
          -- noautocmd = true, -- Don't run autocmds, specifically Conform auto-format
          -- For when we e.g. `cdo` in quickfix
          write_all_buffers = true,
          debounce_delay = 200,
          condition = function() return not vim.g.disable_autosave end,
        },
        mappings = {

          -- Module mappings. Use `''` (empty string) to disable one.

          -- Apply hunks inside a visual/operator region
          -- apply = 'gh',
          apply = '',

          -- Reset hunks inside a visual/operator region
          -- reset = 'gH',
          reset = '',

          -- Hunk range textobject to be used inside operator
          -- Works also in Visual mode if mapping differs from apply and reset
          -- textobject = 'gh',
          textobject = '',

          -- Go to hunk range in corresponding direction
          goto_prev = '[h',
          goto_next = ']h',

          -- goto_first = '[H',
          goto_first = '',
          -- goto_last = ']H',
          goto_last = '',
        },
      }
    end,
  })

  local wk_ok, wk = pcall(require, 'which-key')
  if wk_ok then
    wk.add {
      {
        '<leader>go',
        function() require('mini.diff').toggle_overlay(0) end,
        desc = 'Toggle Diff Overlay',
        icon = '󱀅 ',
      },
    }
  else
    vim.notify('Failed to load plugin [Which-key@mini-diff.lua]', vim.log.levels.ERROR)
  end
else
  vim.notify('Failed to load plugin [Mini-diff@mini-diff.lua]', vim.log.levels.ERROR)
end
